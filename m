Received: from eggs.gnu.org ([2001:4830:134:3::10]:56352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d0Uza-00018A-NO
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d0UzV-00077E-7D
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:24:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1d0UzU-00076I-L7
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:24:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74A627AEA4
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 15:24:26 +0000 (UTC)
Date: Tue, 18 Apr 2017 16:24:24 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170418152424.GX30620@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] virtio-scsi limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

Hi Paolo,

I was looking for documentation on the limits of #controllers,
#channels, #targets, #LUNs, #disks in virtio-scsi, and couldn't find
any, so I thought I would create that documentation instead.  I wonder
if you could check that the following is correct information.  Also -
at the bottom of the email - a puzzling problem or bug.

At the libvirt level, we refer to virtio-scsi disks using:

  <devices>
    <controller type=3D"scsi" index=3D"0" model=3D"virtio-scsi"/>
    ...
    <disk device=3D"disk" type=3D"file">
      <source file=3D"disk.img"/>
      <target dev=3D"sda" bus=3D"scsi"/>
      <driver name=3D"qemu" type=3D"raw"/>
      <address type=3D"drive" controller=3D"0" bus=3D"0" target=3D"0" unit=
=3D"0"/>
    </disk>

On the qemu command line, the controller becomes:

  -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x2

(For Q35, it would specify a PCIe bus and the address would also be a
bit different).

On the qemu command line, the disk becomes:

  -drive file=3Ddisk.img,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-0
  -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddri=
ve-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1

In libvirt <address ... controller=3D"0"> refers back to the
<controller index=3D"0"/> element.  You can add more than one
virtio-scsi controller, but each one takes a PCI slot, and the number
of PCI slots can be limited (or on Q35, there are no effective limits
but there are other architectural constraints).

In libvirt, <address ... bus=3D"0"> refers to the virtio-scsi "channel".
The current virtio-scsi driver in qemu has a hard limit of 1 channel,
so you can only use bus=3D"0" (or channel=3D0).

Open question: Will this limit ever be increased?

In libvirt, <address ... target=3D"0"> refers to the virtio-scsi
"scsi-id" (internally in the driver called just ".id").  You can use
any target from 0 to 255 inclusive.

In libvirt, <address ... unit=3D"0"> refers to the virtio-scsi "unit" ie
the SCSI LUN.  You can use any LUN from 0 to 16383 inclusive.

Open question: What does the bus=3Dscsi0.0 parameter mean?

The maximum number of drives on a single controller is therefore
256 * 16384 =3D 4194304.

However there are other limits to consider:

 (1) qemu is limited by the number of files it can open (ulimit -n /
     RLIMIT_NOFILE).  On Fedora, this is 1024 (soft) or 4096 (hard),
     although of course it may be increased.

 (2) libvirt has trouble with > about 8000 drives
     (https://bugzilla.redhat.com/1443066).

 (3) The Linux kernel used to be limited to three letter drive names
     (ie. up to /dev/sdzzz, or 18278 drives), but in modern kernels
     this is no longer an issue.

 (4) The Linux kernel is quite slow at enumerating drives.  I couldn't
     get past 4000 drives without hitting SCSI layer timeouts.

Not tested yet: Does hotplugging work on individual LUNs?

----------------------------------------------------------------------

Currently libguestfs puts each disk on a separate target (target=3Di
unit=3D0), and therefore has an effective limit of 255 disks (256 - 1
because the appliance uses a disk).

When I changed libguestfs to use LUNs instead of targets (target=3D0
unit=3Di), I got a peculiar bug.  It looks like there is some kind of
race when enumerating the device, where /sys is populated before the
device is actually available.  See the below boot log, and compare it
to the init code:

https://github.com/libguestfs/supermin/blob/master/init/init.c#L176

* fp =3D fopen ("/sys/block/sdab/dev", "r") succeeds at line 181

* we read major:minor from fp at line 230

* we mknod ("/dev/root",...) at line 245

* we mount ("/dev/root", "/root", "ext2"...) at line 262, which fails with
  EINVAL

* shortly after that, kernel messages indicate that sdab has been
  attached.

Rich.

2017-04-18 14:30:28.019+0000: starting up libvirt version: 3.2.0, package: =
1.fc27 (Fedora Project, 2017-04-03-13:37:30, buildvm-26.phx2.fedoraproject.=
org), qemu version: 2.8.93(qemu-2.9.0-0.2.rc3.fc27), hostname: trick.home.a=
nnexia.org
LC_ALL=3DC LD_LIBRARY_PATH=3D/home/rjones/d/libguestfs/ruby/ext/guestfs:/ho=
me/rjones/d/libguestfs/lib/.libs:/home/rjones/d/libguestfs/java/.libs:/home=
/rjones/d/libguestfs/gobject/.libs PATH=3D/home/rjones/d/libguestfs/v2v:/ho=
me/rjones/d/libguestfs/tools:/home/rjones/d/libguestfs/test-tool:/home/rjon=
es/d/libguestfs/sysprep:/home/rjones/d/libguestfs/sparsify:/home/rjones/d/l=
ibguestfs/resize:/home/rjones/d/libguestfs/rescue:/home/rjones/d/libguestfs=
/p2v:/home/rjones/d/libguestfs/make-fs:/home/rjones/d/libguestfs/inspector:=
/home/rjones/d/libguestfs/get-kernel:/home/rjones/d/libguestfs/fuse:/home/r=
jones/d/libguestfs/format:/home/rjones/d/libguestfs/fish:/home/rjones/d/lib=
guestfs/erlang:/home/rjones/d/libguestfs/edit:/home/rjones/d/libguestfs/dif=
f:/home/rjones/d/libguestfs/dib:/home/rjones/d/libguestfs/df:/home/rjones/d=
/libguestfs/customize:/home/rjones/d/libguestfs/cat:/home/rjones/d/libguest=
fs/builder:/home/rjones/d/libguestfs/align:/usr/libexec/python2-sphinx:/usr=
/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/rjones/.local/bin:/home=
/rjones/bin HOME=3D/home/rjones USER=3Drjones LOGNAME=3Drjones QEMU_AUDIO_D=
RV=3Dnone TMPDIR=3D/home/rjones/d/libguestfs/tmp /usr/bin/qemu-kvm -name gu=
est=3Dguestfs-o53fc0or1muu2f30,debug-threads=3Don -S -object secret,id=3Dma=
sterKey0,format=3Draw,file=3D/home/rjones/.config/libvirt/qemu/lib/domain-1=
-guestfs-o53fc0or1muu/master-key.aes -machine pc-i440fx-2.9,accel=3Dkvm,usb=
=3Doff,dump-guest-core=3Doff -cpu host -m 500 -realtime mlock=3Doff -smp 1,=
sockets=3D1,cores=3D1,threads=3D1 -uuid ca87a437-9562-4ca0-bd11-607342286ba=
1 -display none -no-user-config -nodefaults -device sga -chardev socket,id=
=3Dcharmonitor,path=3D/home/rjones/.config/libvirt/qemu/lib/domain-1-guestf=
s-o53fc0or1muu/monitor.sock,server,nowait -mon chardev=3Dcharmonitor,id=3Dm=
onitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_=
tick_policy=3Ddelay -no-hpet -no-reboot -no-acpi -boot strict=3Don -kernel =
/home/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d/kernel -initrd /hom=
e/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d/initrd -append 'panic=
=3D1 console=3DttyS0 edd=3Doff udevtimeout=3D6000 udev.event-timeout=3D6000=
 no_timer_check printk.time=3D1 cgroup_disable=3Dmemory usbcore.nousb crypt=
omgr.notests tsc=3Dreliable 8250.nr_uarts=3D1 root=3D/dev/sdab selinux=3D0 =
guestfs_verbose=3D1 TERM=3Dxterm-256color' -device virtio-scsi-pci,id=3Dscs=
i0,bus=3Dpci.0,addr=3D0x2 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=
=3Dpci.0,addr=3D0x3 -drive file=3D/home/rjones/d/libguestfs/tmp/libguestfsR=
IVPfK/scratch.1,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-0,cache=3Dunsaf=
e -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddri=
ve-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1 -drive file=3D/home/rjones/d/=
libguestfs/tmp/libguestfsRIVPfK/scratch.2,format=3Draw,if=3Dnone,id=3Ddrive=
-scsi0-0-0-1,cache=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-=
id=3D0,lun=3D1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1 -drive file=3D/ho=
me/rjones/d/libguestfs/tmp/libguestfsRIVPfK/scratch.3,format=3Draw,if=3Dnon=
e,id=3Ddrive-scsi0-0-0-2,cache=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,chann=
el=3D0,scsi-id=3D0,lun=3D2,drive=3Ddrive-scsi0-0-0-2,id=3Dscsi0-0-0-2 -driv=
e file=3D/home/rjones/d/libguestfs/tmp/libguestfsRIVPfK/scratch.4,format=3D=
raw,if=3Dnone,id=3Ddrive-scsi0-0-0-3,cache=3Dunsafe -device scsi-hd,bus=3Ds=
csi0.0,channel=3D0,scsi-id=3D0,lun=3D3,drive=3Ddrive-scsi0-0-0-3,id=3Dscsi0=
-0-0-3 -drive file=3D/home/rjones/d/libguestfs/tmp/libguestfsRIVPfK/scratch=
=2E5,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-4,cache=3Dunsafe -device s=
csi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D4,drive=3Ddrive-scsi0-0-=
0-4,id=3Dscsi0-0-0-4 -drive file=3D/home/rjones/d/libguestfs/tmp/libguestfs=
RIVPfK/scratch.6,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-5,cache=3Dunsa=
fe -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D5,drive=3Ddr=
ive-scsi0-0-0-5,id=3Dscsi0-0-0-5 -drive file=3D/home/rjones/d/libguestfs/tm=
p/libguestfsRIVPfK/scratch.7,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-6,=
cache=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D=
6,drive=3Ddrive-scsi0-0-0-6,id=3Dscsi0-0-0-6 -drive file=3D/home/rjones/d/l=
ibguestfs/tmp/libguestfsRIVPfK/scratch.8,format=3Draw,if=3Dnone,id=3Ddrive-=
scsi0-0-0-7,cache=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-i=
d=3D0,lun=3D7,drive=3Ddrive-scsi0-0-0-7,id=3Dscsi0-0-0-7 -drive file=3D/hom=
e/rjones/d/libguestfs/tmp/libguestfsRIVPfK/scratch.9,format=3Draw,if=3Dnone=
,id=3Ddrive-scsi0-0-0-8,cache=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,channe=
l=3D0,scsi-id=3D0,lun=3D8,drive=3Ddrive-scsi0-0-0-8,id=3Dscsi0-0-0-8 -drive=
 file=3D/home/rjones/d/libguestfs/tmp/libguestfsRIVPfK/scratch.10,format=3D=
raw,if=3Dnone,id=3Ddrive-scsi0-0-0-9,cache=3Dunsafe -device scsi-hd,bus=3Ds=
csi0.0,channel=3D0,scsi-id=3D0,lun=3D9,drive=3Ddrive-scsi0-0-0-9,id=3Dscsi0=
-0-0-9 -drive file=3D/home/rjones/d/libguestfs/tmp/libguestfsRIVPfK/scratch=
=2E11,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-10,cache=3Dunsafe -device=
 scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D10,drive=3Ddrive-scsi0=
-0-0-10,id=3Dscsi0-0-0-10 -drive file=3D/home/rjones/d/libguestfs/tmp/libgu=
estfsRIVPfK/scratch.12,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-11,cache=
=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D11,dr=
ive=3Ddrive-scsi0-0-0-11,id=3Dscsi0-0-0-11 -drive file=3D/home/rjones/d/lib=
guestfs/tmp/libguestfsRIVPfK/scratch.13,format=3Draw,if=3Dnone,id=3Ddrive-s=
csi0-0-0-12,cache=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-i=
d=3D0,lun=3D12,drive=3Ddrive-scsi0-0-0-12,id=3Dscsi0-0-0-12 -drive file=3D/=
home/rjones/d/libguestfs/tmp/libguestfsRIVPfK/scratch.14,format=3Draw,if=3D=
none,id=3Ddrive-scsi0-0-0-13,cache=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,c=
hannel=3D0,scsi-id=3D0,lun=3D13,drive=3Ddrive-scsi0-0-0-13,id=3Dscsi0-0-0-1=
3 -drive file=3D/home/rjones/d/libguestfs/tmp/libguestfsRIVPfK/scratch.15,f=
ormat=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-14,cache=3Dunsafe -device scsi-h=
d,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D14,drive=3Ddrive-scsi0-0-0-14=
,id=3Dscsi0-0-0-14 -drive file=3D/home/rjones/d/libguestfs/tmp/libguestfsRI=
VPfK/scratch.16,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-15,cache=3Dunsa=
fe -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D15,drive=3Dd=
rive-scsi0-0-0-15,id=3Dscsi0-0-0-15 -drive file=3D/home/rjones/d/libguestfs=
/tmp/libguestfsRIVPfK/scratch.17,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-=
0-16,cache=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,l=
un=3D16,drive=3Ddrive-scsi0-0-0-16,id=3Dscsi0-0-0-16 -drive file=3D/home/rj=
ones/d/libguestfs/tmp/libguestfsRIVPfK/scratch.18,format=3Draw,if=3Dnone,id=
=3Ddrive-scsi0-0-0-17,cache=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,channel=
=3D0,scsi-id=3D0,lun=3D17,drive=3Ddrive-scsi0-0-0-17,id=3Dscsi0-0-0-17 -dri=
ve file=3D/home/rjones/d/libguestfs/tmp/libguestfsRIVPfK/scratch.19,format=
=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-18,cache=3Dunsafe -device scsi-hd,bus=
=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D18,drive=3Ddrive-scsi0-0-0-18,id=
=3Dscsi0-0-0-18 -drive file=3D/home/rjones/d/libguestfs/tmp/libguestfsRIVPf=
K/scratch.20,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-19,cache=3Dunsafe =
-device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D19,drive=3Ddriv=
e-scsi0-0-0-19,id=3Dscsi0-0-0-19 -drive file=3D/home/rjones/d/libguestfs/tm=
p/libguestfsRIVPfK/scratch.21,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-2=
0,cache=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=
=3D20,drive=3Ddrive-scsi0-0-0-20,id=3Dscsi0-0-0-20 -drive file=3D/home/rjon=
es/d/libguestfs/tmp/libguestfsRIVPfK/scratch.22,format=3Draw,if=3Dnone,id=
=3Ddrive-scsi0-0-0-21,cache=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,channel=
=3D0,scsi-id=3D0,lun=3D21,drive=3Ddrive-scsi0-0-0-21,id=3Dscsi0-0-0-21 -dri=
ve file=3D/home/rjones/d/libguestfs/tmp/libguestfsRIVPfK/scratch.23,format=
=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-22,cache=3Dunsafe -device scsi-hd,bus=
=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D22,drive=3Ddrive-scsi0-0-0-22,id=
=3Dscsi0-0-0-22 -drive file=3D/home/rjones/d/libguestfs/tmp/libguestfsRIVPf=
K/scratch.24,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-23,cache=3Dunsafe =
-device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D23,drive=3Ddriv=
e-scsi0-0-0-23,id=3Dscsi0-0-0-23 -drive file=3D/home/rjones/d/libguestfs/tm=
p/libguestfsRIVPfK/scratch.25,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-2=
4,cache=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=
=3D24,drive=3Ddrive-scsi0-0-0-24,id=3Dscsi0-0-0-24 -drive file=3D/home/rjon=
es/d/libguestfs/tmp/libguestfsRIVPfK/scratch.26,format=3Draw,if=3Dnone,id=
=3Ddrive-scsi0-0-0-25,cache=3Dunsafe -device scsi-hd,bus=3Dscsi0.0,channel=
=3D0,scsi-id=3D0,lun=3D25,drive=3Ddrive-scsi0-0-0-25,id=3Dscsi0-0-0-25 -dri=
ve file=3D/home/rjones/d/libguestfs/tmp/libguestfsRIVPfK/scratch.27,format=
=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-26,cache=3Dunsafe -device scsi-hd,bus=
=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D26,drive=3Ddrive-scsi0-0-0-26,id=
=3Dscsi0-0-0-26 -drive file=3D/home/rjones/d/libguestfs/tmp/libguestfsRIVPf=
K/overlay28,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-27,cache=3Dunsafe=
 -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D27,drive=3Ddri=
ve-scsi0-0-0-27,id=3Dscsi0-0-0-27 -chardev socket,id=3Dcharserial0,path=3D/=
run/user/1000/libguestfsE9o2dm/console.sock -device isa-serial,chardev=3Dch=
arserial0,id=3Dserial0 -chardev socket,id=3Dcharchannel0,path=3D/run/user/1=
000/libguestfsE9o2dm/guestfsd.sock -device virtserialport,bus=3Dvirtio-seri=
al0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.libguestfs.cha=
nnel.0 -object rng-random,id=3Dobjrng0,filename=3D/dev/urandom -device virt=
io-rng-pci,rng=3Dobjrng0,id=3Drng0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=3D=
on
2017-04-18 14:30:28.019+0000: Domain id=3D1 is tainted: custom-argv
2017-04-18 14:30:28.019+0000: Domain id=3D1 is tainted: host-cpu
2017-04-18 14:30:31.860+0000: shutting down, reason=3Dshutdown


Google, Inc.=0D
Serial Graphics Adapter 02/12/17=0D
SGABIOS $Id: sgabios.S 8 2010-04-22 00:03:40Z nlaredo $ (mockbuild@) Sun Fe=
b 12 00:43:05 UTC 2017=0D
Term: 80x24=0D
4 0=0D
\x1b[2J=0DSeaBIOS (version 1.10.2-1.fc26)=0D=0D
=0DMachine UUID ca87a437-9562-4ca0-bd11-607342286ba1=0D=0D
=0DBooting from ROM...=0D=0D
\x1b[2J[    0.000000] Linux version 4.11.0-0.rc4.git1.1.fc27.x86_64 (mockbu=
ild@bkernel02.phx2.fedoraproject.org) (gcc version 7.0.1 20170327 (Red Hat =
7.0.1-0.13) (GCC) ) #1 SMP Tue Mar 28 15:20:45 UTC 2017=0D
[    0.000000] Command line: panic=3D1 console=3DttyS0 edd=3Doff udevtimeou=
t=3D6000 udev.event-timeout=3D6000 no_timer_check printk.time=3D1 cgroup_di=
sable=3Dmemory usbcore.nousb cryptomgr.notests tsc=3Dreliable 8250.nr_uarts=
=3D1 root=3D/dev/sdab selinux=3D0 guestfs_verbose=3D1 TERM=3Dxterm-256color=
=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'=0D
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256=0D
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'standard' format.=0D
[    0.000000] e820: BIOS-provided physical RAM map:=0D
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff] usabl=
e=0D
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001f3fdfff] usabl=
e=0D
[    0.000000] BIOS-e820: [mem 0x000000001f3fe000-0x000000001f3fffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved=0D
[    0.000000] NX (Execute Disable) protection: active=0D
[    0.000000] SMBIOS 2.8 present.=0D
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.f=
c26 04/01/2014=0D
[    0.000000] Hypervisor detected: KVM=0D
[    0.000000] e820: last_pfn =3D 0x1f3fe max_arch_pfn =3D 0x400000000=0D
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT=
  =0D
[    0.000000] found SMP MP-table at [mem 0x000f6c10-0x000f6c1f] mapped at =
[ffffa059000f6c10]=0D
[    0.000000] Scanning 1 areas for low memory corruption=0D
[    0.000000] Using GB pages for direct mapping=0D
[    0.000000] RAMDISK: [mem 0x1f366000-0x1f3effff]=0D
[    0.000000] ACPI: Early table checksum verification disabled=0D
[    0.000000] ACPI BIOS Error (bug): A valid RSDP was not found (20170119/=
tbxfroot-244)=0D
[    0.000000] No NUMA configuration found=0D
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000001f3fdfff]=
=0D
[    0.000000] NODE_DATA(0) allocated [mem 0x1f33b000-0x1f365fff]=0D
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00=0D
[    0.000000] kvm-clock: cpu 0, msr 0:1f2bb001, primary cpu clock=0D
[    0.000000] kvm-clock: using sched offset of 371325493 cycles=0D
[    0.000000] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles:=
 0x1cd42e4dffb, max_idle_ns: 881590591483 ns=0D
[    0.000000] Zone ranges:=0D
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]=0D
[    0.000000]   DMA32    [mem 0x0000000001000000-0x000000001f3fdfff]=0D
[    0.000000]   Normal   empty=0D
[    0.000000]   Device   empty=0D
[    0.000000] Movable zone start for each node=0D
[    0.000000] Early memory node ranges=0D
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]=0D
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001f3fdfff]=0D
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000001f3fd=
fff]=0D
[    0.000000] SFI: Simple Firmware Interface v0.81 http://simplefirmware.o=
rg=0D
[    0.000000] Intel MultiProcessor Specification v1.4=0D
[    0.000000] MPTABLE: OEM ID: BOCHSCPU=0D
[    0.000000] MPTABLE: Product ID: 0.1         =0D
[    0.000000] MPTABLE: APIC at: 0xFEE00000=0D
[    0.000000] Processor #0 (Bootup-CPU)=0D
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23=0D
[    0.000000] Processors: 1=0D
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs=0D
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]=0D
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]=0D
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]=0D
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]=0D
[    0.000000] e820: [mem 0x1f400000-0xfeffbfff] available for PCI devices=
=0D
[    0.000000] Booting paravirtualized kernel on KVM=0D
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns=0D
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:1 nr_cpu_ids:1 nr=
_node_ids:1=0D
[    0.000000] percpu: Embedded 485 pages/cpu @ffffa0591f000000 s1948504 r8=
192 d29864 u2097152=0D
[    0.000000] KVM setup async PF for cpu 0=0D
[    0.000000] kvm-stealtime: cpu 0, msr 1f00db40=0D
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Tota=
l pages: 125879=0D
[    0.000000] Policy zone: DMA32=0D
[    0.000000] Kernel command line: panic=3D1 console=3DttyS0 edd=3Doff ude=
vtimeout=3D6000 udev.event-timeout=3D6000 no_timer_check printk.time=3D1 cg=
roup_disable=3Dmemory usbcore.nousb cryptomgr.notests tsc=3Dreliable 8250.n=
r_uarts=3D1 root=3D/dev/sdab selinux=3D0 guestfs_verbose=3D1 TERM=3Dxterm-2=
56color=0D
[    0.000000] PID hash table entries: 2048 (order: 2, 16384 bytes)=0D
[    0.000000] Memory: 461856K/511600K available (9745K kernel code, 2014K =
rwdata, 3808K rodata, 4652K init, 17160K bss, 49744K reserved, 0K cma-reser=
ved)=0D
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1=0D
[    0.001000] Running RCU self tests=0D
[    0.001000] Hierarchical RCU implementation.=0D
[    0.001000] \tRCU lockdep checking is enabled.=0D
[    0.001000] \tBuild-time adjustment of leaf fanout to 64.=0D
[    0.001000] \tRCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=3D1=
=2E=0D
[    0.001000] RCU: Adjusting geometry for rcu_fanout_leaf=3D64, nr_cpu_ids=
=3D1=0D
[    0.001000] NR_IRQS:524544 nr_irqs:256 16=0D
[    0.001000] \tOffload RCU callbacks from all CPUs=0D
[    0.001000] \tOffload RCU callbacks from CPUs: 0.=0D
[    0.001000] Console: colour *CGA 80x25=0D
[    0.001000] console [ttyS0] enabled=0D
[    0.001000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar=0D
[    0.001000] ... MAX_LOCKDEP_SUBCLASSES:  8=0D
[    0.001000] ... MAX_LOCK_DEPTH:          48=0D
[    0.001000] ... MAX_LOCKDEP_KEYS:        8191=0D
[    0.001000] ... CLASSHASH_SIZE:          4096=0D
[    0.001000] ... MAX_LOCKDEP_ENTRIES:     32768=0D
[    0.001000] ... MAX_LOCKDEP_CHAINS:      65536=0D
[    0.001000] ... CHAINHASH_SIZE:          32768=0D
[    0.001000]  memory used by lock dependency info: 8671 kB=0D
[    0.001000]  per task-struct memory footprint: 2688 bytes=0D
[    0.001000] kmemleak: Kernel memory leak detector disabled=0D
[    0.001018] tsc: Detected 1699.998 MHz processor=0D
[    0.003027] Calibrating delay loop (skipped) preset value.. 3399.99 Bogo=
MIPS (lpj=3D1699998)=0D
[    0.004011] pid_max: default: 32768 minimum: 301=0D
[    0.006165] Security Framework initialized=0D
[    0.008011] Yama: becoming mindful.=0D
[    0.009025] SELinux:  Disabled at boot.=0D
[    0.011214] Dentry cache hash table entries: 65536 (order: 7, 524288 byt=
es)=0D
[    0.013193] Inode-cache hash table entries: 32768 (order: 6, 262144 byte=
s)=0D
[    0.015082] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)=
=0D
[    0.016015] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 by=
tes)=0D
[    0.019517] Disabling memory control group subsystem=0D
[    0.021128] CPU: Physical Processor ID: 0=0D
[    0.023017] mce: CPU supports 10 MCE banks=0D
[    0.025120] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0=0D
[    0.026010] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0=0D
[    0.040016] Freeing SMP alternatives memory: 32K=0D
[    0.042863] ftrace: allocating 32197 entries in 126 pages=0D
[    0.055311] smpboot: Max logical packages: 1=0D
[    0.057531] x2apic enabled=0D
[    0.058011] Switched APIC routing to physical x2apic.=0D
[    0.062806] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1=0D
[    0.063000] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2609 v4 @ 1.70GHz (fa=
mily: 0x6, model: 0x4f, stepping: 0x1)=0D
[    0.063254] Performance Events: Broadwell events, Intel PMU driver.=0D
[    0.064021] ... version:                2=0D
[    0.065010] ... bit width:              48=0D
[    0.066009] ... generic registers:      8=0D
[    0.067021] ... value mask:             0000ffffffffffff=0D
[    0.068010] ... max period:             000000007fffffff=0D
[    0.069010] ... fixed-purpose events:   3=0D
[    0.070010] ... event mask:             00000007000000ff=0D
[    0.072669] smp: Bringing up secondary CPUs ...=0D
[    0.073038] smp: Brought up 1 node, 1 CPU=0D
[    0.074011] smpboot: Total of 1 processors activated (3399.99 BogoMIPS)=
=0D
[    0.075808] sched_clock: Marking stable (75000000, 0)->(396801627, -3218=
01627)=0D
[    0.079129] devtmpfs: initialized=0D
[    0.080701] x86/mm: Memory block size: 128MB=0D
[    0.085293] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns=0D
[    0.089064] futex hash table entries: 256 (order: 3, 32768 bytes)=0D
[    0.091677] pinctrl core: initialized pinctrl subsystem=0D
[    0.094067] RTC time: 14:30:28, date: 04/18/17=0D
[    0.096314] NET: Registered protocol family 16=0D
[    0.098807] cpuidle: using governor menu=0D
[    0.100932] PCI: Using configuration type 1 for base access=0D
[    0.110790] HugeTLB registered 1 GB page size, pre-allocated 0 pages=0D
[    0.113333] HugeTLB registered 2 MB page size, pre-allocated 0 pages=0D
[    0.116674] ACPI: Interpreter disabled.=0D
[    0.118503] vgaarb: loaded=0D
[    0.119907] SCSI subsystem initialized=0D
[    0.121620] usbcore: USB support disabled=0D
[    0.124193] PCI: Probing PCI hardware=0D
[    0.125796] PCI host bridge to bus 0000:00=0D
[    0.127419] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]=0D
[    0.129884] pci_bus 0000:00: root bus resource [mem 0x00000000-0xfffffff=
fff]=0D
[    0.132671] pci_bus 0000:00: No busn resource found for root bus, will u=
se [bus 00-ff]=0D
[    0.145046] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]=0D
[    0.147908] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]=0D
[    0.151764] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]=0D
[    0.154494] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]=0D
[    0.206482] pci 0000:00:01.0: PIIX/ICH IRQ router [8086:7000]=0D
[    0.211141] NetLabel: Initializing=0D
[    0.212580] NetLabel:  domain hash size =3D 128=0D
[    0.214330] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO=0D
[    0.216836] NetLabel:  unlabeled traffic allowed by default=0D
[    0.219328] clocksource: Switched to clocksource kvm-clock=0D
[    0.288806] VFS: Disk quotas dquot_6.6.0=0D
[    0.290516] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)=0D
[    0.293531] pnp: PnP ACPI: disabled=0D
[    0.301297] NET: Registered protocol family 2=0D
[    0.303701] TCP established hash table entries: 4096 (order: 3, 32768 by=
tes)=0D
[    0.306910] TCP bind hash table entries: 4096 (order: 6, 327680 bytes)=0D
[    0.309906] TCP: Hash tables configured (established 4096 bind 4096)=0D
[    0.312599] UDP hash table entries: 256 (order: 3, 49152 bytes)=0D
[    0.315142] UDP-Lite hash table entries: 256 (order: 3, 49152 bytes)=0D
[    0.318143] NET: Registered protocol family 1=0D
[    0.319891] pci 0000:00:00.0: Limiting direct PCI/PCI transfers=0D
[    0.322254] pci 0000:00:01.0: PIIX3: Enabling Passive Release=0D
[    0.324597] pci 0000:00:01.0: Activating ISA DMA hang workarounds=0D
[    0.327530] Unpacking initramfs...=0D
[    0.332133] Freeing initrd memory: 552K=0D
[    0.361347] DMA-API: preallocated 65536 debug entries=0D
[    0.365537] DMA-API: debugging enabled by kernel config=0D
[    0.367840] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)=0D
[    0.371369] Scanning for low memory corruption every 60 seconds=0D
[    0.374041] alg: self-tests disabled=0D
[    0.376207] audit: initializing netlink subsys (disabled)=0D
[    0.378523] cryptomgr_test (31) used greatest stack depth: 14640 bytes l=
eft=0D
[    0.382109] Initialise system trusted keyrings=0D
[    0.384258] workingset: timestamp_bits=3D36 max_order=3D17 bucket_order=
=3D0=0D
[    0.393146] zbud: loaded=0D
[    0.400637] NET: Registered protocol family 38=0D
[    0.402612] Key type asymmetric registered=0D
[    0.404396] Asymmetric key parser 'x509' registered=0D
[    0.406442] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 249)=0D
[    0.409491] io scheduler noop registered=0D
[    0.411402] io scheduler deadline registered=0D
[    0.413212] io scheduler cfq registered (default)=0D
[    0.415091] io scheduler mq-deadline registered=0D
[    0.419179] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE=0D
[    0.423584] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled=0D
[    0.456161] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115=
200) is a 16550A=0D
[    0.460297] Non-volatile memory driver v1.3=0D
[    0.462130] Linux agpgart interface v0.103=0D
[    0.467678] scsi host0: ata_piix=0D
[    0.469434] scsi host1: ata_piix=0D
[    0.470911] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0a0 irq 1=
4=0D
[    0.473629] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0a8 irq 1=
5=0D
[    0.476591] libphy: Fixed MDIO Bus: probed=0D
[    0.478471] usbserial: usb_serial_init - usb_register failed=0D
[    0.480806] usbserial: usb_serial_init - returning with error -19=0D
[    0.484518] i8042: PNP: No PS/2 controller found.=0D
[    0.486389] i8042: Probing ports directly.=0D
[    0.489922] serio: i8042 KBD port at 0x60,0x64 irq 1=0D
[    0.491958] serio: i8042 AUX port at 0x60,0x64 irq 12=0D
[    0.494442] mousedev: PS/2 mouse device common for all mice=0D
[    0.497646] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0=0D
[    0.501898] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0=0D
[    0.502142] rtc_cmos rtc_cmos: alarms up to one day, 114 bytes nvram=0D
[    0.502369] device-mapper: uevent: version 1.0.3=0D
[    0.507619] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised:=
 dm-devel@redhat.com=0D
[    0.508012] hidraw: raw HID events driver (C) Jiri Kosina=0D
[    0.508244] drop_monitor: Initializing network drop monitor service=0D
[    0.508480] ip_tables: (C) 2000-2006 Netfilter Core Team=0D
[    0.508555] Initializing XFRM netlink socket=0D
[    0.509052] NET: Registered protocol family 10=0D
[    0.515512] kworker/u2:2 (84) used greatest stack depth: 13984 bytes lef=
t=0D
[    0.526228] Segment Routing with IPv6=0D
[    0.526280] mip6: Mobile IPv6=0D
[    0.526299] NET: Registered protocol family 17=0D
[    0.526758] AVX2 version of gcm_enc/dec engaged.=0D
[    0.526760] AES CTR mode by8 optimization enabled=0D
[    0.543050] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042=
/serio1/input/input3=0D
[    0.547081] registered taskstats version 1=0D
[    0.547110] Loading compiled-in X.509 certificates=0D
[    0.552180] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042=
/serio1/input/input2=0D
[    0.556764] Loaded X.509 cert 'Fedora kernel signing key: 036bba79a715c1=
478c894d1c952934f04ad530a5'=0D
[    0.556932] zswap: loaded using pool lzo/zbud=0D
[    0.577721] Key type big_key registered=0D
[    0.579809] Key type encrypted registered=0D
[    0.583175]   Magic number: 13:302:536=0D
[    0.584997] rtc_cmos rtc_cmos: setting system clock to 2017-04-18 14:30:=
29 UTC (1492525829)=0D
[    0.641961] Freeing unused kernel memory: 4652K=0D
[    0.643872] Write protecting the kernel read-only data: 14336k=0D
[    0.647151] Freeing unused kernel memory: 480K=0D
[    0.649973] Freeing unused kernel memory: 288K=0D
[    0.654106] x86/mm: Checked W+X mappings: passed, no W+X pages found.=0D
[    0.656601] rodata_test: all tests were successful=0D
supermin: mounting /proc=0D
supermin: ext2 mini initrd starting up: 5.1.17 dietlibc=0D
supermin: cmdline: panic=3D1 console=3DttyS0 edd=3Doff udevtimeout=3D6000 u=
dev.event-timeout=3D6000 no_timer_check printk.time=3D1 cgroup_disable=3Dme=
mory usbcore.nousb cryptomgr.notests tsc=3Dreliable 8250.nr_uarts=3D1 root=
=3D/dev/sdab selinux=3D0 guestfs_verbose=3D1 TERM=3Dxterm-256color=0D
supermin: uptime: 0.60 0.08=0D
supermin: mounting /sys=0D
supermin: internal insmod crc32-pclmul.ko=0D
supermin: internal insmod crc32c-intel.ko=0D
supermin: internal insmod crct10dif-pclmul.ko=0D
supermin: internal insmod crc32_generic.ko=0D
supermin: internal insmod nfit.ko=0D
insmod: init_module: nfit.ko: No such device=0D
supermin: internal insmod virtio.ko=0D
supermin: internal insmod virtio_ring.ko=0D
supermin: internal insmod virtio_blk.ko=0D
supermin: internal insmod virtio-rng.ko=0D
supermin: internal insmod virtio_console.ko=0D
supermin: internal insmod crypto_engine.ko=0D
supermin: internal insmod virtio_crypto.ko[    0.716226] random: fast init =
done=0D
=0D
supermin: internal insmod virtio_net.ko=0D
supermin: internal insmod nd_btt.ko=0D
supermin: internal insmod nd_pmem.ko=0D
supermin: internal insmod virtio_scsi.ko=0D
supermin: internal insmod virtio_balloon.ko=0D
supermin: internal insmod virtio_input.ko=0D
supermin: internal insmod virtio_mmio.ko=0D
supermin: internal insmod virtio_pci.ko=0D
[    0.750232] virtio-pci 0000:00:02.0: PCI->APIC IRQ transform: INT A -> I=
RQ 10=0D
[    0.757888] scsi host2: Virtio SCSI HBA=0D
[    0.760908] virtio-pci 0000:00:03.0: PCI->APIC IRQ transform: INT A -> I=
RQ 11=0D
[    0.765966] scsi 2:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    0.777079] scsi 2:0:0:27: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.797056] scsi 2:0:0:26: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.801051] virtio-pci 0000:00:04.0: PCI->APIC IRQ transform: INT A -> I=
RQ 11=0D
[    0.808212] scsi 2:0:0:25: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.811926] random: crng init done=0D
[    0.814597] scsi 2:0:0:24: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.819568] scsi 2:0:0:23: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.823898] scsi 2:0:0:22: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.828180] scsi 2:0:0:21: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.832427] scsi 2:0:0:20: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.836679] scsi 2:0:0:19: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.840946] scsi 2:0:0:18: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.845154] scsi 2:0:0:17: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.849404] scsi 2:0:0:16: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.853644] scsi 2:0:0:15: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.857927] scsi 2:0:0:14: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.862196] scsi 2:0:0:13: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.866432] scsi 2:0:0:12: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.870682] scsi 2:0:0:11: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.874952] scsi 2:0:0:10: Direct-Access     QEMU     QEMU HARDDISK    2=
=2E5+ PQ: 0 ANSI: 5=0D
[    0.879142] scsi 2:0:0:9: Direct-Access     QEMU     QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    0.883343] scsi 2:0:0:8: Direct-Access     QEMU     QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    0.887531] scsi 2:0:0:7: Direct-Access     QEMU     QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    0.891778] scsi 2:0:0:6: Direct-Access     QEMU     QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    0.895953] scsi 2:0:0:5: Direct-Access     QEMU     QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    0.900142] scsi 2:0:0:4: Direct-Access     QEMU     QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    0.904411] scsi 2:0:0:3: Direct-Access     QEMU     QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    0.908635] scsi 2:0:0:2: Direct-Access     QEMU     QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    0.912806] scsi 2:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    1.124757] sd 2:0:0:0: Attached scsi generic sg0 type 0=0D
[    1.127512] sd 2:0:0:0: [sda] 2048 512-byte logical blocks: (1.05 MB/1.0=
0 MiB)=0D
[    1.130779] sd 2:0:0:0: [sda] Write Protect is off=0D
[    1.133100] sd 2:0:0:27: Attached scsi generic sg1 type 0=0D
[    1.135704] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0D
[    1.139705] sd 2:0:0:27: [sdb] 8388608 512-byte logical blocks: (4.29 GB=
/4.00 GiB)=0D
[    1.142948] sd 2:0:0:27: [sdb] Write Protect is off=0D
[    1.144929] sd 2:0:0:26: Attached scsi generic sg2 type 0=0D
[    1.147482] sd 2:0:0:27: [sdb] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.151944] sd 2:0:0:26: [sdc] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.155113] sd 2:0:0:26: [sdc] Write Protect is off=0D
[    1.157290] sd 2:0:0:25: Attached scsi generic sg3 type 0=0D
[    1.160070] sd 2:0:0:26: [sdc] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.164503] sd 2:0:0:25: [sdd] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.167645] sd 2:0:0:25: [sdd] Write Protect is off=0D
[    1.169807] sd 2:0:0:24: Attached scsi generic sg4 type 0=0D
[    1.173149] sd 2:0:0:25: [sdd] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.177990] sd 2:0:0:24: [sde] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.181191] sd 2:0:0:24: [sde] Write Protect is off=0D
[    1.184067] sd 2:0:0:0: [sda] Attached SCSI disk=0D
[    1.186874] sd 2:0:0:23: Attached scsi generic sg5 type 0=0D
[    1.189651] sd 2:0:0:24: [sde] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.193690] sd 2:0:0:23: [sdf] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.196837] sd 2:0:0:23: [sdf] Write Protect is off=0D
[    1.199386] sd 2:0:0:27: [sdb] Attached SCSI disk=0D
[    1.202784] sd 2:0:0:22: [sdg] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.205824] sd 2:0:0:22: Attached scsi generic sg6 type 0=0D
[    1.208463] sd 2:0:0:22: [sdg] Write Protect is off=0D
[    1.210808] sd 2:0:0:23: [sdf] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.214644] sd 2:0:0:26: [sdc] Attached SCSI disk=0D
[    1.218080] sd 2:0:0:22: [sdg] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.221902] sd 2:0:0:21: Attached scsi generic sg7 type 0=0D
[    1.224778] sd 2:0:0:21: [sdh] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.228138] sd 2:0:0:21: [sdh] Write Protect is off=0D
[    1.230348] sd 2:0:0:25: [sdd] Attached SCSI disk=0D
[    1.233903] sd 2:0:0:20: Attached scsi generic sg8 type 0=0D
[    1.236246] sd 2:0:0:20: [sdi] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.239513] sd 2:0:0:20: [sdi] Write Protect is off=0D
[    1.241794] sd 2:0:0:24: [sde] Attached SCSI disk=0D
[    1.244088] sd 2:0:0:21: [sdh] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.249007] sd 2:0:0:20: [sdi] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.253181] sd 2:0:0:19: Attached scsi generic sg9 type 0=0D
[    1.255730] sd 2:0:0:19: [sdj] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.259110] sd 2:0:0:19: [sdj] Write Protect is off=0D
[    1.261235] sd 2:0:0:23: [sdf] Attached SCSI disk=0D
[    1.265214] sd 2:0:0:22: [sdg] Attached SCSI disk=0D
[    1.267227] sd 2:0:0:18: Attached scsi generic sg10 type 0=0D
[    1.269935] sd 2:0:0:18: [sdk] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.273341] sd 2:0:0:19: [sdj] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.277362] sd 2:0:0:18: [sdk] Write Protect is off=0D
[    1.280756] sd 2:0:0:17: Attached scsi generic sg11 type 0=0D
[    1.283513] sd 2:0:0:17: [sdl] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.286731] sd 2:0:0:18: [sdk] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.290468] sd 2:0:0:21: [sdh] Attached SCSI disk=0D
[    1.292833] sd 2:0:0:17: [sdl] Write Protect is off=0D
[    1.296174] sd 2:0:0:20: [sdi] Attached SCSI disk=0D
[    1.298389] sd 2:0:0:16: Attached scsi generic sg12 type 0=0D
[    1.301208] sd 2:0:0:16: [sdm] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.304585] sd 2:0:0:17: [sdl] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.308906] sd 2:0:0:16: [sdm] Write Protect is off=0D
[    1.311919] sd 2:0:0:19: [sdj] Attached SCSI disk=0D
[    1.313897] sd 2:0:0:15: Attached scsi generic sg13 type 0=0D
[    1.316698] sd 2:0:0:16: [sdm] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.320370] sd 2:0:0:15: [sdn] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.324055] sd 2:0:0:15: [sdn] Write Protect is off=0D
[    1.327433] sd 2:0:0:14: Attached scsi generic sg14 type 0=0D
[    1.330038] sd 2:0:0:18: [sdk] Attached SCSI disk=0D
[    1.332066] sd 2:0:0:14: [sdo] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.335256] sd 2:0:0:15: [sdn] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.339196] sd 2:0:0:14: [sdo] Write Protect is off=0D
[    1.342776] sd 2:0:0:13: Attached scsi generic sg15 type 0=0D
[    1.345573] sd 2:0:0:13: [sdp] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.348562] sd 2:0:0:17: [sdl] Attached SCSI disk=0D
[    1.350497] sd 2:0:0:14: [sdo] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.355531] sd 2:0:0:13: [sdp] Write Protect is off=0D
[    1.358208] sd 2:0:0:12: Attached scsi generic sg16 type 0=0D
[    1.360815] sd 2:0:0:12: [sdq] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.364075] sd 2:0:0:13: [sdp] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.367740] sd 2:0:0:16: [sdm] Attached SCSI disk=0D
[    1.369849] sd 2:0:0:12: [sdq] Write Protect is off=0D
[    1.373438] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x188=
125786ea, max_idle_ns: 440795276273 ns=0D
[    1.377623] sd 2:0:0:11: Attached scsi generic sg17 type 0=0D
[    1.377859] sd 2:0:0:11: [sdr] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.378005] sd 2:0:0:11: [sdr] Write Protect is off=0D
[    1.378256] sd 2:0:0:11: [sdr] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.378639] sd 2:0:0:15: [sdn] Attached SCSI disk=0D
[    1.380664] sd 2:0:0:10: Attached scsi generic sg18 type 0=0D
[    1.380967] sd 2:0:0:10: [sds] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.381119] sd 2:0:0:10: [sds] Write Protect is off=0D
[    1.381389] sd 2:0:0:10: [sds] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.384464] sd 2:0:0:14: [sdo] Attached SCSI disk=0D
[    1.385634] sd 2:0:0:12: [sdq] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.385663] sd 2:0:0:9: Attached scsi generic sg19 type 0=0D
[    1.385741] sd 2:0:0:11: [sdr] Attached SCSI disk=0D
[    1.386069] sd 2:0:0:9: [sdt] 2048 512-byte logical blocks: (1.05 MB/1.0=
0 MiB)=0D
[    1.386226] sd 2:0:0:9: [sdt] Write Protect is off=0D
[    1.386822] sd 2:0:0:9: [sdt] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0D
[    1.388375] sd 2:0:0:10: [sds] Attached SCSI disk=0D
[    1.389302] sd 2:0:0:8: Attached scsi generic sg20 type 0=0D
[    1.389413] sd 2:0:0:8: [sdu] 2048 512-byte logical blocks: (1.05 MB/1.0=
0 MiB)=0D
[    1.389539] sd 2:0:0:8: [sdu] Write Protect is off=0D
[    1.389837] sd 2:0:0:8: [sdu] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0D
[    1.391885] sd 2:0:0:9: [sdt] Attached SCSI disk=0D
[    1.393465] sd 2:0:0:12: [sdq] Attached SCSI disk=0D
[    1.393497] sd 2:0:0:7: Attached scsi generic sg21 type 0=0D
[    1.397123] sd 2:0:0:7: [sdv] 2048 512-byte logical blocks: (1.05 MB/1.0=
0 MiB)=0D
[    1.397365] sd 2:0:0:7: [sdv] Write Protect is off=0D
[    1.397609] sd 2:0:0:8: [sdu] Attached SCSI disk=0D
[    1.397631] sd 2:0:0:7: [sdv] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0D
[    1.399306] sd 2:0:0:6: Attached scsi generic sg22 type 0=0D
[    1.399555] sd 2:0:0:6: [sdw] 2048 512-byte logical blocks: (1.05 MB/1.0=
0 MiB)=0D
[    1.399688] sd 2:0:0:6: [sdw] Write Protect is off=0D
[    1.399938] sd 2:0:0:6: [sdw] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0D
[    1.400566] sd 2:0:0:13: [sdp] Attached SCSI disk=0D
supermin: internal insmod crc-itu-t.ko=0D
[    1.402077] sd 2:0:0:5: Attached scsi generic sg23 type 0=0D
[    1.403090] sd 2:0:0:7: [sdv] Attached SCSI disk=0D
supermin: internal insmod crc7.ko=0D
supermin: internal insmod crc8.ko=0D
supermin: internal insmod libcrc32c.ko=0D
supermin: picked /sys/block/sdab/dev as root device=0D
supermin: creating /dev/root as block special 65:176=0D
supermin: mounting new root on /root=0D
[    1.403116] sd 2:0:0:5: [sdx] 2048 512-byte logical blocks: (1.05 MB/1.0=
0 MiB)=0D
mount: /root: Invalid argument=0D
[    1.403224] sd 2:0:0:5: [sdx] Write Protect is off=0D
[    1.403226] sd 2:0:0:5: [sdx] Mode Sense: 63 00 00 08=0D
[    1.403517] sd 2:0:0:5: [sdx] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0D
[    1.404406] sd 2:0:0:6: [sdw] Attached SCSI disk=0D
[    1.404703] sd 2:0:0:4: [sdy] 2048 512-byte logical blocks: (1.05 MB/1.0=
0 MiB)=0D
[    1.404761] sd 2:0:0:4: Attached scsi generic sg24 type 0=0D
[    1.404831] sd 2:0:0:4: [sdy] Write Protect is off=0D
[    1.404833] sd 2:0:0:4: [sdy] Mode Sense: 63 00 00 08=0D
[    1.405097] sd 2:0:0:4: [sdy] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0D
[    1.406816] sd 2:0:0:3: [sdz] 2048 512-byte logical blocks: (1.05 MB/1.0=
0 MiB)=0D
[    1.406859] sd 2:0:0:3: Attached scsi generic sg25 type 0=0D
[    1.406972] sd 2:0:0:3: [sdz] Write Protect is off=0D
[    1.406975] sd 2:0:0:3: [sdz] Mode Sense: 63 00 00 08=0D
[    1.407209] sd 2:0:0:3: [sdz] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0D
[    1.412134] sd 2:0:0:4: [sdy] Attached SCSI disk=0D
[    1.412173] sd 2:0:0:5: [sdx] Attached SCSI disk=0D
[    1.412669] sd 2:0:0:2: Attached scsi generic sg26 type 0=0D
[    1.412796] sd 2:0:0:2: [sdaa] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.412941] sd 2:0:0:2: [sdaa] Write Protect is off=0D
[    1.412943] sd 2:0:0:2: [sdaa] Mode Sense: 63 00 00 08=0D
[    1.413207] sd 2:0:0:2: [sdaa] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.414442] sd 2:0:0:1: Attached scsi generic sg27 type 0=0D
[    1.414495] sd 2:0:0:3: [sdz] Attached SCSI disk=0D
[    1.418581] sd 2:0:0:1: [sdab] 2048 512-byte logical blocks: (1.05 MB/1.=
00 MiB)=0D
[    1.420628] sd 2:0:0:1: [sdab] Write Protect is off=0D
[    1.420630] sd 2:0:0:1: [sdab] Mode Sense: 63 00 00 08=0D
[    1.425977] sd 2:0:0:1: [sdab] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA=0D
[    1.460647] sd 2:0:0:2: [sdaa] Attached SCSI disk=0D
[    1.508275] sd 2:0:0:1: [sdab] Attached SCSI disk=0D
[    1.538175] EXT4-fs (sdab): VFS: Can't find ext4 filesystem=0D
[    1.540218] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x00000100=0D
[    1.540218] =0D
[    1.540222] CPU: 0 PID: 1 Comm: init Not tainted 4.11.0-0.rc4.git1.1.fc2=
7.x86_64 #1=0D
[    1.540224] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1.fc26 04/01/2014=0D
[    1.540225] Call Trace:=0D
[    1.540234]  dump_stack+0x8e/0xd1=0D
[    1.540243]  panic+0xe9/0x237=0D
[    1.540282]  do_exit+0xd3f/0xd70=0D
[    1.540289]  ? trace_hardirqs_on_caller+0xf4/0x1b0=0D
[    1.540301]  SyS_exit+0x17/0x20=0D
[    1.540307]  entry_SYSCALL_64_fastpath+0x1f/0xc2=0D
[    1.540311] RIP: 0033:0x400e03=0D
[    1.540313] RSP: 002b:00007ffc58c7b998 EFLAGS: 00000246 ORIG_RAX: 000000=
000000003c=0D
[    1.540316] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004=
00e03=0D
[    1.540320] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000000=
00001=0D
[    1.540322] RBP: 0000000000000000 R08: 0000000000403bc4 R09: 00007ffc58c=
7b863=0D
[    1.540323] R10: 0000000000400e03 R11: 0000000000000246 R12: 00000000000=
00000=0D
[    1.540325] R13: 0000000000000041 R14: 0000000000000003 R15: 00007f66684=
48010=0D
[    1.540724] Kernel Offset: 0x13000000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)=0D
[    1.652370] Rebooting in 1 seconds..=0D


--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
