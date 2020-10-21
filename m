Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F252C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14265223C7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jG/AVq5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14265223C7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLrT-0000nS-1E
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3tqmQXwsKCk8y91z44v35v4x55x2v.t537v3B-uvCv2454x4B.58x@flex--hskinnemoen.bounces.google.com>)
 id 1kVLm5-0003QI-At
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:36:01 -0400
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849]:50693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3tqmQXwsKCk8y91z44v35v4x55x2v.t537v3B-uvCv2454x4B.58x@flex--hskinnemoen.bounces.google.com>)
 id 1kVLlw-000377-8T
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:36:00 -0400
Received: by mail-qt1-x849.google.com with SMTP id e19so2595750qtq.17
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc:content-transfer-encoding;
 bh=ouqoL7S29tD4PVEuJKzZnMTGGD9JXqB31xNOhXsD6FQ=;
 b=jG/AVq5nBj7eTAhu/Qc2wBztX508DEWEu3fOV13uYkzvyPw5/vGuDp0DCwCBSY79GE
 CDSDSc3Vm6JjMWZauxYsUTM0TOqs4Ooe0MTfj+2XAMUdnl9ELLgze5iUgkG5qVgXV6/z
 ZR2RnOgNA6ulPeKISZWw3nqzE/SAQ9REm12ufRVtl9Ws12IHEpSxwyl+1oc1gyylE/Er
 SPb4aPbIS04vNSqfjLviLU7X1vDP4qMyFySP3f8R5Y+hggywC1Yhjv3RPNQQ2b/geyvs
 PK/xCy2WHK9HAngDe74WJ/uf8kUIjHScwBcU/5YDR9CeSN4Qsk/U0p55nWtTCy4PKYE5
 ydBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=ouqoL7S29tD4PVEuJKzZnMTGGD9JXqB31xNOhXsD6FQ=;
 b=RVUWCuDA1FxIVfN3AKenHWBBK5i4iMzPjVB4aAc0E252MEzyXa2j5qlx2eJxv9WrOH
 UOhsoqU2ss2UaxCXBOH8zjUaZ7y31Dz1g2uDNR8jBJY5GWKWcrCc7mLnlK8M/IRc24OK
 djSOSYlXe6S2JCLr/cHrhYO9j/R0UaNpLgOHzDPEIzoP6U77fLryC545wDp8gVxB+Gzq
 uIn7ZFboQca4jJsg+EI+7EW1ePZH3+XWkFYVsvJiHS8UElxvq/EAdgRjGp2vfRfb3Fdy
 LNz4PzkYZB3Gww0wDfUV3xLdbATAcCU1USE6GwpvpGA2bF9BcuDx4BYaE0R/xYPkZu0N
 pVfQ==
X-Gm-Message-State: AOAM5319frWLU7KSSbk14Y5PL47xmwpte1r7o/NBsQJx/LbVMfo2gsC2
 trQR0uyV+oX/qv92cd2cYi3qhmaR6h/RoKVemg==
X-Google-Smtp-Source: ABdhPJyP8YKPG3XRg7cjRMbGH5DrzXObGqxEujYCt9oaAQedV9Eady11tPtdwcm+ehTQxO3h48QZKTnYkINkwhDfDQ==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:ad4:55ad:: with SMTP id
 f13mr4558qvx.21.1603316150574; Wed, 21 Oct 2020 14:35:50 -0700 (PDT)
Date: Wed, 21 Oct 2020 14:35:40 -0700
In-Reply-To: <20201021213544.3399271-1-hskinnemoen@google.com>
Message-Id: <20201021213544.3399271-2-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20201021213544.3399271-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 1/5] Move npcm7xx_timer_reached_zero call out of
 npcm7xx_timer_pause
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, venture@google.com, wuhaotsh@google.com, 
 Havard Skinnemoen <hskinnemoen@google.com>, 
 "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::849;
 envelope-from=3tqmQXwsKCk8y91z44v35v4x55x2v.t537v3B-uvCv2454x4B.58x@flex--hskinnemoen.bounces.google.com;
 helo=mail-qt1-x849.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This allows us to reuse npcm7xx_timer_pause for the watchdog timer.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/timer/npcm7xx_timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
index 5703e43d40..2df9e3e496 100644
--- a/hw/timer/npcm7xx_timer.c
+++ b/hw/timer/npcm7xx_timer.c
@@ -157,9 +157,6 @@ static void npcm7xx_timer_pause(NPCM7xxTimer *t)
     timer_del(&t->qtimer);
     now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     t->remaining_ns =3D t->expires_ns - now;
-    if (t->remaining_ns <=3D 0) {
-        npcm7xx_timer_reached_zero(t);
-    }
 }
=20
 /*
@@ -239,6 +236,9 @@ static void npcm7xx_timer_write_tcsr(NPCM7xxTimer *t, u=
int32_t new_tcsr)
         } else {
             t->tcsr &=3D ~NPCM7XX_TCSR_CACT;
             npcm7xx_timer_pause(t);
+            if (t->remaining_ns <=3D 0) {
+                npcm7xx_timer_reached_zero(t);
+            }
         }
     }
 }
--=20
2.29.0.rc1.297.gfa9743e501-goog


