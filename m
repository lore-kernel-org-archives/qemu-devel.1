Received: from eggs.gnu.org ([2001:4830:134:3::10]:45354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTlnb-0007RZ-Fw
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 04:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTlna-00024Z-38
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 04:45:27 -0500
Date: Tue, 26 Dec 2017 17:45:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171226094509.GG9418@lemon>
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<20171213041248.GB31040@lemon>
	<af98ffe7-71fb-0493-c4da-4b77a4c453f5@virtuozzo.com>
	<696c198b-e3d8-fab6-0128-de9ed34e4cff@redhat.com>
	<d5df7e51-fe6b-da89-9bf1-9b03c1afdd67@virtuozzo.com>
	<20171226070715.GF9418@lemon>
	<9b13b53f-996c-4f19-ecf8-8cd4620f231a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9b13b53f-996c-4f19-ecf8-8cd4620f231a@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: John Snow <jsnow@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, dev@acronis.com

On Tue, 12/26 11:57, Vladimir Sementsov-Ogievskiy wrote:
> 26.12.2017 10:07, Fam Zheng wrote:
> > On Wed, 12/20 11:20, Vladimir Sementsov-Ogievskiy wrote:
> > > external backup:
> > >=20
> > > 0. we have active_disk and attached to it dirty bitmap bitmap0
> > > 1. qmp blockdev-add tmp_disk (backing=3Dactive_disk)
> > > 2. guest fsfreeze
> > > 3. qmp transaction:
> > >  =A0=A0=A0=A0=A0=A0=A0 - block-dirty-bitmap-add node=3Dactive_disk =
name=3Dbitmap1
> > >  =A0=A0=A0=A0=A0=A0=A0 - block-dirty-bitmap-disable node=3Dactive_d=
isk name=3Dbitmap0
> > >  =A0=A0=A0=A0=A0=A0=A0 - blockdev-backup drive=3Dactive_disk target=
=3Dtmp_disk sync=3Dnone
> > > 4. guest fsthaw
> > > 5. (? not designed yet) qmp blockdev-add filter_node - special filt=
er node
> > > over tmp_disk for synchronization of nbd-reads and backup(sync=3Dno=
ne) cow
> > > requests (like it is done in block/replication)
> > > 6. qmp nbd-server-start
> > > 7. qmp nbd-server-add filter_node (there should be possibility of e=
xporting
> > > bitmap of child node filter_node->tmp_disk->active_disk->bitmap0)
> > >=20
> > > then, external tool can connect to nbd server and get exported bitm=
ap and
> > > read data (including bitmap0) accordingly to nbd specification.
> > > (also, external tool may get a merge of several bitmaps, if we alre=
ady have
> > > a sequence of them)
> > > then, after backup finish, what can be done:
> > >=20
> > > 1. qmp block-job-cancel device=3Dactive_disk (stop our backup(sync=3D=
none))
> > > 2. qmp nbd-server-stop (or qmp nbd-server-remove filter_node)
> > > 3. qmp blockdev-remove filter_node
> > > 4. qmp blockdev-remove tmp_disk
> > >=20
> > > on successful backup, you can drop old bitmap if you want (or do no=
t drop
> > > it, if you need to keep sequence of disabled bitmaps):
> > > 1. block-dirty-bitmap-remove node=3Dactive_disk name=3Dbitmap0
> > >=20
> > > on failed backup, you can merge bitmaps, to make it look like nothi=
ng
> > > happened:
> > > 1. qmp transaction:
> > >  =A0=A0=A0=A0=A0=A0 - block-dirty-bitmap-merge node=3Dactive_disk n=
ame-source=3Dbitmap1
> > > name-target=3Dbitmap0
> > Being done in a transaction, will merging a large-ish bitmap synchron=
ously hurt
> > the responsiveness? Because we have the BQL lock held here which paus=
es all
> > device emulation.
> >=20
> > Have you measured how long it takes to merge two typical bitmaps. Say=
, for a 1TB
> > disk?
> >=20
> > Fam
>=20
> We don't need merge in a transaction.

Yes. Either way, the command is synchronous and the whole merge process i=
s done
with BQL held, so my question still stands. But your numbers have answere=
d it
and the time is neglectable.

Bitmap merging even doesn't have to be synchronous if it really matters, =
but we
can live with a synchronous implementation for now.

Thanks!

Fam

>=20
> Anyway, good question.
>=20
> two full of ones bitmaps, 64k granularity, 1tb disk:
> # time virsh qemu-monitor-command tmp '{"execute":
> "block-dirty-bitmap-merge", "arguments": {"node": "disk", "src_name": "=
a",
> "dst_name": "b"}}'
> {"return":{},"id":"libvirt-1181"}
> real=A0=A0=A0 0m0.009s
> user=A0=A0=A0 0m0.006s
> sys=A0=A0=A0=A0 0m0.002s
>=20
> and this is fine:
> for last level of hbitmap we will have
> =A0=A0 disk_size / granularity / nb_bits_in_long =3D (1024 ^ 4) / (64 *=
 1024) / 64
> =3D 262144
> oparations, which is quite a few
>=20
>=20
>=20
> bitmaps in gdb:
>=20
> (gdb) p bdrv_lookup_bs ("disk", "disk", 0)
> $1 =3D (BlockDriverState *) 0x7fd3f6274940
> (gdb) p *$1->dirty_bitmaps.lh_first
> $2 =3D {mutex =3D 0x7fd3f6277b28, bitmap =3D 0x7fd3f5a5adc0, meta =3D 0=
x0, successor
> =3D 0x0,
> =A0 name =3D 0x7fd3f637b410 "b", size =3D 1099511627776, disabled =3D f=
alse,
> active_iterators =3D 0,
> =A0 readonly =3D false, autoload =3D false, persistent =3D false, list =
=3D {le_next =3D
> 0x7fd3f567c650,
> =A0=A0=A0 le_prev =3D 0x7fd3f6277b58}}
> (gdb) p *$1->dirty_bitmaps.lh_first ->bitmap
> $3 =3D {size =3D 16777216, count =3D 16777216, granularity =3D 16, meta=
 =3D 0x0,
> levels =3D {0x7fd3f6279a90,
> =A0=A0=A0 0x7fd3f5506350, 0x7fd3f5affcb0, 0x7fd3f547a860, 0x7fd3f637b20=
0,
> 0x7fd3f67ff5c0, 0x7fd3d8dfe010},
> =A0 sizes =3D {1, 1, 1, 1, 64, 4096, 262144}}
> (gdb) p *$1->dirty_bitmaps.lh_first ->list .le_next
> $4 =3D {mutex =3D 0x7fd3f6277b28, bitmap =3D 0x7fd3f567cb30, meta =3D 0=
x0, successor
> =3D 0x0,
> =A0 name =3D 0x7fd3f5482fb0 "a", size =3D 1099511627776, disabled =3D f=
alse,
> active_iterators =3D 0,
> =A0 readonly =3D false, autoload =3D false, persistent =3D false, list =
=3D {le_next =3D
> 0x0,
> =A0=A0=A0 le_prev =3D 0x7fd3f6c779e0}}
> (gdb) p *$1->dirty_bitmaps.lh_first ->list .le_next ->bitmap
> $5 =3D {size =3D 16777216, count =3D 16777216, granularity =3D 16, meta=
 =3D 0x0,
> levels =3D {0x7fd3f5ef8880,
> =A0=A0=A0 0x7fd3f5facea0, 0x7fd3f5f1cec0, 0x7fd3f5f40a00, 0x7fd3f6c80a0=
0,
> 0x7fd3f66e5f60, 0x7fd3d8fff010},
> =A0 sizes =3D {1, 1, 1, 1, 64, 4096, 262144}}
>=20
> --=20
> Best regards,
> Vladimir
>=20
