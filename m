Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5413FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40532074F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYzdwORS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40532074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc9uo-0000nf-Rr
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 11:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc9tL-0007os-Pp
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:19:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc9tJ-0006qf-O5
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604938775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c74r/9TB1kiGAwlYOpNyd1EBlTZRCTXB5lpRTVp0bzg=;
 b=ZYzdwORSflRq3yJaIju5+NcG7d/QeGirTpMB6LW2aFYt2bK1lGxmWnvHMgBHjwIzaRgeJp
 k/OOX14wX33DN2kmlzmFnMmZtXsFJEKlN17F9k89Rswrqnx/LyX+yymez6GpKnTgmXaKFK
 cxfS1MAPnD6PGTeIQBNV3wT9n6IBrfg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-DsX5R3x3OJyEeyM6N47C3A-1; Mon, 09 Nov 2020 11:19:33 -0500
X-MC-Unique: DsX5R3x3OJyEeyM6N47C3A-1
Received: by mail-wm1-f71.google.com with SMTP id y26so2203966wmj.7
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 08:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c74r/9TB1kiGAwlYOpNyd1EBlTZRCTXB5lpRTVp0bzg=;
 b=aXxL86HuZlmRzEcFWOCsWHkn7m18ynX++GW+PEccQUFgdfAp9Xvf8GGiQi8CkQCNH5
 tg3uNEp4xTIgbrp5LX86j8D5qHwURHIw9SA0XrCb7FXDfdovAot4JgyUA3QJR+xlmo3Z
 tREyKaI1lxideJipiQC0f9SgkiCORgFoditHOnZTzxBbf7VGCFzpzyH1CwhfH59oJWy5
 3Wzsz4hT/awSaf1YyOUAJW9IyZt8GBUqdMa/mKBx7kqWeWdc0k0YjPRiH3sfn5paWqLJ
 pRvh4n7fVBIxG9jVYvs7FESSR4Zpx0eB3Oi2OBJHu+omUr21tdAg34bVw7RlKlzoA1GJ
 R8GQ==
X-Gm-Message-State: AOAM530S0SIYs27gHL+H0Nn3AOfNhd1uva/petTxGqjVH0VUeB1ipFg4
 DqzLT65uU2nleA1u4zqNSl6D/urDd4c4yR6YKUrscpipxCb4epivUIvQCRyPWX0aNE6J5HnEoj7
 VmSK4Yn58EXKXTfU=
X-Received: by 2002:a5d:4f92:: with SMTP id d18mr19846131wru.118.1604938771360; 
 Mon, 09 Nov 2020 08:19:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzs8vVpm0Fv7ncn8kSQ+bN8IAXk00vXnIdj4nWaTKtl1jG0LP0qvrvapNMF8PX0a6kw6Opww==
X-Received: by 2002:a5d:4f92:: with SMTP id d18mr19846117wru.118.1604938771220; 
 Mon, 09 Nov 2020 08:19:31 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y4sm12747714wmj.2.2020.11.09.08.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 08:19:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [NOTFORMERGE PATCH 1/2] hw/net: Test line with 342 chars
Date: Mon,  9 Nov 2020 17:19:22 +0100
Message-Id: <20201109161923.2632747-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109161923.2632747-1-philmd@redhat.com>
References: <20201109161923.2632747-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Applying using unrestricted checkpatch:

 WARNING: line over 100 characters
 #16: FILE: include/hw/net/imx_fec.h:118:

This change is not easy to review in gitk.

  $ xwininfo -root | egrep "Width|Height"
    Width: 1920
    Height: 2160

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/net/imx_fec.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index e3a8755db92..c3ac7d25823 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -115,13 +115,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXFECState, IMX_FEC)
 #define ENET_INT_TXF1          (1 <<  3)
 #define ENET_INT_TXB1          (1 <<  2)
 
-#define ENET_INT_MAC           (ENET_INT_HB | ENET_INT_BABR | ENET_INT_BABT | \
-                                ENET_INT_GRA | ENET_INT_TXF | ENET_INT_TXB | \
-                                ENET_INT_RXF | ENET_INT_RXB | ENET_INT_MII | \
-                                ENET_INT_EBERR | ENET_INT_LC | ENET_INT_RL | \
-                                ENET_INT_UN | ENET_INT_PLR | ENET_INT_WAKEUP | \
-                                ENET_INT_TS_AVAIL | ENET_INT_TXF1 | \
-                                ENET_INT_TXB1 | ENET_INT_TXF2 | ENET_INT_TXB2)
+#define ENET_INT_MAC           (ENET_INT_HB | ENET_INT_BABR | ENET_INT_BABT | ENET_INT_GRA | ENET_INT_TXF | ENET_INT_TXB | ENET_INT_RXF | ENET_INT_RXB | ENET_INT_MII | ENET_INT_EBERR | ENET_INT_LC | ENET_INT_RL | ENET_INT_UN | ENET_INT_PLR | ENET_INT_WAKEUP | ENET_INT_TS_AVAIL | ENET_INT_TXF1 | ENET_INT_TXB1 | ENET_INT_TXF2 | ENET_INT_TXB2)
 
 /* RDAR */
 #define ENET_RDAR_RDAR         (1 << 24)
-- 
2.26.2


