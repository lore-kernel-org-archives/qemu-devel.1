Received: from eggs.gnu.org ([2001:4830:134:3::10]:48679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dmLTz-00051M-HK
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dmLTw-0008GJ-Bu
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:57:43 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:10875)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dmLTv-0008DL-QY
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:57:40 -0400
Date: Mon, 28 Aug 2017 17:57:28 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170828145728.dqubknb7fruy4sfu@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wlea66pr35rkw3dt"
Content-Disposition: inline
Subject: [Qemu-devel] GSOC Report: Moving I/O throttling and write notifiers
 into block filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--wlea66pr35rkw3dt
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is a GSOC project summary required for the project's final=20
submission. As part of GSOC 2017, I took the project of moving two hard=20
coded block layer features into filter drivers. I/O Throttling is=20
implemented in block/throttle.c and before write notifiers are split=20
into a driver for each user of the before write notifier API:=20
block/backup.c and block/write-threshold.c. Furthermore, work began on=20
block-insert-node and block-remove-node commands for the QMP interface=20
to allow runtime insertion and removal of filter drivers. [0]

A lot of thanks to my mentors for their help: Alberto Garcia, Stefan=20
Hajnoczi and Kevin Wolf.

Terms
=3D=3D=3D=3D=3D

The BlockBackend struct (block/block-backend.c) represents the backend part=
=20
of a storage device that a VM sees in the QEMU environment. The BlockBacken=
d=20
has the responsibility to forward I/O requests from the VM down to the=20
actual underlying storage; a network block device, a qcow2 image etc.

In order to allow for polymorphic storage, a BlockBackend forwards the=20
requests to an acyclic graph in which the leaves are the terminal I/O=20
destination, a file or network connection. The BlockDriverState struct=20
represents a node in this graph, and each node is governed by a specific=20
driver. Above the leaf-nodes we have format drivers that translate requests=
=20
for each format (ie a qcow2 driver, or a raw driver). Backing files are=20
implemented as chains of nodes that forward read requests to their=20
children but keep write requests to themselves. This setup allows=20
different node drivers to intercept requests before they reach their=20
destination by being inserted into points of interest in the graph. We=20
call these block filter drivers.

An existing filter driver for example is block/blkverify.c which compares=
=20
two children for content parity and reports content mismatches.

I/O Throttling
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I/O throttling is done by intercepting I/O requests and throttling them=20
based on the configured limits (docs/throttle.txt). The interface was=20
refactored into the throttle driver [1] while the throttling primitives=20
were left unchanged. The already existing interface of setting limits on=20
a BlockBackend device is simulated [2] by inserting a hidden to the user=20
throttle filter node at the root of the BlockBackend with the user's set=20
limits. Implicitly created filter nodes is not a good solution since=20
some of the QEMU internals are written without considering filter nodes. =
=20
Some patches in the throttle-remove-legacy branch are dedicated to=20
changing existing behaviour to match the new concept of implicit=20
filters. In the future management tools should be expected to explicitly=20
add and remove filter nodes like throttle (except for transient block=20
job filters which may remain implicit) and there should be no surprises=20
about the state of the block layer graph for the user.

Throttle groups are categories of drives sharing the same limits with a=20
round-robin algorithm. Additional effort was spent on making throttle group=
s=20
easier to configure by turning them into a separately creatable object (wit=
h=20
-object syntax on command line invocation or object-add in QMP). Their=20
properties can be set with 'qom-set' commands and retrieved with 'qom-get'.


Write Notifiers
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

While a backup block job is running, it is important to have knowledge of=
=20
writes to the relevant image. Before write notifiers pass the write request=
s=20
to the backup job to perform copy on write on the target image with the new=
=20
data. Currently this is done on the BlockBackend level. Other block jobs=20
(commit/mirror) already create implicit nodes in the BDS chain and this=20
approach was copied and a backup filter driver was created [3], internal to=
=20
block/backup.c

The write-threshold feature once enabled via QMP, watches passing write=20
requests and compares them to a user-given threshold offset. When that=20
threshold is exceeded an event is delivered to the user and the feature=20
disables itself. This is used for management tools that need to know when=
=20
they have to resize their images. Like backup, this was done in the=20
BlockBackend level. However it wasn't easy to replace the existing interfac=
e=20
with an implicit filter node like in throttling, so only a separate driver=
=20
was created [4] in block/write-threshold.c. Like other filter drivers, it=
=20
can be inserted on runtime and removed once it delivers the event and is=20
spent and should be removed or replaced.

Branches / Patches
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The 'throttle' and 'throttle-remove-legacy' patches should be merged soon=
=20
after master unfreezes from the 2.10 release. The rest of the patch series=
=20
are in final stages of review on qemu-devel except for block-insert-node=20
which is an RFC [5].

Already merged patches in 2.10
  https://github.com/qemu/qemu/commits/v2.10.0-rc4?author=3Depilys
Already merged patches for 2.11
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg470461.html

[0] [insert-node] block-insert-node and block-remove-node commands
  https://github.com/epilys/qemu/commits/insert-node?author=3Depilys

[1] [throttle] add throttle filter driver
  https://github.com/epilys/qemu/commits/throttle?author=3Depilys
  Message-ID: <20170825132028.6184-1-el13635@mail.ntua.gr>
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg476047.html

[2] [throttle-remove-legacy] remove legacy throttling interface
  https://github.com/epilys/qemu/commits/throttle-remove-legacy?author=3Dep=
ilys

[3] [4] [notify] https://github.com/epilys/qemu/commits/notify?author=3Depi=
lys

[5] block-insert-node RFC
  Message-ID: <20170815074513.9055-1-el13635@mail.ntua.gr>
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg473619.html

--wlea66pr35rkw3dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmkL1gACgkQc2J8L2kN
9xDLGhAAtaW1Os5Q6m5Ka+qMtOXgchPlWDsZytC0SzKzfLmLO9xsY9WOJCJkQh5w
HapbHtVyopB9ZxQJy5d7XelDQ/S6EL6qeoTKANcKTtJtXgL+1hOaWWbX+iQhxsxR
CqDMGF/n/mi/XZzh9Dh5Ps8c3Gk3T6mXK6WUXtVPxpAGAdCGEYrvdExyUwDNaCrv
vt/hcQeDJ85aOmp9c7kaZHly6oZ9niK4YaX+1s+eyIkba2In0i8NS+a/32e8k+Tl
MDTc1UigcjjCOj1uVofm0MiA/O0igu3gU8czNq9yVkh80w4TGuF+YFqd6Ra6g0Dx
DECNwXrLczTUegSsKGo/L8OVhlLAAC5ASCXru3Ke9O15/lBkMfMmhRwaRZhl2Sgn
z+g9GwAFO5yHuq78q5xVzS7ZB5Qy9ZNSEua+/g2ylTFPxmmj6UN8JGa26h2w0Uod
VKhY8l+VB2CcF19OOcn+fp7YD22ullfoRvjrr0j224qX3KWfy2uyBVALAbSvCV8H
GZQDGd97I0h5va2oGS+LFwuHu+0fHxuNcTN/JF0yX0kClOlZ67KuBFXYU+xjCO0z
VfAsSkrVBXG1kjOc8rit0vwOTKgRNzKrLCWvSiYg/PXlSIGB64vTibiIV+wmQTNW
b/QKN7Xumr/8t0We+Ct6MbqYSOUpJK9NanWE7jo8un2pAVttyN0=
=9bR9
-----END PGP SIGNATURE-----

--wlea66pr35rkw3dt--
