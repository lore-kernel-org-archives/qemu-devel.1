Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB7CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4152081A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmOH+ahS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4152081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlLA-0000pG-UA
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl3S-0001Mo-36
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:53:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46175
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl3O-0001eu-Qt
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2tWNry73oPv2gQlztpgeBRBkHzYAUwx8arM+2V6vlZU=;
 b=DmOH+ahSsMnKTXheLuE6MZSgEWE7gYa53qkIb+0G8WtMMDg9e8GZ8NVEa4z1xTFnVQJ7yP
 vl8Ckj19BzsqYH8Vx/69mKvuLhi3x9Y6vvnUK1PkoaLvHxZkzij0vEcuehqvNVimOycVjT
 ZOTk64/Nz/fuuH+DP1e8AJaRoE8EJEo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-FR1BFfhUNRaFgbS2hdUC8g-1; Fri, 12 Jun 2020 10:53:04 -0400
X-MC-Unique: FR1BFfhUNRaFgbS2hdUC8g-1
Received: by mail-wr1-f71.google.com with SMTP id h6so4019293wrx.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2tWNry73oPv2gQlztpgeBRBkHzYAUwx8arM+2V6vlZU=;
 b=mafemCS7uQy6wq/S/hjWS24gfEn8+7pVd3ZlMm/pBgmE+8O8txUsEpDwcZyeWm1RnW
 KCZery8Pyz97ORntwT4bM7wfwHP+XSgtmEZS5HXYsbpJ/bE2cThDZgBBMp1fVgwvOEKs
 uKPwTnFB/BNJTt4STSJSqQ3cNDe5x6Z4cmNoN+SPRxGac9y25qiJULI1awCwgzqdfTD4
 gSZkI5wi+6NVY1VPy7rSLikhU8F+tXA/VAJbw7+YQ9qdhW1SBST8KMAQesUadnk/WLnP
 Z29/bUqcN4apczmgaB2XNOtAwn3LUsgVJ9IWD/YmdCsW5pGurfk62+Z74umOx5yAyp9u
 8cAg==
X-Gm-Message-State: AOAM532h0TvH7LrMDfv60W+Z0v8sND4a1PnEbkMi/Qapokf/NxTAf6bH
 oyMdIM6v87Oiw3XzY2Jw47RAqB+4Y4n5A9KGU7+RgpERT7d+rXndO3ztvERgtRSj2wA+so1Pst4
 ApssxA/FIz/PZ6ZY=
X-Received: by 2002:adf:f205:: with SMTP id p5mr16382959wro.302.1591973582837; 
 Fri, 12 Jun 2020 07:53:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwc14BKPyIKhs1OuKJ3EPlYFqZ34/1iXfmlY2UBj3gIzeZrcVhR636cIWmvK342Y0PkeO4PBg==
X-Received: by 2002:adf:f205:: with SMTP id p5mr16382934wro.302.1591973582620; 
 Fri, 12 Jun 2020 07:53:02 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id z206sm9561863wmg.30.2020.06.12.07.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:53:02 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:53:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 54/58] acpi: fadt: add hw-reduced sleep register support
Message-ID: <20200612141917.9446-55-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:30:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Add fields to struct AcpiFadtData and update build_fadt() to properly
generate sleep register entries.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200520132003.9492-9-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi-defs.h | 2 ++
 hw/acpi/aml-build.c         | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index c13327fa78..3be9ab5049 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -88,6 +88,8 @@ typedef struct AcpiFadtData {
     struct AcpiGenericAddress pm_tmr;    /* PM_TMR_BLK */
     struct AcpiGenericAddress gpe0_blk;  /* GPE0_BLK */
     struct AcpiGenericAddress reset_reg; /* RESET_REG */
+    struct AcpiGenericAddress sleep_ctl; /* SLEEP_CONTROL_REG */
+    struct AcpiGenericAddress sleep_sts; /* SLEEP_STATUS_REG */
     uint8_t reset_val;         /* RESET_VALUE */
     uint8_t  rev;              /* Revision */
     uint32_t flags;            /* Flags */
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index d24e9e6c3a..2cb7b991ef 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1866,9 +1866,9 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
     }
 
     /* SLEEP_CONTROL_REG */
-    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
+    build_append_gas_from_struct(tbl, &f->sleep_ctl);
     /* SLEEP_STATUS_REG */
-    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
+    build_append_gas_from_struct(tbl, &f->sleep_sts);
 
     /* TODO: extra fields need to be added to support revisions above rev5 */
     assert(f->rev == 5);
-- 
MST


