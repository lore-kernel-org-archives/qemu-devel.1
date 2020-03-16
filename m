Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FFEC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D319020753
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOnK+QCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D319020753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47597 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvMr-0002uG-2B
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuqZ-0002cq-FH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuqY-0003m2-A8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:52:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuqY-0003jJ-5m
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AR3d9nNMRFmjviCA9QeiC7WRyBhxuQ8IV0t5Cc30NxA=;
 b=UOnK+QCEAIduUtzR4WpmA2AzLmKpP3A60lQqZSaTecbukW+OpEPpBqGuToOna+4bayq3Sw
 F5s1t4HtsmR4OK+PS1G0PFZ9FLBcEiz7kpeoVPV53Hz5PU28YYabapfYnlv5AL2lEw7JT1
 ViQmZSdbVhRBb6970xHBeFPsoVOgrGs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-I_KV75HMM2WbPqyMyvwK_A-1; Mon, 16 Mar 2020 14:52:13 -0400
X-MC-Unique: I_KV75HMM2WbPqyMyvwK_A-1
Received: by mail-ed1-f70.google.com with SMTP id dm17so13897392edb.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TBpfmSRiP+jw9OHkhFWUdHoGBaG1dAqB4VuWEQEEYBw=;
 b=N/AF96zMqDodo5oiE1rcKA3o8oNThc5U6I1eCwm9A07buXKx44Fdfpr1GWTxaRzxkV
 ZzGvQnq6lQn8ZZWJX/KL34ZYidGZxnjaAG+6X8FCfLSBz+y6FHqZU9eClKuviIvQcMAS
 PsLU/WbfYWxMuVv5JzgtDfv6eqzjjdJr9nmi+McJ1jNY9wZby4i8DPPJH4Qci6U17hT9
 RAT5dIK+V7AqxnrZkQuCitVuxsLbUG2zLVj9936RegHdG0qoo4N3/YhgA0Fc5iXZ2kOg
 IeatQhfbvR438uKv6CUyd7ttBWhSWf64V4qCZZA1w2x8fNadzN3SN8bwyhh7jCQDaTlH
 5zzQ==
X-Gm-Message-State: ANhLgQ08VkD0xt0J2TqswYXN5eaJY60BrPUxjWOM35SBRGSdiDCqEeJ3
 ptihqANHR0qPZ4fJRFHRCjfcqhQ1U4OtpK9/8guCXAnLzrcZk8MnDxzMiIbCSpo2dSlx61nwbu5
 omqh5JkTwrZkoY+w=
X-Received: by 2002:a50:ab5a:: with SMTP id t26mr1490340edc.380.1584384732774; 
 Mon, 16 Mar 2020 11:52:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsJAlBuLmYcN8n8KFL+8zOP47JcsAxX5A8HD5CQdNHCIL6+R6SB8mBOjKPnNRopA5/vp7Zr1Q==
X-Received: by 2002:a50:ab5a:: with SMTP id t26mr1490321edc.380.1584384732567; 
 Mon, 16 Mar 2020 11:52:12 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id e15sm51724eds.2.2020.03.16.11.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:52:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 24/25] hw/arm: Remove unnecessary
 memory_region_set_readonly() on ROM alias
Date: Mon, 16 Mar 2020 19:50:05 +0100
Message-Id: <20200316185006.576-25-philmd@redhat.com>
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "open list:Exynos" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/exynos4210.c    | 1 -
 hw/arm/stm32f205_soc.c | 1 -
 hw/arm/stm32f405_soc.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 3af6502a5e..4e1fd7edb3 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -320,7 +320,6 @@ static void exynos4210_realize(DeviceState *socdev, Err=
or **errp)
                              &s->irom_mem,
                              0,
                              EXYNOS4210_IROM_SIZE);
-    memory_region_set_readonly(&s->irom_alias_mem, true);
     memory_region_add_subregion(system_mem, EXYNOS4210_IROM_MIRROR_BASE_AD=
DR,
                                 &s->irom_alias_mem);
=20
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 2de56275b7..6e93726d45 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -97,7 +97,6 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, E=
rror **errp)
                            &error_fatal);
     memory_region_init_alias(flash_alias, NULL, "STM32F205.flash.alias",
                              flash, 0, FLASH_SIZE);
-    memory_region_set_readonly(flash_alias, true);
=20
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
     memory_region_add_subregion(system_memory, 0, flash_alias);
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index b8fca13f95..d590cd040d 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -103,7 +103,6 @@ static void stm32f405_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     }
     memory_region_init_alias(&s->flash_alias, NULL, "STM32F405.flash.alias=
",
                              &s->flash, 0, FLASH_SIZE);
-    memory_region_set_readonly(&s->flash_alias, true);
=20
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->fla=
sh);
     memory_region_add_subregion(system_memory, 0, &s->flash_alias);
--=20
2.21.1


