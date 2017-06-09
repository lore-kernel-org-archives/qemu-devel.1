Received: from eggs.gnu.org ([2001:4830:134:3::10]:42733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1dJM46-0007Uo-4n
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1dJM41-0000DL-8u
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:43:10 -0400
Received: from mail1.windriver.com ([147.11.146.13]:39203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1dJM40-0000C2-Vx
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:43:05 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v59Fh1Ao015613
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <qemu-devel@nongnu.org>; Fri, 9 Jun 2017 08:43:01 -0700 (PDT)
Message-ID: <593AC202.5000404@windriver.com>
Date: Fri, 9 Jun 2017 09:42:58 -0600
From: Chris Friesen <chris.friesen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] call flow to hit get_pci_config_device() during live
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I'm investigating an issue seen over a live migration from a modified 
qemu-kvm-ev-2.3.0-31.el7_2.7.1 to a modified qemu-kvm-ev-2.6.0-28.el7_3.9.1.  We 
hit an issue down in get_pci_config_device() that caused the migration to fail.

The qemu logs on the destination are included below.

I'm looking for some guidance on the call flow that leads to this function, and 
the likely causes of the bad config data.  And if anyone can help me decode the 
config data information in the log (cmask/wmask/wlcmask) and the logic of the 
"bad config data" check I'd appreciate it.

Thanks,
Chris


2017-06-06 16:29:44.940+0000: starting up libvirt version: 2.0.0, package: 
10.el7_3.5.tis.15 (Unknown, 2017-06-05-23:48:01, yow-cgts4-lx.wrs.com), qemu 
version: 2.6.0 (qemu-kvm-ev-2.6.0-28.el7_3.9.1.tis.39), hostname: compute-0
LC_ALL=C PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin 
QEMU_AUDIO_DRV=none /usr/bin/kvm '-c 0x00000000000000000000000000000001' '-n 4' 
--proc-type=secondary --file-prefix=vs -- -enable-dpdk -name 
guest=instance-00000001,debug-threads=on -S -object 
secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu
/domain-1-instance-00000001/master-key.aes -machine 
pc-i440fx-2.2,accel=kvm,usb=off -m 512 -realtime mlock=off -smp 
1,sockets=1,cores=1,threads=1 -object 
memory-backend-file,id=ram-node0,prealloc=yes,mem-path=/mnt/huge-2048kB/libvirt/qemu,share=yes,size=536870912,host-nodes=0,policy=bind 
-numa node,nodeid=0,cpus=0
,memdev=ram-node0 -uuid b2bef0a9-22d3-4abc-9d61-cf3a79bdba53 -smbios 
'type=1,manufacturer=OpenStack Foundation,product=OpenStack 
Nova,version=2015.1.0,serial=713315ee-a857-11e1-baef-001e674e0243,uuid=b2bef0a9-22d3-4abc-9d61-cf3a79bdba53' 
-no-user-config -nodefaults -chardev socket,id=charmonitor,path=/var/lib/libv
irt/qemu/domain-1-instance-00000001/monitor.sock,server,nowait -mon 
chardev=charmonitor,id=monitor,mode=control -rtc base=utc,driftfix=slew -global 
kvm-pit.lost_tick_policy=discard -no-hpet -no-shutdown -boot 
reboot-timeout=5000,strict=on -device 
piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 -drive file=/dev/disk/b
y-path/ip-192.168.205.6:3260-iscsi-iqn.2010-10.org.openstack:volume-d0446a88-a7f8-487d-9c9c-f15beb009f80-lun-0,format=raw,if=none,id=drive-virtio-disk0,serial=d0446a88-a7f8-487d-9c9c-f15beb009f80,cache=none,aio=native 
-device 
virtio-blk-pci,scsi=off,bus=pci.0,addr=0x6,drive=drive-virtio-disk0,id=virtio-disk0,booti
ndex=1 -netdev avp,port=0f5a61cd-1b3f-45a4-966b-acf239b50423,id=hostnet0 -device 
virtio-net-pci,netdev=hostnet0,id=net0,mac=fa:16:3e:10:3b:59,bus=pci.0,addr=0x3 
-device 
avp,port=a074662d-105c-4ba8-b002-07b4021d1964,id=avpa074662d-10,bus=pci.0,addr=0x4 
-device avp,port=e5891f84-f258-4056-8119-f9bb15c55626,id=avpe58
91f84-f2,bus=pci.0,addr=0x5 -add-fd set=0,fd=31 -chardev 
file,id=charserial0,path=/dev/fdset/0,append=on -device 
isa-serial,chardev=charserial0,id=serial0 -chardev pty,id=charserial1 -device 
isa-serial,chardev=charserial1,id=serial1 -device usb-tablet,id=input0 -vnc 
0.0.0.0:0 -k en-us -device cirrus-vga,id=video0,
bus=pci.0,addr=0x2 -incoming defer -device 
virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x7 -msg timestamp=on
char device redirected to /dev/pts/0 (label charserial1)
2017-06-06T16:29:46.291951Z kvm: get_pci_config_device: Bad config data: i=0x20 
read: 0 device: c cmask: ff wmask: 0 w1cmask:0
2017-06-06T16:29:46.291983Z kvm: error while loading state for instance 0x0 of 
device '0000:00:06.0/virtio-blk'
2017-06-06T16:29:46.292075Z kvm: load of migration failed: Invalid argument
