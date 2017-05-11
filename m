Received: from eggs.gnu.org ([2001:4830:134:3::10]:60437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8hrO-00039d-QM
	for qemu-devel@nongnu.org; Thu, 11 May 2017 02:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8hrN-00029a-Nq
	for qemu-devel@nongnu.org; Thu, 11 May 2017 02:46:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1494431442-25163-1-git-send-email-thuth@redhat.com>
	<51843a32-50ee-391c-0377-a9b7db470ed1@redhat.com>
	<c8e08409-3b6d-6b65-37f9-ea17381e687c@redhat.com>
Date: Thu, 11 May 2017 08:45:52 +0200
In-Reply-To: <c8e08409-3b6d-6b65-37f9-ea17381e687c@redhat.com> (Thomas Huth's
	message of "Wed, 10 May 2017 18:12:25 +0200")
Message-ID: <87y3u3lwm7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] blockdev: Print a warning for legacy drive
 options that belong to -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> On 10.05.2017 17:55, Paolo Bonzini wrote:
>> 
>> 
>> On 10/05/2017 17:50, Thomas Huth wrote:
>>> We likely do not want to carry these legacy -drive options along forever.
>>> Let's emit a deprecation warning for the -drive options that have a
>>> replacement with the -device option, so that the (hopefully few) remaining
>>> users are aware of this and can adapt their scripts / behaviour.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  blockdev.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/blockdev.c b/blockdev.c
>>> index 4d8cded..87a025a 100644
>>> --- a/blockdev.c
>>> +++ b/blockdev.c
>>> @@ -797,6 +797,9 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
>>>      const char *filename;
>>>      Error *local_err = NULL;
>>>      int i;
>>> +    const char *deprecated[] = {
>>> +        "serial", "trans", "secs", "heads", "cyls"
>>> +    };
>>>  
>>>      /* Change legacy command line options into QMP ones */
>>>      static const struct {
>>> @@ -880,6 +883,14 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
>>>                  "update your scripts.\n");
>>>      }
>>>  
>>> +    /* Other deprecated options */
>>> +    for (i = 0; i < ARRAY_SIZE(deprecated); i++) {
>>> +        if (qemu_opt_get(legacy_opts, deprecated[i]) != NULL) {
>>> +            error_report("'%s' is deprecated, please use the corresponding "
>>> +                         "option of '-device' instead", deprecated[i]);
>>> +        }
>>> +    }
>>> +
>>>      /* Media type */
>>>      value = qemu_opt_get(legacy_opts, "media");
>>>      if (value) {
>> 
>> This one should be deprecated too (separate patch if you prefer).
>
> I tried to add it, but then the deprecation message is always shown. I
> think this happens because of the default CD-ROM drive is create in vl.c
> with CDROM_OPTS (that is defined to "media=cdrom").
> So no clue how to properly print a deprecation option for "media" here
> right now (and it should likely be in a separate patch if there is a
> solution).

The knee-jerk solution is to suppress the warning just for default
drives, like we do in drive_check_orphaned().

The proper solution is to desugar default drives into non-legacy form.

Feel free to pick the knee-jerk solution for now.
