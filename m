Received: from eggs.gnu.org ([2001:4830:134:3::10]:33762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dG3AV-0001Zg-EM
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dG3AS-0000HG-7n
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:56:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dG3AR-0000H1-S6
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:56:04 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C438437E66
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 12:56:02 +0000 (UTC)
References: <1496223756-24929-1-git-send-email-peterx@redhat.com>
	<20170531095023.GL14845@pxdev.xzpeter.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d2dd83c-6a57-9617-087a-c57e64a667cd@redhat.com>
Date: Wed, 31 May 2017 14:55:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170531095023.GL14845@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Edu leak fix series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 31/05/2017 11:50, Peter Xu wrote:
> On Wed, May 31, 2017 at 05:42:34PM +0800, Peter Xu wrote:
>> A whitelist for it does not really makes sense. Let's remove it and
>> then we can introduce a blacklist when really needed, with msi_broken.
>> That's patch 1.
> Ok this paragraph does not make sense if not mentioning what's "it"...
> 
> Please just read the commit messages of patch 1. It should be much
> better.

I think fixing the leak in case we have to reintroduce msi_(non)broken should
be as simple as

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 401039c100..01acacf142 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -343,6 +343,12 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
     EduState *edu = DO_UPCAST(EduState, pdev, pdev);
     uint8_t *pci_conf = pdev->config;
 
+    pci_config_set_interrupt_pin(pci_conf, 1);
+
+    if (msi_init(pdev, 0, 1, true, false, errp)) {
+        return;
+    }
+
     timer_init_ms(&edu->dma_timer, QEMU_CLOCK_VIRTUAL, edu_dma_timer, edu);
 
     qemu_mutex_init(&edu->thr_mutex);
@@ -350,12 +356,6 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
     qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
                        edu, QEMU_THREAD_JOINABLE);
 
-    pci_config_set_interrupt_pin(pci_conf, 1);
-
-    if (msi_init(pdev, 0, 1, true, false, errp)) {
-        return;
-    }
-
     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
                     "edu-mmio", 1 << 20);
     pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &edu->mmio);


Then the two patches can be even squashed together.

Paolo
