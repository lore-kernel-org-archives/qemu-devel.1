Received: from eggs.gnu.org ([209.51.188.92]:42531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <oscar.zhangbo@huawei.com>) id 1gmUGU-0007JD-UK
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <oscar.zhangbo@huawei.com>) id 1gmU8K-0006tD-J6
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:48:46 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2053 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <oscar.zhangbo@huawei.com>)
	id 1gmU8K-0006Ws-8O
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 20:48:44 -0500
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.54])
	by Forcepoint Email with ESMTP id 2FA95232A576CFA8BF6C
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 09:32:59 +0800 (CST)
From: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
Date: Thu, 24 Jan 2019 01:32:49 +0000
Message-ID: <0259E1C966E8C54AA93AA2B1240828E65D04F94E@dggeml509-mbx.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] 'sys_rawio' selinux alarm triggered while doing SCSI
 reservation inside the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: yinyipeng <yinyipeng1@huawei.com>, "Yanzheng (A)" <yanzheng759@huawei.com>, "dengkai (A)" <dengkai1@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

When performing SCSI reservation inside the guest, 'sys_rawio' selinux alar=
m is triggered, shown as below:
"type=3DAVC msg=3Daudit(1548231520.416:8086): avc: denied { sys_rawio } for=
 pid=3D30357 comm=3D"worker" capability=3D17 scontext=3Dsystem_u:system_r:s=
virt_t:s0:c72,c348 tcontext=3Dsystem_u:system_r:svirt_t:s0:c72,c348 tclass=
=3Dcapability"

It's quite possible that the *ioctl SG_IO * caused this problem.
Is it a design flaw in qemu? Ioctl SG_IO seems too privileged for qemu?

Here comes the possible solutions:
  possible solution 1: Add an selinux policy boolean to allow the 'sys_rawi=
o' action, which suggests that this scenario is not a problem/design flaw i=
ndeed.
  possible solution 2: reconstruct the SCSI-related action scheme inside qe=
mu? such as letting libvirtd to accomplish such SG_IO job.
Or, otherwise, any other solutions can you suggest? Thanks!


reproduction:
libvirt version: lastest
qemu version: lastest
selinux mode: Permissive
service auditd status: active(running)

step 1. Configure scsi disk for vm in xml.
<controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
<address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x07' function=
=3D'0x0'/>
</controller>
<disk type=3D'block' device=3D'lun' rawio=3D'yes'>
<driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/>
<source dev=3D'/dev/sdo'/>
<target dev=3D'sda' bus=3D'scsi'/>
<address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' unit=3D'0'/=
>
</disk>

step 2. Define and start vm.
The type of guest OS is not the key. here is centos-7.4

step 3. Perform SCSI reservation command inside the guest.
# sg_persist -o -n -I -K 123abc -S 0 -d /dev/sda
# sg_persist -n -o -L -K 123abc -T 5 -d /dev/sda
# sg_persist -o -n -I -K 123abc -S 0 -d /dev/sda
# sg_persist -o -n -I -S 123abc -d /dev/sda
# sg_persist -i -n -k -d /dev/sda
# sg_persist -n -o -R -T 5 -K 123abc -d /dev/sda
# sg_persist -n -i -r -d /dev/sda
# sg_persist -n -o -L -K 123abc -T 5 -d /dev/sda

Then we can read 'sys_rawio' SElinux Denied in /var/log/audit/audit.log
type=3DAVC msg=3Daudit(1548231520.416:8086): avc: denied { sys_rawio } for =
pid=3D30357 comm=3D"worker" capability=3D17 scontext=3Dsystem_u:system_r:sv=
irt_t:s0:c72,c348 tcontext=3Dsystem_u:system_r:svirt_t:s0:c72,c348 tclass=
=3Dcapability
