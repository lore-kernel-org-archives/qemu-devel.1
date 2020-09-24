Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E3EC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1587720702
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvpwGy6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1587720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLKXw-00048X-O7
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 02:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kLKXH-0003ef-Pk
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 02:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kLKXF-0000Iv-I9
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 02:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600928116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G9MK7cRlHJoHIT3YOvSd4305gUAxG1HQ781S9JnjNio=;
 b=XvpwGy6dcSSjFP7xj5Xk4i8Vp5Log8Ujn2uoU71F8KN/MOc8z0gPkBB94HKoAPXP/GmlG5
 e3Q77yxyCT8bo4ORkgv8O9X8Cy3YNG2K8EPpbFg2Iteuw7UkmBlkLNRocMvI7hzLJOECOb
 p/d+OTya1Hzoidl7yF7Wi+TeqiUZoVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-paWm8-5SMr6RDL_BAmHolA-1; Thu, 24 Sep 2020 02:15:14 -0400
X-MC-Unique: paWm8-5SMr6RDL_BAmHolA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 635F610074C5;
 Thu, 24 Sep 2020 06:15:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 793D17882B;
 Thu, 24 Sep 2020 06:15:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A5A4B9D78; Thu, 24 Sep 2020 08:15:07 +0200 (CEST)
Date: Thu, 24 Sep 2020 08:15:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v9 3/7] usb/hcd-xhci: Split pci wrapper for xhci base model
Message-ID: <20200924061507.2ztaxii76f6gvmfm@sirius.home.kraxel.org>
References: <1600883407-15147-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600883407-15147-4-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <1600883407-15147-4-git-send-email-sai.pavan.boddu@xilinx.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?utf-8?Q?'Marc-Andr=C3=A9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 'Philippe =?utf-8?Q?Mathieu-Daud=C3=A9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> @@ -203,8 +202,10 @@ struct XHCIState {
>      uint32_t numslots;
>      uint32_t flags;
>      uint32_t max_pstreams_mask;
> -    OnOffAuto msi;
> -    OnOffAuto msix;
> +    void (*intr_update)(XHCIState *s, int n, bool enable);
> +    void (*intr_raise)(XHCIState *s, int n, bool level);
> +    void (*vmstate_post_load)(XHCIState *xhci);

No need to create your own post_load hook, there is one in
VMStateDescription ready for use ;)

take care,
  Gerd

[ I can squash that into 3/7 if you have no objections ]

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 294bdc62aeaf..f859a17e73ee 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -205,7 +205,6 @@ typedef struct XHCIState {
     uint32_t max_pstreams_mask;
     void (*intr_update)(XHCIState *s, int n, bool enable);
     void (*intr_raise)(XHCIState *s, int n, bool level);
-    void (*vmstate_post_load)(XHCIState *xhci);
     DeviceState *hostOpaque;
 
     /* Operational Registers */
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index f06a2b7f4c57..77608fb78def 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -85,19 +85,21 @@ static void xhci_pci_reset(DeviceState *dev)
     device_legacy_reset(DEVICE(&s->xhci));
 }
 
-static void xhci_pci_vmstate_post_load(XHCIState *xhci)
+static int xhci_pci_post_load(void *opaque, int version_id)
 {
-    XHCIPciState *s = container_of(xhci, XHCIPciState, xhci);
+    XHCIPciState *s = opaque;
+    XHCIState *xhci = &s->xhci;
     PCIDevice *pci_dev = PCI_DEVICE(s);
     int intr;
 
-   for (intr = 0; intr < xhci->numintrs; intr++) {
+    for (intr = 0; intr < xhci->numintrs; intr++) {
         if (xhci->intr[intr].msix_used) {
             msix_vector_use(pci_dev, intr);
         } else {
             msix_vector_unuse(pci_dev, intr);
         }
     }
+    return 0;
 }
 
 static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
@@ -114,7 +116,6 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
     object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
     s->xhci.intr_update = xhci_pci_intr_update;
     s->xhci.intr_raise = xhci_pci_intr_raise;
-    s->xhci.vmstate_post_load = xhci_pci_vmstate_post_load;
     object_property_set_bool(OBJECT(&s->xhci), "realized", true, &err);
     if (err) {
         error_propagate(errp, err);
@@ -176,6 +177,7 @@ static void usb_xhci_pci_exit(PCIDevice *dev)
 static const VMStateDescription vmstate_xhci_pci = {
     .name = "xhci",
     .version_id = 1,
+    .post_load = xhci_pci_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, XHCIPciState),
         VMSTATE_MSIX(parent_obj, XHCIPciState),
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4a6c0e7edb1a..b1b95abb9b29 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3457,9 +3457,6 @@ static int usb_xhci_post_load(void *opaque, int version_id)
         }
     }
 
-    if (xhci->vmstate_post_load) {
-        xhci->vmstate_post_load(xhci);
-    }
     return 0;
 }
 


