Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD04C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9244F2071A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLh406pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9244F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJiEI-00057K-Q1
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 14:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJiDU-00043n-Le
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJiDR-0000yI-Sr
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:35:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49185
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJiDR-0000xs-MQ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585766153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BwaKIjbDbU75F6Q9/e4Tbv8h6rtjk6qXb1A0oBx/Yjw=;
 b=XLh406peSvqmBsfqERlNwJ+EJyrvkhs4hN7MNVIJzRepCH0QowYck673ZPJD3xNXa6G3tq
 5gMM9sAPgXFhTmxsIrr91f0yMT8IpEzf553B5FUVno2CNLEUABTejO0dTThGYknrMDm9FZ
 2ddXZBLkhY3pdIpKu9DRHqoVfPese1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-oy6OJS7-OueZfMfcGtZSfg-1; Wed, 01 Apr 2020 14:35:51 -0400
X-MC-Unique: oy6OJS7-OueZfMfcGtZSfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 135AF107ACC7;
 Wed,  1 Apr 2020 18:35:50 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-172.ams2.redhat.com [10.36.114.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2156D5C553;
 Wed,  1 Apr 2020 18:35:45 +0000 (UTC)
Date: Wed, 1 Apr 2020 20:35:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: bdrv_drained_begin deadlock with io-threads
Message-ID: <20200401183544.GC27663@linux.fritz.box>
References: <658260883.24.1585644382441@webmail.proxmox.com>
 <20200331125804.GE7030@linux.fritz.box>
 <303038276.59.1585665152860@webmail.proxmox.com>
 <787d7517-bf56-72c7-d197-2313a864e05f@virtuozzo.com>
 <713436887.61.1585668262838@webmail.proxmox.com>
 <20200331153719.GI7030@linux.fritz.box>
 <518198448.62.1585671498399@webmail.proxmox.com>
 <20200401103748.GA4680@linux.fritz.box>
 <997901084.0.1585755465486@webmail.proxmox.com>
 <20200401181256.GB27663@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200401181256.GB27663@linux.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.04.2020 um 20:12 hat Kevin Wolf geschrieben:
> Am 01.04.2020 um 17:37 hat Dietmar Maurer geschrieben:
> > > > I really nobody else able to reproduce this (somebody already tried=
 to reproduce)?
> > >=20
> > > I can get hangs, but that's for job_completed(), not for starting the
> > > job. Also, my hangs have a non-empty bs->tracked_requests, so it look=
s
> > > like a different case to me.
> >=20
> > Please can you post the command line args of your VM? I use something l=
ike
> >=20
> > ./x86_64-softmmu/qemu-system-x86_64 -chardev
> > 'socket,id=3Dqmp,path=3D/var/run/qemu-server/101.qmp,server,nowait' -mo=
n
> > 'chardev=3Dqmp,mode=3Dcontrol' -pidfile /var/run/qemu-server/101.pid  -=
m
> > 1024 -object 'iothread,id=3Diothread-virtioscsi0' -device
> > 'virtio-scsi-pci,id=3Dvirtioscsi0,iothread=3Diothread-virtioscsi0' -dri=
ve
> > 'file=3D/backup/disk3/debian-buster.raw,if=3Dnone,id=3Ddrive-scsi0,form=
at=3Draw,cache=3Dnone,aio=3Dnative,detect-zeroes=3Don'
> > -device
> > 'scsi-hd,bus=3Dvirtioscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddr=
ive-scsi0,id=3Dscsi0'
> > -machine "type=3Dpc,accel=3Dkvm"
> >=20
> > Do you also run "stress-ng -d 5" indied the VM?
>=20
> I'm not using the exact same test case, but something that I thought
> would be similar enough. Specifically, I run the script below, which
> boots from a RHEL 8 CD and in the rescue shell, I'll do 'dd if=3D/dev/zer=
o
> of=3D/dev/sda' while the script keeps starting and cancelling backup jobs
> in the background.
>=20
> Anyway, I finally managed to bisect my problem now (did it wrong the
> first time) and got this result:
> [...]

So back on current git master, my deadlock is between main thread and
the iothread. For some reason, the main thread holds the thread pool
mutex of the iothread's thread pool. This means that the iothread can't
complete its requests and the drain operation in the main thread can't
make progress.

I think there is no reason why the main thread should ever take the
mutex of the thread pool of a different thread, so I'm not sure. But
maybe that backup commit changed something in the way nodes are moved
between AioContexts that would cause this to happen.

Kevin


Thread 3 (Thread 0x7f53c7438700 (LWP 3967)):
#0  0x00007f53d23449ad in __lll_lock_wait () at /lib64/libpthread.so.0
#1  0x00007f53d233dd94 in pthread_mutex_lock () at /lib64/libpthread.so.0
#2  0x000055dcc331bdb3 in qemu_mutex_lock_impl (mutex=3D0x55dcc4ff1c80, fil=
e=3D0x55dcc3512bff "util/async.c", line=3D557) at util/qemu-thread-posix.c:=
78
#3  0x000055dcc33167ae in thread_pool_completion_bh (opaque=3D0x7f53b800312=
0) at util/thread-pool.c:167
#4  0x000055dcc331597e in aio_bh_call (bh=3D0x55dcc5b94680) at util/async.c=
:117
#5  0x000055dcc331597e in aio_bh_poll (ctx=3Dctx@entry=3D0x55dcc4ff1c20) at=
 util/async.c:117
#6  0x000055dcc3318ee7 in aio_poll (ctx=3D0x55dcc4ff1c20, blocking=3Dblocki=
ng@entry=3Dtrue) at util/aio-posix.c:638
#7  0x000055dcc2ff7df0 in iothread_run (opaque=3Dopaque@entry=3D0x55dcc4cfd=
ac0) at iothread.c:75
#8  0x000055dcc331bbba in qemu_thread_start (args=3D<optimized out>) at uti=
l/qemu-thread-posix.c:519
#9  0x00007f53d233b4aa in start_thread () at /lib64/libpthread.so.0
#10 0x00007f53d226b3f3 in clone () at /lib64/libc.so.6

Thread 1 (Thread 0x7f53c7dab680 (LWP 3962)):
#0  0x00007f53d2260526 in ppoll () at /lib64/libc.so.6
#1  0x000055dcc33171c9 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<opt=
imized out>, __fds=3D<optimized out>) at /usr/include/bits/poll2.h:77
#2  0x000055dcc33171c9 in qemu_poll_ns (fds=3D<optimized out>, nfds=3D<opti=
mized out>, timeout=3Dtimeout@entry=3D-1) at util/qemu-timer.c:335
#3  0x000055dcc33199a1 in fdmon_poll_wait (ctx=3D0x55dcc4f78470, ready_list=
=3D0x7fffb3506768, timeout=3D-1) at util/fdmon-poll.c:79
#4  0x000055dcc3318f87 in aio_poll (ctx=3D0x55dcc4f78470, blocking=3Dblocki=
ng@entry=3Dtrue) at util/aio-posix.c:589
#5  0x000055dcc3276763 in bdrv_do_drained_begin (poll=3D<optimized out>, ig=
nore_bds_parents=3Dfalse, parent=3D0x0, recursive=3Dfalse, bs=3D0x55dcc5b66=
010) at block/io.c:429
#6  0x000055dcc3276763 in bdrv_do_drained_begin (bs=3D0x55dcc5b66010, recur=
sive=3D<optimized out>, parent=3D0x0, ignore_bds_parents=3D<optimized out>,=
 poll=3D<optimized out>) at block/io.c:395
#7  0x000055dcc3291422 in bdrv_backup_top_drop (bs=3D0x55dcc5b66010) at blo=
ck/backup-top.c:273
#8  0x000055dcc328cb4c in backup_clean (job=3D0x55dcc64ab800) at block/back=
up.c:132
#9  0x000055dcc322324d in job_clean (job=3D0x55dcc64ab800) at job.c:656
#10 0x000055dcc322324d in job_finalize_single (job=3D0x55dcc64ab800) at job=
.c:672
#11 0x000055dcc322324d in job_finalize_single (job=3D0x55dcc64ab800) at job=
.c:660
#12 0x000055dcc3223baa in job_completed_txn_abort (job=3D<optimized out>) a=
t job.c:748
#13 0x000055dcc3223db2 in job_completed (job=3D0x55dcc64ab800) at job.c:842
#14 0x000055dcc3223db2 in job_completed (job=3D0x55dcc64ab800) at job.c:835
#15 0x000055dcc3223f60 in job_exit (opaque=3D0x55dcc64ab800) at job.c:863
#16 0x000055dcc331597e in aio_bh_call (bh=3D0x7f53b8010eb0) at util/async.c=
:117
#17 0x000055dcc331597e in aio_bh_poll (ctx=3Dctx@entry=3D0x55dcc4f78470) at=
 util/async.c:117
#18 0x000055dcc3318dde in aio_dispatch (ctx=3D0x55dcc4f78470) at util/aio-p=
osix.c:380
#19 0x000055dcc331585e in aio_ctx_dispatch (source=3D<optimized out>, callb=
ack=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:260
#20 0x00007f53d4ccd06d in g_main_context_dispatch () at /lib64/libglib-2.0.=
so.0
#21 0x000055dcc3318048 in glib_pollfds_poll () at util/main-loop.c:219
#22 0x000055dcc3318048 in os_host_main_loop_wait (timeout=3D<optimized out>=
) at util/main-loop.c:242
#23 0x000055dcc3318048 in main_loop_wait (nonblocking=3Dnonblocking@entry=
=3D0) at util/main-loop.c:518
#24 0x000055dcc2f8e3f9 in qemu_main_loop () at /home/kwolf/source/qemu/soft=
mmu/vl.c:1665
#25 0x000055dcc2e7793e in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at /home/kwolf/source/qemu/softmmu/main.c:49

(gdb) thread 3
[Switching to thread 3 (Thread 0x7f53c7438700 (LWP 3967))]
#0  0x00007f53d23449ad in __lll_lock_wait () from /lib64/libpthread.so.0
(gdb) up
#1  0x00007f53d233dd94 in pthread_mutex_lock () from /lib64/libpthread.so.0
(gdb)
#2  0x000055dcc331bdb3 in qemu_mutex_lock_impl (mutex=3D0x55dcc4ff1c80, fil=
e=3D0x55dcc3512bff "util/async.c", line=3D557) at util/qemu-thread-posix.c:=
78
78          err =3D pthread_mutex_lock(&mutex->lock);
(gdb) p *mutex
$1 =3D {lock =3D {__data =3D {__lock =3D 2, __count =3D 1, __owner =3D 3962=
, __nusers =3D 1, __kind =3D 1, __spins =3D 0, __elision =3D 0, __list =3D =
{__prev =3D 0x0, __next =3D 0x0}},
    __size =3D "\002\000\000\000\001\000\000\000z\017\000\000\001\000\000\0=
00\001", '\000' <repeats 22 times>, __align =3D 4294967298}, initialized =
=3D true}
(gdb) info threads
  Id   Target Id                                          Frame
  1    Thread 0x7f53c7dab680 (LWP 3962) "qemu-system-x86" 0x00007f53d226052=
6 in ppoll () from /lib64/libc.so.6
  2    Thread 0x7f53c7c39700 (LWP 3966) "qemu-system-x86" 0x00007f53d2265c4=
d in syscall () from /lib64/libc.so.6
* 3    Thread 0x7f53c7438700 (LWP 3967) "qemu-system-x86" 0x00007f53d23449a=
d in __lll_lock_wait () from /lib64/libpthread.so.0
  4    Thread 0x7f53c61b2700 (LWP 3970) "qemu-system-x86" 0x00007f53d226043=
1 in poll () from /lib64/libc.so.6
  5    Thread 0x7f53c59b1700 (LWP 3972) "qemu-system-x86" 0x00007f53d23449a=
d in __lll_lock_wait () from /lib64/libpthread.so.0
  6    Thread 0x7f53c49ff700 (LWP 3974) "gmain"           0x00007f53d226043=
1 in poll () from /lib64/libc.so.6
  7    Thread 0x7f536ebff700 (LWP 3975) "gdbus"           0x00007f53d226043=
1 in poll () from /lib64/libc.so.6


