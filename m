Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F5C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3089B21D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQsnbO8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3089B21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtNz-0005R7-8h
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4h-00012f-Hd
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4f-0002pF-LH
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:20:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601299212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=se/oNrbj72j7l4wWWeNKso7ox10vwm+7m/MBRp2oEp4=;
 b=HQsnbO8IFM8xrEoDxlHpgNls8BwwmmlG3Q8665znSaVdYLcQcyovj+eb3vMsbwebcpcuTc
 FvJ79iMFCmpAH63QEzev0wPhkfz3lehOO2ZOgE5uKSYiz4qytG1sriDrzjzvqicz3acV12
 zCBoyRSnE8xcJ1Su5WWmIYyvrwMlUco=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-9SD2m5LTPjyo4ulc7pE1-A-1; Mon, 28 Sep 2020 09:20:10 -0400
X-MC-Unique: 9SD2m5LTPjyo4ulc7pE1-A-1
Received: by mail-wr1-f70.google.com with SMTP id 33so401171wrk.12
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=se/oNrbj72j7l4wWWeNKso7ox10vwm+7m/MBRp2oEp4=;
 b=ok0dPgmpdCw7WpwfO7McDbJEr9FYNNg6/TSPtCTe5U8GlrmpoEStgcmNGeAvIcK7Y6
 zx+Xetjk1HWgKY6h5z03r7i4DJlrPY7hyBVstb+p4js5siHAlGIVfgOF/zt25NlgBSap
 s35kYIykMSH6I+6VRpII0isvKKVzTGGRMRvEMu4nbm8IQ+gzsdfjti9mZLvxTs1KfpL7
 7yme3HzO9WiPvumUcDyxl8RjxRWOuGtATSfdFIiaHv0oqJmUD9JcuFoKjI3dPn2Y4jHm
 IGzO+BE613O7yRWWhbfgRq3Q80gRdLqAGOKqpW6vc+TJ/eKgj71CjzHu29Z0z0h3OX0W
 OCEg==
X-Gm-Message-State: AOAM531gwAfm3NjIWEmhpYEztEzt3kNAde/YOFs7oCZXHRbGPcAyNnGy
 HguBzg5yMuljX/tmhNyd2TpOYD9qRg4WNUbXzu3Eg1B2uAGoeQ+fS7UKc75B+fL+xYh13V7XVwU
 t5/QMnlCysKsYres=
X-Received: by 2002:adf:a29a:: with SMTP id s26mr1698400wra.197.1601299209069; 
 Mon, 28 Sep 2020 06:20:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUE02FaPHU84DL31UVZTdkSiT6Kw4FelT6seiFl635D8xxNJTA2H9fSmXydnxs+8HeE17oUA==
X-Received: by 2002:adf:a29a:: with SMTP id s26mr1698382wra.197.1601299208893; 
 Mon, 28 Sep 2020 06:20:08 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id y68sm1281318wmd.39.2020.09.28.06.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 06:20:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/8] qemu/bswap: Use compiler __builtin_bswap() on FreeBSD
Date: Mon, 28 Sep 2020 15:19:32 +0200
Message-Id: <20200928131934.739451-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928131934.739451-1-philmd@redhat.com>
References: <20200928131934.739451-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit efc6c070aca ("configure: Add a test for the minimum
compiler version") the minimum compiler version required for GCC
is 4.8, which supports __builtin_bswap().
Remove the FreeBSD specific ifdef'ry.

This reverts commit de03c3164accc21311c39327601fcdd95da301f3
("bswap: Fix build on FreeBSD 10.0").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Ed Maste <emaste@freebsd.org>
---
 include/qemu/bswap.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 719d620bfe6..1a297bfec22 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -6,8 +6,6 @@
 #ifdef CONFIG_MACHINE_BSWAP_H
 # include <sys/endian.h>
 # include <machine/bswap.h>
-#elif defined(__FreeBSD__)
-# include <sys/endian.h>
 #else
 #undef  bswap16
 #define bswap16(_x) __builtin_bswap16(_x)
-- 
2.26.2


