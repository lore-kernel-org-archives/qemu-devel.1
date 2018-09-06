Received: from eggs.gnu.org ([2001:4830:134:3::10]:41171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fxrUQ-0004zB-Py
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fxrUN-0007uH-KH
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:26:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fxrUN-0007sK-DI
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:26:15 -0400
References: <1535630903-146863-1-git-send-email-imammedo@redhat.com>
	<38b3347b-8923-26e9-82a4-f69002262767@redhat.com>
	<20180906114945.1acd0b8e@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <da47aba6-2007-d473-49be-4280b3d961c2@redhat.com>
Date: Thu, 6 Sep 2018 12:26:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180906114945.1acd0b8e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qga: ignore non present cpus when handling
 qmp_guest_get_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Drew Jones <drjones@redhat.com>, mdroth@linux.vnet.ibm.com

On 09/06/18 11:49, Igor Mammedov wrote:
> On Thu, 30 Aug 2018 17:51:13 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> +Drew
>>
>> On 08/30/18 14:08, Igor Mammedov wrote:
>>> If VM has VCPUs plugged sparselly (for example a VM started with
>>> 3 VCPUs (cpu0, cpu1 and cpu2) and then cpu1 was hotunplugged so
>>> only cpu0 and cpu2 are present), QGA will rise a error
>>>   error: internal error: unable to execute QEMU agent command 'guest-get-vcpus':
>>>   open("/sys/devices/system/cpu/cpu1/"): No such file or directory
>>> when
>>>   virsh vcpucount FOO --guest
>>> is executed.
>>> Fix it by ignoring non present CPUs when fetching CPUs status from sysfs.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>>  qga/commands-posix.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>>> index 37e8a2d..2929872 100644
>>> --- a/qga/commands-posix.c
>>> +++ b/qga/commands-posix.c
>>> @@ -2044,7 +2044,9 @@ static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,
>>>                                vcpu->logical_id);
>>>      dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
>>>      if (dirfd == -1) {
>>> -        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
>>> +        if (!(sys2vcpu && errno == ENOENT)) {
>>> +            error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
>>> +        }
>>>      } else {
>>>          static const char fn[] = "online";
>>>          int fd;
>>>   
> [...]
>  
>> I wonder if, instead of this patch, we should rework
>> qmp_guest_get_vcpus(), to silently skip processors for which this
>> dirpath ENOENT condition arises (i.e., return a shorter list of
>> GuestLogicalProcessor objects).
> would something like this on top of this patch do?
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 2929872..990bb80 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2114,12 +2114,14 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
>          vcpu->logical_id = current++;
>          vcpu->has_can_offline = true; /* lolspeak ftw */
>          transfer_vcpu(vcpu, true, &local_err);
> -
> -        entry = g_malloc0(sizeof *entry);
> -        entry->value = vcpu;
> -
> -        *link = entry;
> -        link = &entry->next;
> +        if (errno == ENOENT) {
> +            g_free(vcpu);
> +        } else {
> +            entry = g_malloc0(sizeof *entry);
> +            entry->value = vcpu;
> +            *link = entry;
> +            link = &entry->next;
> +        }
>      }
>  
>      if (local_err == NULL) {
> 
> [...]
> 

To me that looks like the right approach, but the details should be
polished a bit:

- After we drop the vcpu object, "local_err" is still set, and would
terminate the loop in the next iteration.

- It seems like ENOENT can indeed only come from openat(), in
transfer_vcpu(), however, it would be nice if we could grab the error
code from the error object somehow, and not from the "errno" variable. I
vaguely recall this is what error classes were originally invented for,
but now we just use ERROR_CLASS_GENERIC_ERROR...

How about this: we could add a boolean output param to transfer_vcpu(),
called "fatal". Ignored when the function succeeds. When the function
fails (seen from "local_err"), the loop consults "fatal". If the error
is fatal, we act as before; otherwise, we drop the vcpu object, release
-- and zero out -- "local_err" as well, and continue. I think this is
more generic / safer than trying to infer the failure location from the
outside.

I'm not quite up to date on structured error propagation in QEMU, so
take the above with a grain of salt...

Thanks,
Laszlo
