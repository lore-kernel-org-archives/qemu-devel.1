Received: from eggs.gnu.org ([209.51.188.92]:58625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZur-0002iX-Cz
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZjb-0002zA-DY
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:52:16 -0400
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<66295a3d9e21f52d777e6354d6c0f98b0bcb0c26.1556650594.git.alistair.francis@wdc.com>
	<8a53bfff-9b16-7dcf-1626-5b93a44e8dfc@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <af35033d-657f-dde0-418d-3019e7fc3282@vivier.eu>
Date: Tue, 30 Apr 2019 22:51:52 +0200
MIME-Version: 1.0
In-Reply-To: <8a53bfff-9b16-7dcf-1626-5b93a44e8dfc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RGjiCx9lbdc4bGu5GZ6CLlU7KiDG9QW7L"
Subject: Re: [Qemu-devel] [PATCH v1 4/5] linux-user/uname: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "kraxel@redhat.com" <kraxel@redhat.com>, "alistair23@gmail.com" <alistair23@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RGjiCx9lbdc4bGu5GZ6CLlU7KiDG9QW7L
From: Laurent Vivier <laurent@vivier.eu>
To: Eric Blake <eblake@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>
Message-ID: <af35033d-657f-dde0-418d-3019e7fc3282@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v1 4/5] linux-user/uname: Fix GCC 9 build
 warnings
References: <cover.1556650594.git.alistair.francis@wdc.com>
 <66295a3d9e21f52d777e6354d6c0f98b0bcb0c26.1556650594.git.alistair.francis@wdc.com>
 <8a53bfff-9b16-7dcf-1626-5b93a44e8dfc@redhat.com>
In-Reply-To: <8a53bfff-9b16-7dcf-1626-5b93a44e8dfc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 30/04/2019 =C3=A0 22:40, Eric Blake a =C3=A9crit=C2=A0:
> On 4/30/19 3:09 PM, Alistair Francis wrote:
>> Fix this warning when building with GCC9 on Fedora 30:
>> In function =E2=80=98strncpy=E2=80=99,
>>     inlined from =E2=80=98sys_uname=E2=80=99 at /home/alistair/qemu/li=
nux-user/uname.c:94:3:
>> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin=
_strncpy=E2=80=99 output may be truncated copying 64 bytes from a string =
of length 64 [-Werror=3Dstringop-truncation]
>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos =
(__dest));
>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  linux-user/uname.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/linux-user/uname.c b/linux-user/uname.c
>> index 313b79dbad..293b2238f2 100644
>> --- a/linux-user/uname.c
>> +++ b/linux-user/uname.c
>> @@ -90,6 +90,11 @@ int sys_uname(struct new_utsname *buf)
>>     * struct linux kernel uses).
>>     */
>> =20
>> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9=
, 0)
>> +#pragma GCC diagnostic push
>> +#pragma GCC diagnostic ignored "-Wstringop-truncation"
>> +#endif
>=20
> Why do we need the pragma?
>=20
>> +
>>    memset(buf, 0, sizeof(*buf));
>=20
> We are prezeroing the entire field, at which point...
>=20
>>    COPY_UTSNAME_FIELD(buf->sysname, uts_buf.sysname);
>>    COPY_UTSNAME_FIELD(buf->nodename, uts_buf.nodename);
>=20
> ...using strncpy() for a shorter string is wasteful (we're writing the
> tail end twice), and for a long string is warning-prone.  Why not
> rewrite COPY_UTSNAME_FIELD() to use memcpy() for the MIN(strlen(src),
> __NEW_UTS_LEN) and drop the write of the trailing NUL, since it will
> already be NUL from your memset()?
>=20

We must modify this very carefully because I think there is some magic
in COPY_UTSNAME_FIELD() we could miss.

#define COPY_UTSNAME_FIELD(dest, src) \
  do { \
      /* __NEW_UTS_LEN doesn't include terminating null */ \
      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
      (dest)[__NEW_UTS_LEN] =3D '\0'; \
  } while (0)

Thanks,
Laurent


--RGjiCx9lbdc4bGu5GZ6CLlU7KiDG9QW7L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzS913cjjpNwuT1Fz8ww4vT8vvjwFAlzItWgACgkQ8ww4vT8v
vjzunA/9GYWUUTpHkjAtHkCO+bSXM1k2ZH1XpzFtTmtH+PPyfJAvzOkIUiKiOLJj
lbq7pSjEoxGgEF3vi/Qq+xmOh99f7EZKw/L9ulpxjet/wWiC8vkYBQYKruvEO3Rv
wp71BVs8gE4eYteZL1unIYKckEsRaKlLedZa8z87YaA+4I8FM7LIhAydAMDuciR5
3Gq0tcvBPlwlGH02Vzrup/1bARwvZ4RhJ8PTib6aJmskWXXNlrr+bKrtGfc8OybZ
XU5h7lFGHt0HysAahZdM7ojbggu3F7BTJkxjpv/fXHOD6K9MjxUSnPMs+jfXlL28
taf9Miyy/N7kgAevH8vi5eWKgF/Qxu6ckisHGu5qL6Ze+ENy+r5bJKWEKkoKiV8i
guE1T0H2MlbgHJYul6SHGbc/1TKvYNob6JAnclNXDrgqZbXj3oV3CElKfZj04SEh
7NTHud5FpcH6RnJAYuplvy3IYglqCvHXJkG8hvpP631pzrCpjDSw/WyDRwAvc5+4
QeTUbRdFK9Nl0Renk/clekIr5fFmPADk/5dZsmq5+mvDAsRw5nFVTKmslHtAj85K
m3+HFMoTymRAZVwYm+RkfZWjLicGrTxzakzyetZGmfaIybY8YVAlkuJo0YP/+CqQ
cLAwX0Z9FjoLl7v0jafk/RlOcZ+QcDKZrjJ6BoENMDAAOmvocqk=
=6B+P
-----END PGP SIGNATURE-----

--RGjiCx9lbdc4bGu5GZ6CLlU7KiDG9QW7L--
