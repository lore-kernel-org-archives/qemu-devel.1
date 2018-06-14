Received: from eggs.gnu.org ([2001:4830:134:3::10]:37446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTPmU-00022A-RK
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTPmU-0003ig-1l
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:47:06 -0400
Date: Thu, 14 Jun 2018 12:46:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180614104656.GD8564@localhost.localdomain>
References: <f9a9b5bb-4941-a6b3-ff6b-02ab2cb046df@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f9a9b5bb-4941-a6b3-ff6b-02ab2cb046df@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] bug in reopen arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>

Am 12.06.2018 um 20:57 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Hi all!
>=20
> I've faced the following problem:
>=20
> =A0=A0=A0 1. create image with dirty bitmap, a.qcow2 (start qemu and ru=
n qmp
> =A0=A0=A0 command block-dirty-bitmap-add)
>=20
> =A0=A0=A0 2. run the following commands:
>=20
> =A0=A0=A0=A0=A0=A0=A0 qemu-img create -f qcow2 -b a.qcow2 b.qcow2 10M
> =A0=A0=A0=A0=A0=A0=A0 qemu-io -c 'write 0 512' b.qcow2
> =A0=A0=A0=A0=A0=A0=A0 qemu-img commit b.qcow2
>=20
> =A0=A0=A0 3. last command fails with the following output:
>=20
> Formatting 'b.qcow2', fmt=3Dqcow2 size=3D68719476736 backing_file=3Da.q=
cow2
> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> wrote 512/512 bytes at offset 0
> 512 bytes, 1 ops; 0.0953 sec (5.243 KiB/sec and 10.4867 ops/sec)
> qemu-img: #block397: Failed to make dirty bitmaps writable: Can't updat=
e
> bitmap directory: Operation not permitted
> qemu-img: Block job failed: Operation not permitted
>=20
> And problem is that children are reopened _after_ parent. But qcow2 reo=
pen
> needs write access to its file, to write IN_USE flag to dirty-bitmaps
> extension.

I was aware of a different instance of this problem: Assume a qcow2
image with an unknown autoclear flag (so it will be cleared on r/w
open), which is first opened r/o and then reopened r/w. This will fail
because .bdrv_reopen_prepare doesn't have the permissions yet.

Simply changing the order won't fix this because in the r/w -> r/o, the
driver will legitimately flush its caches in .bdrv_reopen_prepare, and
for this it still needs to be able to write.

We may need to have a way for nodes to access both the old and the new
state of their children. I'm not completely sure how to achieve this
best, though.

When I thought only of permissions, the obvious and simple thing to do
was to just get combined permissions for the old and new state, i.e.
'old_perm | new_perm' and 'old_shared & new_shared'. But I don't think
this is actually enough when the child node switches between a r/w and
a r/o file descriptor because even though QEMU's permission system would
allow the write, you still can't successfully write to a r/o file
descriptor.

Kevin
