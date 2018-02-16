Received: from eggs.gnu.org ([2001:4830:134:3::10]:46725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1emfUX-0006Yj-3V
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1emfUS-0001OP-6b
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:51:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47188
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1emfUR-0001Nj-ON
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:51:48 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GCnq53023281
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 07:51:45 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g5y6kh42g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 07:51:45 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Fri, 16 Feb 2018 05:51:44 -0700
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 07:51:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d8d33338-c04b-899d-602b-19b6c059dee6@linux.vnet.ibm.com>
Subject: [Qemu-devel] QEMU on s390 segfaults with co-routine error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Jeff Cody <jcody@redhat.com>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>

Hi,

I have noticed a QEMU crash with one of my tests. And the qemu log file 
states the guest crashed with the following error message:

aio_co_schedule: Co-routine was already scheduled in 'aio_co_schedule'


Investigating a little more, it looks like the error message was 
introduced by the following commit:

commit 6133b39f3c36623425a6ede9e89d93175fde15cd
Author: Jeff Cody <jcody@redhat.com>
Date:   Fri Nov 17 22:27:09 2017 -0500

     coroutine: abort if we try to schedule or enter a pending coroutine

     The previous patch fixed a race condition, in which there were
     coroutines being executing doubly, or after coroutine deletion.

     We can detect common scenarios when this happens, and print an error
     message and abort before we corrupt memory / data, or segfault.

     This patch will abort if an attempt to enter a coroutine is made while
     it is currently pending execution, either in a specific AioContext bh,
     or pending execution via a timer.  It will also abort if a coroutine
     is scheduled, before a prior scheduled run has occurred.

     We cannot rely on the existing co->caller check for recursive re-entry
     to catch this, as the coroutine may run and exit with
     COROUTINE_TERMINATE before the scheduled coroutine executes.

     (This is the scenario that was occurring and fixed in the previous
     patch).

     This patch also re-orders the Coroutine struct elements in an 
attempt to
     optimize caching.

     Signed-off-by: Jeff Cody <jcody@redhat.com>
     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>



Here is the qemu command line:

LC_ALL=C PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin 
QEMU_AUDIO_DRV=none /usr/bin/qemu-kvm -name guest=vm_2,debug-threads=on 
-S -object 
secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-4-vm_2/master-key.aes 
-machine s390-ccw-virtio-2.12,accel=kvm,usb=off,dump-guest-core=off -m 
1024 -realtime mlock=off -smp 2,sockets=2,cores=1,threads=1 -object 
iothread,id=iothread1 -uuid f1359d37-bcfb-439f-a6c2-79bf9859e701 
-display none -no-user-config -nodefaults -chardev 
socket,id=charmonitor,path=/var/lib/libvirt/qemu/domain-4-vm_2/monitor.sock,server,nowait 
-mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc 
-no-shutdown -boot strict=on -drive 
file=/dev/mapper/360050763998b0883980000001500001c,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native 
-device 
virtio-blk-ccw,iothread=iothread1,scsi=off,devno=fe.0.0001,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 
-drive 
file=/dev/mapper/360050763998b0883980000001b000022,format=raw,if=none,id=drive-virtio-disk1,cache=none,aio=native 
-device 
virtio-blk-ccw,iothread=iothread1,scsi=off,devno=fe.0.0002,drive=drive-virtio-disk1,id=virtio-disk1 
-netdev tap,fd=27,id=hostnet0,vhost=on,vhostfd=29 -device 
virtio-net-ccw,netdev=hostnet0,id=net0,mac=02:75:b0:55:2a:b1,devno=fe.0.0000 
-chardev pty,id=charconsole0 -device 
sclpconsole,chardev=charconsole0,id=console0 -device 
virtio-balloon-ccw,id=balloon0,devno=fe.3.ffba -msg timestamp=on


I remember some time ago we had similar segfaults with coroutines and 
iothreads. I have only hit this error once, and I have not been able to 
reproduce it consistently.


Thank you
Farhan
