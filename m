Received: from eggs.gnu.org ([2001:4830:134:3::10]:49013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHy9Y-0005FM-92
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 15:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHy9W-0005vl-KI
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 15:59:04 -0400
References: <20170605190824.25184-1-eblake@redhat.com>
	<20170605190824.25184-2-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbe7598c-77bb-eb1c-ba0c-59ebb600ae57@redhat.com>
Date: Mon, 5 Jun 2017 14:58:47 -0500
MIME-Version: 1.0
In-Reply-To: <20170605190824.25184-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nIRhip3BG4ri9r5Dibpci9psP7fL0S97N"
Subject: Re: [Qemu-devel] [PATCH v3 1/4] qemu-io: Don't die on second open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nIRhip3BG4ri9r5Dibpci9psP7fL0S97N
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <dbe7598c-77bb-eb1c-ba0c-59ebb600ae57@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/4] qemu-io: Don't die on second open
References: <20170605190824.25184-1-eblake@redhat.com>
 <20170605190824.25184-2-eblake@redhat.com>
In-Reply-To: <20170605190824.25184-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/05/2017 02:08 PM, Eric Blake wrote:

>=20
> Note, however, that we do have some qemu-iotests that do 'qemu-io
> -c "open file" -c "$something"'; such tests will now proceed to
> attempt $something whether or not the open succeeded, the same way
> as if the two commands had been attempted in interactive mode; but it
> also means that it is now possible to use -c close and have a single
> qemu-io command line operate on more than one file even without
> using interactive mode.  Although the '-c open' action is a subtle
> change in behavior, remember that qemu-io is for debugging purposes,
> so as long as it serves the needs of qemu-iotests while still being
> reasonable for interactive use, it should not be a problem.

Bummer - iotest 60 catches me:

+++ 060.out.bad	2017-06-05 14:55:48.336814834 -0500
@@ -21,6 +21,7 @@
     refcount bits: 16
     corrupt: true
 can't open device TEST_DIR/t.IMGFMT: IMGFMT: Image is corrupt; cannot
be opened read/write
+no file open, try 'help open'
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

Looks like 114 and 153 as well.  I'll have to post a v4 (serves me right
for JUST testing 177).

Also, I'm seeing a segfault on 68 that exists on current master:

068 1s ... - output mismatch (see 068.out.bad)
--- /home/eblake/qemu/tests/qemu-iotests/068.out	2017-06-01
17:01:25.113094957 -0500
+++ 068.out.bad	2017-06-05 14:55:54.140835402 -0500
@@ -6,6 +6,8 @@
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm 0
 (qemu) quit
+./common.config: line 107: 13333 Segmentation fault      (core dumped)
( if [ -n "${QEMU_NEED_PID}" ]; then
+    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
+fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
-*** done
+(qemu) *** done


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nIRhip3BG4ri9r5Dibpci9psP7fL0S97N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNbf3AAoJEKeha0olJ0NqsuMIAKkDmsu8rpOBFaOHeUk+Of83
AhwbN8//WtZvP8yzO9Pq1vI7tOulbXcahxvMVB7Se+rmIHbJZG4YQfkXctGCQMtS
dSuI2g29ueNOJdE/PsN1UUJmmydkSXBytxRcII1E8N8p4SMuwfPlvmmvILbx/Nq0
vH3Og2AZ8hLZbApWHGA9AJ7o1TMDEhKr1FunCI7h9HaMKDxTGK6TP6dsz4ErF2xW
fTcbGJPP9s/n6EOIOOTbb+H3gd803McVO2Fwic8IwbrWXk7nGeO6IEN8oSqXfiRs
sXMH5HjZ5xtNoj74W8zS92ej+2oSp5VLXkPR3W9glANZOEw6Y/25hPtDIg1VP9g=
=mFga
-----END PGP SIGNATURE-----

--nIRhip3BG4ri9r5Dibpci9psP7fL0S97N--
