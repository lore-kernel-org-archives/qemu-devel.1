Received: from eggs.gnu.org ([2001:4830:134:3::10]:56022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHyWN-0005A3-Fl
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 16:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHyWJ-00068a-8z
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 16:22:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHyWI-00067Y-Vo
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 16:22:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CF9980F75
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 20:22:33 +0000 (UTC)
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-5-git-send-email-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d74b1067-d582-78af-d849-8d8b7b837dcf@redhat.com>
Date: Mon, 5 Jun 2017 15:22:24 -0500
MIME-Version: 1.0
In-Reply-To: <1495176212-14446-5-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wINEp7ILn47A7hoIw3LttiswncCqAS9hE"
Subject: Re: [Qemu-devel] [PATCH RFC 4/6] migration: shut src return path
 unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wINEp7ILn47A7hoIw3LttiswncCqAS9hE
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Message-ID: <d74b1067-d582-78af-d849-8d8b7b837dcf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 4/6] migration: shut src return path
 unconditionally
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
 <1495176212-14446-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1495176212-14446-5-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 01:43 AM, Peter Xu wrote:
> We were do the shutting off only for postcopy. Now we do this as long a=
s
> the source return path is there.
>=20
> Moving the cleanup of from_src_file there too.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c    | 8 +++++++-
>  migration/postcopy-ram.c | 1 -
>  2 files changed, 7 insertions(+), 2 deletions(-)

This commit causes a regression in qemu-iotests 68:

$ cd tests/qemu-iotests
$ ./check -qcow2 68
=2E..
068 1s ... - output mismatch (see 068.out.bad)
--- /home/eblake/qemu-tmp2/tests/qemu-iotests/068.out	2017-05-30
09:27:26.795821748 -0500
+++ 068.out.bad	2017-06-05 15:21:18.566816816 -0500
@@ -6,6 +6,8 @@
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm 0
 (qemu) quit
+./common.config: line 107:  1912 Segmentation fault      (core dumped)
( if [ -n "${QEMU_NEED_PID}" ]; then
+    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
+fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
-*** done
+(qemu) *** done
Failures: 068
Failed 1 of 1 tests

I didn't investigate further; but am hoping you'll be able to fix the
segfault and get the test working again.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wINEp7ILn47A7hoIw3LttiswncCqAS9hE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNb2AAAoJEKeha0olJ0NqDKAH/A4vzLrirCmzN1RibmbkjJ6U
JoAyuQVvmdpMpBOh/t8gBKHBFrcEoxFfukgDhHXCl3bKuex/Qcla7T772P8QIFFr
mHueVOTV+Otlcu27LWk88fmsex4nO7bAGW3eyeCYiCAk5CPPO72GaepWYCWgmnbn
V5pwUX6CSxGcqT0C2LBuweluamPp5BLLL+aEu5AfOu4rlip8ks0RCGQV/ioBL6Dz
n4VyWSMAwX3m86X761VqUXv5FioqTKXj7D3KE1sf7Gr0SdmrGb8GEf4Qhbq4BQwT
9pFk3K0f5CuSw00yCrh3m+hfm07naLKv7EuD/io6IOAVp1tW9vADEN2ay7Lep7o=
=Xagn
-----END PGP SIGNATURE-----

--wINEp7ILn47A7hoIw3LttiswncCqAS9hE--
