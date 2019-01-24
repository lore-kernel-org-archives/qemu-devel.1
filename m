Received: from eggs.gnu.org ([209.51.188.92]:37066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmcDa-0007nT-Mq
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmcDY-0003NT-Pa
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:26:42 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gmcDY-0003Iu-ED
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:26:40 -0500
Received: by mail-wm1-x32e.google.com with SMTP id b11so2537597wmj.1
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 02:26:39 -0800 (PST)
Date: Thu, 24 Jan 2019 10:26:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190124102637.GE4764@stefanha-x1.localdomain>
References: <0259E1C966E8C54AA93AA2B1240828E65D04F94E@dggeml509-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <0259E1C966E8C54AA93AA2B1240828E65D04F94E@dggeml509-mbx.china.huawei.com>
Subject: Re: [Qemu-devel] 'sys_rawio' selinux alarm triggered while doing
 SCSI reservation inside the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Yanzheng (A)" <yanzheng759@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, yinyipeng <yinyipeng1@huawei.com>, "dengkai (A)" <dengkai1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, jsnow@redhat.com


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 01:32:49AM +0000, Zhangbo (Oscar) wrote:
> When performing SCSI reservation inside the guest, 'sys_rawio' selinux al=
arm is triggered, shown as below:
> "type=3DAVC msg=3Daudit(1548231520.416:8086): avc: denied { sys_rawio } f=
or pid=3D30357 comm=3D"worker" capability=3D17 scontext=3Dsystem_u:system_r=
:svirt_t:s0:c72,c348 tcontext=3Dsystem_u:system_r:svirt_t:s0:c72,c348 tclas=
s=3Dcapability"
>=20
> It's quite possible that the *ioctl SG_IO * caused this problem.
> Is it a design flaw in qemu? Ioctl SG_IO seems too privileged for qemu?

CCing Paolo and John for SCSI.

>=20
> Here comes the possible solutions:
>   possible solution 1: Add an selinux policy boolean to allow the 'sys_ra=
wio' action, which suggests that this scenario is not a problem/design flaw=
 indeed.
>   possible solution 2: reconstruct the SCSI-related action scheme inside =
qemu? such as letting libvirtd to accomplish such SG_IO job.
> Or, otherwise, any other solutions can you suggest? Thanks!
>=20
>=20
> reproduction:
> libvirt version: lastest
> qemu version: lastest
> selinux mode: Permissive
> service auditd status: active(running)
>=20
> step 1. Configure scsi disk for vm in xml.
> <controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
> <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x07' functi=
on=3D'0x0'/>
> </controller>
> <disk type=3D'block' device=3D'lun' rawio=3D'yes'>
> <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/>
> <source dev=3D'/dev/sdo'/>
> <target dev=3D'sda' bus=3D'scsi'/>
> <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' unit=3D'0=
'/>
> </disk>
>=20
> step 2. Define and start vm.
> The type of guest OS is not the key. here is centos-7.4
>=20
> step 3. Perform SCSI reservation command inside the guest.
> # sg_persist -o -n -I -K 123abc -S 0 -d /dev/sda
> # sg_persist -n -o -L -K 123abc -T 5 -d /dev/sda
> # sg_persist -o -n -I -K 123abc -S 0 -d /dev/sda
> # sg_persist -o -n -I -S 123abc -d /dev/sda
> # sg_persist -i -n -k -d /dev/sda
> # sg_persist -n -o -R -T 5 -K 123abc -d /dev/sda
> # sg_persist -n -i -r -d /dev/sda
> # sg_persist -n -o -L -K 123abc -T 5 -d /dev/sda
>=20
> Then we can read 'sys_rawio' SElinux Denied in /var/log/audit/audit.log
> type=3DAVC msg=3Daudit(1548231520.416:8086): avc: denied { sys_rawio } fo=
r pid=3D30357 comm=3D"worker" capability=3D17 scontext=3Dsystem_u:system_r:=
svirt_t:s0:c72,c348 tcontext=3Dsystem_u:system_r:svirt_t:s0:c72,c348 tclass=
=3Dcapability
>=20

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcSZLdAAoJEJykq7OBq3PIwmgIAJkfEtnaZAVgkkGgNu8/doZH
YOW4Pi/M4M+bjbmbeAOLp3CTXPZN2FCbuN+/mmUyYMb7YiG02Gj30NiayJm4opBL
4hH5XB3H5U2f2YMdEfO5qEhKMhLMgcnZ8CXnaxVWQcyE/JGE4Xsiv7WgG0v9kCSb
4m6ivWqyKurz5BxDT6h2cVaWYhsXuSVHoU77iN/xwG6Bdnze8CcsmsII2rBxQpUo
C32Njua7IJPHgmMQICYI4gAAyHztiEeEE5iyeKU2BS3y0G147jplaGuGdmBTkxN6
0XLMoaxt8MBxBwif6sMi3XWnS7U6+4RsabhRpH4VJybCwkNCA8TIO0M5Z6b0YkE=
=jL+1
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
