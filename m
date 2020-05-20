Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA9CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AAC20748
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmBRUY44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AAC20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOmz-00046n-SN
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbOeH-0002M6-Gj
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:20:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46348
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbOeD-0000Jx-R8
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589980836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=6OIxpUflKpjw9oFHZKmMc0sFoAZYdcP0pMC2r+iLubc=;
 b=gmBRUY44K1svrWmqDBViY87OzI28H0rV1130ierxU9wXHbh5MrbmwS2NLRl6i6xzvaQWcz
 HxiBjCoLEnxk6kzyO0Z9xmPgB9Ma/SOQVPkIUfrdmvwZMmpbh8no+2xMp1DAnIeZY/3KL3
 5J5CrUpZdXBjPQpC7V/ekxbf0+9TNTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-9KxStO4rPR61EXfnfpNnJA-1; Wed, 20 May 2020 09:20:34 -0400
X-MC-Unique: 9KxStO4rPR61EXfnfpNnJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85527464;
 Wed, 20 May 2020 13:20:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 125D019C58;
 Wed, 20 May 2020 13:20:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7A1469D73; Wed, 20 May 2020 15:20:04 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 21/22] [RfC] acpi: add per machine type acpi default
Date: Wed, 20 May 2020 15:20:02 +0200
Message-Id: <20200520132003.9492-22-kraxel@redhat.com>
In-Reply-To: <20200520132003.9492-1-kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow setting acpi default value for each machine type.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/x86.h |  1 +
 hw/i386/x86.c         | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index b52285481687..d2fffa8252ff 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -37,6 +37,7 @@ typedef struct {
     bool save_tsc_khz;
     /* Enables contiguous-apic-ID mode */
     bool compat_apic_id_mode;
+    bool acpi_default;
 } X86MachineClass;
 
 typedef struct {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index ac7a0a958781..3a56a157c5f0 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -940,10 +940,22 @@ static void x86_machine_set_smm(Object *obj, Visitor *v, const char *name,
 
 bool x86_machine_is_acpi_enabled(X86MachineState *x86ms)
 {
-    if (x86ms->acpi == ON_OFF_AUTO_OFF) {
-        return false;
+    X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
+    bool enabled;
+
+    switch (x86ms->acpi) {
+    case ON_OFF_AUTO_ON:
+        enabled = true;
+        break;
+    case ON_OFF_AUTO_OFF:
+        enabled = false;
+        break;
+    case ON_OFF_AUTO_AUTO:
+    default:
+        enabled = x86mc->acpi_default;
+        break;
     }
-    return true;
+    return enabled;
 }
 
 static void x86_machine_get_acpi(Object *obj, Visitor *v, const char *name,
@@ -991,6 +1003,9 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     x86mc->save_tsc_khz = true;
     nc->nmi_monitor_handler = x86_nmi;
 
+    /* acpi is on by default */
+    x86mc->acpi_default = true;
+
     object_class_property_add(oc, X86_MACHINE_MAX_RAM_BELOW_4G, "size",
         x86_machine_get_max_ram_below_4g, x86_machine_set_max_ram_below_4g,
         NULL, NULL);
-- 
2.18.4


