Received: from eggs.gnu.org ([2001:4830:134:3::10]:45686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dzagorui@cisco.com>) id 1dvO10-0003lT-F1
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dzagorui@cisco.com>) id 1dvO0x-0008M4-RG
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:29:10 -0400
Received: from aer-iport-4.cisco.com ([173.38.203.54]:33077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <dzagorui@cisco.com>) id 1dvO0x-0008Io-GL
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:29:07 -0400
From: Denys Zagorui <dzagorui@cisco.com>
Message-ID: <8e67afb3-46b4-9d04-552f-740331165f8f@cisco.com>
Date: Fri, 22 Sep 2017 16:28:40 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Qemu-devel] KVM serial8250: too much work for irq3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hpa@zytor.com
Cc: qemu-devel@nongnu.org

Hello

This is known issue, it was mentioned at first time about 9 years ago.

https://lkml.org/lkml/2008/2/5/401

https://bugzilla.redhat.com/show_bug.cgi?id=986761


But it seems not fixed. I tested on my setup.

My Host machine Debian Stretch (kernel 4.9-30), Guest vanilla kernel 
4.4-76. Tried on Qemu  2.8 and 2.10

qemu-system-x86_64 -name guest=guest,debug-threads=on -S -object 
secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-7-guest/master-key.aes 
-machine pc-i440fx-2.8,accel=kvm,usb=off,dump-guest-core=off -cpu 
SkylakeClient,ds=on,acpi=on,ss=on,ht=on,tm=on,pbe=on,dtes64=on,monitor=on,ds_cpl=on,vmx=on,smx=on,est=on,tm2=on,xtpr=on,pdcm=on,osxsave=on,tsc_adjust=on,clflushopt=on,pdpe1gb=on 
-m 4096 -realtime mlock=off -smp 4,sockets=1,cores=4,threads=1 -uuid 
4537ca29-73b2-40c3-9b43-666de182ba5f -display none -no-user-config 
-nodefaults -chardev 
socket,id=charmonitor,path=/var/lib/libvirt/qemu/domain-7-guest/monitor.sock,server,nowait 
-mon chardev=charmonitor,id=monitor,mode=control -rtc 
base=utc,driftfix=slew -global kvm-pit.lost_tick_policy=delay -no-hpet 
-no-shutdown -global PIIX4_PM.disable_s3=1 -global PIIX4_PM.disable_s4=1 
-boot strict=on -device ich9-usb-ehci1,id=usb,bus=pci.0,addr=0x8.0x7 
-device 
ich9-usb-uhci1,masterbus=usb.0,firstport=0,bus=pci.0,multifunction=on,addr=0x8 
-device 
ich9-usb-uhci2,masterbus=usb.0,firstport=2,bus=pci.0,addr=0x8.0x1 
-device 
ich9-usb-uhci3,masterbus=usb.0,firstport=4,bus=pci.0,addr=0x8.0x2 -drive 
file=/home/dzagorui/csr/csr_disk.qcow2,format=qcow2,if=none,id=drive-ide0-0-0 
-device 
ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1 
-netdev tap,fd=25,id=hostnet0 -device 
e1000,netdev=hostnet0,id=net0,mac=52:54:00:a9:4c:86,bus=pci.0,addr=0x3 
-netdev tap,fd=27,id=hostnet1 -device 
e1000,netdev=hostnet1,id=net1,mac=52:54:00:d4:7f:fa,bus=pci.0,addr=0x4 
-netdev tap,fd=28,id=hostnet2 -device 
e1000,netdev=hostnet2,id=net2,mac=52:54:00:d6:ec:f6,bus=pci.0,addr=0x5 
-netdev tap,fd=29,id=hostnet3 -device 
e1000,netdev=hostnet3,id=net3,mac=52:54:00:99:2b:46,bus=pci.0,addr=0xa 
-chardev 
socket,id=charserial0,host=127.0.0.1,port=4000,telnet,server,nowait 
-device isa-serial,chardev=charserial0,id=serial0 -chardev 
socket,id=charserial1,host=127.0.0.1,port=4001,telnet,server,nowait 
-device isa-serial,chardev=charserial1,id=serial1 -device 
virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x9 -msg timestamp=on


With this 100% reproduce:

dd if=/dev/zero of=/dev/ttyS1


And there is fix proposed by H. Peter Anvin in 2008

https://lkml.org/lkml/2008/2/7/485


So maybe it needs to be reworked?


Regards,

Denys
