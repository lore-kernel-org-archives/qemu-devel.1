Return-Path: <SRS0=sDSq=3P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03384C2D0DB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 13:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2ABE20716
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 13:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="GnEVHnah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2ABE20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivhvn-0005yZ-OQ
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 08:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1ivhv5-0005SJ-UZ
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 08:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1ivhv2-0005IX-T4
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 08:25:43 -0500
Received: from mail1.hostfission.com ([139.99.139.48]:48892)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1ivhv2-0005GB-AE
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 08:25:40 -0500
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id B41A24C5BF
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 00:25:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1580045135;
 bh=wbj9Fx14tiBS0DMv5FjUusQPYdqNpgku6khVuBi4vyU=;
 h=Date:From:To:Subject:From;
 b=GnEVHnahqdXjlEGF0SL36IYMLW3d5Y1G6Mq1lYWH5+VAKVtiScwz/DXHSCGhWFV8v
 SLsPca2ZxWBLWFtXkB5iSeNCLKWIGcOzI1Ufi7YUy15Rq6cjDFOh/wGftBtZodIzhx
 VKmjvtk+Q5k+qPzP2fIhE8fwLR5wioZoSDc+zS+E=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id A9EF78126F
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 00:25:35 +1100 (AEDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Jan 2020 00:25:35 +1100
From: Geoffrey McRae <geoff@hostfission.com>
To: qemu-devel@nongnu.org
Subject: High rate of MMIO causes KVM stall
Message-ID: <919519ecb934186479eef62c5bcef6bd@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 139.99.139.48
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi All,

I have run into what appears to be a race condition in Qemu with regards 
to iommu
access involving atomic reads performed by a userspace application in 
the guest
virtual machine with a VFIO passthrough GPU.

While polling a memory mapped IO address on the ivshmem device at a high 
rate,
graphical updates such as simple click and drag to select multiple icons 
on the
Windows desktop can randomly trigger a stall lasting several seconds.

Below is a trace I obtained from attaching a debugger and breaking 
during one of
these events. As can be seen multiple threads are waiting on the
qemu_global_mutex while trying to perform a MMIO read.

What is more concerning then the poor guest operation is that during 
this stall
the host system and all other guests on the system becomes very 
slow/unresponsive
until the guest manages to resume itself. This might be possible to be 
used as a
form of DoS attack on the host system if the exact usage pattern can be 
narrowed
down.

The VM's is configured as follows:

   -machine 
q35,accel=kvm,usb=off,vmport=off,dump-guest-core=off,kernel-irqchip=on \
   -cpu 
host,hv_time,hv_vpindex,hv_reset,hv_runtime,hv_crash,hv_synic,hv_stimer,hv_spinlocks=0x1fff,hv_vendor_id=lakeuv283713,kvm=off,l3-cache=on,-hypervisor,migratable=no,+invtsc,topoext

If further details are required please advise.

Kind Regards,
Geoffrey McRae
HostFission
https://hostfission.com

== TRACE ==

Thread 12 (Thread 0x7f3ceb5fe700 (LWP 77094)):
#0  0x00007f3d12b91819 in __GI___poll (fds=0x7f38ac000b20, nfds=2, 
timeout=1490) at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x00007f3d142e2131 in  () at /usr/lib/x86_64-linux-gnu/libpulse.so.0
#2  0x00007f3d142d39a0 in pa_mainloop_poll () at 
/usr/lib/x86_64-linux-gnu/libpulse.so.0
#3  0x00007f3d142d3fee in pa_mainloop_iterate () at 
/usr/lib/x86_64-linux-gnu/libpulse.so.0
#4  0x00007f3d142d40a0 in pa_mainloop_run () at 
/usr/lib/x86_64-linux-gnu/libpulse.so.0
#5  0x00007f3d142e2079 in  () at /usr/lib/x86_64-linux-gnu/libpulse.so.0
#6  0x00007f3d124bc468 in  () at 
/usr/lib/x86_64-linux-gnu/pulseaudio/libpulsecommon-12.2.so
#7  0x00007f3d12c6bfa3 in start_thread (arg=<optimized out>) at 
pthread_create.c:486
#8  0x00007f3d12b9c4cf in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 11 (Thread 0x7f3cebdff700 (LWP 77091)):
#0  0x00007f3d12c763c7 in __libc_recvmsg (flags=0, msg=0x7f3cebdfbb80, 
fd=41) at ../sysdeps/unix/sysv/linux/recvmsg.c:28
#1  0x00007f3d12c763c7 in __libc_recvmsg (fd=41, msg=0x7f3cebdfbb80, 
flags=0) at ../sysdeps/unix/sysv/linux/recvmsg.c:25
#2  0x00007f3d12497fd7 in pa_iochannel_read_with_ancil_data () at 
/usr/lib/x86_64-linux-gnu/pulseaudio/libpulsecommon-12.2.so
#3  0x00007f3d124a8867 in  () at 
/usr/lib/x86_64-linux-gnu/pulseaudio/libpulsecommon-12.2.so
#4  0x00007f3d124ab7ff in  () at 
/usr/lib/x86_64-linux-gnu/pulseaudio/libpulsecommon-12.2.so
#5  0x00007f3d142d3d28 in pa_mainloop_dispatch () at 
/usr/lib/x86_64-linux-gnu/libpulse.so.0
#6  0x00007f3d142d3ffc in pa_mainloop_iterate () at 
/usr/lib/x86_64-linux-gnu/libpulse.so.0
#7  0x00007f3d142d40a0 in pa_mainloop_run () at 
/usr/lib/x86_64-linux-gnu/libpulse.so.0
#8  0x00007f3d142e2079 in  () at /usr/lib/x86_64-linux-gnu/libpulse.so.0
#9  0x00007f3d124bc468 in  () at 
/usr/lib/x86_64-linux-gnu/pulseaudio/libpulsecommon-12.2.so
#10 0x00007f3d12c6bfa3 in start_thread (arg=<optimized out>) at 
pthread_create.c:486
#11 0x00007f3d12b9c4cf in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 10 (Thread 0x7f3cf97fa700 (LWP 77088)):
#0  0x00007f3d12c7529c in __lll_lock_wait () at 
../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
#1  0x00007f3d12c6e714 in __GI___pthread_mutex_lock 
(mutex=mutex@entry=0x5564ce5bc740 <qemu_global_mutex>) at 
../nptl/pthread_mutex_lock.c:80
#2  0x00005564cde59023 in qemu_mutex_lock_impl (mutex=0x5564ce5bc740 
<qemu_global_mutex>, file=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=3129)
     at /srv/QEMU/Source/util/qemu-thread-posix.c:78
#3  0x00005564cd96c27e in qemu_mutex_lock_iothread_impl 
(file=file@entry=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=line@entry=3129)
     at /srv/QEMU/Source/cpus.c:1899
#4  0x00005564cd90d155 in prepare_mmio_access (mr=0x5564cf271f10, 
mr=0x5564cf271f10) at /srv/QEMU/Source/exec.c:3129
#5  0x00005564cd90d155 in flatview_read_continue
     (fv=0x7f3ce0649880, addr=1544, attrs=..., buf=0x7f3d02f1e000 "", 
len=4, addr1=<optimized out>, l=<optimized out>, mr=0x5564cf271f10)
     at /srv/QEMU/Source/exec.c:3225
#6  0x00005564cd90d30d in flatview_read (fv=0x7f3ce0649880, addr=1544, 
attrs=..., buf=0x7f3d02f1e000 "", len=4) at /srv/QEMU/Source/exec.c:3266
#7  0x00005564cd90d93f in address_space_read_full (len=0, buf=<optimized 
out>, attrs=..., addr=139900019134464, as=<optimized out>)
     at /srv/QEMU/Source/exec.c:3279
#8  0x00005564cd90d93f in address_space_rw (as=<optimized out>, 
addr=addr@entry=1544, attrs=...,
     attrs@entry=..., buf=<optimized out>, len=len@entry=4, 
is_write=is_write@entry=false) at /srv/QEMU/Source/exec.c:3307
#9  0x00005564cd994273 in kvm_handle_io (count=1, size=4, 
direction=<optimized out>, data=<optimized out>, attrs=..., port=1544)
     at /srv/QEMU/Source/accel/kvm/kvm-all.c:2104
#10 0x00005564cd994273 in kvm_cpu_exec (cpu=cpu@entry=0x5564cecde430) at 
/srv/QEMU/Source/accel/kvm/kvm-all.c:2350
#11 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn (arg=0x5564cecde430) at 
/srv/QEMU/Source/cpus.c:1318
#12 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn 
(arg=arg@entry=0x5564cecde430) at /srv/QEMU/Source/cpus.c:1290
#13 0x00005564cde58eca in qemu_thread_start (args=<optimized out>) at 
/srv/QEMU/Source/util/qemu-thread-posix.c:519
#14 0x00007f3d12c6bfa3 in start_thread (arg=<optimized out>) at 
pthread_create.c:486
#15 0x00007f3d12b9c4cf in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 9 (Thread 0x7f3cf9ffb700 (LWP 77087)):
#0  0x00007f3d12c7529c in __lll_lock_wait () at 
../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
#1  0x00007f3d12c6e714 in __GI___pthread_mutex_lock 
(mutex=mutex@entry=0x5564ce5bc740 <qemu_global_mutex>) at 
../nptl/pthread_mutex_lock.c:80
#2  0x00005564cde59023 in qemu_mutex_lock_impl (mutex=0x5564ce5bc740 
<qemu_global_mutex>, file=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=3129)
     at /srv/QEMU/Source/util/qemu-thread-posix.c:78
#3  0x00005564cd96c27e in qemu_mutex_lock_iothread_impl 
(file=file@entry=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=line@entry=3129)
     at /srv/QEMU/Source/cpus.c:1899
#4  0x00005564cd90d155 in prepare_mmio_access (mr=0x5564cf271f10, 
mr=0x5564cf271f10) at /srv/QEMU/Source/exec.c:3129
#5  0x00005564cd90d155 in flatview_read_continue
     (fv=0x7f3ce0649880, addr=1544, attrs=..., buf=0x7f3d042e1000 "", 
len=4, addr1=<optimized out>, l=<optimized out>, mr=0x5564cf271f10)
     at /srv/QEMU/Source/exec.c:3225
#6  0x00005564cd90d30d in flatview_read (fv=0x7f3ce0649880, addr=1544, 
attrs=..., buf=0x7f3d042e1000 "", len=4) at /srv/QEMU/Source/exec.c:3266
#7  0x00005564cd90d93f in address_space_read_full (len=0, buf=<optimized 
out>, attrs=..., addr=139900039856128, as=<optimized out>)
     at /srv/QEMU/Source/exec.c:3279
#8  0x00005564cd90d93f in address_space_rw (as=<optimized out>, 
addr=addr@entry=1544, attrs=...,
     attrs@entry=..., buf=<optimized out>, len=len@entry=4, 
is_write=is_write@entry=false) at /srv/QEMU/Source/exec.c:3307
#9  0x00005564cd994273 in kvm_handle_io (count=1, size=4, 
direction=<optimized out>, data=<optimized out>, attrs=..., port=1544)
     at /srv/QEMU/Source/accel/kvm/kvm-all.c:2104
#10 0x00005564cd994273 in kvm_cpu_exec (cpu=cpu@entry=0x5564cecb66f0) at 
/srv/QEMU/Source/accel/kvm/kvm-all.c:2350
#11 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn (arg=0x5564cecb66f0) at 
/srv/QEMU/Source/cpus.c:1318
#12 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn 
(arg=arg@entry=0x5564cecb66f0) at /srv/QEMU/Source/cpus.c:1290
#13 0x00005564cde58eca in qemu_thread_start (args=<optimized out>) at 
/srv/QEMU/Source/util/qemu-thread-posix.c:519
#14 0x00007f3d12c6bfa3 in start_thread (arg=<optimized out>) at 
pthread_create.c:486
#15 0x00007f3d12b9c4cf in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 8 (Thread 0x7f3cfa7fc700 (LWP 77086)):
#0  0x00007f3d12c7529c in __lll_lock_wait () at 
../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
#1  0x00007f3d12c6e714 in __GI___pthread_mutex_lock 
(mutex=mutex@entry=0x5564ce5bc740 <qemu_global_mutex>) at 
../nptl/pthread_mutex_lock.c:80
#2  0x00005564cde59023 in qemu_mutex_lock_impl (mutex=0x5564ce5bc740 
<qemu_global_mutex>, file=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=3129)
     at /srv/QEMU/Source/util/qemu-thread-posix.c:78
#3  0x00005564cd96c27e in qemu_mutex_lock_iothread_impl 
(file=file@entry=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=line@entry=3129)
     at /srv/QEMU/Source/cpus.c:1899
#4  0x00005564cd90d155 in prepare_mmio_access (mr=0x5564cf271f10, 
mr=0x5564cf271f10) at /srv/QEMU/Source/exec.c:3129
#5  0x00005564cd90d155 in flatview_read_continue
     (fv=0x7f3ce0649880, addr=1544, attrs=..., buf=0x7f3d042e4000 "", 
len=4, addr1=<optimized out>, l=<optimized out>, mr=0x5564cf271f10)
     at /srv/QEMU/Source/exec.c:3225
#6  0x00005564cd90d30d in flatview_read (fv=0x7f3ce0649880, addr=1544, 
attrs=..., buf=0x7f3d042e4000 "", len=4) at /srv/QEMU/Source/exec.c:3266
#7  0x00005564cd90d93f in address_space_read_full (len=0, buf=<optimized 
out>, attrs=..., addr=139900039868416, as=<optimized out>)
     at /srv/QEMU/Source/exec.c:3279
#8  0x00005564cd90d93f in address_space_rw (as=<optimized out>, 
addr=addr@entry=1544, attrs=...,
     attrs@entry=..., buf=<optimized out>, len=len@entry=4, 
is_write=is_write@entry=false) at /srv/QEMU/Source/exec.c:3307
#9  0x00005564cd994273 in kvm_handle_io (count=1, size=4, 
direction=<optimized out>, data=<optimized out>, attrs=..., port=1544)
     at /srv/QEMU/Source/accel/kvm/kvm-all.c:2104
#10 0x00005564cd994273 in kvm_cpu_exec (cpu=cpu@entry=0x5564cec8da00) at 
/srv/QEMU/Source/accel/kvm/kvm-all.c:2350
#11 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn (arg=0x5564cec8da00) at 
/srv/QEMU/Source/cpus.c:1318
#12 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn 
(arg=arg@entry=0x5564cec8da00) at /srv/QEMU/Source/cpus.c:1290
#13 0x00005564cde58eca in qemu_thread_start (args=<optimized out>) at 
/srv/QEMU/Source/util/qemu-thread-posix.c:519
#14 0x00007f3d12c6bfa3 in start_thread (arg=<optimized out>) at 
pthread_create.c:486
#15 0x00007f3d12b9c4cf in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 7 (Thread 0x7f3d01fff700 (LWP 77085)):
#0  0x00007f3d12c7529c in __lll_lock_wait () at 
../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
#1  0x00007f3d12c6e714 in __GI___pthread_mutex_lock 
(mutex=mutex@entry=0x5564ce5bc740 <qemu_global_mutex>) at 
../nptl/pthread_mutex_lock.c:80
#2  0x00005564cde59023 in qemu_mutex_lock_impl (mutex=0x5564ce5bc740 
<qemu_global_mutex>, file=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=3129)
     at /srv/QEMU/Source/util/qemu-thread-posix.c:78
#3  0x00005564cd96c27e in qemu_mutex_lock_iothread_impl 
(file=file@entry=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=line@entry=3129)
     at /srv/QEMU/Source/cpus.c:1899
#4  0x00005564cd90d155 in prepare_mmio_access (mr=0x5564cf271f10, 
mr=0x5564cf271f10) at /srv/QEMU/Source/exec.c:3129
#5  0x00005564cd90d155 in flatview_read_continue
     (fv=0x7f3ce0649880, addr=1544, attrs=..., buf=0x7f3d042e7000 "", 
len=4, addr1=<optimized out>, l=<optimized out>, mr=0x5564cf271f10)
     at /srv/QEMU/Source/exec.c:3225
#6  0x00005564cd90d30d in flatview_read (fv=0x7f3ce0649880, addr=1544, 
attrs=..., buf=0x7f3d042e7000 "", len=4) at /srv/QEMU/Source/exec.c:3266
#7  0x00005564cd90d93f in address_space_read_full (len=0, buf=<optimized 
out>, attrs=..., addr=139900039880704, as=<optimized out>)
     at /srv/QEMU/Source/exec.c:3279
#8  0x00005564cd90d93f in address_space_rw (as=<optimized out>, 
addr=addr@entry=1544, attrs=..., attrs@entry=..., buf=<optimized out>, 
len=len@entry=4, is_write=is_write@entry=false) at 
/srv/QEMU/Source/exec.c:3307
#9  0x00005564cd994273 in kvm_handle_io (count=1, size=4, 
direction=<optimized out>, data=<optimized out>, attrs=..., port=1544) 
at /srv/QEMU/Source/accel/kvm/kvm-all.c:2104
#10 0x00005564cd994273 in kvm_cpu_exec (cpu=cpu@entry=0x5564cec65f40) at 
/srv/QEMU/Source/accel/kvm/kvm-all.c:2350
#11 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn (arg=0x5564cec65f40) at 
/srv/QEMU/Source/cpus.c:1318
#12 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn 
(arg=arg@entry=0x5564cec65f40) at /srv/QEMU/Source/cpus.c:1290
#13 0x00005564cde58eca in qemu_thread_start (args=<optimized out>) at 
/srv/QEMU/Source/util/qemu-thread-posix.c:519
#14 0x00007f3d12c6bfa3 in start_thread (arg=<optimized out>) at 
pthread_create.c:486
#15 0x00007f3d12b9c4cf in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 6 (Thread 0x7f3d00f1b700 (LWP 77084)):
#0  0x00007f3d12c7529c in __lll_lock_wait () at 
../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
#1  0x00007f3d12c6e714 in __GI___pthread_mutex_lock 
(mutex=mutex@entry=0x5564ce5bc740 <qemu_global_mutex>) at 
../nptl/pthread_mutex_lock.c:80
#2  0x00005564cde59023 in qemu_mutex_lock_impl (mutex=0x5564ce5bc740 
<qemu_global_mutex>, file=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=3129) at /srv/QEMU/Source/util/qemu-thread-posix.c:78
#3  0x00005564cd96c27e in qemu_mutex_lock_iothread_impl 
(file=file@entry=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=line@entry=3129) at /srv/QEMU/Source/cpus.c:1899
#4  0x00005564cd90d155 in prepare_mmio_access (mr=0x5564cf271f10, 
mr=0x5564cf271f10) at /srv/QEMU/Source/exec.c:3129
#5  0x00005564cd90d155 in flatview_read_continue (fv=0x7f3ce0649880, 
addr=1544, attrs=..., buf=0x7f3d042ea000 "", len=4, addr1=<optimized 
out>, l=<optimized out>, mr=0x5564cf271f10) at 
/srv/QEMU/Source/exec.c:3225
#6  0x00005564cd90d30d in flatview_read (fv=0x7f3ce0649880, addr=1544, 
attrs=..., buf=0x7f3d042ea000 "", len=4) at /srv/QEMU/Source/exec.c:3266
#7  0x00005564cd90d93f in address_space_read_full (len=0, buf=<optimized 
out>, attrs=..., addr=139900039892992, as=<optimized out>) at 
/srv/QEMU/Source/exec.c:3279
#8  0x00005564cd90d93f in address_space_rw (as=<optimized out>, 
addr=addr@entry=1544, attrs=..., attrs@entry=..., buf=<optimized out>, 
len=len@entry=4, is_write=is_write@entry=false) at 
/srv/QEMU/Source/exec.c:3307
#9  0x00005564cd994273 in kvm_handle_io (count=1, size=4, 
direction=<optimized out>, data=<optimized out>, attrs=..., port=1544) 
at /srv/QEMU/Source/accel/kvm/kvm-all.c:2104
#10 0x00005564cd994273 in kvm_cpu_exec (cpu=cpu@entry=0x5564cec3e4f0) at 
/srv/QEMU/Source/accel/kvm/kvm-all.c:2350
#11 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn (arg=0x5564cec3e4f0) at 
/srv/QEMU/Source/cpus.c:1318
#12 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn 
(arg=arg@entry=0x5564cec3e4f0) at /srv/QEMU/Source/cpus.c:1290
#13 0x00005564cde58eca in qemu_thread_start (args=<optimized out>) at 
/srv/QEMU/Source/util/qemu-thread-posix.c:519
#14 0x00007f3d12c6bfa3 in start_thread (arg=<optimized out>) at 
pthread_create.c:486
#15 0x00007f3d12b9c4cf in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 5 (Thread 0x7f3cfbfff700 (LWP 77083)):
#0  0x00007f3d12c7529c in __lll_lock_wait () at 
../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
#1  0x00007f3d12c6e714 in __GI___pthread_mutex_lock 
(mutex=mutex@entry=0x5564ce5bc740 <qemu_global_mutex>) at 
../nptl/pthread_mutex_lock.c:80
#2  0x00005564cde59023 in qemu_mutex_lock_impl (mutex=0x5564ce5bc740 
<qemu_global_mutex>, file=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=3129) at /srv/QEMU/Source/util/qemu-thread-posix.c:78
#3  0x00005564cd96c27e in qemu_mutex_lock_iothread_impl 
(file=file@entry=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=line@entry=3129) at /srv/QEMU/Source/cpus.c:1899
#4  0x00005564cd90d155 in prepare_mmio_access (mr=0x5564cf271f10, 
mr=0x5564cf271f10) at /srv/QEMU/Source/exec.c:3129
#5  0x00005564cd90d155 in flatview_read_continue (fv=0x7f3ce0649880, 
addr=1544, attrs=..., buf=0x7f3d042ed000 "", len=4, addr1=<optimized 
out>, l=<optimized out>, mr=0x5564cf271f10) at 
/srv/QEMU/Source/exec.c:3225
#6  0x00005564cd90d30d in flatview_read (fv=0x7f3ce0649880, addr=1544, 
attrs=..., buf=0x7f3d042ed000 "", len=4) at /srv/QEMU/Source/exec.c:3266
#7  0x00005564cd90d93f in address_space_read_full (len=0, buf=<optimized 
out>, attrs=..., addr=139900039905280, as=<optimized out>) at 
/srv/QEMU/Source/exec.c:3279
#8  0x00005564cd90d93f in address_space_rw (as=<optimized out>, 
addr=addr@entry=1544, attrs=..., attrs@entry=..., buf=<optimized out>, 
len=len@entry=4, is_write=is_write@entry=false) at 
/srv/QEMU/Source/exec.c:3307
#9  0x00005564cd994273 in kvm_handle_io (count=1, size=4, 
direction=<optimized out>, data=<optimized out>, attrs=..., port=1544) 
at /srv/QEMU/Source/accel/kvm/kvm-all.c:2104
#10 0x00005564cd994273 in kvm_cpu_exec (cpu=cpu@entry=0x5564cec16c30) at 
/srv/QEMU/Source/accel/kvm/kvm-all.c:2350
#11 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn (arg=0x5564cec16c30) at 
/srv/QEMU/Source/cpus.c:1318
#12 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn 
(arg=arg@entry=0x5564cec16c30) at /srv/QEMU/Source/cpus.c:1290
#13 0x00005564cde58eca in qemu_thread_start (args=<optimized out>) at 
/srv/QEMU/Source/util/qemu-thread-posix.c:519
#14 0x00007f3d12c6bfa3 in start_thread (arg=<optimized out>) at 
pthread_create.c:486
#15 0x00007f3d12b9c4cf in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 4 (Thread 0x7f3cfb7fe700 (LWP 77082)):
#0  0x00007f3d12b93427 in ioctl () at 
../sysdeps/unix/syscall-template.S:78
#1  0x00005564cd993e99 in kvm_vcpu_ioctl (cpu=cpu@entry=0x5564cebee630, 
type=type@entry=44672) at /srv/QEMU/Source/accel/kvm/kvm-all.c:2473
#2  0x00005564cd993fd1 in kvm_cpu_exec (cpu=cpu@entry=0x5564cebee630) at 
/srv/QEMU/Source/accel/kvm/kvm-all.c:2310
#3  0x00005564cd96a704 in qemu_kvm_cpu_thread_fn (arg=0x5564cebee630) at 
/srv/QEMU/Source/cpus.c:1318
#4  0x00005564cd96a704 in qemu_kvm_cpu_thread_fn 
(arg=arg@entry=0x5564cebee630) at /srv/QEMU/Source/cpus.c:1290
#5  0x00005564cde58eca in qemu_thread_start (args=<optimized out>) at 
/srv/QEMU/Source/util/qemu-thread-posix.c:519
#6  0x00007f3d12c6bfa3 in start_thread (arg=<optimized out>) at 
pthread_create.c:486
#7  0x00007f3d12b9c4cf in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 3 (Thread 0x7f3cfaffd700 (LWP 77081)):
#0  0x00007f3d12c7529c in __lll_lock_wait () at 
../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:103
#1  0x00007f3d12c6e714 in __GI___pthread_mutex_lock 
(mutex=mutex@entry=0x5564ce5bc740 <qemu_global_mutex>) at 
../nptl/pthread_mutex_lock.c:80
#2  0x00005564cde59023 in qemu_mutex_lock_impl (mutex=0x5564ce5bc740 
<qemu_global_mutex>, file=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=3129) at /srv/QEMU/Source/util/qemu-thread-posix.c:78
#3  0x00005564cd96c27e in qemu_mutex_lock_iothread_impl 
(file=file@entry=0x5564cdf1d004 "/srv/QEMU/Source/exec.c", 
line=line@entry=3129) at /srv/QEMU/Source/cpus.c:1899
#4  0x00005564cd90d155 in prepare_mmio_access (mr=0x5564cf778c60, 
mr=0x5564cf778c60) at /srv/QEMU/Source/exec.c:3129
#5  0x00005564cd90d155 in flatview_read_continue (fv=0x7f3ce10cb670, 
addr=34896613376, attrs=..., buf=0x7f3d149d3028 "", len=1, 
addr1=<optimized out>, l=<optimized out>, mr=0x5564cf778c60) at 
/srv/QEMU/Source/exec.c:3225
#6  0x00005564cd90d30d in flatview_read (fv=0x7f3ce10cb670, 
addr=34896613376, attrs=..., buf=0x7f3d149d3028 "", len=1) at 
/srv/QEMU/Source/exec.c:3266
#7  0x00005564cd90d93f in address_space_read_full (len=<optimized out>, 
buf=0x0, attrs=..., addr=<optimized out>, as=<optimized out>) at 
/srv/QEMU/Source/exec.c:3279
#8  0x00005564cd90d93f in address_space_rw (as=<optimized out>, 
addr=<optimized out>, attrs=..., attrs@entry=..., 
buf=buf@entry=0x7f3d149d3028 "", len=<optimized out>, 
is_write=<optimized out>) at /srv/QEMU/Source/exec.c:3307
#9  0x00005564cd994199 in kvm_cpu_exec (cpu=cpu@entry=0x5564ceb9e850) at 
/srv/QEMU/Source/accel/kvm/kvm-all.c:2360
#10 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn (arg=0x5564ceb9e850) at 
/srv/QEMU/Source/cpus.c:1318
#11 0x00005564cd96a704 in qemu_kvm_cpu_thread_fn 
(arg=arg@entry=0x5564ceb9e850) at /srv/QEMU/Source/cpus.c:1290
#12 0x00005564cde58eca in qemu_thread_start (args=<optimized out>) at 
/srv/QEMU/Source/util/qemu-thread-posix.c:519
#13 0x00007f3d12c6bfa3 in start_thread (arg=<optimized out>) at 
pthread_create.c:486
#14 0x00007f3d12b9c4cf in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 2 (Thread 0x7f3d04218700 (LWP 77049)):
#0  0x00007f3d12b96f59 in syscall () at 
../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x00005564cde59cfb in qemu_futex_wait (val=<optimized out>, 
f=<optimized out>) at /srv/QEMU/Source/util/qemu-thread-posix.c:455
#2  0x00005564cde59cfb in qemu_event_wait (ev=ev@entry=0x5564ce5f6488 
<rcu_call_ready_event>) at /srv/QEMU/Source/util/qemu-thread-posix.c:459
#3  0x00005564cde7190f in call_rcu_thread (opaque=opaque@entry=0x0) at 
/srv/QEMU/Source/util/rcu.c:260
#4  0x00005564cde58eca in qemu_thread_start (args=<optimized out>) at 
/srv/QEMU/Source/util/qemu-thread-posix.c:519
#5  0x00007f3d12c6bfa3 in start_thread (arg=<optimized out>) at 
pthread_create.c:486
#6  0x00007f3d12b9c4cf in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 1 (Thread 0x7f3d043556c0 (LWP 77047)):
#0  0x00007f3d12b93427 in ioctl () at 
../sysdeps/unix/syscall-template.S:78
#1  0x00005564cd990364 in kvm_vm_ioctl (s=s@entry=0x5564ce92f3e0, 
type=-1073172889) at /srv/QEMU/Source/accel/kvm/kvm-all.c:2455
#2  0x00005564cd991a75 in kvm_set_irq (s=0x5564ce92f3e0, 
irq=irq@entry=8, level=level@entry=1) at 
/srv/QEMU/Source/accel/kvm/kvm-all.c:1253
#3  0x00005564cda3daa3 in kvm_pic_set_irq (opaque=<optimized out>, 
irq=8, level=1) at /srv/QEMU/Source/hw/i386/kvm/i8259.c:118
#4  0x00005564cd9e52d3 in qemu_irq_raise (irq=<optimized out>) at 
/srv/QEMU/Source/include/hw/irq.h:12
#5  0x00005564cd9e52d3 in rtc_policy_slew_deliver_irq (s=0x5564cee46000) 
at /srv/QEMU/Source/hw/rtc/mc146818rtc.c:125
#6  0x00005564cd9e52d3 in rtc_periodic_timer (opaque=0x5564cee46000) at 
/srv/QEMU/Source/hw/rtc/mc146818rtc.c:256
#7  0x00005564cde54d41 in timerlist_run_timers 
(timer_list=0x5564ce8eae90) at /srv/QEMU/Source/util/qemu-timer.c:588
#8  0x00005564cde55125 in timerlist_run_timers (timer_list=<optimized 
out>) at /srv/QEMU/Source/util/qemu-timer.c:508
#9  0x00005564cde55125 in qemu_clock_run_timers (type=QEMU_CLOCK_HOST) 
at /srv/QEMU/Source/util/qemu-timer.c:602
#10 0x00005564cde55125 in qemu_clock_run_all_timers () at 
/srv/QEMU/Source/util/qemu-timer.c:688
#11 0x00005564cde557c0 in main_loop_wait (nonblocking=<optimized out>) 
at /srv/QEMU/Source/util/main-loop.c:525
#12 0x00005564cdacf3ae in main_loop () at /srv/QEMU/Source/vl.c:1686
#13 0x00005564cd902edc in main (argc=<optimized out>, argv=<optimized 
out>, envp=<optimized out>) at /srv/QEMU/Source/vl.c:4312

