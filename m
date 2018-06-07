Received: from eggs.gnu.org ([2001:4830:134:3::10]:45239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQvtA-0001tQ-7h
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQvt9-00070C-6X
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:27:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180529174821.19964-1-f4bug@amsat.org>
	<20180529174821.19964-2-f4bug@amsat.org>
	<fba4c1c5-a479-60c6-31e3-99affcacd5b7@redhat.com>
	<5374cfa5-e314-0c4f-92e9-b3ec3bf3bd95@amsat.org>
	<87po12vhm8.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e34c36ea-95ea-685c-ea7e-72554925e350@amsat.org>
Date: Thu, 7 Jun 2018 11:27:32 -0300
MIME-Version: 1.0
In-Reply-To: <87po12vhm8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] hw/block/fdc: Replace
 error_setg(&error_abort) by error_report() + abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 06/07/2018 10:41 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>> On 05/30/2018 05:23 PM, John Snow wrote:
>>> On 05/29/2018 01:48 PM, Philippe Mathieu-Daudé wrote:
>>>> Use error_report() + abort() instead of error_setg(&error_abort),
>>>> as suggested by the "qapi/error.h" documentation:
>>>>
>>>>     Please don't error_setg(&error_fatal, ...), use error_report() and
>>>>     exit(), because that's more obvious.
>>>>     Likewise, don't error_setg(&error_abort, ...), use assert().
>>>>
>>>
>>> Didn't realize this was bad form (Why do we have it?)
> 
> Because &error_abort has other uses, and I can't see how we can get rid
> of just error_setg(&error_abort, ...).  Open to ideas.
> 
>>>> Use abort() instead of the suggested assert() because the error message
>>>> already got displayed.
>>>>
>>>
>>> Update the suggestion?
>>
>> Fair enough.
> 
> No.  I intentionally pointed to assert(), because ...
> 
>>>> Suggested-by: Eric Blake <eblake@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>
>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>> Acked-by: John Snow <jsnow@redhat.com>
>>
>> Thanks!
>>
>>>> ---
>>>>  hw/block/fdc.c | 7 ++++---
>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
>>>> index cd29e27d8f..048467c00b 100644
>>>> --- a/hw/block/fdc.c
>>>> +++ b/hw/block/fdc.c
>>>> @@ -401,9 +401,10 @@ static int pick_geometry(FDrive *drv)
>>>>  
>>>>      /* No match of any kind found -- fd_format is misconfigured, abort. */
>>>>      if (match == -1) {
>>>> -        error_setg(&error_abort, "No candidate geometries present in table "
>>>> -                   " for floppy drive type '%s'",
>>>> -                   FloppyDriveType_str(drv->drive));
>>>> +        error_report("No candidate geometries present in table "
>>>> +                     " for floppy drive type '%s'",
>>>> +                     FloppyDriveType_str(drv->drive));
>>>> +        abort();
> 
> ... no matter how "nice" you make the message before an abort, it's
> still an abort.  It should not happen (or else aborting would be wrong),
> and when it does, somebody will have to stare at the code anyway.  I
> recommend not to bother with niceties there.

OK I see, thanks for the clear explanation.

> 
> Pig:
> 
>     hw/block/fdc.c:403:pick_geometry: assertion failed: (match != -1)
>     Aborted (core dumped)
> 
> Pig with lipstick on:
> 
>     No candidate geometries present in table for floppy drive type 'FOO'
>     Aborted (core dumped)
> 
> Now, if you're really, really into lipstick: to each his own.  But
> please return the courtesy and keep it out of the stuff I maintain :)
> 
>>>>      }
>>>>  
>>>>      parse = &(fd_formats[match]);
>>>> -- 
>>>> 2.17.0
