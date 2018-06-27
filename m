Received: from eggs.gnu.org ([2001:4830:134:3::10]:53028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYIjE-0001Gx-Oj
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 18:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYIjD-00024U-MT
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 18:15:56 -0400
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7dc96aab-2a4d-3f9d-ca2d-6944e8f19e75@redhat.com>
Date: Thu, 28 Jun 2018 00:15:41 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uCcZx8HiurlK5bQBvXkpQDFTs73Xcl11B"
Subject: [Qemu-devel] Segfault with vmdk and overridden backing child
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uCcZx8HiurlK5bQBvXkpQDFTs73Xcl11B
From: Max Reitz <mreitz@redhat.com>
To: Qemu-block <qemu-block@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <7dc96aab-2a4d-3f9d-ca2d-6944e8f19e75@redhat.com>
Subject: Segfault with vmdk and overridden backing child
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I've seen a segfault with vmdk, though I haven't investigated further.
I suspect it has to do something with vmdk not supporting non-vmdk
backing files.  It definitely has to do something with vmdk sending a
request to a NULL child.

This is a reproducer (not necessarily a minimal one):

$ ./qemu-img create -f vmdk base.vmdk 64M
Formatting 'base.vmdk', fmt=3Dvmdk size=3D67108864 compat6=3Doff
hwversion=3Dundefined
$ ./qemu-img create -f vmdk -b base.vmdk mid.vmdk
Formatting 'mid.vmdk', fmt=3Dvmdk size=3D67108864 backing_file=3Dbase.vmd=
k
compat6=3Doff hwversion=3Dundefined
$ ./qemu-img create -f vmdk -b mid.vmdk top.vmdk
Formatting 'top.vmdk', fmt=3Dvmdk size=3D67108864 backing_file=3Dmid.vmdk=

compat6=3Doff hwversion=3Dundefined
$ ./qemu-io -c 'write 0 1M' mid.vmdk
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0695 sec (14.379 MiB/sec and 14.3786 ops/sec)
$ echo '
{"execute":"qmp_capabilities"}
{"execute":"blockdev-add",
 "arguments":{"node-name":"node0","driver":"vmdk",
 "file":{"driver":"file","filename":"top.vmdk"},
 "backing":{
   "driver":"vmdk","file":{"driver":"file","filename":"mid.vmdk"},
   "backing":{
     "driver":"vmdk","file":{"driver":"file","filename":"base.vmdk"},
     "backing":{"driver":"null-co"}}}}}
{"execute":"block-commit",
 "arguments":{"job-id":"commit","device":"node0",
 "top":"mid.vmdk","base":"base.vmdk","speed":1}}
{"execute":"job-pause","arguments":{"id":"commit"}}
{"execute":"quit"}' | \
    x86_64-softmmu/qemu-system-x86_64 -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2},
"package": "v2.12.0-1769-g9d0c64bac6-dirty"}, "capabilities": []}}
{"return": {}}
{"return": {}}
{"timestamp": {"seconds": 1530137344, "microseconds": 421127}, "event":
"JOB_STATUS_CHANGE", "data": {"status": "created", "id": "commit"}}
{"timestamp": {"seconds": 1530137344, "microseconds": 421480}, "event":
"JOB_STATUS_CHANGE", "data": {"status": "running", "id": "commit"}}
{"return": {}}
[2]    17059 done                              echo  |
       17060 segmentation fault (core dumped)
x86_64-softmmu/qemu-system-x86_64 -qmp stdio


(gdb) bt
#0  0x000055c338ea719d in bdrv_co_preadv (child=3D0x0,
offset=3D94296964162136, bytes=3D10240, qiov=3D0x7f7a3a4ef9c0, flags=3D0)=
 at
block/io.c:1361
#1  0x000055c338ea7f22 in bdrv_rw_co_entry (opaque=3D0x7f7a3a4ef960) at
block/io.c:768
#2  0x000055c338ea7f8b in bdrv_prwv_co (child=3Dchild@entry=3D0x0,
offset=3Doffset@entry=3D94296964162136, qiov=3Dqiov@entry=3D0x7f7a3a4ef9c=
0,
is_write=3Dis_write@entry=3Dfalse, flags=3Dflags@entry=3D0) at block/io.c=
:797
#3  0x000055c338ea8336 in bdrv_preadv (qiov=3D0x7f7a3a4ef9c0,
offset=3D94296964162136, child=3D0x0) at block/io.c:930
#4  0x000055c338ea8336 in bdrv_pread (child=3D0x0, offset=3D9429696416213=
6,
buf=3Dbuf@entry=3D0x55c33b6a6610, bytes=3Dbytes@entry=3D10240) at block/i=
o.c:930
#5  0x000055c338e60c4a in vmdk_read_cid (parent=3Dparent@entry=3D0,
pcid=3Dpcid@entry=3D0x7f7a3a4efa44, bs=3D<optimized out>, bs=3D<optimized=
 out>)
at block/vmdk.c:259


I don't have the time to investigate this right now, so this mail has to
suffice from my side for now.

Max


--uCcZx8HiurlK5bQBvXkpQDFTs73Xcl11B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAls0DI0ACgkQ9AfbAGHV
z0CQcAf/fs7pkdoGNslVYY3J4zwAB0KJ3ED2Sp/zYssIKZqi0JfgUlYML4qUGBU5
8PYc/SqKqSksauuy4yelevy6gcGbqyxohyrgMOaJ7yniKkqdj9b10nDypP3W9bQg
Z/ZZhztBONKHfbtXGw5XCAUVBbAq/YkIGcp6ofoUOFABG6Qi3WwTyzQdiw3kSVlE
FoYfnBvdRGi7gFGGpAf6cKxYH3+HpCrBk+TV5FmRwR0MEuCKmqHlRfgCifcsq8G2
6wRjHUrh2cfpuiLux9uNJmRT1cV/fgJm+nwPhuaHOP9cW03y5B+p1jctYHp8F2Vh
+vc5mL6844D5vNsjg5SJrshnY8Ieig==
=709X
-----END PGP SIGNATURE-----

--uCcZx8HiurlK5bQBvXkpQDFTs73Xcl11B--
