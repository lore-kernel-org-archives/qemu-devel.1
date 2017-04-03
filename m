Received: from eggs.gnu.org ([2001:4830:134:3::10]:57481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv7Oa-0004Dj-R0
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv7OV-0001lI-PO
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:12:08 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cv7OV-0001kB-Fj
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:12:03 -0400
Received: by mail-wr0-x242.google.com with SMTP id k6so34816185wre.3
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 12:12:03 -0700 (PDT)
Date: Mon, 3 Apr 2017 20:11:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170403191158.GI3539@stefanha-x1.localdomain>
References: <58DEB834.6060405@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TKDEsImF70pdVIl+"
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
Cc: qemu-devel@nongnu.org, Ladi Prosek <lprosek@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--TKDEsImF70pdVIl+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 02:12:36PM -0600, Chris Friesen wrote:
> I'm running into an issue with live-migrating a guest from a host running
> qemu-kvm-ev 2.3.0-31 to a host running qemu-kvm-ev 2.6.0-27.1.  This is a
> libvirt-tunnelled migration, in the context of upgrading an OpenStack
> install to newer software.  The source host is running CentOS 7.2.1511,
> while the dest host is running CentOS 7.3.1611.
>=20
> I'll include the qemu commandlines for the source/dest at the bottom.
>=20
> Initially we have a bunch of guests running on compute-2 (which is running
> qemu-kvm-ev 2.3.0).  We then started live-migrating them one at a time to
> compute-0 (which is running qemu-kvm-ev 2.6.0).  Three of them migrated
> successfully.  The fourth (which was essentially identical in configurati=
on
> to the first three) failed, as per the following logs in
> /var/log/libvirt/qemu/instance-0000000e.log:
>=20
>=20
> 2017-03-29T06:38:37.886940Z qemu-kvm: VQ 2 size 0x80 < last_avail_idx 0x4=
7b
> - used_idx 0x47c
> 2017-03-29T06:38:37.886974Z qemu-kvm: error while loading state for insta=
nce
> 0x0 of device '0000:00:07.0/virtio-balloon'
> 2017-03-29T06:38:37.888684Z qemu-kvm: load of migration failed: Operation
> not permitted
> 2017-03-29 06:38:37.896+0000: shutting down
>=20
>=20
> Does anyone know of an existing bug report covering this issue?  (I took a
> look and didn't see anything obviously related.)

This is the virtio-balloon device.  If you remove the device the live
migration should work reliably.

Alternatively, you can temporarily rmmod virtio_balloon inside the guest
for live migration.  After migration you can modprobe virtio_balloon
again.

last_avail_idx 0x47b with used_idx 0x47c is an invalid device state.
I've diffed qemu-kvm-ev 2.6.0-27.1 hw/virtio/virtio-balloon.c against
qemu.git/master and do not see an obvious bug.  I also compared
qemu-kvm-ev 2.3.0-31 with qemu-kvm-ev 2.6.0-27.1.

>=20
>=20
> The qemu commandline on the source compute node is:
>=20
>=20
> /usr/libexec/qemu-kvm -c 0x00000000000000000000000000000001 -n 4
> --proc-type=3Dsecondary --file-prefix=3Dvs -- -enable-dpdk -name
> instance-0000000e -S -machine pc-i440fx-rhel7.2.0,accel=3Dkvm,usb=3Doff -=
m 512
> -realtime mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -object me=
mory-backend-file,id=3Dram-node0,prealloc=3Dyes,mem-path=3D/mnt/huge-2048kB=
/libvirt/qemu,share=3Dyes,size=3D536870912,host-nodes=3D1,policy=3Dbind
> -numa node,nodeid=3D0,cpus=3D0,memdev=3Dram-node0 -uuid
> 57ae849f-aa66-422a-90a2-62db6c59db29 -smbios type=3D1,manufacturer=3DFedo=
ra
> Project,product=3DOpenStack Nova,version=3D13.0.0-0.tis.4,serial=3D4c8121=
f1-d927-424e-8712-88b1de45be37,uuid=3D57ae849f-aa66-422a-90a2-62db6c59db29,=
family=3DVirtual
> Machine -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=
=3D/var/lib/libvirt/qemu/domain-instance-0000000e/monitor.sock,server,nowait
> -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,dr=
iftfix=3Dslew
> -global kvm-pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -boot
> reboot-timeout=3D5000,strict=3Don -device
> piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/dev/dis=
k/by-path/ip-192.168.205.6:3260-iscsi-iqn.2010-10.org.openstack:volume-ac57=
fcaa-7ecd-4d3b-8671-3bc740337a42-lun-0,if=3Dnone,id=3Ddrive-virtio-disk0,fo=
rmat=3Draw,serial=3Dac57fcaa-7ecd-4d3b-8671-3bc740337a42,cache=3Dnone,aio=
=3Dnative
> -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x6,drive=3Ddrive-vi=
rtio-disk0,id=3Dvirtio-disk0,bootindex=3D1
> -chardev socket,id=3Dcharnet0,path=3D/var/run/vswitch/usvhost-9e574d3c-32=
dd-4d39-97e6-447b15fb00b4
> -netdev type=3Dvhost-user,id=3Dhostnet0,chardev=3Dcharnet0 -device virtio=
-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3Dfa:16:3e:b0:59:a9,bus=3Dpci.0,ad=
dr=3D0x3
> -chardev socket,id=3Dcharnet1,path=3D/var/run/vswitch/usvhost-7bc48d91-f2=
15-4394-99ff-eb7f20d9ff1e
> -netdev type=3Dvhost-user,id=3Dhostnet1,chardev=3Dcharnet1 -device virtio=
-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3Dfa:16:3e:8b:6f:09,bus=3Dpci.0,ad=
dr=3D0x4
> -chardev socket,id=3Dcharnet2,path=3D/var/run/vswitch/usvhost-c32e2d0d-9e=
d4-4f4b-abc9-539a12a86008
> -netdev type=3Dvhost-user,id=3Dhostnet2,chardev=3Dcharnet2 -device virtio=
-net-pci,netdev=3Dhostnet2,id=3Dnet2,mac=3Dfa:16:3e:07:ca:a0,bus=3Dpci.0,ad=
dr=3D0x5
> -chardev file,id=3Dcharserial0,path=3D/etc/nova/instances/57ae849f-aa66-4=
22a-90a2-62db6c59db29/console.log
> -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
> pty,id=3Dcharserial1 -device isa-serial,chardev=3Dcharserial1,id=3Dserial=
1 -device
> usb-tablet,id=3Dinput0 -vnc 0.0.0.0:11 -k en-us -device
> cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -incoming fd:25 -device
> virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 -msg timestamp=3D=
on
>=20
>=20
>=20
> The complete instance-0000000e.log file on the destination is:
>=20
> 2017-03-29 06:38:35.962+0000: starting up libvirt version: 2.0.0, package:
> 10.el7_3.2.tis.24 (Unknown, 2017-03-15-14:59:22,
> yow-dsulliva-lx-vm1.wrs.com), qemu version: 2.6.0
> (qemu-kvm-ev-2.6.0-27.1.el7.tis.31), hostname: compute-0
> LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
> QEMU_AUDIO_DRV=3Dnone /usr/libexec/qemu-kvm '-c
> 0x00000000000000000000000000000001' '-n 4' --proc-type=3Dsecondary
> --file-prefix=3Dvs -- -enable-dpdk -name
> guest=3Dinstance-0000000e,debug-threads=3Don -S -object secret,id=3Dmaste=
rKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-10-instance-0000000e=
/master-key.aes
> -machine pc-i440fx-rhel7.2.0,accel=3Dkvm,usb=3Doff -m 512 -realtime mlock=
=3Doff
> -smp 1,sockets=3D1,cores=3D1,threads=3D1 -object memory-backend-file,id=
=3Dram-node0,prealloc=3Dyes,mem-path=3D/mnt/huge-2048kB/libvirt/qemu,share=
=3Dyes,size=3D536870912,host-nodes=3D0,policy=3Dbind
> -numa node,nodeid=3D0,cpus=3D0,memdev=3Dram-node0 -uuid
> 57ae849f-aa66-422a-90a2-62db6c59db29 -smbios 'type=3D1,manufacturer=3DFed=
ora
> Project,product=3DOpenStack Nova,version=3D13.0.0-0.tis.4,serial=3D4c8121=
f1-d927-424e-8712-88b1de45be37,uuid=3D57ae849f-aa66-422a-90a2-62db6c59db29,=
family=3DVirtual
> Machine' -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,pat=
h=3D/var/lib/libvirt/qemu/domain-10-instance-0000000e/monitor.sock,server,n=
owait
> -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,dr=
iftfix=3Dslew
> -global kvm-pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -boot
> reboot-timeout=3D5000,strict=3Don -device
> piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/dev/dis=
k/by-path/ip-192.168.205.6:3260-iscsi-iqn.2010-10.org.openstack:volume-ac57=
fcaa-7ecd-4d3b-8671-3bc740337a42-lun-0,format=3Draw,if=3Dnone,id=3Ddrive-vi=
rtio-disk0,serial=3Dac57fcaa-7ecd-4d3b-8671-3bc740337a42,cache=3Dnone,aio=
=3Dnative
> -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x6,drive=3Ddrive-vi=
rtio-disk0,id=3Dvirtio-disk0,bootindex=3D1
> -chardev socket,id=3Dcharnet0,path=3D/var/run/vswitch/usvhost-9e574d3c-32=
dd-4d39-97e6-447b15fb00b4
> -netdev type=3Dvhost-user,id=3Dhostnet0,chardev=3Dcharnet0 -device virtio=
-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3Dfa:16:3e:b0:59:a9,bus=3Dpci.0,ad=
dr=3D0x3
> -chardev socket,id=3Dcharnet1,path=3D/var/run/vswitch/usvhost-7bc48d91-f2=
15-4394-99ff-eb7f20d9ff1e
> -netdev type=3Dvhost-user,id=3Dhostnet1,chardev=3Dcharnet1 -device virtio=
-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3Dfa:16:3e:8b:6f:09,bus=3Dpci.0,ad=
dr=3D0x4
> -chardev socket,id=3Dcharnet2,path=3D/var/run/vswitch/usvhost-c32e2d0d-9e=
d4-4f4b-abc9-539a12a86008
> -netdev type=3Dvhost-user,id=3Dhostnet2,chardev=3Dcharnet2 -device virtio=
-net-pci,netdev=3Dhostnet2,id=3Dnet2,mac=3Dfa:16:3e:07:ca:a0,bus=3Dpci.0,ad=
dr=3D0x5
> -add-fd set=3D0,fd=3D51 -chardev file,id=3Dcharserial0,path=3D/dev/fdset/=
0,append=3Don
> -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
> pty,id=3Dcharserial1 -device isa-serial,chardev=3Dcharserial1,id=3Dserial=
1 -device
> usb-tablet,id=3Dinput0 -vnc 0.0.0.0:9 -k en-us -device
> cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -incoming defer -device
> virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 -msg timestamp=3D=
on
> Domain id=3D10 is tainted: high-privileges
> EAL:eal_memory.c:1591: WARNING: Address Space Layout Randomization (ASLR)=
 is
> enabled in the kernel.
> EAL:eal_memory.c:1593:    This may cause issues with mapping memory into
> secondary processes
> char device redirected to /dev/pts/9 (label charserial1)
> 2017-03-29T06:38:37.886940Z qemu-kvm: VQ 2 size 0x80 < last_avail_idx 0x4=
7b
> - used_idx 0x47c
> 2017-03-29T06:38:37.886974Z qemu-kvm: error while loading state for insta=
nce
> 0x0 of device '0000:00:07.0/virtio-balloon'
> 2017-03-29T06:38:37.888684Z qemu-kvm: load of migration failed: Operation
> not permitted
> 2017-03-29 06:38:37.896+0000: shutting down
>=20
>=20
> For what it's worth, the differences between the two qemu command lines a=
re
> as follows:
>=20
> source:
> -name instance-0000000e -chardev file,id=3Dcharserial0,path=3D/etc/nova/i=
nstances/57ae849f-aa66-422a-90a2-62db6c59db29/console.log
> -vnc 0.0.0.0:9 -incoming fd:25
>=20
> destination:
> -name guest=3Dinstance-0000000e,debug-threads=3Don -object secret,id=3Dma=
sterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-10-instance-00000=
00e/master-key.aes
> -add-fd set=3D0,fd=3D51 -chardev file,id=3Dcharserial0,path=3D/dev/fdset/=
0,append=3Don
> -vnc 0.0.0.0:11 -incoming defer
>=20
> Thanks,
> Chris
>=20

--TKDEsImF70pdVIl+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY4p5+AAoJEJykq7OBq3PIJ1EIAL995HNd+oxcSO2YvqRGKvq8
JPp2s+GkDPUkuZi17cPe5Hbe7CanmbosmeMyI5ftvemfWy+sys/3A6edzHGtp1Jv
YrH4VSMGqy79VYFvDBhgeCeApWw667kdKmJANshxk0RpuLIUFsTIYHdLign7+Gdh
1zSt6+p+sSqlhsOl9QcO8LVcHGIoKG4rbeIuNemzr3yUDNTPJI64lvpTXt0SqMTr
5QNb32iATLASBvL/UqSBiyqGCxm43bh19uZVGtt0z00NhC70uSCajHC1zt6xMG/O
FmN0rjH8Gya8fjWchKUsY9pjkke/k3T8UF5Qwxd5bXt8oYKNUvzHCuzdmiqs+/M=
=LHSX
-----END PGP SIGNATURE-----

--TKDEsImF70pdVIl+--
