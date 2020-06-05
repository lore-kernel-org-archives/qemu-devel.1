Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287F0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5BE22074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+pPUVQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BE22074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9XZ-0000Ar-30
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9VQ-0004F0-Ld
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:23:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46132
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9VP-0006YK-RG
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591352599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fRA1bjw8PFajFz66cmd9KYwjFOeduTwYTWjhF6GRIY=;
 b=K+pPUVQ3gYslBeMpdw9S+cvH+SyzHkv6hQuTT+/5rLISdTgcYfNNcqp/LF9bb32ktU3Bgf
 WwJSPwoTGD2oiq6uWs/nims9HvrO11M+hEC4VJBbJVkPjf676FbevX3BBA8/D80gN6THrw
 iACMT5BF7GazFDe9JrJNkSLldU9h9SU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-bTR4r4r8MUS1S4zGLBxWaQ-1; Fri, 05 Jun 2020 06:23:17 -0400
X-MC-Unique: bTR4r4r8MUS1S4zGLBxWaQ-1
Received: by mail-wm1-f71.google.com with SMTP id h6so2588386wmb.7
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5fRA1bjw8PFajFz66cmd9KYwjFOeduTwYTWjhF6GRIY=;
 b=fQvgQcp6N/JwGNArH6J/XU3Jh16dP3KinKvuB/MXdwpxqLWMN8hXsRtDUNubCQG+8N
 0/26cizrbhkvSxJAE1MEoxLPlw0SAksWB093QlS3TnybvFW8y/e+V9/6/PclGp2zMXKI
 45ALet8ls7KP7I/ZUSjjY45o/DOylLJRaZFLie1z8WdBkLqA5PMRI25tKN6bG2gltfDE
 serpb2zldxdd9OszFkl74K4yG6pvWIuf6iyXs8v13xyf4h9X0C8i69LecuTzjd58x3KH
 FRyKYDUIiqsp7tJJMTAOfiwJB3jLYzqxLP5oQbKJINsYzoMyozWIAzkZ8/0IlM1NMCde
 x6sA==
X-Gm-Message-State: AOAM5312aoFYc9x+LgJCSFvjVl+7RVgqyv6dzIJhjfB1c+gsPrcySePY
 5l/z0eZZ7r0fXENSwefxFXEz/w3YA/H4GnZsqfF3JKSRrE24+clbeKH1FdslUptljVoHQbyDVpR
 0bgiDrtnqdvo2SrM=
X-Received: by 2002:a05:600c:1146:: with SMTP id
 z6mr1952046wmz.179.1591352595600; 
 Fri, 05 Jun 2020 03:23:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTvOX7zZ5aOQm+r3CsNFj/JftKxFSEgZXZuaWbz4IsMxvnaRSlKKK/5s1lygd1+oa56bENWg==
X-Received: by 2002:a05:600c:1146:: with SMTP id
 z6mr1952023wmz.179.1591352595316; 
 Fri, 05 Jun 2020 03:23:15 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id u13sm10448725wmm.6.2020.06.05.03.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:23:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/11] hw/sd/sdcard: Correctly display the command name in
 trace events
Date: Fri,  5 Jun 2020 12:22:28 +0200
Message-Id: <20200605102230.21493-10-philmd@redhat.com>
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

Some ACMD were incorrectly displayed. Fix by remembering if we
are processing a ACMD (with current_cmd_is_acmd) and add the
sd_current_cmd_name() helper, which display to correct name
regardless it is a CMD or ACMD.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 952be36399..fad34ab184 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -114,6 +114,7 @@ struct SDState {
     uint8_t pwd[16];
     uint32_t pwd_len;
     uint8_t function_group[6];
+    bool current_cmd_is_acmd;
     uint8_t current_cmd;
     /* True if we will handle the next command as an ACMD. Note that this does
      * *not* track the APP_CMD status bit!
@@ -1687,6 +1688,8 @@ int sd_do_command(SDState *sd, SDRequest *req,
                       req->cmd);
         req->cmd &= 0x3f;
     }
+    sd->current_cmd = req->cmd;
+    sd->current_cmd_is_acmd = sd->expecting_acmd;
 
     if (sd->card_status & CARD_IS_LOCKED) {
         if (!cmd_valid_while_locked(sd, req->cmd)) {
@@ -1714,7 +1717,6 @@ int sd_do_command(SDState *sd, SDRequest *req,
         /* Valid command, we can update the 'state before command' bits.
          * (Do this now so they appear in r1 responses.)
          */
-        sd->current_cmd = req->cmd;
         sd->card_status &= ~CURRENT_STATE;
         sd->card_status |= (last_state << 9);
     }
@@ -1775,6 +1777,15 @@ send_response:
     return rsplen;
 }
 
+static const char *sd_current_cmd_name(SDState *sd)
+{
+    if (sd->current_cmd_is_acmd) {
+        return sd_acmd_name(sd->current_cmd);
+    } else {
+        return sd_cmd_name(sd->current_cmd);
+    }
+}
+
 static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
     trace_sdcard_read_block(addr, len);
@@ -1813,7 +1824,7 @@ void sd_write_data(SDState *sd, uint8_t value)
         return;
 
     trace_sdcard_write_data(sd->proto_name,
-                            sd_acmd_name(sd->current_cmd),
+                            sd_current_cmd_name(sd),
                             sd->current_cmd, value);
     switch (sd->current_cmd) {
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
@@ -1967,7 +1978,7 @@ uint8_t sd_read_data(SDState *sd)
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
     trace_sdcard_read_data(sd->proto_name,
-                           sd_acmd_name(sd->current_cmd),
+                           sd_current_cmd_name(sd),
                            sd->current_cmd, io_len);
     switch (sd->current_cmd) {
     case 6:	/* CMD6:   SWITCH_FUNCTION */
-- 
2.21.3


