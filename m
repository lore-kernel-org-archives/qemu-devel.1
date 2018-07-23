Received: from eggs.gnu.org ([2001:4830:134:3::10]:54323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fhayj-00035T-5v
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fhayf-0005qr-Tp
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:34:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fhayf-0005qL-Jq
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:34:17 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6NDSijh040796
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 09:34:15 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kddpnwr7h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 09:34:14 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Mon, 23 Jul 2018 07:34:13 -0600
From: Farhan Ali <alifm@linux.ibm.com>
References: <20180718211256.29774-1-naravamudan@digitalocean.com>
	<a1269390-a798-9165-aaf5-a2aa6270bd54@linux.ibm.com>
Date: Mon, 23 Jul 2018 09:34:06 -0400
MIME-Version: 1.0
In-Reply-To: <a1269390-a798-9165-aaf5-a2aa6270bd54@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <ad11d1ee-baef-5a3b-58ab-a80cf4cef6fd@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block/file-posix: add
 bdrv_attach_aio_context callback for host dev and cdrom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org



On 07/20/2018 03:11 PM, Farhan Ali wrote:
> I am seeing another issue pop up, in a different test. Even though it's=
=20
> a different assertion, it might be related based on the call trace.
>=20
> Stack trace of thread 276199:
> #0=C2=A0 0x000003ff8473e274 raise (libc.so.6)
> #1=C2=A0 0x000003ff847239a8 abort (libc.so.6)
> #2=C2=A0 0x000003ff847362ce __assert_fail_base (libc.so.6)
> #3=C2=A0 0x000003ff8473634c __assert_fail (libc.so.6)
> #4=C2=A0 0x000002aa30aba0c4 iov_memset (qemu-system-s390x)
> #5=C2=A0 0x000002aa30aba9a6 qemu_iovec_memset (qemu-system-s390x)
> #6=C2=A0 0x000002aa30a23e88 qemu_laio_process_completion (qemu-system-s=
390x)
> #7=C2=A0 0x000002aa30a23f68 qemu_laio_process_completions (qemu-system-=
s390x)
> #8=C2=A0 0x000002aa30a2418e qemu_laio_process_completions_and_submit=20
> (qemu-system-s390x)
> #9=C2=A0 0x000002aa30a24220 qemu_laio_poll_cb (qemu-system-s390x)
> #10 0x000002aa30ab22c4 run_poll_handlers_once (qemu-system-s390x)
> #11 0x000002aa30ab2e78 aio_poll (qemu-system-s390x)
> #12 0x000002aa30a29f4e bdrv_do_drained_begin (qemu-system-s390x)
> #13 0x000002aa30a2a276 bdrv_drain (qemu-system-s390x)
> #14 0x000002aa309d45aa bdrv_set_aio_context (qemu-system-s390x)
> #15 0x000002aa3085acfe virtio_blk_data_plane_stop (qemu-system-s390x)
> #16 0x000002aa3096994c virtio_bus_stop_ioeventfd.part.1 (qemu-system-s3=
90x)
> #17 0x000002aa3087d1d6 virtio_vmstate_change (qemu-system-s390x)
> #18 0x000002aa308e8a12 vm_state_notify (qemu-system-s390x)
> #19 0x000002aa3080ed54 do_vm_stop (qemu-system-s390x)
> #20 0x000002aa307bea04 main (qemu-system-s390x)
> #21 0x000003ff84723dd2 __libc_start_main (libc.so.6)
> #22 0x000002aa307c0414 _start (qemu-system-s390x)
>=20
>=20
> The failing assertion is:
>=20
> qemu-kvm: util/iov.c:78: iov_memset: Assertion `offset =3D=3D 0' failed.
>=20

Just to give some context, this a guest with 2 disks with each assigned=20
an iothread. The guest was running a memory intensive workload.

 From the coredump of the qemu process, I see there were 2 threads that=20
were trying to call aio_poll with the same AioContext on the same=20
BlockDeviceDriver

Thread 1:

#0  0x000003ff8473e274 in raise () from /lib64/libc.so.6
#1  0x000003ff847239a8 in abort () from /lib64/libc.so.6
#2  0x000003ff847362ce in __assert_fail_base () from /lib64/libc.so.6
#3  0x000003ff8473634c in __assert_fail () from /lib64/libc.so.6
#4  0x000002aa30aba0c4 in iov_memset (iov=3D<optimized out>,=20
iov_cnt=3D<optimized out>, offset=3D<optimized out>, fillc=3D<optimized o=
ut>,=20
bytes=3D18446744073709547520) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/util/iov.c:7=
8
#5  0x000002aa30aba9a6 in qemu_iovec_memset (qiov=3D<optimized out>,=20
offset=3Doffset@entry=3D8192, fillc=3Dfillc@entry=3D0,=20
bytes=3D18446744073709547520) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/util/iov.c:4=
10
#6  0x000002aa30a23e88 in qemu_laio_process_completion=20
(laiocb=3D0x3fe36a6a3f0) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/block/linux-=
aio.c:88
#7  0x000002aa30a23f68 in qemu_laio_process_completions=20
(s=3Ds@entry=3D0x3fe60001910) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/block/linux-=
aio.c:222
#8  0x000002aa30a2418e in qemu_laio_process_completions_and_submit=20
(s=3D0x3fe60001910) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/block/linux-=
aio.c:237
#9  0x000002aa30a24220 in qemu_laio_poll_cb (opaque=3D<optimized out>) at=
=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/block/linux-=
aio.c:272
#10 0x000002aa30ab22c4 in run_poll_handlers_once=20
(ctx=3Dctx@entry=3D0x2aa4f35df50) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/util/aio-pos=
ix.c:494
#11 0x000002aa30ab2e78 in try_poll_mode (blocking=3D<optimized out>,=20
ctx=3D<optimized out>) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/util/aio-pos=
ix.c:573
=3D=3D=3D=3D>  #12 aio_poll (ctx=3D0x2aa4f35df50, blocking=3Dblocking@ent=
ry=3Dfalse)=20
at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/util/aio-pos=
ix.c:602
#13 0x000002aa30a29f4e in bdrv_drain_poll_top_level=20
(ignore_parent=3D<optimized out>, recursive=3D<optimized out>, bs=3D<opti=
mized=20
out>) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/block/io.c:3=
90
#14 bdrv_do_drained_begin (bs=3D0x2aa4f392510, recursive=3D<optimized out=
>,=20
parent=3D0x0, ignore_bds_parents=3D<optimized out>, poll=3D<optimized out=
>) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/block/io.c:3=
90
#15 0x000002aa30a2a276 in bdrv_drained_begin (bs=3D0x2aa4f392510) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/block/io.c:3=
96
#16 bdrv_drain (bs=3Dbs@entry=3D0x2aa4f392510) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/block/io.c:4=
78
#17 0x000002aa309d45aa in bdrv_set_aio_context (bs=3D0x2aa4f392510,=20
new_context=3D0x2aa4f3594f0) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/block.c:4954
#18 0x000002aa30a1c228 in blk_set_aio_context=20
(blk=3Dblk@entry=3D0x2aa4f38ed90, new_context=3D<optimized out>) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/block/block-=
backend.c:1894
#19 0x000002aa3085acfe in virtio_blk_data_plane_stop (vdev=3D<optimized=20
out>) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/hw/block/dat=
aplane/virtio-blk.c:285
#20 0x000002aa3096994c in virtio_bus_stop_ioeventfd (bus=3D0x2aa4f4f61f0)=
=20
at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/hw/virtio/vi=
rtio-bus.c:246
#21 0x000002aa3087d1d6 in virtio_vmstate_change (opaque=3D0x2aa4f4f72b8,=20
running=3D<optimized out>, state=3D<optimized out>) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/hw/virtio/vi=
rtio.c:2222
#22 0x000002aa308e8a12 in vm_state_notify (running=3D<optimized out>,=20
state=3D<optimized out>) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/vl.c:1532
#23 0x000002aa3080ed54 in do_vm_stop (state=3D<optimized out>,=20
send_stop=3D<optimized out>) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/cpus.c:1012
#24 0x000002aa307bea04 in main (argc=3D<optimized out>, argv=3D<optimized=
=20
out>, envp=3D<optimized out>) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/vl.c:4649


Thread 2 which is an IOThread:

#0  0x000003ff84910f9e in __lll_lock_wait () from /lib64/libpthread.so.0
#1  0x000003ff8490a1a2 in pthread_mutex_lock () from /lib64/libpthread.so=
.0
#2  0x000002aa30ab4cea in qemu_mutex_lock_impl (mutex=3D0x2aa4f35dfb0,=20
file=3Dfile@entry=3D0x2aa30b963f4=20
"/builddir/build/BUILD/qemu-2.12.91/util/async.c", line=3Dline@entry=3D51=
1)
     at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/util/qemu-th=
read-posix.c:66
#3  0x000002aa30aafff4 in aio_context_acquire (ctx=3D<optimized out>) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/util/async.c=
:511
#4  0x000002aa30a2419a in qemu_laio_process_completions_and_submit=20
(s=3D0x3fe60001910) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/block/linux-=
aio.c:239
#5  0x000002aa30ab23ee in aio_dispatch_handlers=20
(ctx=3Dctx@entry=3D0x2aa4f35df50) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/util/aio-pos=
ix.c:406
=3D=3D=3D=3D=3D> #6  0x000002aa30ab30b4 in aio_poll (ctx=3D0x2aa4f35df50,=
=20
blocking=3Dblocking@entry=3Dtrue) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/util/aio-pos=
ix.c:692
#7  0x000002aa308e2322 in iothread_run (opaque=3D0x2aa4f35d5c0) at=20
/usr/src/debug/qemu-2.12.91-20180720.0.677af45304.fc28.s390x/iothread.c:6=
3
#8  0x000003ff849079a8 in start_thread () from /lib64/libpthread.so.0
#9  0x000003ff847f97ee in thread_start () from /lib64/libc.so.6


This looked a little suspicious to me, I don't if this the expected=20
behavior or there is a race condition here. Any help debugging this=20
would be greatly appreciated.

Thanks
Farhan
