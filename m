Received: from eggs.gnu.org ([2001:4830:134:3::10]:50841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <f.gruenbichler@proxmox.com>) id 1cTRqV-0004cj-2b
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <f.gruenbichler@proxmox.com>) id 1cTRqQ-0003NU-Af
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:22:35 -0500
Date: Tue, 17 Jan 2017 12:22:24 +0100
From: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Message-ID: <20170117112224.2st4wuivcbwuif2m@nora.maurer-it.com>
References: <5878AF90.8020709@kamp.de>
	<260873230.6154791.1484638426777.JavaMail.zimbra@oxygem.tv>
	<20170117080326.dfjqzwstfxusuhgc@nora.maurer-it.com>
	<b7f5dc23-6d72-4897-e9ca-6482acfb4c72@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b7f5dc23-6d72-4897-e9ca-6482acfb4c72@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-stable] Data corruption in Qemu 2.7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On Tue, Jan 17, 2017 at 11:41:44AM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 17/01/2017 09:03, Fabian Gr=FCnbichler wrote:
> > Commit 8fdc7839e40f43a426bc7e858cf1dbfe315a3804 (first included in
> > 2.7.0)[1] changed the behaviour of scsi-block passthrough. Previously
> > this worked with SATA disks, now it doesn't anymore. A bisect run
> > confirmed this, scsi-block with a SATA disk passed through via
> > virtio-scsi-single corrupts on writes since that commit, scsi-hd and
> > scsi-disk work fine (scsi-generic corrupts as well).
> >=20
> > PVE's detection logic for passthrough just differentiated between dis=
ks
> > and tape drives, and unfortunately the SG_IO ioctl says SATA disks ar=
e
> > disks as well.. we probably need to default to scsi-hd or scsi-disk
> > instead of scsi-block, and only when we explicitly detect a "real" SC=
SI
> > disk we are allowed to use scsi-block?
> >=20
> > @Paolo: was the old behaviour just an accident and the new bevaviour
> > intentional? documentation is quite sparse, or maybe I am looking in =
the
> > wrong places..
>=20
> No, it would be a bug (QEMU or kernel).
>=20
> Do you have an easy reproducer with dd, as suggested at
> https://forum.proxmox.com/threads/proxmox-4-4-virtio_scsi-regression.31=
471/page-2?
>=20
> Paolo
>=20

setup

1) dd 1G of (u)random data to a file on a file system on a SATA disk on
the host (I tested with ext2/3/4, ZFS and btrfs, btrfs produces
corruption the fastest here, but raw writes to the device should already
trigger the kernel error messages)

2) calculate the md5sum of this file, and store it on the same FS

test (with current qemu master, using PVE's 4.4.35 kernel as host kernel

1) start Ubuntu 16.04 VM (see full commandline at the end, I tested with
three disks, one for each of the file systems above) - the same behaviour
can also be observed when booting from an Alpine Linux iso

2) mount FS

3) dd random file from above to new file on same FS

4) sync

5) check md5sum of resulting file

6) repeat 3-5 until md5sum does not match, kernel spews error
messages, or you are convinced that everything is OK

sample kernel message (for ext3):
Jan 17 11:39:32 ubuntu kernel: sd 2:0:0:0: [sda] tag#32 FAILED Result: ho=
stbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
Jan 17 11:39:32 ubuntu kernel: sd 2:0:0:0: [sda] tag#32 Sense Key : Illeg=
al Request [current]
Jan 17 11:39:32 ubuntu kernel: sd 2:0:0:0: [sda] tag#32 Add. Sense: Inval=
id field in cdb
Jan 17 11:39:32 ubuntu kernel: sd 2:0:0:0: [sda] tag#32 CDB: Write(10) 2a=
 00 0f 3a 90 00 00 07 d8 00
Jan 17 11:39:32 ubuntu kernel: blk_update_request: critical target error,=
 dev sda, sector 255496192
Jan 17 11:39:32 ubuntu kernel: EXT4-fs warning (device sda1): ext4_end_bi=
o:329: I/O error -121 writing to inode 125 (offset 0 size 0 starting bloc=
k 31937280)
Jan 17 11:39:32 ubuntu kernel: buffer_io_error: 246 callbacks suppressed
Jan 17 11:39:32 ubuntu kernel: Buffer I/O error on device sda1, logical b=
lock 31936768
Jan 17 11:39:32 ubuntu kernel: Buffer I/O error on device sda1, logical b=
lock 31936769
Jan 17 11:39:32 ubuntu kernel: Buffer I/O error on device sda1, logical b=
lock 31936770
Jan 17 11:39:32 ubuntu kernel: Buffer I/O error on device sda1, logical b=
lock 31936771
Jan 17 11:39:32 ubuntu kernel: Buffer I/O error on device sda1, logical b=
lock 31936772
Jan 17 11:39:32 ubuntu kernel: Buffer I/O error on device sda1, logical b=
lock 31936773
Jan 17 11:39:32 ubuntu kernel: Buffer I/O error on device sda1, logical b=
lock 31936774
Jan 17 11:39:32 ubuntu kernel: Buffer I/O error on device sda1, logical b=
lock 31936775
Jan 17 11:39:32 ubuntu kernel: Buffer I/O error on device sda1, logical b=
lock 31936776
Jan 17 11:39:32 ubuntu kernel: Buffer I/O error on device sda1, logical b=
lock 31936777
Jan 17 11:39:39 ubuntu kernel: JBD2: Detected IO errors while flushing fi=
le data on sda1-8
Jan 17 11:39:41 ubuntu kernel: JBD2: Detected IO errors while flushing fi=
le data on sda1-8
Jan 17 11:39:55 ubuntu kernel: JBD2: Detected IO errors while flushing fi=
le data on sda1-8
Jan 17 11:39:56 ubuntu kernel: JBD2: Detected IO errors while flushing fi=
le data on sda1-8
Jan 17 11:40:07 ubuntu kernel: JBD2: Detected IO errors while flushing fi=
le data on sda1-8
Jan 17 11:40:08 ubuntu kernel: JBD2: Detected IO errors while flushing fi=
le data on sda1-8
Jan 17 11:40:15 ubuntu kernel: JBD2: Detected IO errors while flushing fi=
le data on sda1-8
Jan 17 11:40:22 ubuntu kernel: JBD2: Detected IO errors while flushing fi=
le data on sda1-8

qemu commandline, originally generated by PVE, feel free to adapt or
minimize.. sdb, sdc and sde are the three SATA disks from above,
vm-101-disk-1 is the Ubuntu rootfs on LVM-thin.

/root/qemu/build/x86_64-softmmu/qemu-system-x86_64 \
 -enable-kvm \
 -chardev 'socket,id=3Dqmp,path=3D/var/run/qemu-server/101.qmp,server,now=
ait' \
 -mon 'chardev=3Dqmp,mode=3Dcontrol' \
 -pidfile /var/run/qemu-server/101.pid \
 -smbios 'type=3D1,uuid=3D3e550136-9d7f-4a12-9d98-e25a5d2d5806' \
 -name diskpassthroughtest \
 -smp '8,sockets=3D1,cores=3D8,maxcpus=3D8' \
 -nodefaults \
 -boot 'menu=3Don,strict=3Don,reboot-timeout=3D1000,splash=3D/usr/share/q=
emu-server/bootsplash.jpg' \
 -vga cirrus \
 -vnc unix:/var/run/qemu-server/101.vnc,x509,password \
 -cpu kvm64,+lahf_lm,+sep,+kvm_pv_unhalt,+kvm_pv_eoi,enforce \
 -m 4096 \
 -k de \
 -device 'pci-bridge,id=3Dpci.1,chassis_nr=3D1,bus=3Dpci.0,addr=3D0x1e' \
 -device 'pci-bridge,id=3Dpci.2,chassis_nr=3D2,bus=3Dpci.0,addr=3D0x1f' \
 -device 'pci-bridge,id=3Dpci.3,chassis_nr=3D3,bus=3Dpci.0,addr=3D0x5' \
 -device 'piix3-usb-uhci,id=3Duhci,bus=3Dpci.0,addr=3D0x1.0x2' \
 -device 'usb-tablet,id=3Dtablet,bus=3Duhci.0,port=3D1' \
 -device 'virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x3' \
 -iscsi 'initiator-name=3Diqn.1993-08.org.debian:01:c6676e1b1f72' \
 -drive 'file=3D/mnt/pve/iso/template/iso/ubuntu-16.04.1-server-amd64.iso=
,if=3Dnone,id=3Ddrive-ide2,media=3Dcdrom,aio=3Dthreads' \
 -device 'ide-cd,bus=3Dide.1,unit=3D0,drive=3Ddrive-ide2,id=3Dide2,bootin=
dex=3D200' \
 -device 'virtio-scsi-pci,id=3Dvirtioscsi0,bus=3Dpci.3,addr=3D0x1' \
 -drive 'file=3D/dev/sdb,if=3Dnone,id=3Ddrive-scsi0,format=3Draw,cache=3D=
none,aio=3Dnative,detect-zeroes=3Don' \
 -device 'scsi-block,bus=3Dvirtioscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,=
drive=3Ddrive-scsi0,id=3Dscsi0' \
 -device 'virtio-scsi-pci,id=3Dvirtioscsi1,bus=3Dpci.3,addr=3D0x2' \
 -drive 'file=3D/dev/sdc,if=3Dnone,id=3Ddrive-scsi1,format=3Draw,cache=3D=
none,aio=3Dnative,detect-zeroes=3Don' \
 -device 'scsi-block,bus=3Dvirtioscsi1.0,channel=3D0,scsi-id=3D0,lun=3D1,=
drive=3Ddrive-scsi1,id=3Dscsi1' \
 -device 'virtio-scsi-pci,id=3Dvirtioscsi3,bus=3Dpci.3,addr=3D0x4' \
 -drive 'file=3D/dev/sde,if=3Dnone,id=3Ddrive-scsi3,format=3Draw,cache=3D=
none,aio=3Dnative,detect-zeroes=3Don' \
 -device 'scsi-block,bus=3Dvirtioscsi3.0,channel=3D0,scsi-id=3D0,lun=3D3,=
drive=3Ddrive-scsi3,id=3Dscsi3' \
 -drive 'file=3D/dev/pve/vm-101-disk-1,if=3Dnone,id=3Ddrive-virtio0,forma=
t=3Draw,cache=3Dnone,aio=3Dnative,detect-zeroes=3Don' \
 -device 'virtio-blk-pci,drive=3Ddrive-virtio0,id=3Dvirtio0,bus=3Dpci.0,a=
ddr=3D0xa,bootindex=3D103' \
 -netdev 'type=3Dtap,id=3Dnet0,ifname=3Dtap101i0,script=3D/var/lib/qemu-s=
erver/pve-bridge,downscript=3D/var/lib/qemu-server/pve-bridgedown,vhost=3D=
on' \
 -device 'virtio-net-pci,mac=3D46:83:4B:92:EC:88,netdev=3Dnet0,bus=3Dpci.=
0,addr=3D0x12,id=3Dnet0,bootindex=3D300'
