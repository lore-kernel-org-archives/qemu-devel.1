Received: from eggs.gnu.org ([2001:4830:134:3::10]:58011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1d2dnW-0005Lw-SN
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1d2dnS-000819-Px
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:12:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3521
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1d2dnS-0007xu-Dq
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:12:54 -0400
From: "Herongguang (Stephen)" <herongguang.he@huawei.com>
Message-ID: <58FDF9BD.2030100@huawei.com>
Date: Mon, 24 Apr 2017 21:12:29 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH] pci: deassert intx when pci device
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "wangxinxin.wang@huawei.com >> wangxin (U)" <wangxinxin.wang@huawei.com>

If a pci device is not reset by VM (by writing into config space)
and unplugged by VM, after that when VM reboots, qemu may assert:
pcibus_reset: Assertion `bus->irq_count[i] == 0' failed

Signed-off-by: herongguang <herongguang.he@huawei.com>
---

Is there need to call pci_do_device_reset()?

---
  hw/pci/pci.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 259483b..afe6397 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1078,6 +1078,7 @@ static void pci_qdev_unrealize(DeviceState *dev, Error **errp)

      pci_unregister_io_regions(pci_dev);
      pci_del_option_rom(pci_dev);
+    pci_device_deassert_intx(pci_dev);

      if (pc->exit) {
          pc->exit(pci_dev);
--
1.7.12.4
