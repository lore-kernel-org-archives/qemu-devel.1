Received: from eggs.gnu.org ([209.51.188.92]:55971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLnuz-0002AA-IS
	for qemu-devel@nongnu.org; Wed, 01 May 2019 08:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLnuw-00031u-GD
	for qemu-devel@nongnu.org; Wed, 01 May 2019 08:00:57 -0400
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<14aab381eaa678eca875d0b8bd456feb22a21bd8.1556666645.git.alistair.francis@wdc.com>
	<503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af19377f-4874-0374-99b6-ee9ab5b0f446@redhat.com>
Date: Wed, 1 May 2019 07:00:03 -0500
MIME-Version: 1.0
In-Reply-To: <503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cWuKhQNXUyPcCDWb7oTARORvy0k7wUsDw"
Subject: Re: [Qemu-devel] [PATCH v2 4/5] linux-user/uname: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "kraxel@redhat.com" <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cWuKhQNXUyPcCDWb7oTARORvy0k7wUsDw
From: Eric Blake <eblake@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Message-ID: <af19377f-4874-0374-99b6-ee9ab5b0f446@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] linux-user/uname: Fix GCC 9 build
 warnings
References: <cover.1556666645.git.alistair.francis@wdc.com>
 <14aab381eaa678eca875d0b8bd456feb22a21bd8.1556666645.git.alistair.francis@wdc.com>
 <503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
In-Reply-To: <503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/1/19 4:40 AM, Laurent Vivier wrote:
> On 01/05/2019 01:28, Alistair Francis wrote:
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
>>  linux-user/uname.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/linux-user/uname.c b/linux-user/uname.c
>> index 313b79dbad..2fc6096a5b 100644
>> --- a/linux-user/uname.c
>> +++ b/linux-user/uname.c
>> @@ -73,7 +73,7 @@ const char *cpu_to_uname_machine(void *cpu_env)
>>  #define COPY_UTSNAME_FIELD(dest, src) \
>>    do { \
>>        /* __NEW_UTS_LEN doesn't include terminating null */ \
>> -      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
>> +      (void) memcpy((dest), (src), MIN(strlen(src), __NEW_UTS_LEN)); =
\
>=20
> You should use MIN(strlen(src) + 1, __NEW_UTS_LEN) to copy the NUL
> character if it is present and fit in __NEW_UTS_LEN.

No, the NUL character is already present, due to the memset() prior to
any use of COPY_UTSNAME_FIELD().  However, the commit message should
call that out, as it is not part of the default 3-line diff.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--cWuKhQNXUyPcCDWb7oTARORvy0k7wUsDw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzJikQACgkQp6FrSiUn
Q2qfuAgApDJvUYWkMmk2kJMcz8AzL8zkLXtT1lbru3HnonwcauRyRUmLeUHgn7hq
I0lNxoR1/rxZmOr3cuiRxuO2N2Y6bLMNgYlRXeW7cgGnkEYVsjwuSD3dVkJ53ggh
pfIfVmiY2V1+WgoTj/9OL+RVDK5iu18GT3/D3FCqbjJTuDX4UlrCM0usd9kt616j
C0A5THCh7JhfY0GuqgkzrZmMUofBwR6CJTriAFPfEWQhNQRoTSCGS8kRjYNwGeW4
QZkOfRwZIX/3Mc1RsAf1Zba40mwtNAIKDfJNahYqidK4GulptiGIK2Mi33xKIocW
W0OqU6jTHk6ocLw7NjSwgC5wp0jwnw==
=74z3
-----END PGP SIGNATURE-----

--cWuKhQNXUyPcCDWb7oTARORvy0k7wUsDw--
