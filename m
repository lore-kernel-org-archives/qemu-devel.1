Received: from eggs.gnu.org ([2001:4830:134:3::10]:42603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ceBjN-0002k0-2t
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ceBjJ-0004JG-Vn
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:23:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ceBjJ-0004IO-QA
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:23:33 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0175D3B71F
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 02:23:33 +0000 (UTC)
Date: Thu, 16 Feb 2017 10:23:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170216022327.GB15985@pxdev.xzpeter.org>
References: <1487058692-2789-1-git-send-email-peterx@redhat.com>
	<71fa8e37-5928-bc49-cdf0-27727cf333d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71fa8e37-5928-bc49-cdf0-27727cf333d6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pcie: simplify pcie_add_capability()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, "\\ Michael S . Tsirkin \\ " <mst@redhat.com>

On Wed, Feb 15, 2017 at 04:25:05PM +0200, Marcel Apfelbaum wrote:
> On 02/14/2017 09:51 AM, Peter Xu wrote:
> >When we add PCIe extended capabilities, we should be following the rule
> >that we add the head extended cap (at offset 0x100) first, then the rest
> >of them. Meanwhile, we are always adding new capability bits at the end
> >of the list. Here the "next" looks meaningless in all cases since it
> >should always be zero (along with the "header").
> >
> >Simplify the function a bit, and it looks more readable now.
> >
> >Signed-off-by: Peter Xu <peterx@redhat.com>
> >---
> > hw/pci/pcie.c | 15 ++++-----------
> > 1 file changed, 4 insertions(+), 11 deletions(-)
> >
> >diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> >index cbd4bb4..e0e6f6a 100644
> >--- a/hw/pci/pcie.c
> >+++ b/hw/pci/pcie.c
> >@@ -664,30 +664,23 @@ void pcie_add_capability(PCIDevice *dev,
> >                          uint16_t cap_id, uint8_t cap_ver,
> >                          uint16_t offset, uint16_t size)
> > {
> >-    uint32_t header;
> >-    uint16_t next;
> >-
> >     assert(offset >= PCI_CONFIG_SPACE_SIZE);
> >     assert(offset < offset + size);
> >     assert(offset + size <= PCIE_CONFIG_SPACE_SIZE);
> >     assert(size >= 8);
> >     assert(pci_is_express(dev));
> >
> >-    if (offset == PCI_CONFIG_SPACE_SIZE) {
> >-        header = pci_get_long(dev->config + offset);
> >-        next = PCI_EXT_CAP_NEXT(header);
> >-    } else {
> >+    if (offset != PCI_CONFIG_SPACE_SIZE) {
> >         uint16_t prev;
> >
> >         /* 0 is reserved cap id. use internally to find the last capability
> >            in the linked list */
> >-        next = pcie_find_capability_list(dev, 0, &prev);
> >-
> >+        assert(pcie_find_capability_list(dev, 0, &prev) == 0);
> 
> Hi Peter,
> 
> It is not recommended to use assert with an expression with side-effects.

Exactly. Thanks Marcel, I'll repost.

-- peterx
