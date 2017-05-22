Received: from eggs.gnu.org ([2001:4830:134:3::10]:44964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCleW-000458-5J
	for qemu-devel@nongnu.org; Mon, 22 May 2017 07:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCleV-0002Yt-2D
	for qemu-devel@nongnu.org; Mon, 22 May 2017 07:37:32 -0400
References: <1495376506-13227-1-git-send-email-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <705cdc34-b45d-5f56-3fb2-f8a67c4d2b9f@redhat.com>
Date: Mon, 22 May 2017 06:37:21 -0500
MIME-Version: 1.0
In-Reply-To: <1495376506-13227-1-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0DD9rFh86M7tcOM3l4rXpwjTUahsGc03N"
Subject: Re: [Qemu-devel] [PATCH 1/1] qcow2: handle cluster leak happening
 with a guest TRIM command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0DD9rFh86M7tcOM3l4rXpwjTUahsGc03N
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <705cdc34-b45d-5f56-3fb2-f8a67c4d2b9f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] qcow2: handle cluster leak happening
 with a guest TRIM command
References: <1495376506-13227-1-git-send-email-den@openvz.org>
In-Reply-To: <1495376506-13227-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/21/2017 09:21 AM, Denis V. Lunev wrote:
>   qemu-img create -f qcow2 1.img 64G
>   qemu-io -c "write -P 0x32 0 64k" 1.img
> results in
>   324 -rw-r--r-- 1 den den 393216 May 21 16:48 1.img
> Subsequent
>   qemu-io -c "write -z 0 64k" 1.img
>   qemu-io -c "write -P 0x32 0 64k" 1.img
> results in
>   388 -rw-r--r-- 1 den den 458752 May 21 16:50 1.img
> which looks like we have 1 cluster leaked.
>=20
> Indeed, qcow2_co_pwrite_zeroes calls qcow2_zero_clusters/zero_single_l2=
,
> which does not update refcount for the host cluster and keep the offset=

> as used. Later on handle_copied() does not take into account
> QCOW2_CLUSTER_ZERO type of the cluster.

NACK.  We've already fixed this upstream, at commit 564a6b693.

$ ./qemu-img create -f qcow2 1.img 64g
Formatting '1.img', fmt=3Dqcow2 size=3D68719476736 encryption=3Doff
cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
$ ./qemu-io -c 'w -P 0x32 0 64k' 1.img
wrote 65536/65536 bytes at offset 0
64 KiB, 1 ops; 0.0410 sec (1.524 MiB/sec and 24.3902 ops/sec)
$ ls -l 1.img
-rw-r--r--. 1 eblake eblake 393216 May 22 06:35 1.img
$ ./qemu-io -c 'w -z 0 64k' 1.img
wrote 65536/65536 bytes at offset 0
64 KiB, 1 ops; 0.0055 sec (11.345 MiB/sec and 181.5211 ops/sec)
$ ./qemu-io -c 'w -P 0x32 0 64k' 1.img
wrote 65536/65536 bytes at offset 0
64 KiB, 1 ops; 0.0160 sec (3.903 MiB/sec and 62.4415 ops/sec)
$ ls -l 1.img
-rw-r--r--. 1 eblake eblake 393216 May 22 06:35 1.img


As it is, your patch doesn't apply to master.  And even if it did, your
patch breaks semantics - we CANNOT discard clusters that must read back
as zeroes.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0DD9rFh86M7tcOM3l4rXpwjTUahsGc03N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIs1xAAoJEKeha0olJ0NqFV4H/AzVeQmLd7+Wj3xXebAuOj0U
RftLDclNDBnkSlGsP6yLHm14vKNKqclsn4hnBPXJAjByudVaxMmwX5A2DqSCA78Z
Vmf3R+GWfqTXroC+xpfEzjyJgXL4XQqe/ZzNr08efJKoLX6W9EI0IA+H1zWF7vj5
rC4KhoQUzsU0Sv/aaKdqaqzlV0euajsEHEHLe1JuRDebg35ZzutNaSZjMNQpvjJl
1/931YtKC1wRiacd5zn6DR8Rp4kRmtIadjJMjhjFczrm9xhbWPPWGUdRVSW/CnhP
/ipmqh0+vgSypO/eFJo+hWdjX2MbTV0BC2nGerw0QR2X5IIFGSoU5VfIkWndv9c=
=YARx
-----END PGP SIGNATURE-----

--0DD9rFh86M7tcOM3l4rXpwjTUahsGc03N--
