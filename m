Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCDCC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC1121530
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8Sre7Qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC1121530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59886 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heHs9-0007IX-E7
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48969)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkT-0000b0-IA
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkQ-0005Fa-Ex
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:29 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:36805)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHkQ-0005Ax-9Y
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id u8so6232710wmm.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rF5i6pzq9tNlUQhJFdaXZR//yZxu/EIyRbH8FbNdhFc=;
 b=g8Sre7QknNHtFtphUdMs5eL54QdJdNbHLa5ErO8JLxbX93KhpcQqd2/yOgY3u3cz5w
 KWsqlBm8HFnQbtip5ineBCESCiPEFrTQBLxbXBacw46bcS5Y6ICkJdkg9ukD2tDmC575
 HF7UAAsBZofU5Z8WOJrpbflq09ukSkeOWU5VYQzKcj5TE9d+TEiLB42hF8PG69Zr3MNc
 pQYumcb3z0LSDKonfHeLgoSFP1L8KFpt64w2M4niBtIgUO44zY++p47YU4BQkMHea8GF
 qqzuxEqmz+WYwxzEy5C3D/kN8LwsmGs3WDHxs1NQ77GwT+XwUeXVUQcMLbqE4zaP5YTf
 F1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=rF5i6pzq9tNlUQhJFdaXZR//yZxu/EIyRbH8FbNdhFc=;
 b=g7YnlWcg32FB5CZ0z4EscpCf2mD2EJR+55OYBBvkSLFQqQYidAFuMQGP99QiyZzLEk
 iuaS6g9RrrWZshkHdvbuZ5B0AtOTk9DWakTSPOgRv295geJirR/m6I4ZIeJZ2cV5GS1j
 gC9UoQUcT3acnx8nXBjuP57RM8unu2RSH1wRdlislEksa/Fj0Fa2N+uAp5c6CVm7iLJu
 kZOpVRSCEa+BFTwdJmRLhDaK9Wr6SNzs8nB6/LN8nFD90rP1gmXkbvWSvykvFZsvOAK5
 13FRzbct2rEsgKigY/KXM7uQnv0NWGnFuI0M+WLebdalb859PgXMEmdGFtjw8Fzz7gQJ
 91Ig==
X-Gm-Message-State: APjAAAVpfZx6Dw5ER0w++Qfini880/3O4SqW61fTc6XsHZshBTNFy61C
 i+0VysX9X+JQwUfE+hugLwlVcMgZ
X-Google-Smtp-Source: APXvYqxPeiv7kTBkZkbvR3QsBfWkHJN6a+axIiGTt7CVpNX35ck1sxbGjtJ256JsZ75CY+E166IZUw==
X-Received: by 2002:a1c:6156:: with SMTP id v83mr4043366wmb.81.1561116623218; 
 Fri, 21 Jun 2019 04:30:23 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:29:56 +0200
Message-Id: <1561116620-22245-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PULL 01/25] kvm-all: Add/update fprintf's for
 kvm_*_ioeventfd_del
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
Cc: Yury Kotov <yury-kotov@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yury Kotov <yury-kotov@yandex-team.ru>

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Message-Id: <20190607090830.18807-1-yury-kotov@yandex-team.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b0c4bed..d2f481a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -863,8 +863,8 @@ static void kvm_mem_ioeventfd_add(MemoryListener *listener,
                                data, true, int128_get64(section->size),
                                match_data);
     if (r < 0) {
-        fprintf(stderr, "%s: error adding ioeventfd: %s\n",
-                __func__, strerror(-r));
+        fprintf(stderr, "%s: error adding ioeventfd: %s (%d)\n",
+                __func__, strerror(-r), -r);
         abort();
     }
 }
@@ -881,6 +881,8 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
                                data, false, int128_get64(section->size),
                                match_data);
     if (r < 0) {
+        fprintf(stderr, "%s: error deleting ioeventfd: %s (%d)\n",
+                __func__, strerror(-r), -r);
         abort();
     }
 }
@@ -897,8 +899,8 @@ static void kvm_io_ioeventfd_add(MemoryListener *listener,
                               data, true, int128_get64(section->size),
                               match_data);
     if (r < 0) {
-        fprintf(stderr, "%s: error adding ioeventfd: %s\n",
-                __func__, strerror(-r));
+        fprintf(stderr, "%s: error adding ioeventfd: %s (%d)\n",
+                __func__, strerror(-r), -r);
         abort();
     }
 }
@@ -916,6 +918,8 @@ static void kvm_io_ioeventfd_del(MemoryListener *listener,
                               data, false, int128_get64(section->size),
                               match_data);
     if (r < 0) {
+        fprintf(stderr, "%s: error deleting ioeventfd: %s (%d)\n",
+                __func__, strerror(-r), -r);
         abort();
     }
 }
-- 
1.8.3.1



