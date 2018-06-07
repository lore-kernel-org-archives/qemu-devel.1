Received: from eggs.gnu.org ([2001:4830:134:3::10]:35874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvAg-0000KF-Jp
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvAf-0007Gf-Q0
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:41:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180529174821.19964-1-f4bug@amsat.org>
	<20180529174821.19964-2-f4bug@amsat.org>
	<fba4c1c5-a479-60c6-31e3-99affcacd5b7@redhat.com>
	<5374cfa5-e314-0c4f-92e9-b3ec3bf3bd95@amsat.org>
Date: Thu, 07 Jun 2018 15:41:35 +0200
In-Reply-To: <5374cfa5-e314-0c4f-92e9-b3ec3bf3bd95@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed,
	30 May 2018 18:30:58 -0300")
Message-ID: <87po12vhm8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 05/30/2018 05:23 PM, John Snow wrote:
>> On 05/29/2018 01:48 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Use error_report() + abort() instead of error_setg(&error_abort),
>>> as suggested by the "qapi/error.h" documentation:
>>>
>>>     Please don't error_setg(&error_fatal, ...), use error_report() and
>>>     exit(), because that's more obvious.
>>>     Likewise, don't error_setg(&error_abort, ...), use assert().
>>>
>>=20
>> Didn't realize this was bad form (Why do we have it?)

Because &error_abort has other uses, and I can't see how we can get rid
of just error_setg(&error_abort, ...).  Open to ideas.

>>> Use abort() instead of the suggested assert() because the error message
>>> already got displayed.
>>>
>>=20
>> Update the suggestion?
>
> Fair enough.

No.  I intentionally pointed to assert(), because ...

>>> Suggested-by: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>=20
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> Acked-by: John Snow <jsnow@redhat.com>
>
> Thanks!
>
>>> ---
>>>  hw/block/fdc.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
>>> index cd29e27d8f..048467c00b 100644
>>> --- a/hw/block/fdc.c
>>> +++ b/hw/block/fdc.c
>>> @@ -401,9 +401,10 @@ static int pick_geometry(FDrive *drv)
>>>=20=20
>>>      /* No match of any kind found -- fd_format is misconfigured, abort=
. */
>>>      if (match =3D=3D -1) {
>>> -        error_setg(&error_abort, "No candidate geometries present in t=
able "
>>> -                   " for floppy drive type '%s'",
>>> -                   FloppyDriveType_str(drv->drive));
>>> +        error_report("No candidate geometries present in table "
>>> +                     " for floppy drive type '%s'",
>>> +                     FloppyDriveType_str(drv->drive));
>>> +        abort();

... no matter how "nice" you make the message before an abort, it's
still an abort.  It should not happen (or else aborting would be wrong),
and when it does, somebody will have to stare at the code anyway.  I
recommend not to bother with niceties there.

Pig:

    hw/block/fdc.c:403:pick_geometry: assertion failed: (match !=3D -1)
    Aborted (core dumped)

Pig with lipstick on:

    No candidate geometries present in table for floppy drive type 'FOO'
    Aborted (core dumped)

Now, if you're really, really into lipstick: to each his own.  But
please return the courtesy and keep it out of the stuff I maintain :)

>>>      }
>>>=20=20
>>>      parse =3D &(fd_formats[match]);
>>> --=20
>>> 2.17.0
