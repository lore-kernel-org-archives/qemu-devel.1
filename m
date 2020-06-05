Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7366AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6152074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkCs9a4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6152074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9ZW-0003jE-FC
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9VB-0003ak-So
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:23:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25426
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9VB-0006PC-0M
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591352584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCwuEoJ2Oz59P52pgmfXcQkO9n1Xvg5SPqRDxLaXzRI=;
 b=hkCs9a4re8KJ4Nl4t845mLN+0NTYNr0is0jmDNaLrNAGQ9n+RMJeKJy8jPbCgA0gxvo9jq
 lqvXCTNmmshhVeuRfyIRJlZCBSNs9FEk4IRGukp1R2qLkoiGOxgJR6oQRky6E2lwDW6/Pf
 gPuSYbS5g7Mcsn1cy7QBkF02m508oYU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-GphZWswwNCavn6W070fOXA-1; Fri, 05 Jun 2020 06:23:02 -0400
X-MC-Unique: GphZWswwNCavn6W070fOXA-1
Received: by mail-wr1-f72.google.com with SMTP id w16so3583056wru.18
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cCwuEoJ2Oz59P52pgmfXcQkO9n1Xvg5SPqRDxLaXzRI=;
 b=NxiVMqelgycbHBLpEyqXlF3rjNCBgvzoQxzltisaWuSJp8s8ErzVsXxMt2ffYHy3qN
 B9Tielb0dvp4hrSuzg+l6U/deg9E5jUdBNj+aV723tWNMoWv4SjYo1r5GluxcLYIAw0N
 61yYYojr+ZpSQdMtmDtaJ7o8camAyVcjkz35DMijUMD0qbg4HzI6oBNamh19dfH65mVi
 E7WX2d4ZLSymir1rNin4lQRMnUsu3v4xQ497oJiU1CIpq2TffdMEsbErsQTDT9Mhi2f4
 r5ulw83FshN+vfACt/zL/ZIfsIz0UfykYcaxaOey78tHjVuyrwfX7NM9xfH07p8MlE3Q
 c8XQ==
X-Gm-Message-State: AOAM530faQUoNu8baANk1G94p6xAeVMsaMpIrWKe4NtzktTFzEfIckqF
 +KZoF5bEe6kqoOBrF6umn5/Bw2eSLeVAtT83UCsVrXKXnEGKDaP8HOq8Na8bP1Zs77G3bLh4juD
 Yss0i6PUByYZ9Faw=
X-Received: by 2002:a5d:610f:: with SMTP id v15mr8827762wrt.52.1591352581350; 
 Fri, 05 Jun 2020 03:23:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkIyf5cb1hyyHLYtN7d0yIbePCKHjNDYfY5+3Uq3Tl67IiC2rMM5qr+C7UTvnqDP1iU0xGCg==
X-Received: by 2002:a5d:610f:: with SMTP id v15mr8827746wrt.52.1591352581183; 
 Fri, 05 Jun 2020 03:23:01 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id s2sm10350288wmh.11.2020.06.05.03.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:23:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/11] hw/sd/sdcard: Simplify cmd_valid_while_locked()
Date: Fri,  5 Jun 2020 12:22:25 +0200
Message-Id: <20200605102230.21493-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605102230.21493-1-philmd@redhat.com>
References: <20200605102230.21493-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

cmd_valid_while_locked() only needs to read SDRequest->cmd,
pass it directly and make it const.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9bfd65ac34..7799a3c621 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1647,7 +1647,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     return sd_illegal;
 }
 
-static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
+static int cmd_valid_while_locked(SDState *sd, const uint8_t cmd)
 {
     /* Valid commands in locked state:
      * basic class (0)
@@ -1658,13 +1658,12 @@ static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
      * Anything else provokes an "illegal command" response.
      */
     if (sd->expecting_acmd) {
-        return req->cmd == 41 || req->cmd == 42;
+        return cmd == 41 || cmd == 42;
     }
-    if (req->cmd == 16 || req->cmd == 55) {
+    if (cmd == 16 || cmd == 55) {
         return 1;
     }
-    return sd_cmd_class[req->cmd] == 0
-            || sd_cmd_class[req->cmd] == 7;
+    return sd_cmd_class[cmd] == 0 || sd_cmd_class[cmd] == 7;
 }
 
 int sd_do_command(SDState *sd, SDRequest *req,
@@ -1690,7 +1689,7 @@ int sd_do_command(SDState *sd, SDRequest *req,
     }
 
     if (sd->card_status & CARD_IS_LOCKED) {
-        if (!cmd_valid_while_locked(sd, req)) {
+        if (!cmd_valid_while_locked(sd, req->cmd)) {
             sd->card_status |= ILLEGAL_COMMAND;
             sd->expecting_acmd = false;
             qemu_log_mask(LOG_GUEST_ERROR, "SD: Card is locked\n");
-- 
2.21.3


