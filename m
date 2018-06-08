Received: from eggs.gnu.org ([2001:4830:134:3::10]:35174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRIvh-0003v6-MF
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRIvg-0002qI-NW
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:03:53 -0400
References: <20180607144645.10187-1-f4bug@amsat.org>
	<20180607144645.10187-2-f4bug@amsat.org>
	<30e6332f-7f4f-5fe3-9517-d057d3bff4a7@redhat.com>
	<87k1r9dd8c.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <45a8a086-a04b-bc54-31a1-570521c657cf@redhat.com>
Date: Fri, 8 Jun 2018 11:03:43 -0400
MIME-Version: 1.0
In-Reply-To: <87k1r9dd8c.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hw/block/fdc: Replace
 error_setg(&error_abort) by assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 06/08/2018 02:05 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
>=20
>> On 06/07/2018 10:46 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Use assert() instead of error_setg(&error_abort),
>>> as suggested by the "qapi/error.h" documentation:
>>>
>>>     Please don't error_setg(&error_fatal, ...), use error_report() an=
d
>>>     exit(), because that's more obvious.
>>>     Likewise, don't error_setg(&error_abort, ...), use assert().
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  hw/block/fdc.c | 9 +--------
>>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>>
>>> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
>>> index cd29e27d8f..7c1c57f57f 100644
>>> --- a/hw/block/fdc.c
>>> +++ b/hw/block/fdc.c
>>> @@ -396,16 +396,9 @@ static int pick_geometry(FDrive *drv)
>>>                             nb_sectors,
>>>                             FloppyDriveType_str(parse->drive));
>>>          }
>>> +        assert(type_match !=3D -1 && "misconfigured fd_format");
>>>          match =3D type_match;
>>>      }
>>> -
>>> -    /* No match of any kind found -- fd_format is misconfigured, abo=
rt. */
>>> -    if (match =3D=3D -1) {
>>> -        error_setg(&error_abort, "No candidate geometries present in=
 table "
>>> -                   " for floppy drive type '%s'",
>>> -                   FloppyDriveType_str(drv->drive));
>>> -    }
>>> -
>>>      parse =3D &(fd_formats[match]);
>>> =20
>>>   out:
>>>
>>
>> Truthfully sad to see the lipstick go, because this is my pig.
>> Oh well, it doesn't matter. Not really, anyway.
>>
>> ACK
>=20
> There's still a bit of lipstick in assert()'s argument.
>=20
> v1 has the error_report() lipstick.  Would you like me to merge that on=
e
> instead?  Your pig, your choice :)
>=20

In the end I trust your judgement. I like the more verbose error message
because it tells you precisely what's going on. I like the assert
because it tells you WHERE in the code you've messed up.

I am often very keen on making things more usable and less tersely
worded. I think you favor some of the same things, but with years more
experience than I have.

So I defer to you; after all -- they're just pigs :)

--js
