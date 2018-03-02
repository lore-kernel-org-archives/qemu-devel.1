Received: from eggs.gnu.org ([2001:4830:134:3::10]:58994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1ermeM-0007GS-2Z
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1ermeI-0000bM-Rq
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:31:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41242
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1ermeI-0000ag-L3
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:31:06 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w22FTH33127500
	for <qemu-devel@nongnu.org>; Fri, 2 Mar 2018 10:31:02 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gf8ww12st-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 10:31:02 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Fri, 2 Mar 2018 10:31:01 -0500
References: <079a5da7-6586-b974-6b99-e5de055b1bd1@linux.vnet.ibm.com>
	<20180302092318.GA6026@stefanha-x1.localdomain>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Fri, 2 Mar 2018 10:30:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180302092318.GA6026@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6a3461c2-368d-1aa1-5b86-a6a602251829@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [BUG] I/O thread segfault for QEMU on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mreitz@redhat.com, famz@redhat.com, QEMU Developers <qemu-devel@nongnu.org>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>



On 03/02/2018 04:23 AM, Stefan Hajnoczi wrote:
> On Thu, Mar 01, 2018 at 09:33:35AM -0500, Farhan Ali wrote:
>> Hi,
>>
>> I have been noticing some segfaults for QEMU on s390x, and I have been
>> hitting this issue quite reliably (at least once in 10 runs of a test case).
>> The qemu version is 2.11.50, and I have systemd created coredumps
>> when this happens.
>>
>> Here is a back trace of the segfaulting thread:
> The backtrace looks normal.
> 
> Please post the QEMU command-line and the details of the segfault (which
> memory access faulted?).
> 


I was able to create another crash today and here is the qemu comand line

/usr/bin/qemu-kvm -name guest=sles,debug-threads=on \
-S -object 
secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-2-sles/master-key.aes 
\
-machine s390-ccw-virtio-2.12,accel=kvm,usb=off,dump-guest-core=off \
-m 4096 -realtime mlock=off -smp 8,sockets=8,cores=1,threads=1 \
-object iothread,id=iothread1 -object iothread,id=iothread2 -uuid 
b83a596b-3a1a-4ac9-9f3e-d9a4032ee52c \
-display none -no-user-config -nodefaults -chardev 
socket,id=charmonitor,path=/var/lib/libvirt/qemu/domain-2-sles/monitor.sock,server,nowait 

-mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc 
-no-shutdown \
-boot strict=on -drive 
file=/dev/mapper/360050763998b0883980000002400002b,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native 
-device 
virtio-blk-ccw,iothread=iothread1,scsi=off,devno=fe.0.0001,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 
-drive 
file=/dev/mapper/360050763998b0883980000002800002f,format=raw,if=none,id=drive-virtio-disk1,cache=none,aio=native 
-device 
virtio-blk-ccw,iothread=iothread2,scsi=off,devno=fe.0.0002,drive=drive-virtio-disk1,id=virtio-disk1 
-netdev tap,fd=24,id=hostnet0,vhost=on,vhostfd=26 -device 
virtio-net-ccw,netdev=hostnet0,id=net0,mac=02:38:a6:36:e8:1f,devno=fe.0.0000 
-chardev pty,id=charconsole0 -device 
sclpconsole,chardev=charconsole0,id=console0 -device 
virtio-balloon-ccw,id=balloon0,devno=fe.3.ffba -msg timestamp=on


This the latest back trace on the segfaulting thread, and it seems to 
segfault in swapcontext.

Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x000003ff8595202c in swapcontext () from /lib64/libc.so.6


This is the remaining back trace:

#0  0x000003ff8595202c in swapcontext () from /lib64/libc.so.6
#1  0x000002aa33b45566 in qemu_coroutine_new () at 
util/coroutine-ucontext.c:164
#2  0x000002aa33b43eac in qemu_coroutine_create 
(entry=entry@entry=0x2aa33a94c98 <blk_aio_write_entry>, 
opaque=opaque@entry=0x3ff74018be0) at util/qemu-coroutine.c:76
#3  0x000002aa33a954da in blk_aio_prwv (blk=0x2aa4f0efda0, 
offset=<optimized out>, bytes=<optimized out>, qiov=0x3ff74019080, 
co_entry=co_entry@entry=0x2aa33a94c98 <blk_aio_write_entry>, flags=0,
     cb=0x2aa338c62e8 <virtio_blk_rw_complete>, opaque=0x3ff74019020) at 
block/block-backend.c:1299
#4  0x000002aa33a9563e in blk_aio_pwritev (blk=<optimized out>, 
offset=<optimized out>, qiov=<optimized out>, flags=<optimized out>, 
cb=<optimized out>, opaque=0x3ff74019020) at block/block-backend.c:1400
#5  0x000002aa338c6a38 in submit_requests (niov=<optimized out>, 
num_reqs=1, start=<optimized out>, mrb=0x3ff831fe6e0, blk=<optimized 
out>) at /usr/src/debug/qemu-2.11.50/hw/block/virtio-blk.c:369
#6  virtio_blk_submit_multireq (blk=<optimized out>, 
mrb=mrb@entry=0x3ff831fe6e0) at 
/usr/src/debug/qemu-2.11.50/hw/block/virtio-blk.c:426
#7  0x000002aa338c7b78 in virtio_blk_handle_vq (s=0x2aa4f2507c8, 
vq=0x3ff869df010) at /usr/src/debug/qemu-2.11.50/hw/block/virtio-blk.c:620
#8  0x000002aa338ebdf2 in virtio_queue_notify_aio_vq (vq=0x3ff869df010) 
at /usr/src/debug/qemu-2.11.50/hw/virtio/virtio.c:1515
#9  0x000002aa33b2df46 in aio_dispatch_handlers 
(ctx=ctx@entry=0x2aa4f0ca050) at util/aio-posix.c:406
#10 0x000002aa33b2eb50 in aio_poll (ctx=0x2aa4f0ca050, 
blocking=blocking@entry=true) at util/aio-posix.c:692
#11 0x000002aa33957f6a in iothread_run (opaque=0x2aa4f0c9630) at 
iothread.c:60
#12 0x000003ff86987e82 in start_thread () from /lib64/libpthread.so.0
#13 0x000003ff85a11596 in thread_start () from /lib64/libc.so.6
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
