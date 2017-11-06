Received: from eggs.gnu.org ([2001:4830:134:3::10]:60615)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1eBiJ2-0005xP-F9
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1eBiIy-0006nU-Dh
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:23:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:51655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1eBiIy-0006mu-37
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:23:12 -0500
References: <20171013102812.29648-1-berrange@redhat.com>
	<1c52fcd4-e8ce-51c1-a0c7-cf882fab6662@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <6ed3aafe-4b5d-a9fb-6233-d27a20b656d0@gmx.com>
Date: Mon, 6 Nov 2017 15:25:34 +0100
MIME-Version: 1.0
In-Reply-To: <1c52fcd4-e8ce-51c1-a0c7-cf882fab6662@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wtI7QOOkjKdRv6ih3Viw0NfuKug78WewA"
Subject: Re: [Qemu-devel] [PATCH] configure: pick the right compiler for
 OpenBSD by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wtI7QOOkjKdRv6ih3Viw0NfuKug78WewA
From: Kamil Rytarowski <n54@gmx.com>
To: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ed3aafe-4b5d-a9fb-6233-d27a20b656d0@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] configure: pick the right compiler for
 OpenBSD by default
References: <20171013102812.29648-1-berrange@redhat.com>
 <1c52fcd4-e8ce-51c1-a0c7-cf882fab6662@redhat.com>
In-Reply-To: <1c52fcd4-e8ce-51c1-a0c7-cf882fab6662@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.10.2017 12:52, Thomas Huth wrote:
> On 13.10.2017 12:28, Daniel P. Berrange wrote:
>> The system compiler in OpenBSD is gcc 4.2.1 which is too
>> old for our needs. If doing 'pkg_add gcc' you can get a
>> much newer version (4.9.4 in OpenBSD 6.1) which works with
>> QEMU. This installs binaries with two naming schemes:
>>
>>   $ pkg_info  -L gcc | grep bin
>>   /usr/local/bin/ecpp
>>   /usr/local/bin/egcc
>>   /usr/local/bin/egcc-ar
>>   /usr/local/bin/egcc-nm
>>   /usr/local/bin/egcc-ranlib
>>   /usr/local/bin/egcov
>>   /usr/local/bin/x86_64-unknown-openbsd6.0-egcc
>>   /usr/local/bin/x86_64-unknown-openbsd6.0-egcc-ar
>>   /usr/local/bin/x86_64-unknown-openbsd6.0-egcc-nm
>>   /usr/local/bin/x86_64-unknown-openbsd6.0-egcc-ranlib
>>   /usr/local/bin/x86_64-unknown-openbsd6.0-gcc-4.9.3
>>
>> We pick the short name this it won't change across OpenBSD
>> releases.
>>
>> This means users don't need to manually pass custom --cc
>> and --cxx args to configure to avoid immediate failure.
>>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>  configure | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 06f18ea9af..fcb7523933 100755
>> --- a/configure
>> +++ b/configure
>> @@ -255,7 +255,21 @@ cross_prefix=3D""
>>  audio_drv_list=3D""
>>  block_drv_rw_whitelist=3D""
>>  block_drv_ro_whitelist=3D""
>> -host_cc=3D"cc"
>> +
>> +case `uname -s` in
>> +    OpenBSD)
>> +    # Default system cc in OpenBSD is unsufficient
>=20
> s/unsufficient/insufficient/
>=20
>> +    # we need the 'gcc' pkg added, whch provides
>=20
> s/whch/which/
>=20
>> +    # these modified binary names
>> +    host_cc=3D"egcc"
>> +    host_cxx=3D"eg++"
>> +    ;;
>> +         *)
>> +    host_cc=3D"cc"
>> +    host_cxx=3D"c++"
>> +    ;;
>> +esac
>=20
> Do we really need such work-arounds in our configure script? GCC 4.2 is=

> really veeeery old nowadays, so if the OpenBSD folks refuse to update
> the default in their distro, IMHO they should be punished by having to
> select the C compiler manually everywhere.
>=20
>  Thomas
>=20

OpenBSD switched to Clang/LLVM and they insist to support older
releases. We can silently ignore their GCC 4.2.1 (the latest one GPLv2
release).


--wtI7QOOkjKdRv6ih3Viw0NfuKug78WewA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaAHDlAAoJEEuzCOmwLnZs6KkP/RbM6WI90yeD9lTMwDcdFKZb
JGzClm+Q+8O6/Hyf7w2+5NDupNzpokZscLWBFk0E+AqhW9OaFzaEGr+vs1R3B9U2
dzhwjvGGyo/Q82lhYIrAz7tbXYqepMNvirEBEtJFp55DmAF8fLvDl0TJW9MxN09A
R/rAfb1n9U5vwJWsNCQWZk/a8fR5snPslaFhr5qLZPgIs6fDu8QOjtlbvXBNIymY
NwvZxtb5PHeUEaEEz3YraBye9pPb9DNTaMV3PVjlhUXrCEQYasl8gzZPWspaVAKp
E2ZJynGu/HjRx1FrGz8Sf5VLPcu+7JeGeXale1WBrddvpwRx840nu6pYrUbOXNk/
RSPhepcz3QFtRAi7PUMwLbI7hHZ4+5RK1KSmFIEg3PkUwDAnet6kM39R6Ls+vtgD
z0bqhO8cP9fhgrPpqONJsL+JJtGKnlo/irEmntOsM2Psm9tPqV2mMQ3kQflFguRL
9JexFZyosCjz5Ih2PFYpXQm5SrBEGa1Odnifxm3iU4hQDNvdSWJLQ8dSJtA7TnRb
D2n05oQ6Yj6P2QzGo0KThgLZZ9Sj0q6lKQqCo98pjRpDY8z+XSQxv7RFUHUQm6HA
qSoX0JHBqRt6ynMt1WLaLNbtqovHroOJ0QNnx0tKjTDUhHseV8MJL3syNT+Sopfl
2hOdg5c+NWUuW5KslgyV
=ixja
-----END PGP SIGNATURE-----

--wtI7QOOkjKdRv6ih3Viw0NfuKug78WewA--
