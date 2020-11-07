Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4356AC388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 17:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D1F20878
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 17:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="BR9sfV19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D1F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbRvZ-0006O1-Et
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 12:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kbRuy-0005ry-Ot
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 12:22:24 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:38962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kbRuw-0002C3-Vy
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 12:22:24 -0500
Received: by mail-pg1-x52b.google.com with SMTP id i7so3521694pgh.6
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 09:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TXyCFy+ftKKMW+sGSwFyxzOZFwwOs3gESr9R+zrqPGU=;
 b=BR9sfV19zOEb1atQz2ic86U93euW8rRmsaAB1BzTAPKC+RJqcU+zMy/0cGjXehaggc
 CZQwMnLAw+f0fFOJ7hPCEokkOQnpKa4PwHQ1R3kHVBBAAJ8T1HZ8WTCKKowH6SYBSCx2
 F/X9CuXnvD8u54yQ95Pn6uhYNtONhY0xoMmPSLuySSIfmrI5olQ5xPKtXJ4zIwZUFZsF
 FUe+/3aNkzpDK4mASpVv57CKq5SLv84ISq7YFzGMEm00pM0zFDEBpANR1KZ63tExw/+z
 v0TiERxyBrlXGygTB4zjkAb+gBbXtOHycG99rYR2WAJqHCf9WFgkxzl5gxJURHomOUCM
 wZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TXyCFy+ftKKMW+sGSwFyxzOZFwwOs3gESr9R+zrqPGU=;
 b=T7wKP042V6TQt+w3kEUWAm9mNa05XHNKwnD25hRU1bn5y5nJZmPrYvTKRm//zFjKix
 VSIECtTVVEvJThelOm+B0M3p0AZA/TzVGwG2EZ2jG/k6/1TNyCJKLWOipyAqXaxtUbo3
 GjCL/44zmBud+UGERuAwK4ANYkeEJYcy/HOjFbLJG6zjypgzaC+cFHpudEDVXHT8g6pE
 IKuoQZiLKFuAntBLEew3v9KAF70oPqO3jhjdoj9ETGp+ByKXsEGmbFlMpfaiePcUtSt1
 xq7QOMb+MvoDHW76gQSsP+dHEknhnP0PZWUaGqUZrhuijT8zQ8nuu40YAhu/Abhv6fP7
 IevQ==
X-Gm-Message-State: AOAM533Z32oCAKNsKmD+FBjBk+Tbt1ZFFpNIcvRwd5XD9Pv9MrgUazOI
 svYf61h/RjeoDV3xYpgiRUbMHLDa9BK4NA==
X-Google-Smtp-Source: ABdhPJwVtoN13jnLr3NwNWjOSuALHa/A9z96hsNLF7jGSzyKeOtJtDJbntwtN5Og9MTXePEZSHizYg==
X-Received: by 2002:a63:5b63:: with SMTP id l35mr6608756pgm.70.1604769740999; 
 Sat, 07 Nov 2020 09:22:20 -0800 (PST)
Received: from localhost.localdomain ([115.96.136.129])
 by smtp.googlemail.com with ESMTPSA id d68sm6444914pfc.135.2020.11.07.09.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 09:22:20 -0800 (PST)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2] acpi-build: Fix maybe-uninitialized warning when
 ACPI hotplug is off
Date: Sat,  7 Nov 2020 22:52:11 +0530
Message-Id: <20201107172211.117990-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, philmd@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 This fixes the following warning (gcc 9.3.0 on Ubuntu):

  ../hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
  ../hw/i386/acpi-build.c:496:9: error: 'method' may be used uninitialized
  in this function [-Werror=maybe-uninitialized]
    496 |         aml_append(parent_scope, method);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Fixes: df4008c9c59 ("piix4: don't reserve hw resources when hotplug is off globally")
Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/i386/acpi-build.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4f66642d88..431f5ba247 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -349,7 +349,7 @@ static void build_append_pcihp_notify_entry(Aml *method, int slot)
 static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
                                          bool pcihp_bridge_en)
 {
-    Aml *dev, *notify_method = NULL, *method;
+    Aml *dev, *notify_method = NULL, *method = NULL;
     QObject *bsel;
     PCIBus *sec;
     int i;
@@ -463,6 +463,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
      * Add this method for root bus only when hotplug is enabled since DSDT
      * expects it.
      */
+    method = NULL;
     if (bsel || pcihp_bridge_en) {
         method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
     }
@@ -492,7 +493,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
         }
     }
 
-    if (bsel || pcihp_bridge_en) {
+    if (method) {
         aml_append(parent_scope, method);
     }
     qobject_unref(bsel);
-- 
2.25.1


