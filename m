Received: from eggs.gnu.org ([2001:4830:134:3::10]:60206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1ermjC-0001Kc-Sy
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:36:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1ermjB-0002Io-S8
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:36:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1ermjB-0002IW-J2
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:36:09 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w22FYCkg015591
	for <qemu-devel@nongnu.org>; Fri, 2 Mar 2018 10:36:06 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gf53wb8rm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 10:36:05 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Fri, 2 Mar 2018 10:36:03 -0500
References: <079a5da7-6586-b974-6b99-e5de055b1bd1@linux.vnet.ibm.com>
	<CAK1Eb9=6ZVorRSRmNwi-xxo+mAHLuhyEZqEtOrY1d=66xPFkLA@mail.gmail.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Fri, 2 Mar 2018 10:35:59 -0500
MIME-Version: 1.0
In-Reply-To: <CAK1Eb9=6ZVorRSRmNwi-xxo+mAHLuhyEZqEtOrY1d=66xPFkLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ebe85c53-7753-b7b1-32e3-3677655e71fc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [BUG] I/O thread segfault for QEMU on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 03/02/2018 01:13 AM, Fam Zheng wrote:
> On Thu, Mar 1, 2018 at 10:33 PM, Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
>> Hi,
>>
>> I have been noticing some segfaults for QEMU on s390x, and I have been
>> hitting this issue quite reliably (at least once in 10 runs of a test case).
>> The qemu version is 2.11.50, and I have systemd created coredumps
>> when this happens.
> 
> Can you describe the test case or suggest how to reproduce it for us?
> 
> Fam
> 

The test case is with a single guest, running a memory intensive 
workload. The guest has 8 vpcus and 4G of memory.

Here is the qemu command line, if that helps:

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


Please let me know if I need to provide any other information.

Thanks
Farhan
