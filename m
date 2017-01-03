Received: from eggs.gnu.org ([2001:4830:134:3::10]:37377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cORMV-0001bS-1Q
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cORMR-000586-Fg
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:50:55 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cORMR-00055m-0c
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:50:51 -0500
Received: by mail-wm0-x242.google.com with SMTP id m203so87174760wma.3
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 07:50:50 -0800 (PST)
Date: Tue, 3 Jan 2017 15:50:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170103155047.GE14707@stefanha-x1.localdomain>
References: <CA+scX6=rRiGHsOj8oxjTe4KqEF7S_GUao3k=TUQeE7FpyT_K8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <CA+scX6=rRiGHsOj8oxjTe4KqEF7S_GUao3k=TUQeE7FpyT_K8w@mail.gmail.com>
Subject: Re: [Qemu-devel] Performance about x-data-plane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Weiwei Jia <harrynjit@gmail.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, libvir-list@redhat.com


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 22, 2016 at 01:34:47AM -0500, Weiwei Jia wrote:
> With QEMU x-data-plane, I find the performance has not been improved
> very much. Please see following two settings.

Using IOThreads improves scalability for SMP guests with many disks.  It
does not improve performance for a single disk benchmark because there
is nothing to spread across IOThreads.

> Setting 1: I/O thread in host OS (VMM) reads 4KB each time from disk
> (8GB in total). Pin the I/O thread to pCPU 5 which will serve I/O
> thread dedicatedly. I find the performance is around 250 MB/s.

250 MB/s / 4 KB =3D 64k IOPS

This seems like a reasonable result for single thread with a single
disk.  I guess the benchmark queue depth setting is larger than 1 though
because it would only allow 15 microseconds per request.

> Setting 2: I/O thread in guest OS (VMM) reads 4KB each time from
> virtual disk (8GB in total). Pin the I/O thread to vCPU 5 and pin vCPU
> 5 thread to pCPU5 so that vCPU 5 handles this I/O thread dedicatedly
> and pCPU5 serve vCPU5 dedicatedly. In order to keep vCPU5 not to be
> idle, I also pin one cpu intensive thread (while (1) {i++}) on vCPU 5
> so that the I/O thread on it can be served without delay. For this
> setting, I find the performance for this I/O thread is around 190
> MB/s.

190 MB/s / 4 KB =3D 48k IOPS

I worry that your while (1) {i++} thread may prevent achieving the best
performance if the guest kernel scheduler allows it to use its time
slice.

Two options that might work better are:
1. idle=3Dpoll guest kernel command-line parameter
2. kvm.ko's halt_poll_ns host kernel module parameter

> NOTE: For setting 2, I also pin the QEMU dedicated IOthread
> (x-data-plane) in host OS to pCPU to handle I/O requests from guest OS
> dedicatedly.

Which pCPU did you pin the dataplane thread to?  Did you try changing
this?

> I think for setting 2, the performance of I/O thread should be almost
> the same as setting 1. I cannot understand why it is 60 MB/s lower
> than setting 1. I am wondering whether there are something wrong with
> my x-data-plane setting or virtio setting for VM.  Would you please
> give me some hints? Thank you.

Ideally QEMU should achieve the same performance as bare metal.  In
practice the overhead increases as IOPS increases.  You may be able to
achieve 260 MB/s inside the guest with a larger request size since it
involves fewer I/O requests.

The expensive part is the virtqueue kick.  Recently we tried polling the
virtqueue instead of waiting for the ioeventfd file descriptor and got
double-digit performance improvements:
https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00148.html

If you want to understand the performance of your benchmark you'll have
compare host/guest disk stats (e.g. request lifetime, disk utilization,
queue depth, average request size) to check that the bare metal and
guest workloads are really sending comparable I/O patterns to the
physical disk.

Then you using Linux and/or QEMU tracing to analyze the request latency
by looking at interesting points in the request lifecycle like virtqueue
kick, host Linux AIO io_submit(2), etc.

> Libvirt version: 2.4.0
> QEMU version: 2.3.0
>=20
> The libvirt xml  configuration file is like following (I only start
> one VM with following xml config).
>=20
> <domain type=3D'kvm' id=3D'1'
> xmlns:qemu=3D'http://libvirt.org/schemas/domain/qemu/1.0'>
>   <name>vm</name>
>   <uuid>3290a8d0-9d9f-b2c4-dd46-5d0d8a730cd6</uuid>
>   <memory unit=3D'KiB'>8290304</memory>
>   <currentMemory unit=3D'KiB'>8290304</currentMemory>
>   <vcpu placement=3D'static'>15</vcpu>
>   <cputune>
>     <vcpupin vcpu=3D'0' cpuset=3D'0'/>
>     <vcpupin vcpu=3D'1' cpuset=3D'1'/>
>     <vcpupin vcpu=3D'2' cpuset=3D'2'/>
>     <vcpupin vcpu=3D'3' cpuset=3D'3'/>
>     <vcpupin vcpu=3D'4' cpuset=3D'4'/>
>     <vcpupin vcpu=3D'5' cpuset=3D'5'/>
>     <vcpupin vcpu=3D'6' cpuset=3D'6'/>
>     <vcpupin vcpu=3D'7' cpuset=3D'7'/>
>     <vcpupin vcpu=3D'8' cpuset=3D'8'/>
>     <vcpupin vcpu=3D'9' cpuset=3D'9'/>
>     <vcpupin vcpu=3D'10' cpuset=3D'10'/>
>     <vcpupin vcpu=3D'11' cpuset=3D'11'/>
>     <vcpupin vcpu=3D'12' cpuset=3D'12'/>
>     <vcpupin vcpu=3D'13' cpuset=3D'13'/>
>     <vcpupin vcpu=3D'14' cpuset=3D'14'/>
>   </cputune>
>   <resource>
>     <partition>/machine</partition>
>   </resource>
>   <os>
>     <type arch=3D'x86_64' machine=3D'pc-i440fx-2.2'>hvm</type>
>     <boot dev=3D'hd'/>
>   </os>
>   <features>
>     <acpi/>
>     <apic/>
>     <pae/>
>   </features>
>   <clock offset=3D'utc'/>
>   <on_poweroff>destroy</on_poweroff>
>   <on_reboot>restart</on_reboot>
>   <on_crash>restart</on_crash>
>   <devices>
>     <emulator>/usr/bin/kvm-spice</emulator>
>     <disk type=3D'file' device=3D'disk'>
>       <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/>
>       <source file=3D'/var/lib/libvirt/images/vm.img'/>
>       <target dev=3D'vda' bus=3D'virtio'/>
>       <alias name=3D'virtio-disk0'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06'
> function=3D'0x0'/>
>     </disk>
>     <disk type=3D'block' device=3D'cdrom'>
>       <driver name=3D'qemu' type=3D'raw'/>
>       <target dev=3D'hdc' bus=3D'ide'/>
>       <readonly/>
>       <alias name=3D'ide0-1-0'/>
>       <address type=3D'drive' controller=3D'0' bus=3D'1' target=3D'0' uni=
t=3D'0'/>
>     </disk>
>     <controller type=3D'usb' index=3D'0'>
>       <alias name=3D'usb0'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01'
> function=3D'0x2'/>
>     </controller>
>     <controller type=3D'pci' index=3D'0' model=3D'pci-root'>
>       <alias name=3D'pci.0'/>
>     </controller>
>     <controller type=3D'ide' index=3D'0'>
>       <alias name=3D'ide0'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01'
> function=3D'0x1'/>
>     </controller>
>     <controller type=3D'scsi' index=3D'0'>
>       <alias name=3D'scsi0'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04'
> function=3D'0x0'/>
>     </controller>
>     <interface type=3D'network'>
>       <mac address=3D'52:54:00:8e:3d:06'/>
>       <source network=3D'default'/>
>       <target dev=3D'vnet0'/>
>       <model type=3D'virtio'/>
>       <alias name=3D'net0'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03'
> function=3D'0x0'/>
>     </interface>
>     <serial type=3D'pty'>
>       <source path=3D'/dev/pts/8'/>
>       <target port=3D'0'/>
>       <alias name=3D'serial0'/>
>     </serial>
>     <console type=3D'pty' tty=3D'/dev/pts/8'>
>       <source path=3D'/dev/pts/8'/>
>       <target type=3D'serial' port=3D'0'/>
>       <alias name=3D'serial0'/>
>     </console>
>     <input type=3D'mouse' bus=3D'ps2'/>
>     <input type=3D'keyboard' bus=3D'ps2'/>
>     <graphics type=3D'vnc' port=3D'5900' autoport=3D'yes' listen=3D'127.0=
=2E0.1'>
>       <listen type=3D'address' address=3D'127.0.0.1'/>
>     </graphics>
>     <video>
>       <model type=3D'cirrus' vram=3D'9216' heads=3D'1'/>
>       <alias name=3D'video0'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02'
> function=3D'0x0'/>
>     </video>
>     <memballoon model=3D'virtio'>
>       <alias name=3D'balloon0'/>
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05'
> function=3D'0x0'/>
>     </memballoon>
>   </devices>
>   <seclabel type=3D'none'/>
>   <qemu:commandline>
>     <qemu:arg value=3D'-set'/>
>     <qemu:arg value=3D'device.virtio-disk0.scsi=3Doff'/>
>     <qemu:arg value=3D'-set'/>
>     <qemu:arg value=3D'device.virtio-disk0.config-wce=3Doff'/>
>     <qemu:arg value=3D'-set'/>
>     <qemu:arg value=3D'device.virtio-disk0.x-data-plane=3Don'/>
>   </qemu:commandline>
> </domain>
>=20
>=20
> Thank you,
> Weiwei Jia

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYa8hXAAoJEJykq7OBq3PIZWgH/RR3I5uTO6FW6sgyqoZr7uS3
FrL+/CugierNd1M9ZMxX3GBzF4V9hu4bq+MHzcQarVJAhQKV/cfwrY1GLYbastlD
57tQrDB9ddPm8ovtC8oocfpO3xbG+EgwJrtSde53Z+QEn18krJM3UMciR9dDmCbr
GeMqLILwBBSGqR2q4pUoZeqe44DC03h5zW2ZBoPkYuUmXUsQbMMJuzPphSb7sYzm
/FJDjIdYyNht+El1PiEBjx71U+ySTsBUufrMylm6CpZcu0CX6sbHLZM40Pv/ZqcP
+PVdw3bUBry+Inrh5PPeVdhdqYR0IG6hNv/oQQ8vpAH8B0yujwQuneRVpXNeQqk=
=+wVo
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
