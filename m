Received: from eggs.gnu.org ([2001:4830:134:3::10]:58891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX32U-0000JL-OZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX32P-0007JU-MT
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:14:06 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dX32P-0007Ih-Cl
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:14:01 -0400
Received: by mail-wm0-x236.google.com with SMTP id b134so42681998wma.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 03:14:01 -0700 (PDT)
Date: Mon, 17 Jul 2017 11:13:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170717101357.GG7163@stefanha-x1.localdomain>
References: <AT5PR84MB0164562E6BDB62601F376F87A0AD0@AT5PR84MB0164.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eMnpOGXCMazMAbfp"
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


--eMnpOGXCMazMAbfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 04:28:12AM +0000, Nagarajan, Padhu (HPE Storage) wr=
ote:
> During an 8K random-read fio benchmark, we observed poor performance insi=
de the guest in comparison to the performance seen on the host block device=
=2E The table below shows the IOPS on the host and inside the guest with bo=
th virtioscsi (scsimq) and virtioblk (blkmq).
>=20
> -----------------------------------
> config        | IOPS  | fio gst hst
> -----------------------------------
> host-q32-t1   | 79478 | 401     271

hst->fio adds 200 microseconds of latency/request?  That seems very
high.

> scsimq-q8-t4  | 45958 | 693 639 351
> blkmq-q8-t4   | 49247 | 647 589 308

The gst->fio latency is much lower than hst->fio in the host-q32-t1
case.  Strange unless the physical HBA driver is very slow or you have a
md or device mapper configuration on the host but not the guest.

What is the storage configuration (guest, host, and hardware)?

Please also look at the latency percentiles in the fio output.  It's
possible that the latency distribution is very different from a normal
distribution and the mean latency isn't very meaningful.

> -----------------------------------
> host-q48-t1   | 85599 | 559     291
> scsimq-q12-t4 | 50237 | 952 807 358
> blkmq-q12-t4  | 54016 | 885 786 329
> -----------------------------------
> fio gst hst =3D> latencies in usecs, as
>                seen by fio, guest and
>                host block layers.
> q8-t4 =3D> qdepth=3D8, numjobs=3D4
> host  =3D> fio run directly on the host
> scsimq,blkmq =3D> fio run inside the guest
>=20
> Shouldn't we get a much better performance inside the guest ?
>=20
> When fio inside the guest was generating 32 outstanding IOs, iostat on th=
e host shows avgqu-sz of only 16. For 48 outstanding IOs inside the guest, =
avgqu-sz on the host was only marginally better.

The latency numbers you posted support the qvgqu-sz result.  fio - hst
is roughly equal to hst.  If the software overhead is ~50% of the entire
request duration, then it makes sense that the host queue size is 50% of
the desired benchmark queue size.

>=20
> qemu command line: qemu-system-x86_64 -L /usr/share/seabios/ -name node1,=
debug-threads=3Don -name node1 -S -machine pc,accel=3Dkvm,usb=3Doff -cpu Sa=
ndyBridge -m 7680 -realtime mlock=3Doff -smp 4,sockets=3D4,cores=3D1,thread=
s=3D1 -object iothread,id=3Diothread1 -object iothread,id=3Diothread2 -obje=
ct iothread,id=3Diothread3 -object iothread,id=3Diothread4 -uuid XX -nograp=
hic -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/va=
r/lib/libvirt/qemu/node1.monitor,server,nowait -mon chardev=3Dcharmonitor,i=
d=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -global kvm-pit.=
lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -boot strict=3Don -device =
piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device lsi,id=3Dscsi0,b=
us=3Dpci.0,addr=3D0x6 -device virtio-scsi-pci,ioeventfd=3Don,num_queues=3D4=
,iothread=3Diothread2,id=3Dscsi1,bus=3Dpci.0,addr=3D0x7 -device virtio-scsi=
-pci,ioeventfd=3Don,num_queues=3D4,iothread=3Diothread2,id=3Dscsi2,bus=3Dpc=
i.0,addr=3D0x8 -drive file=3Drhel7.qcow2,if=3Dnone,id=3Ddrive-virtio-disk0,=
format=3Dqcow2 -device virtio-blk-pci,ioeventfd=3Don,num-queues=3D4,iothrea=
d=3Diothread1,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-disk0,=
id=3Dvirtio-disk0,bootindex=3D1 -drive file=3D/dev/sdc,if=3Dnone,id=3Ddrive=
-virtio-disk1,format=3Draw,cache=3Dnone,aio=3Dnative -device virtio-blk-pci=
,ioeventfd=3Don,num-queues=3D4,iothread=3Diothread1,iothread=3Diothread1,sc=
si=3Doff,bus=3Dpci.0,addr=3D0x17,drive=3Ddrive-virtio-disk1,id=3Dvirtio-dis=
k1 -drive file=3D/dev/sdc,if=3Dnone,id=3Ddrive-scsi1-0-0-0,format=3Draw,cac=
he=3Dnone,aio=3Dnative -device scsi-hd,bus=3Dscsi1.0,channel=3D0,scsi-id=3D=
0,lun=3D0,drive=3Ddrive-scsi1-0-0-0,id=3Dscsi1-0-0-0 -netdev tap,fd=3D24,id=
=3Dhostnet0,vhost=3Don,vhostfd=3D25 -device virtio-net-pci,netdev=3Dhostnet=
0,id=3Dnet0,mac=3DXXX,bus=3Dpci.0,addr=3D0x2 -netdev tap,fd=3D26,id=3Dhostn=
et1,vhost=3Don,vhostfd=3D27 -device virtio-net-pci,netdev=3Dhostnet1,id=3Dn=
et1,mac=3DYYY,bus=3Dpci.0,multifunction=3Don,addr=3D0x15 -netdev tap,fd=3D2=
8,id=3Dhostnet2,vhost=3Don,vhostfd=3D29 -device virtio-net-pci,netdev=3Dhos=
tnet2,id=3Dnet2,mac=3DZZZ,bus=3Dpci.0,multifunction=3Don,addr=3D0x16 -chard=
ev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=3Dseria=
l0 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x3 -msg tim=
estamp=3Don

Are you pinning vcpus and iothreads so that the physical HBA interrupts
are processed by the same host CPU as the vcpu/iothread?

> fio command line: /tmp/fio --time_based --ioengine=3Dlibaio --randrepeat=
=3D1 --direct=3D1 --invalidate=3D1 --verify=3D0 --offset=3D0 --verify_fatal=
=3D0 --group_reporting --numjobs=3D$jobs --name=3Drandread --rw=3Drandread =
--blocksize=3D8K --iodepth=3D$qd --runtime=3D60 --filename=3D{/dev/vdb or /=
dev/sda}
>=20
> # qemu-system-x86_64 --version
> QEMU emulator version 2.8.0(Debian 1:2.8+dfsg-3~bpo8+1)
> Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
>=20
> The guest was running RHEL 7.3 and the host was Debian 8.

--eMnpOGXCMazMAbfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZbI3lAAoJEJykq7OBq3PIKuAIALqyyglGz0bg89QbI7R/Wo+8
ZAMP0NFu5lpQSW+ZJGz/D7nWD+CSm1vZWygVvcs3BGVJlVVRMXO/2iJJCdLy5faZ
Y5Xmy7heSv5qSIF/tgocRG85BOjxPgWwRDRUWYeBSVmyEyU60M1ot2rGDF6LLpQh
iM5qwKy051Tuu87m3YXsjU6IVY2tcLbpeYLmKqBS9ti2r72D2tPQSe6SJJ9VRqKr
pilcH3Mo1bq2iUMo/K2zTZU1MWYiikz3e24XcjDDDOFHUqY8BJkxlTosTGx5RO2j
7VT9tUAu1/scu0Yn8dhxUNhurtj1w6ToHZkDarPlJ3LIqj95hvRIlO3acttZRU8=
=yX+Q
-----END PGP SIGNATURE-----

--eMnpOGXCMazMAbfp--
