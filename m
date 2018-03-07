Received: from eggs.gnu.org ([2001:4830:134:3::10]:56928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rndfax@yandex.ru>) id 1etWdA-0001Cb-Qq
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rndfax@yandex.ru>) id 1etWd9-0001oS-VB
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:49:08 -0500
Received: from forward101o.mail.yandex.net ([2a02:6b8:0:1a2d::601]:53077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rndfax@yandex.ru>) id 1etWd9-0001na-I4
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:49:07 -0500
Received: from mxback2j.mail.yandex.net (mxback2j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::10b])
	by forward101o.mail.yandex.net (Yandex) with ESMTP id 344011342326
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 13:49:02 +0300 (MSK)
From: Aleksey Kuleshov <rndfax@yandex.ru>
MIME-Version: 1.0
Message-Id: <4509561520419741@web56g.yandex.ru>
Date: Wed, 07 Mar 2018 13:49:01 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: [Qemu-devel] BUG? Using memory after freeing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hello!

Explanation of what I saw is follows.

In hw/pci/pci_bridge.c function pci_bridge_update_mappings does follows:
```
void pci_bridge_update_mappings(PCIBridge *br)
{
    PCIBridgeWindows *w = br->windows;

    /* Make updates atomic to: handle the case of one VCPU updating the bridge
     * while another accesses an unaffected region. */
    memory_region_transaction_begin();
    pci_bridge_region_del(br, br->windows);
    br->windows = pci_bridge_region_init(br);
    memory_region_transaction_commit();
    pci_bridge_region_cleanup(br, w);
}
```

It calls memory_region_transaction_commit which calls flatview_unref:
```
static void flatview_unref(FlatView *view)
{
    if (atomic_fetch_dec(&view->ref) == 1) {
        trace_flatview_destroy_rcu(view, view->root);
        assert(view->root);
        call_rcu(view, flatview_destroy, rcu);
    }
}
```
As far as I understood, call_rcu can be considered as a deferred call to flatview_destroy.

Then in pci_bridge_update_mappings there is a call to pci_bridge_region_cleanup which does:
```
static void pci_bridge_region_cleanup(PCIBridge *br, PCIBridgeWindows *w)
{
    object_unparent(OBJECT(&w->alias_io));
    object_unparent(OBJECT(&w->alias_mem));
    object_unparent(OBJECT(&w->alias_pref_mem));
    object_unparent(OBJECT(&w->alias_vga[QEMU_PCI_VGA_IO_LO]));
    object_unparent(OBJECT(&w->alias_vga[QEMU_PCI_VGA_IO_HI]));
    object_unparent(OBJECT(&w->alias_vga[QEMU_PCI_VGA_MEM]));
    g_free(w);
}
```
Note g_free(w). "w" holds MemoryRegions, which are part of that FlatView
which is going to be destroyed some time later in the future.

When RCU thread kicks in, flatview_destroy is called on MemoryRegions which were
part of that "w" which is now freed and QEMU seg faults.
