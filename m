Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0E5C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B78822251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iU5bVLo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B78822251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvfA-00061l-Ok
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJD-0008Qz-I9
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:31:55 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:41230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJA-00058Z-0J
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:31:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id w5so10932778wrp.8
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2zl15kTFfsHZ2Bh7jmqvRG3PAJE7u2kyw5BRKdhzziI=;
 b=iU5bVLo1FHbfFcM3Wxf8oxY9wbmPRPHZbg4TMlkSojQOecFFIupcWhuOB2If6Tfm2j
 4Lt5weSaDeyVC9T8beBAojs00d8xbx4ItlfyiD2iqqTvCyTURzp6jj144rZocGz8lAAs
 U2BzTLBzpvnd8vLLaEB/xQLGOFPYqsVbvZlBG4OwZ3fKauim2PgmVH6nTMeuDAbFklq7
 NUBdnreYlBTWp2S+mFkq3AvLuFP8Iqs/n/0zk2Y37o2+1u/s1oxeuX3cZTG5Xibkbg3m
 FHeetR8n/xwe5bA82kcBvVN5Fu3wrrPf55pt7ciNlSl6tOQvA6uZXKx/owiS6kbNSzV7
 /Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2zl15kTFfsHZ2Bh7jmqvRG3PAJE7u2kyw5BRKdhzziI=;
 b=BXiL4fjVjLPQYKNlAQOsCUpJ7ucaZ8wgZTIWyHm7RKYFC1AzY2Q1C0qs3OdVvohANH
 XVlTDtF2niHH7I5R7pP39Wl0FlyTPyIGXibOPlqF3RsEUL3WVlstdg+DfKBuRA7RKxMb
 xM8ODYDLVlnJKzYqMJ0T1Xa6I1gbjGAUwaCiTYQ8MNz5I3/gUm75Lq9A1Ugq57lusnJw
 LaCTTrncUQDg6bFu166y3B2/NB4GZSbAHQWk+WSuZtFjoOuZXuoCjBc2gj7b2f1LoNvT
 QH5NS/ymVXn4zaUigGokI/QedWO2+jRL2exd/WMCGupj0aFyElblyjwhCg19R4p9p2cP
 9r7A==
X-Gm-Message-State: AOAM532Pg/dRUUzALGClJp1xrBKVxLRidvWxk9TeV/wBBwl84SxpUZJB
 5sseCg0Y18/ipGnO89+up4W+9w==
X-Google-Smtp-Source: ABdhPJzg7a1or2kKK1+vI9gzDxRZxLa6t+v7Thq3YVWjJKlRxUJXX7SAtMltVL5ATnFO4MNq3cO3RA==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr15232931wrr.377.1602261110474; 
 Fri, 09 Oct 2020 09:31:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t124sm13215223wmg.31.2020.10.09.09.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:31:47 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2B3B71FF87;
 Fri,  9 Oct 2020 17:31:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 01/22] configure: fix performance regression due to PIC objects
Date: Fri,  9 Oct 2020 17:31:26 +0100
Message-Id: <20201009163147.28512-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ahmed Karaman <ahmedkrmn@outlook.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Because most files in QEMU are grouped into static libraries, Meson conservatively
compiles them with -fPIC.  This is overkill and produces slowdowns up to 20% on
some TCG tests.

As a stopgap measure, use the b_staticpic option to limit the slowdown to
--enable-pie.  https://github.com/mesonbuild/meson/pull/7760 will allow
us to use b_staticpic=false and let Meson do the right thing.

Reported-by: Ahmed Karaman <ahmedkrmn@outlook.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200924092314.1722645-57-pbonzini@redhat.com>
Message-Id: <20201007160038.26953-2-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 28df227db5..b553288c5e 100755
--- a/configure
+++ b/configure
@@ -7209,6 +7209,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dwerror=$(if test "$werror" = yes; then echo true; else echo false; fi) \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
+        -Db_staticpic=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
 	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim -Dsparse=$sparse \
 	-Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
-- 
2.20.1


