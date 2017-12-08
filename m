Received: from eggs.gnu.org ([2001:4830:134:3::10]:42653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eN8qS-0005Ih-IO
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 21:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eN8qP-0001Bm-HM
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 21:57:00 -0500
Received: from [45.249.212.255] (port=34340 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1eN8qO-00018M-Uc
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 21:56:57 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Fri, 8 Dec 2017 02:10:26 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302C50197@dggemm509-mbx.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [Question] vhost-user: hot-unplug vhost-user nic for
 windows guest OS will fail with 100% reproduce rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "wangxin (U)" <wangxinxin.wang@huawei.com>, "mst@redhat.com" <mst@redhat.com>

Hi, guys

I met a problem when hot-unplug vhost-user nic for Windows 2008 rc2 sp1 64 =
(Guest OS)

The xml of nic is as followed:
<interface type=3D'vhostuser'>
  <mac address=3D'52:54:00:3b:83:aa'/>
  <source type=3D'unix' path=3D'/var/run/vhost-user/port1' mode=3D'client'/=
>
  <target dev=3D'port1'/>
  <model type=3D'virtio'/>
  <driver queues=3D'4'/>
  <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x08' functi=
on=3D'0x0'/>
</interface>

Firstly, I use virsh attach-device win2008 vif.xml to hot-plug a nic for Gu=
est OS. This operation returns success.
After guest OS discover nic successfully, I use virsh detach-device win2008=
 vif.xml to hot-unplug it. This operation will fail with 100% reproduce rat=
e.

However, if I hot-plug and hot-unplug virtio-net nic , it will not fail.

I have analysis the process of qmp_device_del , I found that qemu have inje=
ct interrupt to acpi to let it notice guest OS to remove nic.
I guess there is something wrong in Windows when handle the interrupt.
