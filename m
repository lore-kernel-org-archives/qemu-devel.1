Received: from eggs.gnu.org ([2001:4830:134:3::10]:35248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjfcN-00050q-5C
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 00:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjfcM-00070q-9u
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 00:19:03 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-2-git-send-email-armbru@redhat.com>
	<be25a2d0-a351-e2a9-a753-5c73b44b3eaf@redhat.com>
Date: Fri, 03 Mar 2017 06:18:53 +0100
In-Reply-To: <be25a2d0-a351-e2a9-a753-5c73b44b3eaf@redhat.com> (Eric Blake's
	message of "Thu, 2 Mar 2017 16:46:08 -0600")
Message-ID: <87a8937xaa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 01/15] sheepdog: Defuse time bomb in
 sd_open() error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

Eric Blake <eblake@redhat.com> writes:

> On 03/02/2017 03:43 PM, Markus Armbruster wrote:
>> When qemu_opts_absorb_qdict() fails, sd_open() closes stdin, because
>> sd->fd is still zero.  Fortunately, qemu_opts_absorb_qdict() can't
>> fail, because:
>> 
>> 1. it only fails when qemu_opt_parse() fails, and
>> 2. the only member of runtime_opts.desc[] is a QEMU_OPT_STRING, and
>> 3. qemu_opt_parse() can't fail for QEMU_OPT_STRING.
>> 
>> Defuse this ticking time bomb by jumping behind the file descriptor
>> cleanup on error.
>> 
>> Also do that for the error paths where sd->fd is still -1.  The file
>> descriptor cleanup happens to do nothing then, but let's not rely on
>> that here.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/sheepdog.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>
>>      s->fd = get_sheep_fd(s, errp);
>>      if (s->fd < 0) {
>>          ret = s->fd;
>> -        goto out;
>> +        goto out_no_fd;
>>      }
>
> Thanks to this change...
>
>>  
>>      ret = find_vdi_name(s, vdi, snapid, tag, &vid, true, errp);
>> @@ -1472,6 +1472,7 @@ out:
>>      if (s->fd >= 0) {
>
> ...this 'if' is now always true, and you can unconditionally call
> closesocket().

Yup.

close(-1) is just fine anyway.

> For that matter, the 'out:' label is a bit of a misnomer, since it is
> only reached on errors.
>
>>          closesocket(s->fd);
>>      }
>> +out_no_fd:
>>      qemu_opts_del(opts);
>>      g_free(buf);
>>      return ret;
>> 
>
> The cleanup is correct, but looks like it can be more extensive.

I'll have another look at it.
