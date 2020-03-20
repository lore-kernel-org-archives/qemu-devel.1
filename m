Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ADFC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E6B20732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="c1Lnulym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E6B20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGIt-0000yL-3S
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jFGHu-0007jl-6H
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jFGHt-0000JO-AO
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:58:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jFGHt-0000Ip-4r
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:58:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id h9so7074115wrc.8
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 04:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6H29QJg5B7bgS/AMKBONCsgkT/bfdiwpiQn7qsNuQ08=;
 b=c1LnulymITYbvXEwWx+Tc0cFxZLPNjB2tqhHQfUwvY1P8qYR9aZe0fZLQXc79KVlFv
 3jFeV0Kwi28jxCnZ3doO4WQ8TbUotP3c2MOmstCYZ/6mg6CBBehvPKZBTAzVxjEsN/nM
 W5cHsrKNlxFgSoAbuIwnMSZp2uEJrtBPcPruA/Ilrs/dLgp3ADspy5l9WP3GVeCVvOFK
 A4+Fnppq0A8uiM+jWREy6SrkJFkblIAZE7Uz4twEjEEz3QOLaRCSzLEZpwFAyeFcg0YZ
 G0s3ZuaziBddqyhoEl0Cb3dustHsCFqyLDPwR5bKM9AUbrIQeGoxtpErYbZIU1Bqek+Q
 bkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6H29QJg5B7bgS/AMKBONCsgkT/bfdiwpiQn7qsNuQ08=;
 b=oahBTtEEBU/FtSQZE4AzDCjMi1rtzDT2MakIMn6A1Q1hif2IESZPJZLX8zDeWD8k3o
 jcBbhGSyMiKtcX9Muvz4UA0OaOi6GE0yP8ZFLl+Hyh1M07Hp5kway/Yrh/1WbO6ghcvw
 aaFUHi0Ns3vsTMvvE7GBdbSAEbkCb8Gwoe5JFCH5yHwRxmXKMKdd41Cy386mn5Ij5zQF
 1zFfpcRbLyDXoCuarEcTDdig2qgc0i7i8vunzmL0A3MQ7EFoFXd0KYZ8A/0GWgeEoxIX
 TyCu9+fLfVkp5z34t3sTMzGr4Jpk996Gj42iOwj4rYZbu2GBWpQNX1fVsoO3eHSgKZRK
 W0lg==
X-Gm-Message-State: ANhLgQ0+oHgLgk2ENV/RIG/Y7gDNrdq+N7UZvdLptu8ZzNqtybct8lWv
 FeRKhdfNbeGX6s85T/j7jFWQ8ye+EeOuJA==
X-Google-Smtp-Source: ADFU+vu+D7v2zsf+dcj7YlUxiaNkLA1N8YO1nIz4AOdjM9g0se6bzehefE+O/b+dntl1XduP13vsUg==
X-Received: by 2002:a5d:644c:: with SMTP id d12mr10810610wrw.54.1584705483988; 
 Fri, 20 Mar 2020 04:58:03 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-179-79-224.red.bezeqint.net.
 [79.179.79.224])
 by smtp.gmail.com with ESMTPSA id c18sm6637645wrx.5.2020.03.20.04.58.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 20 Mar 2020 04:58:03 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH v6 4/7] tap: allow extended virtio header with hash info
Date: Fri, 20 Mar 2020 13:57:48 +0200
Message-Id: <20200320115751.19446-5-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320115751.19446-1-yuri.benditovich@daynix.com>
References: <20200320115751.19446-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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


