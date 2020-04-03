Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B05C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E34520737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQtp3mtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E34520737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRIL-0003ov-9e
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 14:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKRHb-0003OS-ML
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKRHZ-000181-EJ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:43:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30507
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKRHY-00014v-SR
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585939387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aflw+9+mXSochuywzMjNdIDnZMy92ps7iSaKDSbRwW8=;
 b=MQtp3mtTnajcPrkx4EnCvfkW12xVhMyAS9TtgsCAiYWcNXyLm75KNG0KTbet2P8iHtNU+H
 aChYcmYCUr1GUhTeJbYB2vkcoeg1fs4Om7Zs8ProsfKAPWy29+JGBSP+8w2oILsSHjhgGF
 4jgHmerv4idUN/X5+uga935H0yEOxDw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-Uhf99Pf3OZe664ZO6tGEyw-1; Fri, 03 Apr 2020 14:43:01 -0400
X-MC-Unique: Uhf99Pf3OZe664ZO6tGEyw-1
Received: by mail-wr1-f70.google.com with SMTP id l17so3555769wro.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 11:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZbQSFTf3G55+jXIM+T5OHMkujsrP6OCc73IyjQc/Uy4=;
 b=G9NVGCUH/4Qg1XcF3qF9B206deX/CbzhqgxHemSAUMZmy3b0g4gyJU2T8kj67Q5Bn2
 6DDMh6DIJJ0rodhk4myWcJJekVaYSiujUsetzAs5GFzy0M1byUrjuO0JmbKzQj0e2ld1
 rh30BqLbkkEiZQo2PialfLqeyro03O2V0KE1/2lQw8Vmm7o2Y55NyD9hicpQshzMFKPW
 Wu+ecQ8rS6ArkFGbQwOmkXTTH9MNHggGNyUfhpl6tQQvaW4oRSlChSAxPQYmRvXiUf6E
 ys0bU1yDodSWxViA1UHQkWr6RRdFbEPUMW3Spgpntj1ZyYijXKgFSG4Vw8J+eUV4gzaZ
 QlqQ==
X-Gm-Message-State: AGi0Pua9R0SGFK25pZNyS8JsAb0sNnIrfjcqsft3gvXDaN5HKjUkbZL5
 ny6qgOmdQ6MCIofp7jZ+0wW7ZDxA0BKb5fTlNTBtqexuUNGY4LSWoUqmDeB3Nm/GHLXIFC7vX3d
 vT6+ZmZJJjeYJLUQ=
X-Received: by 2002:a1c:de41:: with SMTP id v62mr4624033wmg.14.1585939380359; 
 Fri, 03 Apr 2020 11:43:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypLMiJtDxBZv37AZGRvRY4UQfIq/5MF+NcUvvnq4OgfvO+0z+pdKA3E3kS+GKFLfTfujGOxqPw==
X-Received: by 2002:a1c:de41:: with SMTP id v62mr4624018wmg.14.1585939380150; 
 Fri, 03 Apr 2020 11:43:00 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id w15sm2492580wra.25.2020.04.03.11.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 11:42:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] target/rx/translate: Add missing fall through comment
Date: Fri,  3 Apr 2020 20:42:57 +0200
Message-Id: <20200403184257.28040-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity reported a missing fall through comments, add it.

Fixes: e5918d7d7f0 ("target/rx: TCG translation")
Reported-by: Coverity (CID 1422222 MISSING_BREAK)
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/rx/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index b3d7305f23..61e86653a4 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2362,6 +2362,7 @@ static void rx_tr_tb_stop(DisasContextBase *dcbase, C=
PUState *cs)
         break;
     case DISAS_UPDATE:
         tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
+        /* fall through */
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
--=20
2.21.1


