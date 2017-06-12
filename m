Received: from eggs.gnu.org ([2001:4830:134:3::10]:47631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKQ9S-0008CU-Sp
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKQ9R-00022D-Mk
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:17:06 -0400
References: <CAPhXLnv2g_80gi1o6p-QUbKJQ5m+6gkLDN8TWtE-B=70uacDEw@mail.gmail.com>
	<CAPhXLnuNAqwQHdns2Sxv4UuFz9WhGH1ZM4E4TN87e31cDpZ7gQ@mail.gmail.com>
	<fec4ddf7-f316-675b-bccb-236f281a174a@amsat.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3329e926-2300-97b8-4607-0800acc600f9@redhat.com>
Date: Mon, 12 Jun 2017 16:16:50 +0200
MIME-Version: 1.0
In-Reply-To: <fec4ddf7-f316-675b-bccb-236f281a174a@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="35qgAMkojOW6EwaKwgFQ5CerHCRtJV6p4"
Subject: Re: [Qemu-devel] Fwd: [BUG] Failed to compile using gcc7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Tsung-en Hsiao <tsn@cs.nctu.edu.tw>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Qu Wenruo <quwenruo@cn.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--35qgAMkojOW6EwaKwgFQ5CerHCRtJV6p4
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Tsung-en Hsiao <tsn@cs.nctu.edu.tw>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <3329e926-2300-97b8-4607-0800acc600f9@redhat.com>
Subject: Re: [Qemu-devel] Fwd: [BUG] Failed to compile using gcc7.1
References: <CAPhXLnv2g_80gi1o6p-QUbKJQ5m+6gkLDN8TWtE-B=70uacDEw@mail.gmail.com>
 <CAPhXLnuNAqwQHdns2Sxv4UuFz9WhGH1ZM4E4TN87e31cDpZ7gQ@mail.gmail.com>
 <fec4ddf7-f316-675b-bccb-236f281a174a@amsat.org>
In-Reply-To: <fec4ddf7-f316-675b-bccb-236f281a174a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-12 05:19, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Tsung-en,
>=20
> On 06/11/2017 04:08 PM, Tsung-en Hsiao wrote:
>> Hi all,
>> I encountered the same problem on gcc 7.1.1 and found Qu's mail in
>> this list from google search.
>>
>> Temporarily fix it by specifying the string length in snprintf
>> directive. Hope this is helpful to other people encountered the same
>> problem.
>=20
> Thank your for sharing this.
>=20
>>
>> @@ -1,9 +1,7 @@
>> ---
>> --- a/block/blkdebug.c
>> -                 "blkdebug:%s:%s", s->config_file ?: "",
>> --- a/block/blkverify.c
>> -                 "blkverify:%s:%s",
>> --- a/hw/usb/bus.c
>> -        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",=

>> -        snprintf(downstream->path, sizeof(downstream->path), "%d",
>> portnr);
>> --=20
>> +++ b/block/blkdebug.c
>> +                 "blkdebug:%.2037s:%.2037s", s->config_file ?: "",
>=20
> It is a rather funny way to silent this warning :) Truncating the
> filename until it fits.
>=20
> However I don't think it is the correct way since there is indeed an
> overflow of bs->exact_filename.
>=20
> Apparently exact_filename from "block/block_int.h" is defined to hold a=

> pathname:
>     char exact_filename[PATH_MAX];
>=20
> but is used for more than that (for example in blkdebug.c it might use
> until 10+2*PATH_MAX chars).

In any case, truncating the filenames will do just as much as truncating
the result: You'll get an unusable filename.

> I suppose it started as a buffer to hold a pathname then more block
> drivers were added and this buffer ended used differently.
>=20
> If it is a multi-purpose buffer one safer option might be to declare it=

> as a GString* and use g_string_printf().

What it is supposed to be now is just an information string we can print
to the user, because strings are nicer than JSON objects. There are some
commands that take a filename for identifying a block node, but I dream
we can get rid of them in 3.0...

The right solution is to remove it altogether and have a
"char *bdrv_filename(BlockDriverState *bs)" function (which generates
the filename every time it's called). I've been working on this for some
years now, actually, but it was never pressing enough to get it finished
(so I never had enough time).

What we can do in the meantime is to not generate a plain filename if it
won't fit into bs->exact_filename.

(The easiest way to do this probably would be to truncate
bs->exact_filename back to an empty string if snprintf() returns a value
greater than or equal to the length of bs->exact_filename.)

What to do about hw/usb/bus.c I don't know (I guess the best solution
would be to ignore the warning, but I don't suppose that is going to work=
).

Max

>=20
> I CC'ed the block folks to have their feedback.
>=20
> Regards,
>=20
> Phil.
>=20
>> +++ b/block/blkverify.c
>> +                 "blkverify:%.2038s:%.2038s",
>> +++ b/hw/usb/bus.c
>> +        snprintf(downstream->path, sizeof(downstream->path), "%.12s.%=
d",
>> +        snprintf(downstream->path, sizeof(downstream->path), "%.12d",=

>> portnr);
>>
>> Tsung-en Hsiao
>>
>>> Qu Wenruo Wrote:
>>>
>>> Hi all,
>>>
>>> After upgrading gcc from 6.3.1 to 7.1.1, qemu can't be compiled with
>>> gcc.
>>>
>>> The error is:
>>>
>>> ------
>>>  CC      block/blkdebug.o
>>> block/blkdebug.c: In function 'blkdebug_refresh_filename':
>>>
>>> block/blkdebug.c:693:31: error: '%s' directive output may be
>>> truncated writing up to 4095 bytes into a region of size 4086
>>> [-Werror=3Dformat-truncation=3D]
>>>
>>>                  "blkdebug:%s:%s", s->config_file ?: "",
>>>                               ^~
>>> In file included from /usr/include/stdio.h:939:0,
>>>                 from /home/adam/qemu/include/qemu/osdep.h:68,
>>>                 from block/blkdebug.c:25:
>>>
>>> /usr/include/bits/stdio2.h:64:10: note: '__builtin___snprintf_chk'
>>> output 11 or more bytes (assuming 4106) into a destination of size 40=
96
>>>
>>>   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,=

>>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=

>>>        __bos (__s), __fmt, __va_arg_pack ());
>>>        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> cc1: all warnings being treated as errors
>>> make: *** [/home/adam/qemu/rules.mak:69: block/blkdebug.o] Error 1
>>> ------
>>>
>>> It seems that gcc 7 is introducing more restrict check for printf.
>>>
>>> If using clang, although there are some extra warning, it can at
>>> least pass the compile.
>>>
>>> Thanks,
>>> Qu
>>



--35qgAMkojOW6EwaKwgFQ5CerHCRtJV6p4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZPqJSEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQDns
CAChJuwVY1kaXddtIxXaXPcLn73fSD+8JBIZlthzoOKW/Rhp+4E6vFayafmODALb
61ZtosPBVPtg+geR3nFETvJmuZdbJXnBl2ScwZ7ZxS80uH5IphgqT3M8h4vq85TI
QSaT1LVMze7YE2SsNKYFK+pym3S3X4byDpBO7DeduKDFSe2uHak6qJqVLSmd7EfP
xWCZvQGaXcdOWgNcOzVbuiPsHSBrHcTLLhhJ/MXJ1dHivC6FHrxt/nCqbhpsWosm
hLg2poXS2w3EwQMTfaZw6YyPH9DqtEOvnjGKBjQdmg/+BWIYDCEBghlNwkfYZ7QZ
j2ta4jGzlHAjkeoPZFjv9spL
=OKnK
-----END PGP SIGNATURE-----

--35qgAMkojOW6EwaKwgFQ5CerHCRtJV6p4--
