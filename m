Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24929C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAB842076F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="H5BXjcLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB842076F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEUps-0005iG-0A
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 05:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEUnl-0003Cr-Km
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEUnj-0004ZW-Ue
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jEUnj-0004Vf-NC
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id w16so12878435wrv.13
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 02:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6H29QJg5B7bgS/AMKBONCsgkT/bfdiwpiQn7qsNuQ08=;
 b=H5BXjcLvnHEd8F94FZZPv9SVa9ngDmG5O3TxqCfbNOmXNpfM/30W95f0hyPjLxlFdz
 xYCaT45MUJc/cWZdkxEdgG3C9dHWJRsdIBuOF1y78R7ZnrOGMtO8cqb3T1SpceqK2DPu
 jY1p0o2QJi3iBD5GpP0KsxGV7TVTa2YlVbkemy3cMVjBeMRLs8l1cvfEjSNJWI2+IyGs
 pCoorzBKxuAlUTxUwxTk8swAfvgj6UmaxayS1zduCdD0j62j2MZx9b1pP53yKLrVpfyg
 uJAo11Zhst2HpfXeiktT4HhXn7CXPwu9XckvdSwp5IKLocTw3myMeBDczbAhaUdNFF3+
 gUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6H29QJg5B7bgS/AMKBONCsgkT/bfdiwpiQn7qsNuQ08=;
 b=momyeEe2k567PW1Mnir6L1c6HgliBDDnKeWFxzN/PeIVJufrvBxOi3uH0eMuB/ibqP
 U32TAfrXLyHFFhhaLiJtwXU46PKX2QOyKpXVgr3t2QvnyaxY1GOTn41RTUrNdEFNajZG
 l7G2CqexJ9XYSK7V0N60fU7phT27lt9kWqOiZ3HC3UxSX9IScE1fZKI7xYnmCsoDIDmj
 1ePFh8i75EUhpWaIgUmh37S0J9mvmKuVfI2Spydi2MwxllZPRiElU73nnufEuYHzp0b4
 I6+ZFwEvi/jkzVktXcwYIzHOyMGahzSXu66H7bjErTgI0eXcEtvskQe5ZW8mxUFDcdbb
 tKIQ==
X-Gm-Message-State: ANhLgQ0FxGlI5B3dNKm9KCI+8oCqllsZQW7rnZRij7/HF7TEPiU00QuL
 twDYlPRvnpU7h/XIId02M9NV+7qmc2xClw==
X-Google-Smtp-Source: ADFU+vuaXt6VoNU6fpSxWwzynf8kWmbWVihE5qxnQdQjzdIKsXKsDgQujMh7M8cj/EzVRqZAAJLkKg==
X-Received: by 2002:adf:e5d2:: with SMTP id a18mr4583929wrn.334.1584522946494; 
 Wed, 18 Mar 2020 02:15:46 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-43-120.red.bezeqint.net.
 [79.183.43.120])
 by smtp.gmail.com with ESMTPSA id z22sm3062342wmi.1.2020.03.18.02.15.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 18 Mar 2020 02:15:45 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH v5 4/7] tap: allow extended virtio header with hash info
Date: Wed, 18 Mar 2020 11:15:22 +0200
Message-Id: <20200318091525.27044-5-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318091525.27044-1-yuri.benditovich@daynix.com>
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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


