Received: from eggs.gnu.org ([2001:4830:134:3::10]:36720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1ffTjg-0003Zb-4K
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1ffTjc-0007gO-4e
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:26:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1ffTjb-0007fD-Ro
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:26:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6HHOihf126810
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 13:25:58 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k9m16j0sb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 13:25:58 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Tue, 17 Jul 2018 13:25:57 -0400
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 17 Jul 2018 13:25:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e16f10f5-b113-5ebe-51e9-c379ca34193d@linux.ibm.com>
Subject: [Qemu-devel] [BUG?] aio_get_linux_aio: Assertion `ctx->linux_aio'
 failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, naravamudan@digitalocean.com, Christian Borntraeger <borntraeger@de.ibm.com>

Hi,

I am seeing some strange QEMU assertion failures for qemu on s390x,
which prevents a guest from starting.

Git bisecting points to the following commit as the source of the error.

commit ed6e2161715c527330f936d44af4c547f25f687e
Author: Nishanth Aravamudan <naravamudan@digitalocean.com>
Date:   Fri Jun 22 12:37:00 2018 -0700

     linux-aio: properly bubble up errors from initialization

     laio_init() can fail for a couple of reasons, which will lead to a NULL
     pointer dereference in laio_attach_aio_context().

     To solve this, add a aio_setup_linux_aio() function which is called
     early in raw_open_common. If this fails, propagate the error up. The
     signature of aio_get_linux_aio() was not modified, because it seems
     preferable to return the actual errno from the possible failing
     initialization calls.

     Additionally, when the AioContext changes, we need to associate a
     LinuxAioState with the new AioContext. Use the bdrv_attach_aio_context
     callback and call the new aio_setup_linux_aio(), which will allocate a
     new AioContext if needed, and return errors on failures. If it 
fails for
     any reason, fallback to threaded AIO with an error message, as the
     device is already in-use by the guest.

     Add an assert that aio_get_linux_aio() cannot return NULL.

     Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
     Message-id: 20180622193700.6523-1-naravamudan@digitalocean.com
     Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>


Not sure what is causing this assertion to fail. Here is the qemu 
command line of the guest, from qemu log, which throws this error:


LC_ALL=C PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin 
QEMU_AUDIO_DRV=none /usr/local/bin/qemu-system-s390x -name 
guest=rt_vm1,debug-threads=on -S -object 
secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-21-rt_vm1/master-key.aes 
-machine s390-ccw-virtio-2.12,accel=kvm,usb=off,dump-guest-core=off -m 
1024 -realtime mlock=off -smp 4,sockets=4,cores=1,threads=1 -object 
iothread,id=iothread1 -uuid 0cde16cd-091d-41bd-9ac2-5243df5c9a0d 
-display none -no-user-config -nodefaults -chardev 
socket,id=charmonitor,fd=28,server,nowait -mon 
chardev=charmonitor,id=monitor,mode=control -rtc base=utc -no-shutdown 
-boot strict=on -drive 
file=/dev/mapper/360050763998b0883980000002a000031,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native 
-device 
virtio-blk-ccw,iothread=iothread1,scsi=off,devno=fe.0.0001,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on 
-netdev tap,fd=30,id=hostnet0,vhost=on,vhostfd=31 -device 
virtio-net-ccw,netdev=hostnet0,id=net0,mac=02:3a:c8:67:95:84,devno=fe.0.0000 
-netdev tap,fd=32,id=hostnet1,vhost=on,vhostfd=33 -device 
virtio-net-ccw,netdev=hostnet1,id=net1,mac=52:54:00:2a:e5:08,devno=fe.0.0002 
-chardev pty,id=charconsole0 -device 
sclpconsole,chardev=charconsole0,id=console0 -device 
virtio-balloon-ccw,id=balloon0,devno=fe.3.ffba -sandbox 
on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny 
-msg timestamp=on



2018-07-17 15:48:42.252+0000: Domain id=21 is tainted: high-privileges
2018-07-17T15:48:42.279380Z qemu-system-s390x: -chardev 
pty,id=charconsole0: char device redirected to /dev/pts/3 (label 
charconsole0)
qemu-system-s390x: util/async.c:339: aio_get_linux_aio: Assertion 
`ctx->linux_aio' failed.
2018-07-17 15:48:43.309+0000: shutting down, reason=failed


Any help debugging this would be greatly appreciated.

Thank you
Farhan
