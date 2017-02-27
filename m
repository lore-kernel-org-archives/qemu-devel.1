Received: from eggs.gnu.org ([2001:4830:134:3::10]:50459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xzhou@redhat.com>) id 1ciHnd-0001M1-NA
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xzhou@redhat.com>) id 1ciHnZ-0001ZB-Pf
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:40:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xzhou@redhat.com>) id 1ciHnZ-0001YY-Hg
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:40:53 -0500
Date: Mon, 27 Feb 2017 17:40:50 +0800
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <20170227094050.ia6nrkvtvzmg7b2q@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Fail to start 2nd guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org

Hi,

It worked fine on Linus tree commit:
  7bb0338 Merge tag 'rodata-v4.11-rc1' of git://git.kernel.org/pub/scm/..

failed to start 2nd domain on this commit:
37c8596 Merge tag 'tty-4.11-rc1' of git://git.kernel.org/pub/scm/..
(this commit probably is not the first bad, i didn't do the bisecting)


sh-4.2# uname -r
4.10.0-master-37c8596+
sh-4.2# rpm -qv qemu
qemu-2.0.0-1.el7.6.x86_64
sh-4.2# ps ajxf | grep qemu
11441 11462 11461 10972 pts/0    11461 S+       0   0:00              \_ gr=
ep qemu
    1 11065 11064 11064 ?           -1 Sl     107   2:03 /usr/libexec/qemu-=
kvm -name 73h -S -machine pc-i440fx-rhel7.0.0,accel=3Dkvm,usb=3Doff,dump-gu=
est-core=3Doff -cpu Haswell,-hle,-rtm -m 8000 -realtime mlock=3Doff -smp 8,=
sockets=3D8,cores=3D1,threads=3D1 -uuid aab09e0f-d48a-4223-9b81-35d4718d59f=
c -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/var/=
lib/libvirt/qemu/domain-1-73h/monitor.sock,server,nowait -mon chardev=3Dcha=
rmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -globa=
l kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global PIIX4_PM.d=
isable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot strict=3Don -device ich=
9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x6.0x7 -device ich9-usb-uhci1,mast=
erbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=3D0x6 -devi=
ce ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x6.0x=
1 -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=
=3D0x6.0x2 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=
=3D0x5 -drive file=3D/var/lib/libvirt/images/rhel73.qcow2,format=3Dqcow2,if=
=3Dnone,id=3Ddrive-ide0-0-0 -device ide-hd,bus=3Dide.0,unit=3D0,drive=3Ddri=
ve-ide0-0-0,id=3Dide0-0-0,bootindex=3D1 -drive file=3D/var/lib/libvirt/imag=
es/73h.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-ide0-0-1 -device ide-hd,bu=
s=3Dide.0,unit=3D1,drive=3Ddrive-ide0-0-1,id=3Dide0-0-1 -drive file=3D/root=
/RHEL-7.2-20151030.0-Server-x86_64-dvd1.iso,format=3Draw,if=3Dnone,id=3Ddri=
ve-ide0-1-0,readonly=3Don -device ide-cd,bus=3Dide.1,unit=3D0,drive=3Ddrive=
-ide0-1-0,id=3Dide0-1-0,bootindex=3D2 -netdev tap,fd=3D25,id=3Dhostnet0 -de=
vice rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:83:12:7b,bus=3Dpci.=
0,addr=3D0x3 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcha=
rserial0,id=3Dserial0 -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -d=
evice virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,i=
d=3Dchannel0,name=3Dcom.redhat.spice.0 -spice port=3D5900,addr=3D127.0.0.1,=
disable-ticketing,image-compression=3Doff,seamless-migration=3Don -vga qxl =
-global qxl-vga.ram_size=3D67108864 -global qxl-vga.vram_size=3D67108864 -g=
lobal qxl-vga.vgamem_mb=3D16 -device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=
=3D0x4 -device hda-duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -charde=
v spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chardev=3Dchar=
redir0,id=3Dredir0,bus=3Dusb.0,port=3D1 -chardev spicevmc,id=3Dcharredir1,n=
ame=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb=
=2E0,port=3D2 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0=
x7 -msg timestamp=3Don
sh-4.2# virsh list
 Id    Name                           State
----------------------------------------------------
 1     73h                            running

sh-4.2# virsh start 73us
error: Failed to start domain 73us
error: internal error: qemu unexpectedly closed the monitor: ((null):11497)=
: Spice-Warning **: reds.c:2499:reds_init_socket: listen: Address already i=
n use
2017-02-27T09:33:42.335708Z qemu-kvm: failed to initialize spice server

sh-4.2#=20
