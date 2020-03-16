Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB17C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026D020658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E66aKtU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026D020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv5D-0004fK-61
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuou-0007Fn-8n
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuot-0007nQ-3P
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuos-0007h1-UB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKIXWkZQ88WTduFFFkbsC3MYjrqzYmU5aP3tKw4s+ro=;
 b=E66aKtU3AjXGs96/bUQH5A5g1RpwU4zb9JoioA0MEJeromP0IK234O6Fu6fA6pI8qaiBe/
 ibe34NoCPlL2Kp1XoSoAfeHP7LItf741XFW0IqUhBe8FhzjvNGbIa0JLiImhlg9c/TLbrs
 QBNTvZ4y/LRZGHv9qDfvIUw6wHalDII=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-XaWtLWjxN6-k15RYNXvfdw-1; Mon, 16 Mar 2020 14:50:30 -0400
X-MC-Unique: XaWtLWjxN6-k15RYNXvfdw-1
Received: by mail-wr1-f69.google.com with SMTP id l16so8749103wrr.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pKNOtl8y4WJnqPTmGJ+A9Z44KVpFXaN4HJISuiqMTmo=;
 b=aAsjxYQmttJ6SMNIVZOqhrlRS+XpDiMFpNf9n8kH49UfGfQwOAc+kt+ZddDeqWImeF
 vYxy19TzrV87wHkMiFujlwX5NDTr8IL86gwVhebwOU7eqeDekzKRi+TqUQg00Ckf880E
 uPZaom5kbm9qNO/GEiGWP6r+O1Ya6/PdbDiC7G4+CAHFAUR8zk75HCfMvKIqlxEbdOwW
 ekn4gc9mTSnIm1AIwTinK9DM7kPgQW5XDy+vkoBougv6MTYZVovV+g6Q2ETwxlBRslKO
 K/3RQAWeI2LyrV+pxmzijDbXBU+zbAPROnok4KYp3Y+aNaK/H/wabVNzUPhR8CS7ZaJV
 2Z8A==
X-Gm-Message-State: ANhLgQ3wCVOkgTRiZlVxp3zDN4H3UnifrO3PuuaJvFQXXLGiBweFEUhx
 y7L4CVVseovHsCHuQdEU6xalyDGK/0FjoHRpxD/C55nfUXvzCV3yi6m+DhBj+uodmYd9i6Iud/G
 YF3l8nLikhkHnq8c=
X-Received: by 2002:a5d:4283:: with SMTP id k3mr772415wrq.304.1584384629244;
 Mon, 16 Mar 2020 11:50:29 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvLYYS1hcFWDjX+81ipfXjuKriBFgByjOnnLP1rmg7qpolVldr1N15Iz2a7I4cYqnmMXQAUgA==
X-Received: by 2002:a5d:4283:: with SMTP id k3mr772390wrq.304.1584384628962;
 Mon, 16 Mar 2020 11:50:28 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id h10sm1079644wrb.24.2020.03.16.11.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:50:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 04/25] scripts/cocci: Patch to replace
 memory_region_init_{ram, readonly -> rom}
Date: Mon, 16 Mar 2020 19:49:45 +0100
Message-Id: <20200316185006.576-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a semantic patch to replace memory_region_init_ram(readonly)
by memory_region_init_rom().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .../memory-region-housekeeping.cocci           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/=
coccinelle/memory-region-housekeeping.cocci
index 3699c1017e..ee3923d369 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -11,6 +11,24 @@
 */
=20
=20
+// Replace memory_region_init_ram(readonly) by memory_region_init_rom()
+@@
+expression E1, E2, E3, E4, E5;
+symbol true;
+@@
+(
+- memory_region_init_ram(E1, E2, E3, E4, E5);
++ memory_region_init_rom(E1, E2, E3, E4, E5);
+  ... WHEN !=3D E1
+- memory_region_set_readonly(E1, true);
+|
+- memory_region_init_ram_nomigrate(E1, E2, E3, E4, E5);
++ memory_region_init_rom_nomigrate(E1, E2, E3, E4, E5);
+  ... WHEN !=3D E1
+- memory_region_set_readonly(E1, true);
+)
+
+
 // Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
 // code sequences with use of the new memory_region_init_ram function.
 // Similarly for the _rom and _rom_device functions.
--=20
2.21.1


