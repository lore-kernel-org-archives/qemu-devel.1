Received: from eggs.gnu.org ([2001:4830:134:3::10]:39146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cemB6-0004vW-8M
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cemB4-0003BL-CM
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:18:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cemB4-00038N-2W
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:18:38 -0500
Date: Fri, 17 Feb 2017 10:18:35 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170217101835.58e59c41@t450s.home>
In-Reply-To: <1486456099-7345-1-git-send-email-peterx@redhat.com>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 00/17] VT-d: vfio enablement and misc
 enhances
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, David Gibson <david@gibson.dropbear.id.au>, bd.aviv@gmail.com

On Tue,  7 Feb 2017 16:28:02 +0800
Peter Xu <peterx@redhat.com> wrote:

> This is v7 of vt-d vfio enablement series.
[snip]
> =========
> Test Done
> =========
> 
> Build test passed for x86_64/arm/ppc64.
> 
> Simply tested with x86_64, assigning two PCI devices to a single VM,
> boot the VM using:
> 
> bin=x86_64-softmmu/qemu-system-x86_64
> $bin -M q35,accel=kvm,kernel-irqchip=split -m 1G \
>      -device intel-iommu,intremap=on,eim=off,caching-mode=on \
>      -netdev user,id=net0,hostfwd=tcp::5555-:22 \
>      -device virtio-net-pci,netdev=net0 \
>      -device vfio-pci,host=03:00.0 \
>      -device vfio-pci,host=02:00.0 \
>      -trace events=".trace.vfio" \
>      /var/lib/libvirt/images/vm1.qcow2
> 
> pxdev:bin [vtd-vfio-enablement]# cat .trace.vfio
> vtd_page_walk*
> vtd_replay*
> vtd_inv_desc*
> 
> Then, in the guest, run the following tool:
> 
>   https://github.com/xzpeter/clibs/blob/master/gpl/userspace/vfio-bind-group/vfio-bind-group.c
> 
> With parameter:
> 
>   ./vfio-bind-group 00:03.0 00:04.0
> 
> Check host side trace log, I can see pages are replayed and mapped in
> 00:04.0 device address space, like:
> 
> ...
> vtd_replay_ce_valid replay valid context device 00:04.00 hi 0x401 lo 0x38fe1001
> vtd_page_walk Page walk for ce (0x401, 0x38fe1001) iova range 0x0 - 0x8000000000
> vtd_page_walk_level Page walk (base=0x38fe1000, level=3) iova range 0x0 - 0x8000000000
> vtd_page_walk_level Page walk (base=0x35d31000, level=2) iova range 0x0 - 0x40000000
> vtd_page_walk_level Page walk (base=0x34979000, level=1) iova range 0x0 - 0x200000
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x0 -> gpa 0x22dc3000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x1000 -> gpa 0x22e25000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x2000 -> gpa 0x22e12000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x3000 -> gpa 0x22e2d000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x4000 -> gpa 0x12a49000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x5000 -> gpa 0x129bb000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x6000 -> gpa 0x128db000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x7000 -> gpa 0x12a80000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x8000 -> gpa 0x12a7e000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x9000 -> gpa 0x12b22000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0xa000 -> gpa 0x12b41000 mask 0xfff perm 3
> ...

Hi Peter,

I'm trying to make use of this, with your vtd-vfio-enablement-v7 branch
(HEAD 0c1c4e738095).  I'm assigning an 82576 PF to a VM.  It works with
iommu=pt, but if I remove that option, the device does not work and
vfio_iommu_map_notify is never called.  Any suggestions?  My
commandline is below.  Thanks,

Alex

/usr/local/bin/qemu-system-x86_64 \
        -name guest=l1,debug-threads=on -S \
        -machine pc-q35-2.9,accel=kvm,usb=off,dump-guest-core=off,kernel-irqchip=split \
        -cpu host -m 10240 -realtime mlock=off -smp 4,sockets=1,cores=2,threads=2 \
        -no-user-config -nodefaults -monitor stdio -rtc base=utc,driftfix=slew \
        -global kvm-pit.lost_tick_policy=discard -no-hpet -no-shutdown \
        -global ICH9-LPC.disable_s3=1 -global ICH9-LPC.disable_s4=1 \
        -boot strict=on \
        -device ioh3420,port=0x10,chassis=1,id=pci.1,bus=pcie.0,addr=0x2 \
        -device i82801b11-bridge,id=pci.2,bus=pcie.0,addr=0x1e \
        -device pci-bridge,chassis_nr=3,id=pci.3,bus=pci.2,addr=0x0 \
        -device ioh3420,port=0x18,chassis=4,id=pci.4,bus=pcie.0,addr=0x3 \
        -device ioh3420,port=0x20,chassis=5,id=pci.5,bus=pcie.0,addr=0x4 \
        -device ioh3420,port=0x28,chassis=6,id=pci.6,bus=pcie.0,addr=0x5 \
        -device ioh3420,port=0x30,chassis=7,id=pci.7,bus=pcie.0,addr=0x6 \
        -device ioh3420,port=0x38,chassis=8,id=pci.8,bus=pcie.0,addr=0x7 \
        -device ich9-usb-ehci1,id=usb,bus=pcie.0,addr=0x1d.0x7 \
        -device ich9-usb-uhci1,masterbus=usb.0,firstport=0,bus=pcie.0,multifunction=on,addr=0x1d \
        -device ich9-usb-uhci2,masterbus=usb.0,firstport=2,bus=pcie.0,addr=0x1d.0x1 \
        -device ich9-usb-uhci3,masterbus=usb.0,firstport=4,bus=pcie.0,addr=0x1d.0x2 \
        -device virtio-serial-pci,id=virtio-serial0,bus=pci.4,addr=0x0 \
        -drive file=/dev/vg_s20/lv_l1,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native \
        -device virtio-blk-pci,scsi=off,bus=pci.5,addr=0x0,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 \
        -netdev user,id=hostnet0 \
        -device virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:c2:62:30,bus=pci.1,addr=0x0 \
        -device usb-tablet,id=input0,bus=usb.0,port=1 \
        -vnc :0 -vga std \
        -device vfio-pci,host=01:00.0,id=hostdev0,bus=pci.8,addr=0x0 \
        -device intel-iommu,intremap=on,eim=off,caching-mode=on -trace events=/trace-events.txt -msg timestamp=on

# cat /trace-events.txt 
vfio_listener*
vfio_iommu*
vtd*
