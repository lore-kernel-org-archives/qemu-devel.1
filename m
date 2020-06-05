Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8595C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5F120659
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbEJngtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5F120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDuk-0000Cc-26
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jhDlu-0003zA-R1
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:56:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34436
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jhDlp-0007UR-RU
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591368993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AzhrAmxId462PdyhY2syxA6JuMnzZ6hiX4wRnJCQSQw=;
 b=cbEJngtWy5udNjYxXv82u68TSgjEP5hAhLXjsx6nKmi3ngfQEfopZb+MXCbnMjje3moNdI
 hHRqGw+wbFgHxauIP7ImIVrr5FlMQMTwCb8dgWOlObCbYUVhnWmAc3SatpjWVHOFeOI/37
 SVqJX8SxJcQVlRKkSRIU2aixu6IULS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-hBtmRqtEMyi_skwdecp0BQ-1; Fri, 05 Jun 2020 10:56:31 -0400
X-MC-Unique: hBtmRqtEMyi_skwdecp0BQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB5EE19200C1;
 Fri,  5 Jun 2020 14:56:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F79060C1D;
 Fri,  5 Jun 2020 14:56:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D62C51138465; Fri,  5 Jun 2020 16:56:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/16] arm/aspeed: Drop aspeed_board_init_flashes() parameter
 @errp
Date: Fri,  5 Jun 2020 16:56:23 +0200
Message-Id: <20200605145625.2920920-15-armbru@redhat.com>
In-Reply-To: <20200605145625.2920920-1-armbru@redhat.com>
References: <20200605145625.2920920-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
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
Cc: kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, mreitz@redhat.com, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, pbonzini@redhat.com,
 jsnow@redhat.com, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We always pass &error_abort.  Drop the parameter, use &error_abort
directly.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/aspeed.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 5ffaf86b86..4ce6ca0ef5 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -215,8 +215,8 @@ static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_size,
     g_free(storage);
 }
 
-static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
-                                      Error **errp)
+static void aspeed_board_init_flashes(AspeedSMCState *s,
+                                      const char *flashtype)
 {
     int i ;
 
@@ -227,8 +227,8 @@ static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
 
         fl->flash = qdev_new(flashtype);
         if (dinfo) {
-            qdev_prop_set_drive_err(fl->flash, "drive",
-                                    blk_by_legacy_dinfo(dinfo), errp);
+            qdev_prop_set_drive(fl->flash, "drive",
+                                blk_by_legacy_dinfo(dinfo));
         }
         qdev_realize_and_unref(fl->flash, BUS(s->spi), &error_fatal);
 
@@ -314,8 +314,8 @@ static void aspeed_machine_init(MachineState *machine)
                           "max_ram", max_ram_size  - ram_size);
     memory_region_add_subregion(&bmc->ram_container, ram_size, &bmc->max_ram);
 
-    aspeed_board_init_flashes(&bmc->soc.fmc, amc->fmc_model, &error_abort);
-    aspeed_board_init_flashes(&bmc->soc.spi[0], amc->spi_model, &error_abort);
+    aspeed_board_init_flashes(&bmc->soc.fmc, amc->fmc_model);
+    aspeed_board_init_flashes(&bmc->soc.spi[0], amc->spi_model);
 
     /* Install first FMC flash content as a boot rom. */
     if (drive0) {
-- 
2.26.2


