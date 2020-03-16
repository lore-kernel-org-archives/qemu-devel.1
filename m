Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7865C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7D620658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReduTQCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7D620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtzt-0006bQ-OK
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsHl-0004gV-M4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsHk-00079c-LO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45413)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsHk-00077b-I7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MKKYJuqMYf+Eg6JeKj/mCe9oLeCOkHxBA5J4VpCzxs8=;
 b=ReduTQCNiNxNPuCFaS2x3o37CNyxUb9WW4SLYgWvb3/9/wGql6qQlOoi+CXfXPjMVa909p
 sbjavOG49rmGtuv5tFkIcvcqzNPcMUneiNYUy1r827tzAaFA1vRKE5YdP5ahHLFSODaY3p
 UHZNi7EZsU57Pi+NgDTiNHnrcNuuJks=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-ZD3IcRPTM2WqvlWypaNIsw-1; Mon, 16 Mar 2020 12:08:06 -0400
X-MC-Unique: ZD3IcRPTM2WqvlWypaNIsw-1
Received: by mail-wr1-f72.google.com with SMTP id p5so9176244wrj.17
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QDZzTTq3ryTffSf3hGL4Htu3pk7V1G5isiblOtOvRc0=;
 b=UdiNfy7Lri1vzsNQoSWA8H4N+zi6ZfMkNz0ConPJzSmmkOPo7D2CQ4RHDTSGY/ZhVK
 jRNcbi7tUOlBk8O84enGBmLIUWmDq7ooESdL/4QA/gW0YKM1xqJ7ERvWDebCnOLgRDvw
 LZVF61byUqNrqLysUvV73K/5EOFxFXK/Xa2QEwdHnGyErnuH1mjJtvbF1pI5WWLt1J0Y
 EmBHZRtUT+y1lRX2CpgpPl+SRXwePY14cSW61jq5fRMfMaj2xhNSUPB4Kzf5X7tVE8ry
 J0y7dor2jTwnwOtknzm3whHsN9k2CO5RrpqAGoAyQa8NluOX6Np6n+m4ZjH/LjH+mDUT
 pZrw==
X-Gm-Message-State: ANhLgQ36Fx8x5WXOzmKkLEKMFJExL2QuuXeFlLG+kaoczV6IAEzWyGch
 xztKcrIVCVeXTja6R2j7+HAnJrTHl1jZ6L4b5V/J1G6MgjGCEZbNmiDOJm/kRjozJ6TdP8VivaS
 MfoNxz011U0RtKec=
X-Received: by 2002:adf:ed85:: with SMTP id c5mr82542wro.41.1584374885380;
 Mon, 16 Mar 2020 09:08:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtsr6U360K/odsCSzAC+mklkWuyn4n54yHB+Y2LZqv/r6/8LWfd199gkdpJvQ01dxn7hcEgzQ==
X-Received: by 2002:adf:ed85:: with SMTP id c5mr82517wro.41.1584374885204;
 Mon, 16 Mar 2020 09:08:05 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id o23sm553874wro.23.2020.03.16.09.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:08:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/19] target/arm: Do not build TCG objects when TCG is off
Date: Mon, 16 Mar 2020 17:06:31 +0100
Message-Id: <20200316160634.3386-17-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316160634.3386-1-philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 kvm@vger.kernel.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Samuel Ortiz <sameo@linux.intel.com>

We can now safely turn all TCG dependent build off when CONFIG_TCG is
off. This allows building ARM binaries with --disable-tcg.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
[PMD: Heavily rebased during 18 months]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/Makefile.objs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 993899d731..0178431549 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -60,8 +60,6 @@ ifeq ($(CONFIG_TCG),y)
 obj-$(CONFIG_SEMIHOSTING) +=3D arm-semi.o
 obj-$(call lnot,$(CONFIG_SEMIHOSTING)) +=3D arm-semi-stub.o
=20
-endif # CONFIG_TCG
-
 obj-y +=3D tlb_helper.o debug_helper.o
 obj-y +=3D translate.o op_helper.o
 obj-y +=3D crypto_helper.o
@@ -80,3 +78,5 @@ obj-$(CONFIG_SOFTMMU) +=3D psci.o
 obj-$(TARGET_AARCH64) +=3D translate-a64.o helper-a64.o
 obj-$(TARGET_AARCH64) +=3D translate-sve.o sve_helper.o
 obj-$(TARGET_AARCH64) +=3D pauth_helper.o
+
+endif # CONFIG_TCG
--=20
2.21.1


