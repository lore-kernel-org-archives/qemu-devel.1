Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31861C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 21:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64807208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 21:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrDZ7Hev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64807208E4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW4I4-0002Fx-6f
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 17:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <34kWTXwsKCr0kvnlqqhprhqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--hskinnemoen.bounces.google.com>)
 id 1kW4Gu-0000Wh-4Z
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 17:06:49 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a]:36609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <34kWTXwsKCr0kvnlqqhprhqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--hskinnemoen.bounces.google.com>)
 id 1kW4Gq-0002Cb-DO
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 17:06:47 -0400
Received: by mail-pf1-x44a.google.com with SMTP id 62so2373063pfv.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 14:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=g9hLwZzvASQ+W2Fqi0Pfbug+e02F0q9JvSB2utWnBOo=;
 b=ZrDZ7HevVhqan1iJdkUepw5QvbbNkYPiaGjfKRTjAA2C/ax1CgWLRE7euds9gQFu7m
 hKDb/J/MLg8vnvhQ+zKri+N0GGj+sTibayQC6A+QkV+EDtX4I4mt1cBO7SMxgXJGlWdV
 ZF9XA24Xj37dI4IsE/f2/gtVQ5Mgl/jiinvNp2xFO6sCfcx3Rt3/usc9cXHE1Vkjwswa
 4FyuafB2iwzEBCuhDECiT8fHPaNBLZsuiOVhfjMrJsjj+zFifpI2y+/7AGTwlf/FOmp1
 NaEa9Wkb40cyxFRvqjBOw9feGCycoh3c+hLsqkjC8GXTI/g/pXXMiPD/FcNpMV6P+yYH
 jxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=g9hLwZzvASQ+W2Fqi0Pfbug+e02F0q9JvSB2utWnBOo=;
 b=mUD8uZCIdquWiF5lQQ/p7AkrgpR2hum1UWR0cTeXJORtMuMjJJJeDc/LWa4/U/v5Sw
 2F+JRL2SGFeeGW58S1WCnERKqPjWUig1yG3/3GPTLNCaXqav8PxGWpOA5zJV2G2dP52J
 9tKDtKzPWFGJj2elvIouCIUMoRk+/qmGp6Ii6HLQwl9t25aUggngvSGdkaMf3zD4Dcg2
 L/Mu5UkmskY9gMak+rVMitnkXDPJFgpIdoMAZDDpIZ16UbLPoqX8qnLW1Mkym83y7BfM
 I+GzEQqjyL1K9wqbWjvQz05FbijyhZZgw4t7/wBH3HgnqHplWwN4cfl6XVlqg00IKMiG
 ssHA==
X-Gm-Message-State: AOAM53172AylTsApreaUp2V0VhiWV6vSIv+uO21AI0DKrUZAXeow9ZLf
 xrROUeUD4u4DtFIHrOt0ZBmIbw47hGF2WMQcFQ==
X-Google-Smtp-Source: ABdhPJw6VZtiQ3ErLIO4P1hOZIUdPTwyZoP030d2yIHPG0ZLLSmDGsc308egLa4m5h0m5ZyjzwEJo7e0Lbt3jFfwTw==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:a17:90a:6ba7:: with SMTP id
 w36mr4562011pjj.12.1603487202838;
 Fri, 23 Oct 2020 14:06:42 -0700 (PDT)
Date: Fri, 23 Oct 2020 14:06:32 -0700
In-Reply-To: <20201023210637.351238-1-hskinnemoen@google.com>
Message-Id: <20201023210637.351238-2-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20201023210637.351238-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v3 1/6] tests/qtest: Make npcm7xx_timer-test conditional on
 CONFIG_NPCM7XX
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, venture@google.com, wuhaotsh@google.com, thuth@redhat.com, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=34kWTXwsKCr0kvnlqqhprhqjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--hskinnemoen.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

This test won't work if qemu was compiled without CONFIG_NPCM7XX, as
pointed out by Thomas Huth on a different patch.

Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 tests/qtest/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 28d4068718..7e0ecaa2c5 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -133,12 +133,13 @@ qtests_sparc64 = \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
   ['prom-env-test', 'boot-serial-test']
 
+qtests_npcm7xx = ['npcm7xx_timer-test']
 qtests_arm = \
   (config_all_devices.has_key('CONFIG_PFLASH_CFI02') ? ['pflash-cfi02-test'] : []) +         \
+  (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
   ['arm-cpu-features',
    'microbit-test',
    'm25p80-test',
-   'npcm7xx_timer-test',
    'test-arm-mptimer',
    'boot-serial-test',
    'hexloader-test']
-- 
2.29.0.rc1.297.gfa9743e501-goog


