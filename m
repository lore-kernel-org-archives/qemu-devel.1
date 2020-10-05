Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75405C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 21:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07758207EA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 21:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul2XZwSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07758207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPXny-0004sD-63
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 17:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXkO-00089X-Ul
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 17:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXkL-0007LM-AK
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 17:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601932212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VKVHOfnczXhyBWhAP6cPmuP/ZmSpUD+aWjzBUKL3yS8=;
 b=Ul2XZwSlt7jRXLaLkcmmpdklUrtoFSx7y+jqzB0XkQoPtD1Xt1zKNfo52Rb7SKgmQdO05X
 g0RRjhTKDX33binorFAhslaE0tpZW2wOtPcMvfQzgyegUIehQeynMoDvTPNqtKm6UqMoUl
 b2q8nSBEh57a+u6PE3QWVG0B5tcRNFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-NL9VSY6vN5uKq8jytm-I5A-1; Mon, 05 Oct 2020 17:10:10 -0400
X-MC-Unique: NL9VSY6vN5uKq8jytm-I5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44D3E107ACF9;
 Mon,  5 Oct 2020 21:10:08 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D06E5D9CD;
 Mon,  5 Oct 2020 21:10:07 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/21] hw/core/qdev-properties: Use qemu_strtoul() in
 set_pci_host_devaddr()
Date: Mon,  5 Oct 2020 17:09:42 -0400
Message-Id: <20201005211000.710404-4-ehabkost@redhat.com>
In-Reply-To: <20201005211000.710404-1-ehabkost@redhat.com>
References: <20201005211000.710404-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Replace strtoul() by qemu_strtoul() so checkpatch.pl won't complain
if we move this code later.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200930164949.1425294-4-philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/qdev-properties.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 080ba319a1f..a1190a5db9e 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -951,7 +951,7 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
     char *str, *p;
-    char *e;
+    const char *e;
     unsigned long val;
     unsigned long dom = 0, bus = 0;
     unsigned int slot = 0, func = 0;
@@ -966,23 +966,23 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
     }
 
     p = str;
-    val = strtoul(p, &e, 16);
-    if (e == p || *e != ':') {
+    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xffff || e == p) {
+        goto inval;
+    }
+    if (*e != ':') {
         goto inval;
     }
     bus = val;
 
-    p = e + 1;
-    val = strtoul(p, &e, 16);
-    if (e == p) {
+    p = (char *)e + 1;
+    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
         goto inval;
     }
     if (*e == ':') {
         dom = bus;
         bus = val;
-        p = e + 1;
-        val = strtoul(p, &e, 16);
-        if (e == p) {
+        p = (char *)e + 1;
+        if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
             goto inval;
         }
     }
@@ -991,14 +991,13 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
     if (*e != '.') {
         goto inval;
     }
-    p = e + 1;
-    val = strtoul(p, &e, 10);
-    if (e == p) {
+    p = (char *)e + 1;
+    if (qemu_strtoul(p, &e, 10, &val) < 0 || val > 7 || e == p) {
         goto inval;
     }
     func = val;
 
-    if (dom > 0xffff || bus > 0xff || slot > 0x1f || func > 7) {
+    if (bus > 0xff) {
         goto inval;
     }
 
-- 
2.26.2


