Received: from eggs.gnu.org ([2001:4830:134:3::10]:43428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stone.xulei@huawei.com>) id 1eEoAY-00074B-Hj
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 22:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stone.xulei@huawei.com>) id 1eEoAU-00038A-BI
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 22:15:18 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:4369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <stone.xulei@huawei.com>) id 1eEoAS-0002xp-UM
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 22:15:14 -0500
From: "Xulei (Stone)" <stone.xulei@huawei.com>
Date: Wed, 15 Nov 2017 03:14:52 +0000
Message-ID: <8E78D212B8C25246BE4CE7EA0E645FE501B557EA@dggeml511-mbs.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [Question] Qemu's Heap Becomes Very Large and Never
 Reduce Down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, "yang.zhong" <yang.zhong@intel.com>, "anthony.xu" <anthony.xu@intel.com>, pbonzini <pbonzini@redhat.com>, stefanha <stefanha@redhat.com>, berrange <berrange@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "liujunjie (A)" <liujunjie23@huawei.com>

Hi, guys

I met a strange problem, with qemu 2.8.1:
qemu consumes too many heap memory after several operations and can not rel=
ease them anymore:
hot pulg/unplug disk & net, vnc connect/disconnect, guestOS reboot, etc.


01a7a000-3b4efe000 rw-p 00000000 00:00 0                                 [h=
eap]

Size:           15520272 kB

Rss:            14421836 kB

Pss:            14421836 kB

Shared_Clean:          0 kB

Shared_Dirty:          0 kB

Private_Clean:      1164 kB

Private_Dirty:  14420672 kB

Referenced:      7485624 kB

Anonymous:      14421836 kB

AnonHugePages:     34816 kB

Swap:            1098140 kB

KernelPageSize:        4 kB

MMUPageSize:           4 kB

Locked:                0 kB

VmFlags: rd wr mr mw me ac sd

My steps are:
1) start several VMs all equipped only 8G memory;
2) random combining those operations mentioned above;
3) after few hours, qemu's Virt memory and RSS both grow too large and neve=
r fall down;

After analysis via /proc/$pid/smaps, I found the VMA of pc.ram does not occ=
upy much
memory but only becauses of heap section.

I guess that has some relations of glibc or qemu rcu_thread, but i can not =
figure it out.
Is there some patches can fix this problem or does somebody have any idea?
________________________________
