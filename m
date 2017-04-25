Received: from eggs.gnu.org ([2001:4830:134:3::10]:41365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1d2qFE-0005sk-3p
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 22:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1d2qF9-0006Se-De
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 22:30:24 -0400
From: "Herongguang (Stephen)" <herongguang.he@huawei.com>
Message-ID: <58FEB4A2.8070900@huawei.com>
Date: Tue, 25 Apr 2017 10:29:54 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] pci: deassert intx when pci device unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, marcel@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "wangxinxin.wang@huawei.com >> wangxin (U)" <wangxinxin.wang@huawei.com>

If a pci device is not reset by VM (by writing into config space)
and unplugged by VM, after that when VM reboots, qemu may assert:
pcibus_reset: Assertion `bus->irq_count[i] == 0' failed

Signed-off-by: herongguang <herongguang.he@huawei.com>
---
  hw/pci/pci.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 259483b..98ccc27 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1083,6 +1083,7 @@ static void pci_qdev_unrealize(DeviceState *dev, Error **errp)
          pc->exit(pci_dev);
      }

+    pci_device_deassert_intx(pci_dev);
      do_pci_unregister_device(pci_dev);
  }

--
1.7.12.4
