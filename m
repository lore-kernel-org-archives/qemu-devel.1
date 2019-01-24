Received: from eggs.gnu.org ([209.51.188.92]:44194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmcZH-0008KI-8B
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmcZF-0004d8-3Y
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:49:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gmcZE-0004au-Oo
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:49:04 -0500
References: <0259E1C966E8C54AA93AA2B1240828E65D04F94E@dggeml509-mbx.china.huawei.com>
	<20190124102637.GE4764@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e8bf907-f8db-96e4-551e-a332b42de3ec@redhat.com>
Date: Thu, 24 Jan 2019 11:48:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190124102637.GE4764@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tjIhLTbDTc84RiTkZrmgG1efttHnh0BVl"
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
To: Stefan Hajnoczi <stefanha@gmail.com>, "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Yanzheng (A)" <yanzheng759@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, yinyipeng <yinyipeng1@huawei.com>, "dengkai (A)" <dengkai1@huawei.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tjIhLTbDTc84RiTkZrmgG1efttHnh0BVl
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Yanzheng (A)" <yanzheng759@huawei.com>,
 "Huangweidong (C)" <weidong.huang@huawei.com>,
 yinyipeng <yinyipeng1@huawei.com>, "dengkai (A)" <dengkai1@huawei.com>,
 jsnow@redhat.com
Message-ID: <4e8bf907-f8db-96e4-551e-a332b42de3ec@redhat.com>
Subject: Re: [Qemu-devel] 'sys_rawio' selinux alarm triggered while doing SCSI
 reservation inside the guest
References: <0259E1C966E8C54AA93AA2B1240828E65D04F94E@dggeml509-mbx.china.huawei.com>
 <20190124102637.GE4764@stefanha-x1.localdomain>
In-Reply-To: <20190124102637.GE4764@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 24/01/19 11:26, Stefan Hajnoczi wrote:
> On Thu, Jan 24, 2019 at 01:32:49AM +0000, Zhangbo (Oscar) wrote:
>> When performing SCSI reservation inside the guest, 'sys_rawio' selinux=
 alarm is triggered, shown as below:
>> "type=3DAVC msg=3Daudit(1548231520.416:8086): avc: denied { sys_rawio =
} for pid=3D30357 comm=3D"worker" capability=3D17 scontext=3Dsystem_u:sys=
tem_r:svirt_t:s0:c72,c348 tcontext=3Dsystem_u:system_r:svirt_t:s0:c72,c34=
8 tclass=3Dcapability"
>>
>> It's quite possible that the *ioctl SG_IO * caused this problem.
>> Is it a design flaw in qemu? Ioctl SG_IO seems too privileged for qemu=
?
>=20
> CCing Paolo and John for SCSI.
>=20
>>
>> Here comes the possible solutions:
>>   possible solution 1: Add an selinux policy boolean to allow the 'sys=
_rawio' action, which suggests that this scenario is not a problem/design=
 flaw indeed.
>>   possible solution 2: reconstruct the SCSI-related action scheme insi=
de qemu? such as letting libvirtd to accomplish such SG_IO job.
>> Or, otherwise, any other solutions can you suggest? Thanks!

The latest QEMU already has qemu-pr-helper in order to support this.
libvirt will start the helper and tell QEMU to redirect reservations ther=
e.

You need to add "<reservations managed=3D'yes'/>" inside the <source>
element of the disk.

Thanks,

Paolo

>>
>>
>> reproduction:
>> libvirt version: lastest
>> qemu version: lastest
>> selinux mode: Permissive
>> service auditd status: active(running)
>>
>> step 1. Configure scsi disk for vm in xml.
>> <controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
>> <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x07' fun=
ction=3D'0x0'/>
>> </controller>
>> <disk type=3D'block' device=3D'lun' rawio=3D'yes'>
>> <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/>
>> <source dev=3D'/dev/sdo'/>
>> <target dev=3D'sda' bus=3D'scsi'/>
>> <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' unit=3D=
'0'/>
>> </disk>
>>
>> step 2. Define and start vm.
>> The type of guest OS is not the key. here is centos-7.4
>>
>> step 3. Perform SCSI reservation command inside the guest.
>> # sg_persist -o -n -I -K 123abc -S 0 -d /dev/sda
>> # sg_persist -n -o -L -K 123abc -T 5 -d /dev/sda
>> # sg_persist -o -n -I -K 123abc -S 0 -d /dev/sda
>> # sg_persist -o -n -I -S 123abc -d /dev/sda
>> # sg_persist -i -n -k -d /dev/sda
>> # sg_persist -n -o -R -T 5 -K 123abc -d /dev/sda
>> # sg_persist -n -i -r -d /dev/sda
>> # sg_persist -n -o -L -K 123abc -T 5 -d /dev/sda
>>
>> Then we can read 'sys_rawio' SElinux Denied in /var/log/audit/audit.lo=
g
>> type=3DAVC msg=3Daudit(1548231520.416:8086): avc: denied { sys_rawio }=
 for pid=3D30357 comm=3D"worker" capability=3D17 scontext=3Dsystem_u:syst=
em_r:svirt_t:s0:c72,c348 tcontext=3Dsystem_u:system_r:svirt_t:s0:c72,c348=
 tclass=3Dcapability
>>



--tjIhLTbDTc84RiTkZrmgG1efttHnh0BVl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlxJmBkACgkQv/vSX3jH
roPFyQf/Z7w0dI564/Pqy6Gn93V32xa0wyza7+CWsFAaflWo6izIfDAsHap4ZUZF
DjLEQkGLuBQyhjQk87LswtmZ849RiuX9A95lZmEoSZg3guF+WWYp6i9pO7nPPiiB
FieHo6f1UAIIeBRtd6EpJqBZzA2enVSg3tRFPvXYdbtOFEbR3RVr7L3PPJIjAE/3
D5gEPJwTwfXXdZ9Kx4YVstgLpowiJXSfFjoPp4kR1RK+2ZzfEtYBQrZDxftTmknP
BAwq+9juBsmRoFPXl/FCseH/CfYd/bv8+jpcFSI44X6pW5+zAlXWUbg73Jxr0VdX
xNgFLrejXC60r2L0+y//gmEZh9KwAQ==
=izON
-----END PGP SIGNATURE-----

--tjIhLTbDTc84RiTkZrmgG1efttHnh0BVl--
