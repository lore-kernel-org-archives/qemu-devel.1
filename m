Received: from eggs.gnu.org ([2001:4830:134:3::10]:50134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfB3l-00037J-Pi
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfB3h-0007kp-SM
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:25:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfB3h-0007kg-I1
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:24:57 -0400
References: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
	<9e56de2e-2c20-6e28-efd0-1f78b21a7be5@amsat.org>
	<9f3c0af6-1ff8-adca-9f69-2be8dd7d250f@redhat.com>
	<db1e220e-f3bf-352d-57ac-6ad3b427e944@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c26818de-c402-2db2-25f7-0e568ab41ddf@redhat.com>
Date: Tue, 8 Aug 2017 15:24:45 -0500
MIME-Version: 1.0
In-Reply-To: <db1e220e-f3bf-352d-57ac-6ad3b427e944@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BPSgwk9vuFiaCO2sdUGCvGWci8Hxwv3bF"
Subject: Re: [Qemu-devel] [for-2.10 PATCH] 9pfs: local: fix
 fchmodat_nofollow() limitations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>, zhiyong.wu@ucloud.cn, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BPSgwk9vuFiaCO2sdUGCvGWci8Hxwv3bF
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 zhiyong.wu@ucloud.cn, qemu-devel@nongnu.org
Message-ID: <c26818de-c402-2db2-25f7-0e568ab41ddf@redhat.com>
Subject: Re: [Qemu-devel] [for-2.10 PATCH] 9pfs: local: fix
 fchmodat_nofollow() limitations
References: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
 <9e56de2e-2c20-6e28-efd0-1f78b21a7be5@amsat.org>
 <9f3c0af6-1ff8-adca-9f69-2be8dd7d250f@redhat.com>
 <db1e220e-f3bf-352d-57ac-6ad3b427e944@amsat.org>
In-Reply-To: <db1e220e-f3bf-352d-57ac-6ad3b427e944@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 03:10 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Technically, POSIX says (and 'man 2 open' agrees, modulo the fact that=

>> Linux still lacks O_SEARCH) that you MUST provide one of the 5 access
>> modes (they are O_RDONLY, O_RDWR, O_WRONLY, O_EXEC, and O_SEARCH;
>> although POSIX allows O_EXEC and O_SEARCH to be the same bit pattern),=

>> and then bitwise-or any additional flags.  So the usage here is correc=
t.
>>

> Oh ok. I didn't think of that, just checked Linux manpage:
>=20
>    O_PATH (since Linux 2.6.39)
>=20
>           When O_PATH is specified in flags, flag bits other than
>           O_CLOEXEC, O_DIRECTORY, and O_NOFOLLOW are ignored.

There are access modes (5 in POSIX), and then flag bits (O_NONBLOCK
being one of the flag bits, and therefore ignored when O_PATH is true).
Presumably, the author was being careful by mentioning "flag bits" (and
thereby implicitly meaning that O_RDONLY is NOT ignored when using
O_PATH).  But I'm not _quite_ sure whether O_PATH should be considered a
sixth access mode, or a flag bit, and the Linux man page doesn't help on
that front ;)  Hmm - if you treat O_PATH as an access mode rather than a
flag bit, then O_RDONLY | O_PATH no longer makes sense at all (you can't
mix two modes at once).  Maybe we should file a bug report against the
man page to get clarification.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BPSgwk9vuFiaCO2sdUGCvGWci8Hxwv3bF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKHg0ACgkQp6FrSiUn
Q2qHNggAqBTifNxBc5o9k7eZQjl1kS6R5QDuFpEOLhQRihbE7qLSfLliyhUxppXB
vr/6vkwCheyRFK2tiLzqTErW5TnAl31nIaNiaKIhMV9AHxxB1YOMebw8RupgKJho
P2m5H3zNFoI1/NrXK+B1VtwJci5z0HOEhXh5FLkFr88TfH+JDw5UhIk6s2BeZ2ly
C6dugp8uiGIK4HLrMF7EYarH2hoR/ZK9i6HIjuF649MPpNcKT0qdD+/t/CkwCvED
Dug6Yecpp8fC5gf1b4jcsf0Pxvusob01m+eGoAAhjHuD4dagXKhO6/GWL1xMsY7M
JbEaOmp2Absy7q8KExiBm300jS2YpQ==
=tB+b
-----END PGP SIGNATURE-----

--BPSgwk9vuFiaCO2sdUGCvGWci8Hxwv3bF--
