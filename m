Received: from eggs.gnu.org ([2001:4830:134:3::10]:57740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gWQ4T-0007Hm-B9
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:14:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gWQ4P-0002h6-Am
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:14:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gWQ4L-0002fc-GA
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:14:15 -0500
Date: Mon, 10 Dec 2018 13:14:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181210130650-mutt-send-email-mst@kernel.org>
References: <7CECC2DFC21538489F72729DF5EFB4D908ABD3A4@dggemm521-mbs.china.huawei.com>
	<20181209211730-mutt-send-email-mst@kernel.org>
	<7CECC2DFC21538489F72729DF5EFB4D908AC486D@DGGEMM501-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7CECC2DFC21538489F72729DF5EFB4D908AC486D@DGGEMM501-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [BUG]Unassigned mem write during pci device
 hot-plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xuyandong <xuyandong2@huawei.com>
Cc: "marcel@redhat.com" <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

On Mon, Dec 10, 2018 at 03:12:53AM +0000, xuyandong wrote:
> On Sat, Dec 08, 2018 at 11:58:59AM +0000, xuyandong wrote:
> > > Hi all,
> > >
> > >
> > >
> > > In our test, we configured VM with several pci-bridges and a
> > > virtio-net nic been attached with bus 4,
> > >
> > > After VM is startup, We ping this nic from host to judge if it is
> > > working normally. Then, we hot add pci devices to this VM with bus 0.
> > >
> > > We  found the virtio-net NIC in bus 4 is not working (can not connect)
> > > occasionally, as it kick virtio backend failure with error below:
> > >
> > >     Unassigned mem write 00000000fc803004 =3D 0x1
> > >
> > >
> > >
> > > memory-region: pci_bridge_pci
> > >
> > >   0000000000000000-ffffffffffffffff (prio 0, RW): pci_bridge_pci
> > >
> > >     00000000fc800000-00000000fc803fff (prio 1, RW): virtio-pci
> > >
> > >       00000000fc800000-00000000fc800fff (prio 0, RW):
> > > virtio-pci-common
> > >
> > >       00000000fc801000-00000000fc801fff (prio 0, RW): virtio-pci-isr
> > >
> > >       00000000fc802000-00000000fc802fff (prio 0, RW):
> > > virtio-pci-device
> > >
> > >       00000000fc803000-00000000fc803fff (prio 0, RW):
> > > virtio-pci-notify  <- io mem unassigned
> > >
> > >       =E2=80=A6
> > >
> > >
> > >
> > > We caught an exceptional address changing while this problem happened,
> > > show as
> > > follow:
> > >
> > > Before pci_bridge_update_mappings=EF=BC=9A
> > >
> > >       00000000fc000000-00000000fc1fffff (prio 1, RW): alias
> > > pci_bridge_pref_mem @pci_bridge_pci 00000000fc000000-00000000fc1fffff
> > >
> > >       00000000fc200000-00000000fc3fffff (prio 1, RW): alias
> > > pci_bridge_pref_mem @pci_bridge_pci 00000000fc200000-00000000fc3fffff
> > >
> > >       00000000fc400000-00000000fc5fffff (prio 1, RW): alias
> > > pci_bridge_pref_mem @pci_bridge_pci 00000000fc400000-00000000fc5fffff
> > >
> > >       00000000fc600000-00000000fc7fffff (prio 1, RW): alias
> > > pci_bridge_pref_mem @pci_bridge_pci 00000000fc600000-00000000fc7fffff
> > >
> > >       00000000fc800000-00000000fc9fffff (prio 1, RW): alias
> > > pci_bridge_pref_mem @pci_bridge_pci 00000000fc800000-00000000fc9fffff
> > > <- correct Adress Spce
> > >
> > >       00000000fca00000-00000000fcbfffff (prio 1, RW): alias
> > > pci_bridge_pref_mem @pci_bridge_pci 00000000fca00000-00000000fcbfffff
> > >
> > >       00000000fcc00000-00000000fcdfffff (prio 1, RW): alias
> > > pci_bridge_pref_mem @pci_bridge_pci 00000000fcc00000-00000000fcdfffff
> > >
> > >       00000000fce00000-00000000fcffffff (prio 1, RW): alias
> > > pci_bridge_pref_mem @pci_bridge_pci 00000000fce00000-00000000fcffffff
> > >
> > >
> > >
> > > After pci_bridge_update_mappings=EF=BC=9A
> > >
> > >       00000000fda00000-00000000fdbfffff (prio 1, RW): alias
> > > pci_bridge_mem @pci_bridge_pci 00000000fda00000-00000000fdbfffff
> > >
> > >       00000000fdc00000-00000000fddfffff (prio 1, RW): alias
> > > pci_bridge_mem @pci_bridge_pci 00000000fdc00000-00000000fddfffff
> > >
> > >       00000000fde00000-00000000fdffffff (prio 1, RW): alias
> > > pci_bridge_mem @pci_bridge_pci 00000000fde00000-00000000fdffffff
> > >
> > >       00000000fe000000-00000000fe1fffff (prio 1, RW): alias
> > > pci_bridge_mem @pci_bridge_pci 00000000fe000000-00000000fe1fffff
> > >
> > >       00000000fe200000-00000000fe3fffff (prio 1, RW): alias
> > > pci_bridge_mem @pci_bridge_pci 00000000fe200000-00000000fe3fffff
> > >
> > >       00000000fe400000-00000000fe5fffff (prio 1, RW): alias
> > > pci_bridge_mem @pci_bridge_pci 00000000fe400000-00000000fe5fffff
> > >
> > >       00000000fe600000-00000000fe7fffff (prio 1, RW): alias
> > > pci_bridge_mem @pci_bridge_pci 00000000fe600000-00000000fe7fffff
> > >
> > >       00000000fe800000-00000000fe9fffff (prio 1, RW): alias
> > > pci_bridge_mem @pci_bridge_pci 00000000fe800000-00000000fe9fffff
> > >
> > >       fffffffffc800000-fffffffffc800000 (prio 1, RW): alias pci_bridg=
e_pref_mem
> > > @pci_bridge_pci fffffffffc800000-fffffffffc800000   <- Exceptional Ad=
ress
> > Space
> >=20
> > This one is empty though right?
> >=20
> > >
> > >
> > > We have figured out why this address becomes this value,  according to
> > > pci spec,  pci driver can get BAR address size by writing 0xffffffff
> > > to
> > >
> > > the pci register firstly, and then read back the value from this regi=
ster.
> >=20
> >=20
> > OK however as you show below the BAR being sized is the BAR if a bridge=
=2E Are
> > you then adding a bridge device by hotplug?
>=20
> No, I just simply hot plugged a VFIO device to Bus 0, another interesting=
 phenomenon is
> If I hot plug the device to other bus, this doesn't happened.
> =20
> >=20
> >=20
> > > We didn't handle this value  specially while process pci write in
> > > qemu, the function call stack is:
> > >
> > > Pci_bridge_dev_write_config
> > >
> > > -> pci_bridge_write_config
> > >
> > > -> pci_default_write_config (we update the config[address] value here
> > > -> to
> > > fffffffffc800000, which should be 0xfc800000 )
> > >
> > > -> pci_bridge_update_mappings
> > >
> > >                 ->pci_bridge_region_del(br, br->windows);
> > >
> > > -> pci_bridge_region_init
> > >
> > >                                                                 ->
> > > pci_bridge_init_alias (here pci_bridge_get_base, we use the wrong
> > > value
> > > fffffffffc800000)
> > >
> > >                                                 ->
> > > memory_region_transaction_commit
> > >
> > >
> > >
> > > So, as we can see, we use the wrong base address in qemu to update the
> > > memory regions, though, we update the base address to
> > >
> > > The correct value after pci driver in VM write the original value
> > > back, the virtio NIC in bus 4 may still sends net packets concurrently
> > > with
> > >
> > > The wrong memory region address.
> > >
> > >
> > >
> > > We have tried to skip the memory region update action in qemu while
> > > detect pci write with 0xffffffff value, and it does work, but
> > >
> > > This seems to be not gently.
> >=20
> > For sure. But I'm still puzzled as to why does Linux try to size the BA=
R of the
> > bridge while a device behind it is used.
> >=20
> > Can you pls post your QEMU command line?
>=20
> My QEMU command line:
> /root/xyd/qemu-system-x86_64 -name guest=3DLinux,debug-threads=3Don -S -o=
bject secret,id=3DmasterKey0,format=3Draw,file=3D/var/run/libvirt/qemu/doma=
in-194-Linux/master-key.aes -machine pc-i440fx-2.8,accel=3Dkvm,usb=3Doff,du=
mp-guest-core=3Doff -cpu host,+kvm_pv_eoi -bios /usr/share/OVMF/OVMF.fd -m =
size=3D4194304k,slots=3D256,maxmem=3D33554432k -realtime mlock=3Doff -smp 2=
0,sockets=3D20,cores=3D1,threads=3D1 -numa node,nodeid=3D0,cpus=3D0-4,mem=
=3D1024 -numa node,nodeid=3D1,cpus=3D5-9,mem=3D1024 -numa node,nodeid=3D2,c=
pus=3D10-14,mem=3D1024 -numa node,nodeid=3D3,cpus=3D15-19,mem=3D1024 -uuid =
34a588c7-b0f2-4952-b39c-47fae3411439 -no-user-config -nodefaults -chardev s=
ocket,id=3Dcharmonitor,path=3D/var/run/libvirt/qemu/domain-194-Linux/monito=
r.sock,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol=
 -rtc base=3Dutc -no-hpet -global kvm-pit.lost_tick_policy=3Ddelay -no-shut=
down -boot strict=3Don -device pci-bridge,chassis_nr=3D1,id=3Dpci.1,bus=3Dp=
ci.0,addr=3D0x8 -device pci-bridge,chassis_nr=3D2,id=3Dpci.2,bus=3Dpci.0,ad=
dr=3D0x9 -device pci-bridge,chassis_nr=3D3,id=3Dpci.3,bus=3Dpci.0,addr=3D0x=
a -device pci-bridge,chassis_nr=3D4,id=3Dpci.4,bus=3Dpci.0,addr=3D0xb -devi=
ce pci-bridge,chassis_nr=3D5,id=3Dpci.5,bus=3Dpci.0,addr=3D0xc -device piix=
3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device usb-ehci,id=3Dusb1,b=
us=3Dpci.0,addr=3D0x10 -device nec-usb-xhci,id=3Dusb2,bus=3Dpci.0,addr=3D0x=
11 -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x3 -device virtio=
-scsi-pci,id=3Dscsi1,bus=3Dpci.0,addr=3D0x4 -device virtio-scsi-pci,id=3Dsc=
si2,bus=3Dpci.0,addr=3D0x5 -device virtio-scsi-pci,id=3Dscsi3,bus=3Dpci.0,a=
ddr=3D0x6 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D=
0x7 -drive file=3D/mnt/sdb/xml/centos_74_x64_uefi.raw,format=3Draw,if=3Dnon=
e,id=3Ddrive-virtio-disk0,cache=3Dnone -device virtio-blk-pci,scsi=3Doff,bu=
s=3Dpci.0,addr=3D0x2,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=
=3D1 -drive if=3Dnone,id=3Ddrive-ide0-1-1,readonly=3Don,cache=3Dnone -devic=
e ide-cd,bus=3Dide.1,unit=3D1,drive=3Ddrive-ide0-1-1,id=3Dide0-1-1 -netdev =
tap,fd=3D35,id=3Dhostnet0 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet=
0,mac=3D52:54:00:89:5d:8b,bus=3Dpci.4,addr=3D0x1 -chardev pty,id=3Dcharseri=
al0 -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -device usb-table=
t,id=3Dinput0,bus=3Dusb.0,port=3D1 -vnc 0.0.0.0:0 -device cirrus-vga,id=3Dv=
ideo0,vgamem_mb=3D8,bus=3Dpci.0,addr=3D0x12 -device virtio-balloon-pci,id=
=3Dballoon0,bus=3Dpci.0,addr=3D0xd -msg timestamp=3Don
>=20
> I am also very curious about this issue, in the linux kernel code, maybe =
double check in function pci_bridge_check_ranges triggered this problem.

If you can get the stacktrace in Linux when it tries to write this
fffff value, that would be quite helpful.


>=20
> >=20
> >=20
> >=20
> > >
> > >
> > > diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> > >
> > > index b2e50c3..84b405d 100644
> > >
> > > --- a/hw/pci/pci_bridge.c
> > >
> > > +++ b/hw/pci/pci_bridge.c
> > >
> > > @@ -256,7 +256,8 @@ void pci_bridge_write_config(PCIDevice *d,
> > >
> > >      pci_default_write_config(d, address, val, len);
> > >
> > > -    if (ranges_overlap(address, len, PCI_COMMAND, 2) ||
> > >
> > > +    if ( (val !=3D 0xffffffff) &&
> > >
> > > +        (ranges_overlap(address, len, PCI_COMMAND, 2) ||
> > >
> > >          /* io base/limit */
> > >
> > >          ranges_overlap(address, len, PCI_IO_BASE, 2) ||
> > >
> > > @@ -266,7 +267,7 @@ void pci_bridge_write_config(PCIDevice *d,
> > >
> > >          ranges_overlap(address, len, PCI_MEMORY_BASE, 20) ||
> > >
> > >          /* vga enable */
> > >
> > > -        ranges_overlap(address, len, PCI_BRIDGE_CONTROL, 2)) {
> > >
> > > +        ranges_overlap(address, len, PCI_BRIDGE_CONTROL, 2))) {
> > >
> > >          pci_bridge_update_mappings(s);
> > >
> > >      }
> > >
> > >
> > >
> > > Thinks,
> > >
> > > Xu
> > >
