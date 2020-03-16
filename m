Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D5FC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9E72076A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="w+Svhp4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9E72076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDnye-0001rK-Oa
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 07:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jDmgv-000635-CH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jDmgu-0004LW-75
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:09:49 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jDmgt-0003zS-V4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:09:48 -0400
Received: by mail-wm1-x343.google.com with SMTP id z12so8107477wmf.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 03:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6H29QJg5B7bgS/AMKBONCsgkT/bfdiwpiQn7qsNuQ08=;
 b=w+Svhp4cGh5E4G64FVtLDqRzoo9jo6hTS5Mtm6YdRuvLH7sVjCIjXBsJFqEQG+qD7D
 NjF4pOrrmcOW4ItqTVoxnL/TMI2ymHKhSdbR4K7kFjrgWLTlZbdmvt2zLgk87SQcO3VF
 UHYQqgkBsVY1T5XN4TpftCaIDc646eYgIIZIFuH0c90nLnK3639Vr8mb5IIz0oXSEi9S
 Zy7JodrXqz6zQV8vyWnbHfOOfV7kJt06wfwbfxGXsrMPRq8kUyJ8LD9X2NnI4+XZEoF0
 eytsfT2esSnkt/vcsAQkj0NOt2F/BodvvVDTgFoytezV8w6gxJaZNpZboIKnUKNaiQhv
 ycoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6H29QJg5B7bgS/AMKBONCsgkT/bfdiwpiQn7qsNuQ08=;
 b=TXCaPgB/IDG3bz1tOdRclLnqpaI8lNtEvqHU8TAMq96F8VoRKQPKRlmOh0Sg4S4nKp
 lc/OAqnk6OGOjx+khfX7untEYCeCOQ6XQzZLhnPtBtop++Dzyy8Mx97MRbBFqovoyMAQ
 9Rdd9/24hOLWuDQg6GFyV2oys2uuj4BgKrINshSEEDroalLyKuuLtS6VcRvoxZfKNoaX
 HJmqv8alT357sx9PefpcU6Y98JczR+4OEhx1m0YLNP/3nyPY+76dRvzDEvaBbXIB7GOp
 g8LiE7wduyiVzYVljouHMs++lwl1InOZHBxfpTuhmwAni7QQuRJclsARwZA3tVQipQPr
 K2Bg==
X-Gm-Message-State: ANhLgQ3duV42GnHRZJetugr9aNzVjW9E1i9VXsRfDAYQKs33DurlvFHV
 TxbxJmFielqR1DUwN343vpmxfM55Njvq1A==
X-Google-Smtp-Source: ADFU+vuXByjITBfw2urnYct3pk7FPEG9hsldv4bbJLUH3odgAyGaE/i9Jh/tBaOiohze0LTgfTst7A==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr2648250wmi.72.1584353385175;
 Mon, 16 Mar 2020 03:09:45 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-43-120.red.bezeqint.net.
 [79.183.43.120])
 by smtp.gmail.com with ESMTPSA id l7sm22083171wrw.33.2020.03.16.03.09.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Mar 2020 03:09:44 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v4 4/6] tap: allow extended virtio header with hash info
Date: Mon, 16 Mar 2020 12:09:31 +0200
Message-Id: <20200316100933.11499-5-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200316100933.11499-1-yuri.benditovich@daynix.com>
References: <20200316100933.11499-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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


