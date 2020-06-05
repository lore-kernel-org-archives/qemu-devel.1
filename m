Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBA1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F1C2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieW7mYPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F1C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9Vs-0004wq-Qs
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9V2-0003GD-AR
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:22:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38954
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9V1-0006Mv-Lq
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591352574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GcNyt5JpibNbYHzcDu4M3J79WDrEHAq/FGF7Nlj7rRk=;
 b=ieW7mYPukfw5G2soD3iLoa3X4r1kQuIeBgjCJk3iC050kOMYmumFKpKZQQRTlMSQcbPQ69
 AUO5wabh54WT0Ips4JHu39uZRxL/5RzYoY1Wa9NgDj4D03GsMkWT0VPXGYEfuh6WgTveJW
 wM7EB0ydbgi9lmTupyWEPhNbRihCea4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-i7j2F2BfN4iZJQ4pXXiVMQ-1; Fri, 05 Jun 2020 06:22:53 -0400
X-MC-Unique: i7j2F2BfN4iZJQ4pXXiVMQ-1
Received: by mail-wr1-f71.google.com with SMTP id s17so3576780wrt.7
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GcNyt5JpibNbYHzcDu4M3J79WDrEHAq/FGF7Nlj7rRk=;
 b=QraHeyno5LhC4LaPwgwCmw/DhjOmmfmXOIKFVzu39xaO4w2Jc8VtGrwHZ35IdnVNGo
 PsRQ64qAGkduvbYT6JC3QeY8yHb2OvpHPy5N2ivHL1Q9oR7GIupsHRF5eWnpGVDUltw1
 Ggem4e0EJpB2NZO3PaZXtTrQoN6CCRj/xdyMo2MghNH8LsaWOVoQSiaYhabGTbUgXrUD
 S0Uq2tTjD87ruGSAk/QW04eWdzmyIIh05MUeyckHj6C2/XARZlz3GuYHGZCQwycC36MP
 x76G1RvbMd9ujpNIUaicy3UDuNckkQG//AM8lvnuejPb8aNxaA6W/IgOKi874f6ThMfd
 aSEQ==
X-Gm-Message-State: AOAM531Cpngvaxy1jd6TM2uifIqrxfXcXL4X5mOj2I2/nldkQraIrdJU
 4pR0K0h6E099BMfrWzj5LorSeLQvMRYol9Iu0j65uc2ZaxPpu2KuCZ4B+T/7y6eRlV9asA7c5Af
 eBfB56PFOBOEakMw=
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr1991202wmh.8.1591352571940;
 Fri, 05 Jun 2020 03:22:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJlq3ObrJT2DK4tzsfx3QJMTMoBN7zINfc7byjcsmQXhc9b8x32poqWAkxg/B5n0PtfS3IZg==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr1991186wmh.8.1591352571689;
 Fri, 05 Jun 2020 03:22:51 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id k17sm12097520wrl.54.2020.06.05.03.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:22:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/11] hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
Date: Fri,  5 Jun 2020 12:22:23 +0200
Message-Id: <20200605102230.21493-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605102230.21493-1-philmd@redhat.com>
References: <20200605102230.21493-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Only SCSD cards support Class 6 (Block Oriented Write Protection)
commands.

  "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"

  4.3.14 Command Functional Difference in Card Capacity Types

  * Write Protected Group

  SDHC and SDXC do not support write-protected groups. Issuing
  CMD28, CMD29 and CMD30 generates the ILLEGAL_COMMAND error.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 90d5ff6209..4cc1ecf9f9 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -905,6 +905,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         sd->multi_blk_cnt = 0;
     }
 
+    if (sd_cmd_class[req.cmd] == 6 && FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
+        /* Only Standard Capacity cards support class 6 commands */
+        return sd_illegal;
+    }
+
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
     case 0:	/* CMD0:   GO_IDLE_STATE */
-- 
2.21.3


