Received: from eggs.gnu.org ([2001:4830:134:3::10]:37560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fbQzu-0007LL-C3
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fbQzt-00038f-Cv
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:42:06 -0400
References: <20180705074638.770905-1-vsementsov@virtuozzo.com>
	<20180706071754.GB9946@lemon.usersys.redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7747e176-6d75-c640-4f48-0482b8c7c401@virtuozzo.com>
Date: Fri, 6 Jul 2018 16:41:50 +0300
MIME-Version: 1.0
In-Reply-To: <20180706071754.GB9946@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 0/4] fix image fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pl@kamp.de, pbonzini@redhat.com, ronniesahlberg@gmail.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, den@openvz.org

06.07.2018 10:17, Fam Zheng wrote:
> On Thu, 07/05 10:46, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> This fixes image fleecing scheme for 3.0, details are in 04 patch.
> Looks like this breaks 'test-replication':
>
> http://patchew.org/QEMU/20180705074638.770905-1-vsementsov@virtuozzo.com/
>
> test-replication: /stor/work/qemu/block/io.c:725: wait_serialising_reques=
ts: Assertion `qemu_coroutine_self() !=3D req->co' failed.
> GTester: last random seed: R02Se49967625f19c5be9918a2503fb2fff5
> test-replication: /stor/work/qemu/block/io.c:725: wait_serialising_reques=
ts: Assertion `qemu_coroutine_self() !=3D req->co' failed.
>    GTESTER tests/test-qht-par
> GTester: last random seed: R02S8fad2bb2daddc51eb51623bb7c86cb67
> test-replication: /stor/work/qemu/block/io.c:725: wait_serialising_reques=
ts: Assertion `qemu_coroutine_self() !=3D req->co' failed.
> GTester: last random seed: R02S024718e9b1e2b1facafe254c43e1430b
>
> Fam

interesting.

in gdb I see, that both requests are identical (i.e. their=20
BdrvTrackedRequeststructs, except list filed)writes (self and req)...

and it's actually the same request, duplicated in the ist, first it is=20
created in bdrv_co_copy_range_internal,

and than again,
#0=C2=A0 tracked_request_begin (req=3D0x7fffe8f9e7d0, bs=3D0x555555a43040,=
=20
offset=3D33554432, bytes=3D33554432, type=3D
 =C2=A0=C2=A0=C2=A0 BDRV_TRACKED_WRITE) at block/io.c:598
#1=C2=A0 0x00005555555f76bc in bdrv_co_copy_range_internal=20
(src=3D0x55555597ef80, src_offset=3D33882112,
 =C2=A0=C2=A0=C2=A0 dst=3D0x5555559f1d30, dst_offset=3D33554432, bytes=3D33=
554432,=20
read_flags=3DBDRV_REQ_NO_SERIALISING,
 =C2=A0=C2=A0=C2=A0 write_flags=3DBDRV_REQ_SERIALISING, recurse_src=3Dtrue)=
 at block/io.c:2949
#2=C2=A0 0x00005555555f78e9 in bdrv_co_copy_range_from (src=3D0x55555597ef8=
0,=20
src_offset=3D33882112,
 =C2=A0=C2=A0=C2=A0 dst=3D0x5555559f1d30, dst_offset=3D33554432, bytes=3D33=
554432,=20
read_flags=3DBDRV_REQ_NO_SERIALISING,
 =C2=A0=C2=A0=C2=A0 write_flags=3DBDRV_REQ_SERIALISING) at block/io.c:2995
#3=C2=A0 0x00005555555ae931 in qcow2_co_copy_range_from (bs=3D0x555555977ff=
0,=20
src=3D0x5555559f14d0,
 =C2=A0=C2=A0=C2=A0 src_offset=3D33554432, dst=3D0x5555559f1d30, dst_offset=
=3D33554432,=20
bytes=3D33554432,
 =C2=A0=C2=A0=C2=A0 read_flags=3DBDRV_REQ_NO_SERIALISING,=20
write_flags=3DBDRV_REQ_SERIALISING) at block/qcow2.c:3311
#4=C2=A0 0x00005555555f77cf in bdrv_co_copy_range_internal=20
(src=3D0x5555559f14d0, src_offset=3D33554432,
 =C2=A0=C2=A0=C2=A0 dst=3D0x5555559f1d30, dst_offset=3D33554432, bytes=3D33=
554432,=20
read_flags=3DBDRV_REQ_NO_SERIALISING,
 =C2=A0=C2=A0=C2=A0 write_flags=3DBDRV_REQ_SERIALISING, recurse_src=3Dtrue)=
 at block/io.c:2966


so, it's actually bug in copy_range architecture.

--=20
Best regards,
Vladimir
