Received: from eggs.gnu.org ([2001:4830:134:3::10]:59089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTjKm-0006ub-Pb
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 02:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTjKl-0004Aw-T0
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 02:07:32 -0500
Date: Tue, 26 Dec 2017 15:07:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171226070715.GF9418@lemon>
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<20171213041248.GB31040@lemon>
	<af98ffe7-71fb-0493-c4da-4b77a4c453f5@virtuozzo.com>
	<696c198b-e3d8-fab6-0128-de9ed34e4cff@redhat.com>
	<d5df7e51-fe6b-da89-9bf1-9b03c1afdd67@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d5df7e51-fe6b-da89-9bf1-9b03c1afdd67@virtuozzo.com>
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

On Wed, 12/20 11:20, Vladimir Sementsov-Ogievskiy wrote:
> external backup:
>=20
> 0. we have active_disk and attached to it dirty bitmap bitmap0
> 1. qmp blockdev-add tmp_disk (backing=3Dactive_disk)
> 2. guest fsfreeze
> 3. qmp transaction:
> =A0=A0=A0=A0=A0=A0=A0 - block-dirty-bitmap-add node=3Dactive_disk name=3D=
bitmap1
> =A0=A0=A0=A0=A0=A0=A0 - block-dirty-bitmap-disable node=3Dactive_disk n=
ame=3Dbitmap0
> =A0=A0=A0=A0=A0=A0=A0 - blockdev-backup drive=3Dactive_disk target=3Dtm=
p_disk sync=3Dnone
> 4. guest fsthaw
> 5. (? not designed yet) qmp blockdev-add filter_node - special filter n=
ode
> over tmp_disk for synchronization of nbd-reads and backup(sync=3Dnone) =
cow
> requests (like it is done in block/replication)
> 6. qmp nbd-server-start
> 7. qmp nbd-server-add filter_node (there should be possibility of expor=
ting
> bitmap of child node filter_node->tmp_disk->active_disk->bitmap0)
>=20
> then, external tool can connect to nbd server and get exported bitmap a=
nd
> read data (including bitmap0) accordingly to nbd specification.
> (also, external tool may get a merge of several bitmaps, if we already =
have
> a sequence of them)
> then, after backup finish, what can be done:
>=20
> 1. qmp block-job-cancel device=3Dactive_disk (stop our backup(sync=3Dno=
ne))
> 2. qmp nbd-server-stop (or qmp nbd-server-remove filter_node)
> 3. qmp blockdev-remove filter_node
> 4. qmp blockdev-remove tmp_disk
>=20
> on successful backup, you can drop old bitmap if you want (or do not dr=
op
> it, if you need to keep sequence of disabled bitmaps):
> 1. block-dirty-bitmap-remove node=3Dactive_disk name=3Dbitmap0
>=20
> on failed backup, you can merge bitmaps, to make it look like nothing
> happened:
> 1. qmp transaction:
> =A0=A0=A0=A0=A0=A0 - block-dirty-bitmap-merge node=3Dactive_disk name-s=
ource=3Dbitmap1
> name-target=3Dbitmap0

Being done in a transaction, will merging a large-ish bitmap synchronousl=
y hurt
the responsiveness? Because we have the BQL lock held here which pauses a=
ll
device emulation.

Have you measured how long it takes to merge two typical bitmaps. Say, fo=
r a 1TB
disk?

Fam
