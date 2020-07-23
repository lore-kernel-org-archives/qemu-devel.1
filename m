Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AECC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7C420709
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2RUmaEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7C420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyetX-0005nk-NW
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyesi-0005Oi-VO
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:19:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyesh-0000Qb-0p
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595524781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lb6eQAjQ2HF/DDL7JEJoIibADYGAxky7u3oNe8ug5Lg=;
 b=F2RUmaEabiifsoOeO/vC0lUfgCIPOmp58yyr+++NLdVyERQdvWVofpucD/1ruzaeOuCzkc
 SYWpSKxPv8eeV4hOO1V+xFtuK4L4WP+lumIw2RpaXilW9clsFA8bvPwL9YCC4vwISBP8al
 0YisjTVZ2/SGhY253KTwq/YeBJbIGsM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-8VyKluJAPG21t6FmT_m0dA-1; Thu, 23 Jul 2020 13:19:39 -0400
X-MC-Unique: 8VyKluJAPG21t6FmT_m0dA-1
Received: by mail-wr1-f69.google.com with SMTP id i12so1584282wrx.11
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 10:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lb6eQAjQ2HF/DDL7JEJoIibADYGAxky7u3oNe8ug5Lg=;
 b=nh3qPIn4nMsG5AQtlYGbaOil2TfzaYL/ufcXFMGtiw/WfCb0aLo6lVmfaqZwxBPKJQ
 U0vc1gLfAURlpZWxu4mKmA4SGKZU9YsJzv3l807P9hFnoKC+UR5D2nGtXyyqg/B0YSp0
 bKLxyJ79cV3xXZyTJTGiYdh0fJjVIbjqKNbG2F9HL49GyO+N5/TyCCk0SF/eN7/Wv1jw
 3eoApWGN8BD/Y68kxJp6abGUjbUA+RLHbmHwme0YT5IhRxWI46pkHxva57fr7AMQduLZ
 uhsqOh+TeJjfjG0rIhNk2STh/7fNRMXOpomuNReLZc8QAw/nBoANMGOjeW64VKGJfdJA
 +TEQ==
X-Gm-Message-State: AOAM533AHi1ODdMD9LCCkxwLv9RjdromcgXolI5N/MkycYEyr1QsgVAj
 lntTFJNE05hXSnDHirYdNeiVZ01tx4gP7dJYz6tfmeC52kyVO5kbnHgjT9aANA+UTJ7bywS+Q7C
 2K5FedLdzBnH9gm8=
X-Received: by 2002:a5d:6802:: with SMTP id w2mr4783762wru.88.1595524778064;
 Thu, 23 Jul 2020 10:19:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNyaRQNSjERSnHBFtBV9MgZfwfQ3281+Bh2eWEbOwMvFVhF8TSLCDMTsPPdDHWUman4Bm2sQ==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr4783746wru.88.1595524777867;
 Thu, 23 Jul 2020 10:19:37 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 68sm4841139wra.39.2020.07.23.10.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 10:19:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1] libvhost-user: Report descriptor index on panic
Date: Thu, 23 Jul 2020 19:19:35 +0200
Message-Id: <20200723171935.18535-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to report the index of the descriptor,
not its pointer.

Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index d315db1396..53f16bdf08 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -2074,7 +2074,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
 
     /* If their number is silly, that's a fatal mistake. */
     if (*head >= vq->vring.num) {
-        vu_panic(dev, "Guest says index %u is available", head);
+        vu_panic(dev, "Guest says index %u is available", *head);
         return false;
     }
 
@@ -2133,7 +2133,7 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_desc *desc,
     smp_wmb();
 
     if (*next >= max) {
-        vu_panic(dev, "Desc next is %u", next);
+        vu_panic(dev, "Desc next is %u", *next);
         return VIRTQUEUE_READ_DESC_ERROR;
     }
 
-- 
2.21.3


