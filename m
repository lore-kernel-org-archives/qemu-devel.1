Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC9BC43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 15:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DCD206F6
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="UVh4WUij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DCD206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIZcx-0004GY-EF
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 11:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jIZZk-0007nq-Jo
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jIZZj-0006nB-Du
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:12 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jIZZj-0006mL-7a
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id m17so17823860wrw.11
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 08:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6H29QJg5B7bgS/AMKBONCsgkT/bfdiwpiQn7qsNuQ08=;
 b=UVh4WUij5fWwaB4E2nyzgrcyB5apVx1mXWyxUpXssPCpNfl8Rrpwrr0butWVGRpWEA
 Y3ZOtbbZOJsnQGKawwq0oll8fpOEGLeG2hKX1M4kGIfMUHoaIKOWw6oF7DQVeN7vut2G
 9BeOOoxYJ6khgw/Kbvwy1CH6IXxJFPmQT4Pr6dKHvwK399cG4JB5T1xAeR3dbViC10GQ
 BwyagtiTeo3hkTloQjKXUJ/ZysOAPXaeYyE2bRP07pJSuoAgz84eTvrhF5af3BX+2qtK
 UB57hYfXrN+y01TsntV/M2UQT3fXIFNELhkJ8AFPxW/RbPnv5nnWfmWKLaBLekFgM1Bz
 z6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6H29QJg5B7bgS/AMKBONCsgkT/bfdiwpiQn7qsNuQ08=;
 b=AReJBSVBQi3zlkhzumTc6bqr5NIODv/YD+uzNjX+HkEsh+8fc9ruldsusaCmDRayif
 +X12kmY9dhnhK+lel3NkSZ8KtLiqfNCYh1qwmKXilMt/iTuTtNW7T0Eqt77x/lZnZRn6
 ZF1iVHF03xOfAArQQSTpCSUAMb2ZhKohCCdrdQuRZLBbx/larYrafWhNyGeYdnu0CdnD
 PWeuDwwyma5FiMUPkbh1wnNomtp9lfjVFsJrmDDEi88Kq6suYXnfiP2HE5lrKNIV48dc
 ceKKep85imloStI5hAbVyYS6v7cmauLgdMIeupS2+WJJykTBE+u1wDZqQ0EbG6cKXUg5
 EheQ==
X-Gm-Message-State: ANhLgQ0nkUvjrIKoOCP1LZBC8KQ5fAtU+UdxSDLBIzpaSwoBbzvaHCpE
 CgO++z//H7GotUShxAyivygej7tjpzwGHw==
X-Google-Smtp-Source: ADFU+vuRIrvcMRuGGl8ciVQ1ek+fGMp21HLObHU/3pzUMTBN3oxxD66tp9j8q0XRUyEXNPEucd2BBg==
X-Received: by 2002:a5d:6992:: with SMTP id g18mr10449960wru.426.1585494609942; 
 Sun, 29 Mar 2020 08:10:09 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-67-107.red.bezeqint.net.
 [79.183.67.107])
 by smtp.gmail.com with ESMTPSA id s2sm5477874wmh.37.2020.03.29.08.10.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 29 Mar 2020 08:10:09 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v7 4/7] tap: allow extended virtio header with hash info
Date: Sun, 29 Mar 2020 18:09:50 +0300
Message-Id: <20200329150953.23812-5-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329150953.23812-1-yuri.benditovich@daynix.com>
References: <20200329150953.23812-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 net/tap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 6207f61f84..47de7fdeb6 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -63,6 +63,14 @@ typedef struct TAPState {
     Notifier exit;
 } TAPState;
 
+/* TODO: remove when virtio_net.h updated */
+struct virtio_net_hdr_v1_hash {
+    struct virtio_net_hdr_v1 hdr;
+    uint32_t hash_value;
+    uint16_t hash_report;
+    uint16_t padding;
+};
+
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp);
 
@@ -254,7 +262,8 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
     assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
-           len == sizeof(struct virtio_net_hdr));
+           len == sizeof(struct virtio_net_hdr) ||
+           len == sizeof(struct virtio_net_hdr_v1_hash));
 
     tap_fd_set_vnet_hdr_len(s->fd, len);
     s->host_vnet_hdr_len = len;
-- 
2.17.1


