Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306CFC2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3524206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkFijDCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3524206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtPU-0001E2-N8
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF4-0004uc-LF
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF3-0007Hz-JT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:06 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtF3-0007G8-DO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:05 -0500
Received: by mail-wm1-x32b.google.com with SMTP id f129so7407976wmf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=VmTQcO7MS7thh5/mwSJ+9wNSUM+noesb+aFJvdPNQwo=;
 b=AkFijDCaa/Q26zrXhS21VfPc6nNLDsZotA24/i1fiF28r2R1//Mtpw2rfLsGle3PZR
 NG9E6rBdwRrzesfuznQdCJIKZz0/uA82vO+gljUs+NyZEO0OByhhRxK449oB0Sl/BexM
 Gt0jL8GpDf0uRYV7MulVZMSktS1M8dJpqLGBM3BsZco8muwQz2SVJsi0zSO0rkt0jEDp
 xTMmHbGUkVs9BUFEM5yG8RnxbgHvOr9WIlwUwr6AFRuCYHxi7N+hjYzO6DI7ZP877S0/
 gig1SRDAiW6fXgpykDIr1ASfeVIN5P3bW3R1KeAZmWelbwsCTAYwkM4aGenQv909EE7D
 xxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=VmTQcO7MS7thh5/mwSJ+9wNSUM+noesb+aFJvdPNQwo=;
 b=rSbEedW+eLPpTRUNTka05UkNuBt26HU4GOjD+iGpoAvBQ2fzQS1pgI6VYb+bUBVtSV
 HDFr74m5eQV6KxBEqInf5PnvHyQ392ri/daE1CmBK4BWe2egJJZecAxXB8BU9hsCH4xg
 yoBfeqls5dA3zOiZZe5kBMXNkIAumDiyn74NIjtYQ3kpIPf1e+G1uBBOmPylhilRKNIv
 pAMsMVDQKvPdsRIGKC1GPwjE6dGu/7hxJniBhvfdUpy1D1ymOFkQtzbqNBkBo0Tjl8uN
 IOlpj/03LaxbyT4+xTWQdXx37GbPNoz266fUx14xvB7FXY+edSkgZ7Cvfz/UQpjgjcVh
 aRvw==
X-Gm-Message-State: APjAAAWXRKEiHiJEPp73nb9E9GTi0H1eFaQgVvDMFE86vw03QrZ1UlEM
 xX0I+HfsRn2zu6MTtJeYI7eDEa0/
X-Google-Smtp-Source: APXvYqw+1A+gX82rQSgp+AT2jtknR7jP4WTq1iwvUb0btvaNXdxpc0X4G8QbwvtY2P6nJMIFeaC49A==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr5083413wmi.45.1576513744041;
 Mon, 16 Dec 2019 08:29:04 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/62] accel: compile accel/accel.c just once
Date: Mon, 16 Dec 2019 17:28:01 +0100
Message-Id: <1576513726-53700-18-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that accel/accel.c does not use CONFIG_TCG or CONFIG_KVM anymore,
it need not be compiled once for every softmmu target.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs       | 1 +
 accel/Makefile.objs | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.objs b/Makefile.objs
index 11ba1a3..b6fcbac 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -55,6 +55,7 @@ common-obj-$(CONFIG_POSIX) += os-posix.o
 
 common-obj-$(CONFIG_LINUX) += fsdev/
 
+common-obj-y += accel/
 common-obj-y += migration/
 
 common-obj-y += audio/
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 8b498d3..17e5ac6 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -1,4 +1,4 @@
-obj-$(CONFIG_SOFTMMU) += accel.o
+common-obj-$(CONFIG_SOFTMMU) += accel.o
 obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) += qtest.o
 obj-$(CONFIG_KVM) += kvm/
 obj-$(CONFIG_TCG) += tcg/
-- 
1.8.3.1



