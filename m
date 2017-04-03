Received: from eggs.gnu.org ([2001:4830:134:3::10]:35011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cuyJz-0000WJ-Bi
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cuyJu-0002TY-9X
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:30:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cuyJt-0002TC-WE
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:30:42 -0400
Date: Mon, 3 Apr 2017 10:30:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170403093034.GB2112@work-vm>
References: <58DEB834.6060405@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58DEB834.6060405@windriver.com>
Subject: Re: [Qemu-devel] hitting intermittent issue with live migration
 from qemu-kvm-ev 2.3.0 to qemu-kvm-ev 2.6.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chris Friesen <chris.friesen@windriver.com>
Cc: qemu-devel@nongnu.org, lprosek@redhat.com

* Chris Friesen (chris.friesen@windriver.com) wrote:
> Hi,
> 
> I'm running into an issue with live-migrating a guest from a host running
> qemu-kvm-ev 2.3.0-31 to a host running qemu-kvm-ev 2.6.0-27.1.  This is a
> libvirt-tunnelled migration, in the context of upgrading an OpenStack
> install to newer software.  The source host is running CentOS 7.2.1511,
> while the dest host is running CentOS 7.3.1611.
> 
> I'll include the qemu commandlines for the source/dest at the bottom.
> 
> Initially we have a bunch of guests running on compute-2 (which is running
> qemu-kvm-ev 2.3.0).  We then started live-migrating them one at a time to
> compute-0 (which is running qemu-kvm-ev 2.6.0).  Three of them migrated
> successfully.  The fourth (which was essentially identical in configuration
> to the first three) failed, as per the following logs in
> /var/log/libvirt/qemu/instance-0000000e.log:
> 
> 
> 2017-03-29T06:38:37.886940Z qemu-kvm: VQ 2 size 0x80 < last_avail_idx 0x47b
> - used_idx 0x47c
> 2017-03-29T06:38:37.886974Z qemu-kvm: error while loading state for instance
> 0x0 of device '0000:00:07.0/virtio-balloon'
> 2017-03-29T06:38:37.888684Z qemu-kvm: load of migration failed: Operation
> not permitted
> 2017-03-29 06:38:37.896+0000: shutting down
> 
> 
> Does anyone know of an existing bug report covering this issue?  (I took a
> look and didn't see anything obviously related.)

There were a bunch of virtio bugs with similar errors; I think they were fixed in
the early 2.6.0-28 packages; I see the latest one on centos seems to be
2.6.0-28 3.6.1 - so it's worth a try.

I think the upstream fixes are 4a1e48, 297a75

Dave


> 
> The qemu commandline on the source compute node is:
> 
> 
> /usr/libexec/qemu-kvm -c 0x00000000000000000000000000000001 -n 4
> --proc-type=secondary --file-prefix=vs -- -enable-dpdk -name
> instance-0000000e -S -machine pc-i440fx-rhel7.2.0,accel=kvm,usb=off -m 512
> -realtime mlock=off -smp 1,sockets=1,cores=1,threads=1 -object memory-backend-file,id=ram-node0,prealloc=yes,mem-path=/mnt/huge-2048kB/libvirt/qemu,share=yes,size=536870912,host-nodes=1,policy=bind
> -numa node,nodeid=0,cpus=0,memdev=ram-node0 -uuid
> 57ae849f-aa66-422a-90a2-62db6c59db29 -smbios type=1,manufacturer=Fedora
> Project,product=OpenStack Nova,version=13.0.0-0.tis.4,serial=4c8121f1-d927-424e-8712-88b1de45be37,uuid=57ae849f-aa66-422a-90a2-62db6c59db29,family=Virtual
> Machine -no-user-config -nodefaults -chardev socket,id=charmonitor,path=/var/lib/libvirt/qemu/domain-instance-0000000e/monitor.sock,server,nowait
> -mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc,driftfix=slew
> -global kvm-pit.lost_tick_policy=discard -no-hpet -no-shutdown -boot
> reboot-timeout=5000,strict=on -device
> piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 -drive file=/dev/disk/by-path/ip-192.168.205.6:3260-iscsi-iqn.2010-10.org.openstack:volume-ac57fcaa-7ecd-4d3b-8671-3bc740337a42-lun-0,if=none,id=drive-virtio-disk0,format=raw,serial=ac57fcaa-7ecd-4d3b-8671-3bc740337a42,cache=none,aio=native
> -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x6,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1
> -chardev socket,id=charnet0,path=/var/run/vswitch/usvhost-9e574d3c-32dd-4d39-97e6-447b15fb00b4
> -netdev type=vhost-user,id=hostnet0,chardev=charnet0 -device virtio-net-pci,netdev=hostnet0,id=net0,mac=fa:16:3e:b0:59:a9,bus=pci.0,addr=0x3
> -chardev socket,id=charnet1,path=/var/run/vswitch/usvhost-7bc48d91-f215-4394-99ff-eb7f20d9ff1e
> -netdev type=vhost-user,id=hostnet1,chardev=charnet1 -device virtio-net-pci,netdev=hostnet1,id=net1,mac=fa:16:3e:8b:6f:09,bus=pci.0,addr=0x4
> -chardev socket,id=charnet2,path=/var/run/vswitch/usvhost-c32e2d0d-9ed4-4f4b-abc9-539a12a86008
> -netdev type=vhost-user,id=hostnet2,chardev=charnet2 -device virtio-net-pci,netdev=hostnet2,id=net2,mac=fa:16:3e:07:ca:a0,bus=pci.0,addr=0x5
> -chardev file,id=charserial0,path=/etc/nova/instances/57ae849f-aa66-422a-90a2-62db6c59db29/console.log
> -device isa-serial,chardev=charserial0,id=serial0 -chardev
> pty,id=charserial1 -device isa-serial,chardev=charserial1,id=serial1 -device
> usb-tablet,id=input0 -vnc 0.0.0.0:11 -k en-us -device
> cirrus-vga,id=video0,bus=pci.0,addr=0x2 -incoming fd:25 -device
> virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x7 -msg timestamp=on
> 
> 
> 
> The complete instance-0000000e.log file on the destination is:
> 
> 2017-03-29 06:38:35.962+0000: starting up libvirt version: 2.0.0, package:
> 10.el7_3.2.tis.24 (Unknown, 2017-03-15-14:59:22,
> yow-dsulliva-lx-vm1.wrs.com), qemu version: 2.6.0
> (qemu-kvm-ev-2.6.0-27.1.el7.tis.31), hostname: compute-0
> LC_ALL=C PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
> QEMU_AUDIO_DRV=none /usr/libexec/qemu-kvm '-c
> 0x00000000000000000000000000000001' '-n 4' --proc-type=secondary
> --file-prefix=vs -- -enable-dpdk -name
> guest=instance-0000000e,debug-threads=on -S -object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-10-instance-0000000e/master-key.aes
> -machine pc-i440fx-rhel7.2.0,accel=kvm,usb=off -m 512 -realtime mlock=off
> -smp 1,sockets=1,cores=1,threads=1 -object memory-backend-file,id=ram-node0,prealloc=yes,mem-path=/mnt/huge-2048kB/libvirt/qemu,share=yes,size=536870912,host-nodes=0,policy=bind
> -numa node,nodeid=0,cpus=0,memdev=ram-node0 -uuid
> 57ae849f-aa66-422a-90a2-62db6c59db29 -smbios 'type=1,manufacturer=Fedora
> Project,product=OpenStack Nova,version=13.0.0-0.tis.4,serial=4c8121f1-d927-424e-8712-88b1de45be37,uuid=57ae849f-aa66-422a-90a2-62db6c59db29,family=Virtual
> Machine' -no-user-config -nodefaults -chardev socket,id=charmonitor,path=/var/lib/libvirt/qemu/domain-10-instance-0000000e/monitor.sock,server,nowait
> -mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc,driftfix=slew
> -global kvm-pit.lost_tick_policy=discard -no-hpet -no-shutdown -boot
> reboot-timeout=5000,strict=on -device
> piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 -drive file=/dev/disk/by-path/ip-192.168.205.6:3260-iscsi-iqn.2010-10.org.openstack:volume-ac57fcaa-7ecd-4d3b-8671-3bc740337a42-lun-0,format=raw,if=none,id=drive-virtio-disk0,serial=ac57fcaa-7ecd-4d3b-8671-3bc740337a42,cache=none,aio=native
> -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x6,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1
> -chardev socket,id=charnet0,path=/var/run/vswitch/usvhost-9e574d3c-32dd-4d39-97e6-447b15fb00b4
> -netdev type=vhost-user,id=hostnet0,chardev=charnet0 -device virtio-net-pci,netdev=hostnet0,id=net0,mac=fa:16:3e:b0:59:a9,bus=pci.0,addr=0x3
> -chardev socket,id=charnet1,path=/var/run/vswitch/usvhost-7bc48d91-f215-4394-99ff-eb7f20d9ff1e
> -netdev type=vhost-user,id=hostnet1,chardev=charnet1 -device virtio-net-pci,netdev=hostnet1,id=net1,mac=fa:16:3e:8b:6f:09,bus=pci.0,addr=0x4
> -chardev socket,id=charnet2,path=/var/run/vswitch/usvhost-c32e2d0d-9ed4-4f4b-abc9-539a12a86008
> -netdev type=vhost-user,id=hostnet2,chardev=charnet2 -device virtio-net-pci,netdev=hostnet2,id=net2,mac=fa:16:3e:07:ca:a0,bus=pci.0,addr=0x5
> -add-fd set=0,fd=51 -chardev file,id=charserial0,path=/dev/fdset/0,append=on
> -device isa-serial,chardev=charserial0,id=serial0 -chardev
> pty,id=charserial1 -device isa-serial,chardev=charserial1,id=serial1 -device
> usb-tablet,id=input0 -vnc 0.0.0.0:9 -k en-us -device
> cirrus-vga,id=video0,bus=pci.0,addr=0x2 -incoming defer -device
> virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x7 -msg timestamp=on
> Domain id=10 is tainted: high-privileges
> EAL:eal_memory.c:1591: WARNING: Address Space Layout Randomization (ASLR) is
> enabled in the kernel.
> EAL:eal_memory.c:1593:    This may cause issues with mapping memory into
> secondary processes
> char device redirected to /dev/pts/9 (label charserial1)
> 2017-03-29T06:38:37.886940Z qemu-kvm: VQ 2 size 0x80 < last_avail_idx 0x47b
> - used_idx 0x47c
> 2017-03-29T06:38:37.886974Z qemu-kvm: error while loading state for instance
> 0x0 of device '0000:00:07.0/virtio-balloon'
> 2017-03-29T06:38:37.888684Z qemu-kvm: load of migration failed: Operation
> not permitted
> 2017-03-29 06:38:37.896+0000: shutting down
> 
> 
> For what it's worth, the differences between the two qemu command lines are
> as follows:
> 
> source:
> -name instance-0000000e -chardev file,id=charserial0,path=/etc/nova/instances/57ae849f-aa66-422a-90a2-62db6c59db29/console.log
> -vnc 0.0.0.0:9 -incoming fd:25
> 
> destination:
> -name guest=instance-0000000e,debug-threads=on -object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-10-instance-0000000e/master-key.aes
> -add-fd set=0,fd=51 -chardev file,id=charserial0,path=/dev/fdset/0,append=on
> -vnc 0.0.0.0:11 -incoming defer
> 
> Thanks,
> Chris
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
