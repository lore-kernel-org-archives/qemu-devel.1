Received: from eggs.gnu.org ([2001:4830:134:3::10]:38135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fj495-0005cP-F9
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fj491-0001UL-9J
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:55:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fj490-0001T1-Tu
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:55:03 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6REs84A049251
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 10:55:00 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kg3qud69k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 10:54:59 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Fri, 27 Jul 2018 08:54:59 -0600
References: <20180718211256.29774-1-naravamudan@digitalocean.com>
	<a1269390-a798-9165-aaf5-a2aa6270bd54@linux.ibm.com>
	<20180723163011.GH20596@stefanha-x1.localdomain>
	<81e4d6fe-1736-b3cc-45ec-ecaa07098906@linux.ibm.com>
	<20180727132654.GH28555@stefanha-x1.localdomain>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Fri, 27 Jul 2018 10:54:52 -0400
MIME-Version: 1.0
In-Reply-To: <20180727132654.GH28555@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <cba3cc0e-7246-fc96-0186-349dbc0fa56a@linux.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/file-posix: add
 bdrv_attach_aio_context callback for host dev and cdrom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Nishanth Aravamudan <naravamudan@digitalocean.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 07/27/2018 09:26 AM, Stefan Hajnoczi wrote:
> On Mon, Jul 23, 2018 at 12:42:02PM -0400, Farhan Ali wrote:
>>
>>
>> On 07/23/2018 12:30 PM, Stefan Hajnoczi wrote:
>>> On Fri, Jul 20, 2018 at 03:11:14PM -0400, Farhan Ali wrote:
>>>> I am seeing another issue pop up, in a different test. Even though it's a
>>>> different assertion, it might be related based on the call trace.
>>>
>>> Which test case?
>>
>> This test case involved one guest with 2 disks, with an iothread for each
>> disk. The guest was running a memory workload.
> 
> Please post a link to the test case.
> 
> Stefan
> 
Hi Stefan,

Thanks for your response. The test case was run in our internal 
infrastructure, so unfortunately I cannot post any link to the test case.

I have been unable to reproduce this exact issue. On the other hand the 
same test case is throwing another assertion error:

qemu-kvm: /builddir/build/BUILD/qemu-2.12.91/exec.c:3695: 
address_space_unmap: Assertion `mr != NULL' failed.

Again this to me is very strange error. I have been able to reproduce 
this assertion couple of times, though I don't hit it on every run of 
the test case.


The qemu command line for the test case:

/usr/bin/qemu-kvm -name guest=sles,debug-threads=on -S -object 
secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-6-sles/master-key.aes 
-machine s390-ccw-virtio-3.0,accel=kvm,usb=off,dump-guest-core=off -m 
4096 -realtime mlock=off -smp 8,sockets=8,cores=1,threads=1 -object 
iothread,id=iothread1 -object iothread,id=iothread2 -uuid 
094a20ff-e881-44db-a772-fb4029cf8f09 -display none -no-user-config 
-nodefaults -chardev socket,id=charmonitor,fd=28,server,nowait -mon 
chardev=charmonitor,id=monitor,mode=control -rtc base=utc -no-shutdown 
-boot strict=on -drive 
file=/dev/mapper/360050763998b0883980000003300003a,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native 
-device 
virtio-blk-ccw,iothread=iothread1,scsi=off,devno=fe.0.0001,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on 
-drive 
file=/dev/mapper/360050763998b0883980000001e000025,format=raw,if=none,id=drive-virtio-disk1,cache=none,aio=native 
-device 
virtio-blk-ccw,iothread=iothread2,scsi=off,devno=fe.0.0002,drive=drive-virtio-disk1,id=virtio-disk1,write-cache=on 
-netdev tap,fd=30,id=hostnet0,vhost=on,vhostfd=31 -device 
virtio-net-ccw,netdev=hostnet0,id=net0,mac=02:f5:5d:7d:7d:ef,devno=fe.0.0000 
-chardev pty,id=charconsole0 -device 
sclpconsole,chardev=charconsole0,id=console0 -device 
virtio-balloon-ccw,id=balloon0,devno=fe.3.ffba -sandbox 
on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny 
-msg timestamp=on


The backtrace of the thread which trips the assertion:

#0  0x000003ffb553e274 in raise () from /lib64/libc.so.6
#1  0x000003ffb55239a8 in abort () from /lib64/libc.so.6
#2  0x000003ffb55362ce in __assert_fail_base () from /lib64/libc.so.6
#3  0x000003ffb553634c in __assert_fail () from /lib64/libc.so.6
#4  0x000002aa39b487e6 in address_space_unmap (as=<optimized out>, 
buffer=<optimized out>, len=<optimized out>, is_write=<optimized out>, 
access_len=<optimized out>)
     at 
/usr/src/debug/qemu-2.12.91-20180726.0.c6cf862329.fc28.s390x/exec.c:3695
#5  0x000002aa39bfb550 in dma_memory_unmap (access_len=0, 
dir=DMA_DIRECTION_FROM_DEVICE, len=<optimized out>, buffer=<optimized 
out>, as=0x2aa3a085b80 <address_space_memory>)
     at 
/usr/src/debug/qemu-2.12.91-20180726.0.c6cf862329.fc28.s390x/include/sysemu/dma.h:146
#6  virtqueue_unmap_sg (elem=elem@entry=0x3ff9c01c9d0, len=len@entry=1, 
vq=<optimized out>) at 
/usr/src/debug/qemu-2.12.91-20180726.0.c6cf862329.fc28.s390x/hw/virtio/virtio.c:401
#7  0x000002aa39bfc840 in virtqueue_fill (vq=vq@entry=0x3ffb6c9e010, 
elem=0x3ff9c01c9d0, len=<optimized out>, idx=idx@entry=0) at 
/usr/src/debug/qemu-2.12.91-20180726.0.c6cf862329.fc28.s390x/hw/virtio/virtio.c:476
#8  0x000002aa39bfcb80 in virtqueue_push (vq=0x3ffb6c9e010, 
elem=elem@entry=0x3ff9c01c9d0, len=<optimized out>) at 
/usr/src/debug/qemu-2.12.91-20180726.0.c6cf862329.fc28.s390x/hw/virtio/virtio.c:522
#9  0x000002aa39bd78c2 in virtio_blk_req_complete (req=0x3ff9c01c9d0, 
status=<optimized out>) at 
/usr/src/debug/qemu-2.12.91-20180726.0.c6cf862329.fc28.s390x/hw/block/virtio-blk.c:55
#10 0x000002aa39bd8540 in virtio_blk_rw_complete (opaque=<optimized 
out>, ret=<optimized out>) at 
/usr/src/debug/qemu-2.12.91-20180726.0.c6cf862329.fc28.s390x/hw/block/virtio-blk.c:121
#11 0x000002aa39d9a15e in blk_aio_complete (acb=0x3ff9c04f670) at 
/usr/src/debug/qemu-2.12.91-20180726.0.c6cf862329.fc28.s390x/block/block-backend.c:1336
#12 0x000002aa39e48e98 in coroutine_trampoline (i0=<optimized out>, 
i1=<optimized out>) at 
/usr/src/debug/qemu-2.12.91-20180726.0.c6cf862329.fc28.s390x/util/coroutine-ucontext.c:116
#13 0x000003ffb5553b7a in __makecontext_ret () from /lib64/libc.so.6


I don't know if these issues are related to the same underlying problem.
Any help is really appreciated.

Thanks
Farhan
