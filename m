Received: from eggs.gnu.org ([2001:4830:134:3::10]:49064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dLlD5-00038L-Fr
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 02:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dLlD1-0002Ar-J4
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 02:58:23 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:32863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dLlD1-00029G-CE
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 02:58:19 -0400
Received: by mail-vk0-f48.google.com with SMTP id p62so17991583vkp.0
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 23:58:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <VI1PR1001MB137395F2FCBDE6389A9AC5FCB7C30@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR1001MB137395F2FCBDE6389A9AC5FCB7C30@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 16 Jun 2017 08:58:17 +0200
Message-ID: <CABdb7358YVXbk++Z7s+q6Z5O0Q=6CQiQvYsTdc35eqmQeUnP_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Guest unresponsive after Virtqueue size exceeded
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@hotmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,

On Wed, Jun 14, 2017 at 11:56 PM, Fernando Casas Sch=C3=B6ssow
<casasfernando@hotmail.com> wrote:
> Hi there,
>
> I recently migrated a Hyper-V host to qemu/kvm runing on Alpine Linux 3.6=
.1 (kernel 4.9.30 -with grsec patches- and qemu 2.8.1).
>
> Almost on daily basis at least one of the guests is showing the following=
 error in the log and the it needs to be terminated and restarted to recove=
r it:
>
> qemu-system-x86_64: Virtqueue size exceeded
>
> Is not always the same guest, and the error is appearing for both, Linux =
(CentOS 7.3) and Windows (2012R2) guests.
> As soon as this error appears the guest is not really working anymore. It=
 may respond to ping or you can even try to login but then everything is ve=
ry slow or completely unresponsive. Restarting the guest from within the gu=
est OS is not working either and the only thing I can do is to terminate it=
 (virsh destroy) and start it again until the next failure.
>
> In Windows guest the error seems to be related to disk:
> "Reset to device, \Device\RaidPort2, was issued" and the source is viosto=
r
>
> And in Linux guests the error is always (with the process and pid changin=
g):
>
> INFO: task <process>:<pid> blocked for more than 120 seconds
>
> But unfortunately I was not able to find any other indication of a proble=
m in the guests logs nor in the host logs except for the error regarding th=
e virtqueue size. The problem is happening at different times of day and I =
couldn't find any patterns yet.
>
> All the Windows guests are using virtio drivers version 126 and all Linux=
 guests are CentOS 7.3 using the latest kernel available in the distributio=
n (3.10.0-514.21.1). They all run qemu-guest agent as well.
> All the guest disks are qcow2 images with cache=3Dnone and aimode=3Dthrea=
ds (tried native mode before but with the same results).
>
> Example qemu command for a Linux guest:
>
> /usr/bin/qemu-system-x86_64 -name guest=3DDOCKER01,debug-threads=3Don -S =
-object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/do=
main-24-DOCKER01/master-key.aes -machine pc-i440fx-2.8,accel=3Dkvm,usb=3Dof=
f,dump-guest-core=3Doff -cpu IvyBridge,+ds,+acpi,+ss,+ht,+tm,+pbe,+dtes64,+=
monitor,+ds_cpl,+vmx,+smx,+est,+tm2,+xtpr,+pdcm,+pcid,+osxsave,+arat,+xsave=
opt -drive file=3D/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd,if=3Dp=
flash,format=3Draw,unit=3D0,readonly=3Don -drive file=3D/var/lib/libvirt/qe=
mu/nvram/DOCKER01_VARS.fd,if=3Dpflash,format=3Draw,unit=3D1 -m 2048 -realti=
me mlock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -uuid 4705b146-3b14=
-4c20-923c-42105d47e7fc -no-user-config -nodefaults -chardev socket,id=3Dch=
armonitor,path=3D/var/lib/libvirt/qemu/domain-24-DOCKER01/monitor.sock,serv=
er,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=
=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -n=
o-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 =
-boot strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x4.0x=
7 -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multif=
unction=3Don,addr=3D0x4 -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=
=3D2,bus=3Dpci.0,addr=3D0x4.0x1 -device ich9-usb-uhci3,masterbus=3Dusb.0,fi=
rstport=3D4,bus=3Dpci.0,addr=3D0x4.0x2 -device virtio-serial-pci,id=3Dvirti=
o-serial0,bus=3Dpci.0,addr=3D0x5 -drive file=3D/storage/storage-ssd-vms/vir=
tual_machines_ssd/docker01.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio=
-disk0,cache=3Dnone,aio=3Dthreads -device virtio-blk-pci,scsi=3Doff,bus=3Dp=
ci.0,addr=3D0x6,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 =
-netdev tap,fd=3D35,id=3Dhostnet0,vhost=3Don,vhostfd=3D45 -device virtio-ne=
t-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:1c:af:ce,bus=3Dpci.0,addr=
=3D0x3 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharseria=
l0,id=3Dserial0 -chardev socket,id=3Dcharchannel0,path=3D/var/lib/libvirt/q=
emu/channel/target/domain-24-DOCKER01/org.qemu.guest_agent.0,server,nowait =
-device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0=
,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 -chardev spicevmc,id=3Dcharcha=
nnel1,name=3Dvdagent -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,c=
hardev=3Dcharchannel1,id=3Dchannel1,name=3Dcom.redhat.spice.0 -device usb-t=
ablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice port=3D5905,addr=3D127.0.0.1,=
disable-ticketing,seamless-migration=3Don -device qxl-vga,id=3Dvideo0,ram_s=
ize=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D16,max_o=
utputs=3D1,bus=3Dpci.0,addr=3D0x2 -chardev spicevmc,id=3Dcharredir0,name=3D=
usbredir -device usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,por=
t=3D2 -chardev spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-redir,c=
hardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virtio-balloon=
-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 -object rng-random,id=3Dobjrng0,f=
ilename=3D/dev/random -device virtio-rng-pci,rng=3Dobjrng0,id=3Drng0,bus=3D=
pci.0,addr=3D0x8 -msg timestamp=3Don
>
> For what it worth, the same guests were working fine for years on Hyper-V=
 on the same hardware (Intel Xeon E3, 32GB RAM, Supermicro mainboard, 6x3TB=
 Western Digital Red disks and 6x120MB Kingston V300 SSD all connected to a=
 LSI LSISAS2008 controller).
> Except for this stability issue that I hope to solve everything else is w=
orking great and outperforming Hyper-V.
>
> Any ideas, thoughts or suggestions to try to narrow down the problem?

Would you be able to enhance the error message and rebuild QEMU?

--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -856,7 +856,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     max =3D vq->vring.num;

     if (vq->inuse >=3D vq->vring.num) {
-        virtio_error(vdev, "Virtqueue size exceeded");
+        virtio_error(vdev, "Virtqueue %u device %s size exceeded",
vq->queue_index, vdev->name);
         goto done;
     }

This would at least confirm the theory that it's caused by virtio-blk-pci.

If rebuilding is not feasible I would start by removing other virtio
devices -- particularly balloon which has had quite a few virtio
related bugs fixed recently.

Does your environment involve VM migrations or saving/resuming, or
does the crashing QEMU process always run the VM from its boot?

Thanks!

> Thanks in advance and sorry for the long email but I wanted to be as desc=
riptive as possible.
>
> Fer
