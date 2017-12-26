Received: from eggs.gnu.org ([2001:4830:134:3::10]:43286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eTl3X-0005dT-JU
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 03:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eTl3U-0001VU-Fm
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 03:57:51 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<20171213041248.GB31040@lemon>
	<af98ffe7-71fb-0493-c4da-4b77a4c453f5@virtuozzo.com>
	<696c198b-e3d8-fab6-0128-de9ed34e4cff@redhat.com>
	<d5df7e51-fe6b-da89-9bf1-9b03c1afdd67@virtuozzo.com>
	<20171226070715.GF9418@lemon>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9b13b53f-996c-4f19-ecf8-8cd4620f231a@virtuozzo.com>
Date: Tue, 26 Dec 2017 11:57:35 +0300
MIME-Version: 1.0
In-Reply-To: <20171226070715.GF9418@lemon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: John Snow <jsnow@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, dev@acronis.com

26.12.2017 10:07, Fam Zheng wrote:
> On Wed, 12/20 11:20, Vladimir Sementsov-Ogievskiy wrote:
>> external backup:
>>
>> 0. we have active_disk and attached to it dirty bitmap bitmap0
>> 1. qmp blockdev-add tmp_disk (backing=3Dactive_disk)
>> 2. guest fsfreeze
>> 3. qmp transaction:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - block-dirty-bitmap-add nod=
e=3Dactive_disk name=3Dbitmap1
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - block-dirty-bitmap-disable=
 node=3Dactive_disk name=3Dbitmap0
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - blockdev-backup drive=3Dac=
tive_disk target=3Dtmp_disk sync=3Dnone
>> 4. guest fsthaw
>> 5. (? not designed yet) qmp blockdev-add filter_node - special filter no=
de
>> over tmp_disk for synchronization of nbd-reads and backup(sync=3Dnone) c=
ow
>> requests (like it is done in block/replication)
>> 6. qmp nbd-server-start
>> 7. qmp nbd-server-add filter_node (there should be possibility of export=
ing
>> bitmap of child node filter_node->tmp_disk->active_disk->bitmap0)
>>
>> then, external tool can connect to nbd server and get exported bitmap an=
d
>> read data (including bitmap0) accordingly to nbd specification.
>> (also, external tool may get a merge of several bitmaps, if we already h=
ave
>> a sequence of them)
>> then, after backup finish, what can be done:
>>
>> 1. qmp block-job-cancel device=3Dactive_disk (stop our backup(sync=3Dnon=
e))
>> 2. qmp nbd-server-stop (or qmp nbd-server-remove filter_node)
>> 3. qmp blockdev-remove filter_node
>> 4. qmp blockdev-remove tmp_disk
>>
>> on successful backup, you can drop old bitmap if you want (or do not dro=
p
>> it, if you need to keep sequence of disabled bitmaps):
>> 1. block-dirty-bitmap-remove node=3Dactive_disk name=3Dbitmap0
>>
>> on failed backup, you can merge bitmaps, to make it look like nothing
>> happened:
>> 1. qmp transaction:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - block-dirty-bitmap-merge node=3D=
active_disk name-source=3Dbitmap1
>> name-target=3Dbitmap0
> Being done in a transaction, will merging a large-ish bitmap synchronousl=
y hurt
> the responsiveness? Because we have the BQL lock held here which pauses a=
ll
> device emulation.
>
> Have you measured how long it takes to merge two typical bitmaps. Say, fo=
r a 1TB
> disk?
>
> Fam

We don't need merge in a transaction.

Anyway, good question.

two full of ones bitmaps, 64k granularity, 1tb disk:
# time virsh qemu-monitor-command tmp '{"execute":=20
"block-dirty-bitmap-merge", "arguments": {"node": "disk", "src_name":=20
"a", "dst_name": "b"}}'
{"return":{},"id":"libvirt-1181"}
real=C2=A0=C2=A0=C2=A0 0m0.009s
user=C2=A0=C2=A0=C2=A0 0m0.006s
sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.002s

and this is fine:
for last level of hbitmap we will have
 =C2=A0=C2=A0 disk_size / granularity / nb_bits_in_long =3D (1024 ^ 4) / (6=
4 * 1024)=20
/ 64 =3D 262144
oparations, which is quite a few



bitmaps in gdb:

(gdb) p bdrv_lookup_bs ("disk", "disk", 0)
$1 =3D (BlockDriverState *) 0x7fd3f6274940
(gdb) p *$1->dirty_bitmaps.lh_first
$2 =3D {mutex =3D 0x7fd3f6277b28, bitmap =3D 0x7fd3f5a5adc0, meta =3D 0x0,=
=20
successor =3D 0x0,
 =C2=A0 name =3D 0x7fd3f637b410 "b", size =3D 1099511627776, disabled =3D f=
alse,=20
active_iterators =3D 0,
 =C2=A0 readonly =3D false, autoload =3D false, persistent =3D false, list =
=3D=20
{le_next =3D 0x7fd3f567c650,
 =C2=A0=C2=A0=C2=A0 le_prev =3D 0x7fd3f6277b58}}
(gdb) p *$1->dirty_bitmaps.lh_first ->bitmap
$3 =3D {size =3D 16777216, count =3D 16777216, granularity =3D 16, meta =3D=
 0x0,=20
levels =3D {0x7fd3f6279a90,
 =C2=A0=C2=A0=C2=A0 0x7fd3f5506350, 0x7fd3f5affcb0, 0x7fd3f547a860, 0x7fd3f=
637b200,=20
0x7fd3f67ff5c0, 0x7fd3d8dfe010},
 =C2=A0 sizes =3D {1, 1, 1, 1, 64, 4096, 262144}}
(gdb) p *$1->dirty_bitmaps.lh_first ->list .le_next
$4 =3D {mutex =3D 0x7fd3f6277b28, bitmap =3D 0x7fd3f567cb30, meta =3D 0x0,=
=20
successor =3D 0x0,
 =C2=A0 name =3D 0x7fd3f5482fb0 "a", size =3D 1099511627776, disabled =3D f=
alse,=20
active_iterators =3D 0,
 =C2=A0 readonly =3D false, autoload =3D false, persistent =3D false, list =
=3D=20
{le_next =3D 0x0,
 =C2=A0=C2=A0=C2=A0 le_prev =3D 0x7fd3f6c779e0}}
(gdb) p *$1->dirty_bitmaps.lh_first ->list .le_next ->bitmap
$5 =3D {size =3D 16777216, count =3D 16777216, granularity =3D 16, meta =3D=
 0x0,=20
levels =3D {0x7fd3f5ef8880,
 =C2=A0=C2=A0=C2=A0 0x7fd3f5facea0, 0x7fd3f5f1cec0, 0x7fd3f5f40a00, 0x7fd3f=
6c80a00,=20
0x7fd3f66e5f60, 0x7fd3d8fff010},
 =C2=A0 sizes =3D {1, 1, 1, 1, 64, 4096, 262144}}

--=20
Best regards,
Vladimir
