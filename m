Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E50C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5E8206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6WliViq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5E8206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbrgx-0003NO-62
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrao-00041g-Gq
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbram-0000UM-Q8
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQZWhvSbI5p4N1e0B4bgocntEDGXJm7E/SmoI1MVHIY=;
 b=g6WliViqkM2k4oOMEgfGaZM0d/Ar8OmHtUeOZyufEO1WDIeytLuunpIU1wdm29CYwiUKIW
 HuGS5EVV4YsOh0Ifyr0tBUnBy98zzhYbJHEXxLHP0/xzt2VJeI2NiWpip6txjegrh8fuCK
 impssMZsVJrstzZVHfw6y+zsJWorX6Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-mjH24TeMPI6EePx5xKTxVQ-1; Sun, 08 Nov 2020 15:47:14 -0500
X-MC-Unique: mjH24TeMPI6EePx5xKTxVQ-1
Received: by mail-wr1-f69.google.com with SMTP id w17so2646403wrp.11
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AQZWhvSbI5p4N1e0B4bgocntEDGXJm7E/SmoI1MVHIY=;
 b=fUeOQWVwJWqQtcYvl2XSjLHePo9uY1pLXfPafzqwq19zlbBbkEJ/2JogopYJDAl4WI
 Z/q85a7HMrF65k1CZvODUJ6cAVpxX7jA1oaAoyIQ8bUHuNbJqS/g+8Nt/ztkUvKcotU/
 P5+xoY9BWsXu+XCoCPD5YT4oC/MfVx6Lz3iDj/IwZc4dT3A5C6SvaYtwU190JNq0ENN6
 IpdcP5Su6KrOB2oxXWK+qTFZez9Za47dTWAcLYk/b1DNUGnUtp+VXzmi2t9pPB2vpRQH
 3rRZoacC+xWamJJOtRhPuOf0UexidSG7Rcwby5tsYEGxLvFrCLdoLzGkN6AT+b9VYiJJ
 cKUA==
X-Gm-Message-State: AOAM531L697A8D9QqK+1EcQKgiPt+zsV6VeV6aTeob+/s01xXMuKbxr5
 C1QOmbJAY+K3R9L5NW6RZGNRDZv2IanehSzvE5jf6CiUsOof/akK7xQmOulQzIQfZ1e1Jcc6QGM
 uMeGiW8YvXGE3Wo8=
X-Received: by 2002:adf:bb43:: with SMTP id x3mr14453193wrg.250.1604868433210; 
 Sun, 08 Nov 2020 12:47:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6xiS2T1BEEsf+xEKz+wrtpCamxQytQ9n9oVGcCZnWvRwoLrlXkZ4xtOR6+A5AWfTYfv+vzw==
X-Received: by 2002:adf:bb43:: with SMTP id x3mr14453174wrg.250.1604868433074; 
 Sun, 08 Nov 2020 12:47:13 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t13sm11244180wru.67.2020.11.08.12.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:47:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v4 03/17] hw/i386/acpi-build: Fix maybe-uninitialized
 error when ACPI hotplug off
Date: Sun,  8 Nov 2020 21:45:21 +0100
Message-Id: <20201108204535.2319870-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108204535.2319870-1-philmd@redhat.com>
References: <20201108204535.2319870-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:03:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GCC 9.3.0 thinks that 'method' can be left uninitialized. This code
is already in the "if (bsel || pcihp_bridge_en)" block statement,
but it isn't smart enough to figure it out.

Restrict the code to be used only in the "if (bsel || pcihp_bridge_en)"
block statement to fix (on Ubuntu):

  ../hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
  ../hw/i386/acpi-build.c:496:9: error: 'method' may be used uninitialized
  in this function [-Werror=maybe-uninitialized]
    496 |         aml_append(parent_scope, method);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Fixes: df4008c9c59 ("piix4: don't reserve hw resources when hotplug is off globally")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/i386/acpi-build.c | 45 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4f66642d887..1f5c2112452 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -465,34 +465,31 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
      */
     if (bsel || pcihp_bridge_en) {
         method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
-    }
-    /* If bus supports hotplug select it and notify about local events */
-    if (bsel) {
-        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
 
-        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
-        aml_append(method,
-            aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Check */)
-        );
-        aml_append(method,
-            aml_call2("DVNT", aml_name("PCID"), aml_int(3)/* Eject Request */)
-        );
-    }
+        /* If bus supports hotplug select it and notify about local events */
+        if (bsel) {
+            uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
 
-    /* Notify about child bus events in any case */
-    if (pcihp_bridge_en) {
-        QLIST_FOREACH(sec, &bus->child, sibling) {
-            int32_t devfn = sec->parent_dev->devfn;
-
-            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
-                continue;
-            }
-
-            aml_append(method, aml_name("^S%.02X.PCNT", devfn));
+            aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
+            aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
+                                         aml_int(1))); /* Device Check */
+            aml_append(method, aml_call2("DVNT", aml_name("PCID"),
+                                         aml_int(3))); /* Eject Request */
+        }
+
+        /* Notify about child bus events in any case */
+        if (pcihp_bridge_en) {
+            QLIST_FOREACH(sec, &bus->child, sibling) {
+                int32_t devfn = sec->parent_dev->devfn;
+
+                if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
+                    continue;
+                }
+
+                aml_append(method, aml_name("^S%.02X.PCNT", devfn));
+            }
         }
-    }
 
-    if (bsel || pcihp_bridge_en) {
         aml_append(parent_scope, method);
     }
     qobject_unref(bsel);
-- 
2.26.2


