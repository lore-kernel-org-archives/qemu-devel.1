Received: from eggs.gnu.org ([2001:4830:134:3::10]:37655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4Zef-0002Mf-73
	for Qemu-devel@nongnu.org; Fri, 06 Apr 2018 18:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4Zeb-0006Ok-7V
	for Qemu-devel@nongnu.org; Fri, 06 Apr 2018 18:16:21 -0400
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b490d71-4f3e-9069-9c92-89d27e107f57@redhat.com>
Date: Fri, 6 Apr 2018 17:16:07 -0500
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J0dZe8A4HeaEeXiQY5R3r2sgcOzFWUpd7"
Subject: [Qemu-devel] block-stream/commit and mixing internal and external
 snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J0dZe8A4HeaEeXiQY5R3r2sgcOzFWUpd7
From: Eric Blake <eblake@redhat.com>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <9b490d71-4f3e-9069-9c92-89d27e107f57@redhat.com>
Subject: block-stream/commit and mixing internal and external snapshots
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Perhaps others have already known this, but I just realized that if you
mix internal and external snapshots, you can set yourself up for massive
failures when trying to use block-stream or block-commit to consolidate
data across the external backing chain, without also thinking about the
internal snapshots.

Here's a quick demonstration:

$ # create the backing file, with all 1's; 1M clusters for convenience
$ qemu-img create -f qcow2 -o cluster_size=3D1m base.qcow2 4M
Formatting 'base.qcow2', fmt=3Dqcow2 size=3D4194304 cluster_size=3D104857=
6
lazy_refcounts=3Doff refcount_bits=3D16
$ qemu-io -c 'w -P 1 0 4m' -f qcow2 base.qcow2
wrote 4194304/4194304 bytes at offset 0
4 MiB, 1 ops; 0.0050 sec (791.139 MiB/sec and 197.7848 ops/sec)
$ # create the wrapper file, write 2 to the first 2 clusters
$ qemu-img create -f qcow2 -o backing_file=3Dbase.qcow2,backing_fmt=3Dqco=
w2
top.qcow2
Formatting 'top.qcow2', fmt=3Dqcow2 size=3D4194304 backing_file=3Dbase.qc=
ow2
backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bi=
ts=3D16
$ qemu-io -c 'w -P 2 0 2m' -f qcow2 top.qcow2
wrote 2097152/2097152 bytes at offset 0
2 MiB, 1 ops; 0.0009 sec (2.144 GiB/sec and 1097.6948 ops/sec)
$ # create an internal snapshot, then write 3 to the middle 2 clusters
$ qemu-img snapshot -c snap1 top.qcow2
$ qemu-io -c 'w -P 3 1m 2m' -f qcow2 top.qcow2
wrote 2097152/2097152 bytes at offset 1048576
2 MiB, 1 ops; 0.0009 sec (2.102 GiB/sec and 1076.4263 ops/sec)
$ # we've mixed internal and external; let's shorten the chain now
$ qemu-img info top.qcow2
image: top.qcow2
file format: qcow2
virtual size: 4.0M (4194304 bytes)
disk size: 2.3M
cluster_size: 65536
backing file: base.qcow2
backing file format: qcow2
Snapshot list:
ID        TAG                 VM SIZE                DATE       VM CLOCK
1         snap1                     0 2018-04-06 16:44:54   00:00:00.000
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false
$ qemu-img rebase -f qcow2 -b '' top.qcow2
$ # create second snapshot, then revert to the first
$ qemu-img snapshot -c snap2 top.qcow2
$ qemu-img snapshot -a snap1 top.qcow2
$ # contents at the time we took snap1 were 2211, right? OOOPS!
$ qemu-io -c 'r -P 2 0 2m' -c 'r -P 1 2m 2m' -f qcow2 top.qcow2
read 2097152/2097152 bytes at offset 0
2 MiB, 1 ops; 0.0004 sec (3.914 GiB/sec and 2004.0080 ops/sec)
Pattern verification failed at offset 2097152, 2097152 bytes
read 2097152/2097152 bytes at offset 2097152
2 MiB, 1 ops; 0.0000 sec (24.723 GiB/sec and 12658.2278 ops/sec)
$ # the last two clusters were rewritten from 1 to 0. :(
$ qemu-io -c 'r -P 0 2m 2m' -f qcow2 top.qcow2
read 2097152/2097152 bytes at offset 2097152
2 MiB, 1 ops; 0.0001 sec (13.754 GiB/sec and 7042.2535 ops/sec)
$ # repair the damage, for now, and write 4 into last cluster...
$ qemu-img rebase -u -f qcow2 -b base.qcow2 -F qcow2 top.qcow2
$ qemu-io -c 'w -P 4 3m 1m' -f qcow2 top.qcow2
wrote 1048576/1048576 bytes at offset 3145728
1 MiB, 1 ops; 0.0005 sec (1.713 GiB/sec and 1754.3860 ops/sec)
$ # now let's try committing instead
$ qemu-img commit -f qcow2 -d top.qcow2
Image committed.
$ # revert back to snap2, which had contents 2331, right? OOPS!
$ qemu-img snapshot -a snap2 top.qcow2
$ qemu-io -c 'r -P 2 0 1m' -c 'r -P 3 1m 1m' -c 'r -P 3 2m 1m' -c 'r -P
1 3m 1m' -f qcow2 top.qcow2
read 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0002 sec (3.860 GiB/sec and 3952.5692 ops/sec)
read 1048576/1048576 bytes at offset 1048576
1 MiB, 1 ops; 0.0002 sec (3.577 GiB/sec and 3663.0037 ops/sec)
read 1048576/1048576 bytes at offset 2097152
1 MiB, 1 ops; 0.0002 sec (4.628 GiB/sec and 4739.3365 ops/sec)
Pattern verification failed at offset 3145728, 1048576 bytes
read 1048576/1048576 bytes at offset 3145728
1 MiB, 1 ops; 0.0007 sec (1.345 GiB/sec and 1377.4105 ops/sec)
$ # the last cluster was rewritten from 1 to 4. :(
$ qemu-io -c 'r -P 4 3m 1m' -f qcow2 top.qcow2
read 1048576/1048576 bytes at offset 3145728
1 MiB, 1 ops; 0.0011 sec (878.735 MiB/sec and 878.7346 ops/sec)


The root cause to all of this is that right now, ALL internal snapshots
share the same backing file information in the file header; but
block-stream operations only modify the active snapshot.  The actions of
changing the backing file or of rewriting the clusters in the backing
file don't break the active snapshot, but DO bleed through to the
internal snapshots, for any cluster where the internal snapshot was
relying on the backing file.

Does this mean we should make it harder to perform external block
operations on a qcow2 file that has internal snapshots (either refuse
outright, or at least require a 'force' flag to let the user acknowledge
the risk)?  Similarly, should it be harder to create an internal
snapshot when an image already has an external backing file, and/or
should we improve the qcow2 specification of internal snapshot
descriptors to record a per-snapshot backing file rather than the
current approach that all snapshots share the same backing file?
Whether or not we track a per-snapshot backing file, should the presence
of internal snapshots be used to request op-blockers for read
consistency on backing files?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--J0dZe8A4HeaEeXiQY5R3r2sgcOzFWUpd7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrH8acACgkQp6FrSiUn
Q2rw1wf+ImtSlZVhpUJw0npfr2yNxj8QK3WzRbtNdcAXni5YC0KGiMbTTGUYZwft
HSv5o1y6zwIQp2lEsAEFa6NA5ekasQ2/VesDWtWb3UlQuIyYFGeDg8tAT8T36kjy
UjRIYvmZQ+vXjQCynn/jWKmPJAK1bAqbWdLaFjy6e7fciGCooblEOYToWI5bjPUT
HnWDFSkYG/bRDKJRBI0viyGdP3ahJEb8MHucibY1XyIw618fRUvbliTLMFuyMpVj
XVO5sBw2RuiPpdZTiWzrERRGB7gkk2YU3gyiX7Zgwew2ah2NaHISthUB9UIMj1Qe
/TPWOBxFSwI+5R/Of1r1664jEYyOOA==
=HD2M
-----END PGP SIGNATURE-----

--J0dZe8A4HeaEeXiQY5R3r2sgcOzFWUpd7--
