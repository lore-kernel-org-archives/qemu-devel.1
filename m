Received: from eggs.gnu.org ([2001:4830:134:3::10]:34307)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dH5ZF-0006bN-FL
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 05:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dH5ZC-0002Bu-CR
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 05:41:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:64140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dH5ZB-0002AB-Vr
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 05:41:54 -0400
References: <1496414138-7622-1-git-send-email-peter.maydell@linaro.org>
	<31f800cb-846d-e627-9d1f-f898a0948652@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <53bc1565-7ea2-0e13-65ab-db72e3dd9867@gmx.com>
Date: Sat, 3 Jun 2017 11:43:48 +0200
MIME-Version: 1.0
In-Reply-To: <31f800cb-846d-e627-9d1f-f898a0948652@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GGFMKTlLbEa7VGPXafCk2aOICtlGW1k3x"
Subject: Re: [Qemu-devel] [PATCH] configure: Define NCURSES_WIDECHAR if
 we're using curses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Chad Joan <chadjoan@gmail.com>, =?UTF-8?Q?Rainer_M=c3=bcller?= <raimue@codingfarm.de>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GGFMKTlLbEa7VGPXafCk2aOICtlGW1k3x
From: Kamil Rytarowski <n54@gmx.com>
To: Laszlo Ersek <lersek@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Chad Joan <chadjoan@gmail.com>,
 =?UTF-8?Q?Rainer_M=c3=bcller?= <raimue@codingfarm.de>, patches@linaro.org
Message-ID: <53bc1565-7ea2-0e13-65ab-db72e3dd9867@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Define NCURSES_WIDECHAR if we're
 using curses
References: <1496414138-7622-1-git-send-email-peter.maydell@linaro.org>
 <31f800cb-846d-e627-9d1f-f898a0948652@redhat.com>
In-Reply-To: <31f800cb-846d-e627-9d1f-f898a0948652@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.06.2017 23:58, Laszlo Ersek wrote:
> On 06/02/17 16:35, Peter Maydell wrote:
>> We want the wide character functions from the ncurses header.
>> Unfortunately it doesn't provide them by default, but only
>> if either:
>>  * NCURSES_WIDECHAR is defined (for ncurses 20111030 and up)
>>  * _XOPEN_SOURCE/_XOPEN_SOURCE_EXTENDED are suitably defined
>>
>> So far we have been implicitly relying on the latter, because
>> for GNU libc when we define _GNU_SOURCE this causes libc
>> to define the _XOPEN_SOURCE macros for us. Unfortunately
>> this doesn't work on all libcs, because some (like OSX and
>> musl libc) do not define _XOPEN_SOURCE when _GNU_SOURCE
>> is defined.
>>
>> We can't fix this by defining _XOPEN_SOURCE ourselves, because
>> that also means "and don't provide any functions that aren't in
>> that standard", and not all libcs provide any way to override
>> that to also get the non-standard functions. In particular
>> FreeBSD has no such mechanism, and OSX's _DARWIN_C_SOURCE
>> doesn't reenable everything (for instance getpagesize()
>> is still not prototyped if _DARWIN_C_SOURCE and _XOPEN_SOURCE
>> are both defined).
>>
>> So we have to define NCURSES_WIDECHAR. (This will only work
>> if your ncurses is at least 20111030, as older versions
>> don't honour this macro.)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Testing from the people with musl libc and OSX-with-ncurses
>> appreciated, as I don't have any systems which have the bug
>> which this patch is attempting to fix...
>>
>>  configure | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/configure b/configure
>> index 0586ec9..6aca5d1 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3053,6 +3053,8 @@ int main(void) {
>>  EOF
>>    IFS=3D:
>>    for curses_inc in $curses_inc_list; do
>> +    # Make sure we get the wide character prototypes
>> +    curses_inc=3D"-DNCURSES_WIDECHAR $curses_inc"
>>      IFS=3D:
>>      for curses_lib in $curses_lib_list; do
>>        unset IFS
>>
>=20
> Given that we're already consciously using non-portable functions, this=

> solution looks the least messy to me.
>=20

These functions are enough portable to work on NetBSD curses(3).

pkgsrc had an equivalent patch to define NCURSES_WIDECHAR=3D1 to fix buil=
d
on Darwin.

> Acked-by: Laszlo Ersek <lersek@redhat.com>
>=20
> Thanks
> Laszlo
>=20



--GGFMKTlLbEa7VGPXafCk2aOICtlGW1k3x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMoTaAAoJEEuzCOmwLnZsgPwQAIBsS3SgTTDE6DZuzmi7lmIw
JxuJGxxXvqFp1RC72LVp8466PgGU11Fn2bHFjm9QAKUhcesN60E3ZSw2Fueg445O
gU20zqK69BA7omujrAFItGm+QA9qVe+ecLlsfmfPJG2AaEG5r+MEY3/2zHB6gS6u
Nnog2NDKqPu+IZjLn20OrLUDw3iTzs44mCUcc0xoxT6BFSi306Z0aJ9ClxTF7jB/
sSvzMDjhs6yylLkdNF7uJ5TQ/CA2FDxs+7L4814HCK79SpuZYtVngGpMjZfJlvyo
9yZ9x7PssevXjsTo/X8gpYDFZhzNmt4n759ZwcvNDnfUbksqw6RBxE6b3yEALPKp
fmPkeFkrCYaPN73FdhXVS5gPyjMUdfXP16sk7irC40atA7ilMamfmuPEvEsPKc6T
p7B1xl/Z1OaIcsAAI0H1hsBhIpxU1axTDCcSOcsg/fSIqdo+eG98fDm5gC6ujDAp
+Q7aJath3eAPXJB3u6mC1uEiA9tY+SpcZSS1bwmCe8QVwInANupxjICgmWXyLbqs
zrIJ0mm+XEDh5uzvaOR1vcEFwnl/9S1KF3a0wt/dNyrMokVAVg4+fIwFhsIELeV1
3ilF54Jhi3UM4/2ccXA5eNmxkkH2ylWcace/BodDLym+TpsqnZUUWjKZZLS/bScs
CAkPUjOsp3KsAm6I6wg3
=Awm4
-----END PGP SIGNATURE-----

--GGFMKTlLbEa7VGPXafCk2aOICtlGW1k3x--
