Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D46FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC782208DB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aya0q2GK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC782208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdy3D-0002hf-UI
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdy2Y-0002G6-B8
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:32:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60392
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdy2O-0005M5-Cq
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590593527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=10oSkb4PvvTP/yJmiLzUgvPVndG7S5+ZQgWeY4ntTpQ=;
 b=aya0q2GK6ZvC8fBLMhyfU/Tgdu3L7rILCAXg1QzZQ0yFLt1xHaflq+uTLgmHnOvbFsJqmr
 gthrIuuDxC6XCVHCLTgg71Z9eTnoiSMz1k8j8y1xYRyAuoBjDUwBF2ZwpkihvjssbprAhb
 QjLFCtTIxS7Gs4mzQOnLyXTdIXERI50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-dWYvHCFBO1aIosjubPFWwQ-1; Wed, 27 May 2020 11:32:05 -0400
X-MC-Unique: dWYvHCFBO1aIosjubPFWwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A25D461;
 Wed, 27 May 2020 15:32:03 +0000 (UTC)
Received: from thuth.com (ovpn-112-170.ams2.redhat.com [10.36.112.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 836CE1A8F1;
 Wed, 27 May 2020 15:31:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] hw/pci: Fix crash when running QEMU with "-nic model=rocker"
Date: Wed, 27 May 2020 17:31:52 +0200
Message-Id: <20200527153152.9211-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU currently aborts when being started with "-nic model=rocker" or with
"-net nic,model=rocker". This happens because the "rocker" device is not
a normal NIC but a switch, which has different properties. Thus we should
only consider real NIC devices for "-nic" and "-net". These devices can
be identified by the "netdev" property, so check for this property before
adding the device to the list.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Fixes: 52310c3fa7dc854d ("net: allow using any PCI NICs in -net or -nic")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/pci/pci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 70c66965f5..46214f8287 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1887,7 +1887,18 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
         if (test_bit(DEVICE_CATEGORY_NETWORK, dc->categories) &&
             dc->user_creatable) {
             const char *name = object_class_get_name(list->data);
-            g_ptr_array_add(pci_nic_models, (gpointer)name);
+            /*
+             * A network device might also be something else than a NIC, see
+             * e.g. the "rocker" device. Thus we have to look for the "netdev"
+             * property, too. Unfortunately, some devices like virtio-net only
+             * create this property during instance_init, so we have to create
+             * a temporary instance here to be able to check it.
+             */
+            Object *obj = object_new_with_class(OBJECT_CLASS(dc));
+            if (object_property_find(obj, "netdev", NULL)) {
+                g_ptr_array_add(pci_nic_models, (gpointer)name);
+            }
+            object_unref(obj);
         }
         next = list->next;
         g_slist_free_1(list);
-- 
2.18.1


