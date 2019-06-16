Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14698C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA75C20679
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA75C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43060 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hccv1-000473-0k
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40924)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hccoy-0006cN-Kp
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hccox-0006U8-6O
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:16 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:45068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hccov-0006Mw-8S
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:13 -0400
Received: by mail-qt1-f181.google.com with SMTP id j19so8529319qtr.12
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0Gmea495QVVLM6xw0J88mG+RZ+DViLSf/FZoEgunIws=;
 b=ETipsgvkAia9HseAOi5hXIJbwsUkws+7BtHpZNyuJLKl/zG+lB1TdA0Ym2pTG868Fb
 RldNYMb1RLkaCMtrVS9lS8nRgrKtmmLJARCr2qHW4vQEv+E0EKlty7ChQk1QxjBuk9A2
 iuNURL8hkaVat+HS/sRTghv3Vfi5Uadjz/WblGrfWB+5e7+GXZ1gJ4JnPHLcqcvuxysS
 H9lQtaYHLxkxMe4LKh4nJrZ3eJiMFXLu+hgdRM1BuRNtFeP/e8BUA9z3K+GgGloR6Yvg
 h1J+0F6tAUTu9xjJfQAzXFaEsduSh7oZvP+3z28vufoW40BSBBB+DeyPuzQfR66SAdLz
 +oSA==
X-Gm-Message-State: APjAAAWnp/UwJbeO96FzQIOfJUK+Oxk14LTtHxUehGridV0zD/77V1Yq
 1Pj3+JO3u8OQApr5GnyCCbEk2UbwQ1o=
X-Google-Smtp-Source: APXvYqzRW3+iINqJ4zRkGzV/YgOvIEY08R3WnnLeE2GH8m6h5HGLmPPnG5NWlul/RAZKxOhjsGC8ng==
X-Received: by 2002:ac8:2dfd:: with SMTP id q58mr84556004qta.379.1560720970650; 
 Sun, 16 Jun 2019 14:36:10 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id q2sm5379629qkf.44.2019.06.16.14.36.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:36:09 -0700 (PDT)
Date: Sun, 16 Jun 2019 17:36:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190605145829.7674-4-marcandre.lureau@redhat.com>
References: <20190616213540.20430-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190616213540.20430-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.181
Subject: [Qemu-devel] [PULL 03/11] vhost-user: improve error report
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190616213609.PmhlpWhPuZ1Xy5wQVJU0ohiKNNKArkRvpaFqiqQkcds@z>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

g_printerr() needs a trailing \n

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190605145829.7674-4-marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/vhost-user-gpu/main.c   | 2 +-
 contrib/vhost-user-input/main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/vhost-user-gpu/main.c b/contrib/vhost-user-gpu/main.c
index e0b6df5b4d..0ef649ffaa 100644
--- a/contrib/vhost-user-gpu/main.c
+++ b/contrib/vhost-user-gpu/main.c
@@ -1170,7 +1170,7 @@ main(int argc, char *argv[])
         fd = opt_fdnum;
     }
     if (fd == -1) {
-        g_printerr("Invalid socket");
+        g_printerr("Invalid vhost-user socket.\n");
         exit(EXIT_FAILURE);
     }
 
diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/main.c
index 8b854117f5..54f882602a 100644
--- a/contrib/vhost-user-input/main.c
+++ b/contrib/vhost-user-input/main.c
@@ -377,7 +377,7 @@ main(int argc, char *argv[])
         fd = opt_fdnum;
     }
     if (fd == -1) {
-        g_printerr("Invalid socket");
+        g_printerr("Invalid vhost-user socket.\n");
         exit(EXIT_FAILURE);
     }
     vug_init(&vi.dev, fd, vi_panic, &vuiface);
-- 
MST


