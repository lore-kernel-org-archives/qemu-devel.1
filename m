Received: from eggs.gnu.org ([2001:4830:134:3::10]:42577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVtkq-0007AL-Iz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVtkp-0000N5-DM
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:07:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVtkp-0000Ld-3z
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:07:07 -0400
Date: Fri, 14 Jul 2017 14:07:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170714060702.GD18687@lemon>
References: <AT5PR84MB0164562E6BDB62601F376F87A0AD0@AT5PR84MB0164.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AT5PR84MB0164562E6BDB62601F376F87A0AD0@AT5PR84MB0164.NAMPRD84.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] Poor 8K random IO performance inside the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Nagarajan, Padhu (HPE Storage)" <padhu@hpe.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, 07/14 04:28, Nagarajan, Padhu (HPE Storage) wrote:
> During an 8K random-read fio benchmark, we observed poor performance inside
> the guest in comparison to the performance seen on the host block device. The
> table below shows the IOPS on the host and inside the guest with both
> virtioscsi (scsimq) and virtioblk (blkmq).
> 
> -----------------------------------
> config        | IOPS  | fio gst hst
> -----------------------------------
> host-q32-t1   | 79478 | 401     271
> scsimq-q8-t4  | 45958 | 693 639 351
> blkmq-q8-t4   | 49247 | 647 589 308
> -----------------------------------
> host-q48-t1   | 85599 | 559     291
> scsimq-q12-t4 | 50237 | 952 807 358
> blkmq-q12-t4  | 54016 | 885 786 329
> -----------------------------------
> fio gst hst => latencies in usecs, as
>                seen by fio, guest and
>                host block layers.

Out of curisoty, how are gst and hst collected here? It's interesting why hst
(q32-t1) is better than (q8-t4).

> q8-t4 => qdepth=8, numjobs=4
> host  => fio run directly on the host
> scsimq,blkmq => fio run inside the guest
> 
> Shouldn't we get a much better performance inside the guest ?
> 
> When fio inside the guest was generating 32 outstanding IOs, iostat on the
> host shows avgqu-sz of only 16. For 48 outstanding IOs inside the guest,
> avgqu-sz on the host was only marginally better.
> 
> qemu command line: qemu-system-x86_64 -L /usr/share/seabios/ -name
> node1,debug-threads=on -name node1 -S -machine pc,accel=kvm,usb=off -cpu
> SandyBridge -m 7680 -realtime mlock=off -smp 4,sockets=4,cores=1,threads=1
> -object iothread,id=iothread1 -object iothread,id=iothread2 -object
> iothread,id=iothread3 -object iothread,id=iothread4 -uuid XX -nographic
> -no-user-config -nodefaults -chardev
> socket,id=charmonitor,path=/var/lib/libvirt/qemu/node1.monitor,server,nowait
> -mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc,driftfix=slew
> -global kvm-pit.lost_tick_policy=discard -no-hpet -no-shutdown -boot strict=on
> -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 -device
> lsi,id=scsi0,bus=pci.0,addr=0x6 -device
> virtio-scsi-pci,ioeventfd=on,num_queues=4,iothread=iothread2,id=scsi1,bus=pci.0,addr=0x7
> -device
> virtio-scsi-pci,ioeventfd=on,num_queues=4,iothread=iothread2,id=scsi2,bus=pci.0,addr=0x8
> -drive file=rhel7.qcow2,if=none,id=drive-virtio-disk0,format=qcow2 -device
> virtio-blk-pci,ioeventfd=on,num-queues=4,iothread=iothread1,scsi=off,bus=pci.0,addr=0x4,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1
> -drive
> file=/dev/sdc,if=none,id=drive-virtio-disk1,format=raw,cache=none,aio=native
> -device
> virtio-blk-pci,ioeventfd=on,num-queues=4,iothread=iothread1,iothread=iothread1,scsi=off,bus=pci.0,addr=0x17,drive=drive-virtio-disk1,id=virtio-disk1

num-queues here will not make much of a difference with current implementation
in QEMU because they all get processed in the same iothread.

> -drive
> file=/dev/sdc,if=none,id=drive-scsi1-0-0-0,format=raw,cache=none,aio=native
> -device
> scsi-hd,bus=scsi1.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi1-0-0-0,id=scsi1-0-0-0
> -netdev tap,fd=24,id=hostnet0,vhost=on,vhostfd=25 -device
> virtio-net-pci,netdev=hostnet0,id=net0,mac=XXX,bus=pci.0,addr=0x2 -netdev
> tap,fd=26,id=hostnet1,vhost=on,vhostfd=27 -device
> virtio-net-pci,netdev=hostnet1,id=net1,mac=YYY,bus=pci.0,multifunction=on,addr=0x15
> -netdev tap,fd=28,id=hostnet2,vhost=on,vhostfd=29 -device
> virtio-net-pci,netdev=hostnet2,id=net2,mac=ZZZ,bus=pci.0,multifunction=on,addr=0x16
> -chardev pty,id=charserial0 -device isa-serial,chardev=charserial0,id=serial0
> -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x3 -msg timestamp=on
> 
> fio command line: /tmp/fio --time_based --ioengine=libaio --randrepeat=1
> --direct=1 --invalidate=1 --verify=0 --offset=0 --verify_fatal=0
> --group_reporting --numjobs=$jobs --name=randread --rw=randread --blocksize=8K
> --iodepth=$qd --runtime=60 --filename={/dev/vdb or /dev/sda}
> 
> # qemu-system-x86_64 --version
> QEMU emulator version 2.8.0(Debian 1:2.8+dfsg-3~bpo8+1)
> Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
> 
> The guest was running RHEL 7.3 and the host was Debian 8.
> 
> Any thoughts on what could be happening here ?

While there could be things that can be optimized/tuned, the results are not too
surprising to me. You have fast disks here so the overhead is more obvious.

Fam
