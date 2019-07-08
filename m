Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77089C606AF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4952D204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTVPVhde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4952D204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkTfQ-0001GZ-Hm
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 09:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52297)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkTbR-00063U-Is
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkTbQ-0003zd-ED
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:22:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkTbQ-0003yv-7R
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:22:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id p17so5924192wrf.11
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=inhHrQ3AI5RlPujeD5LJ2O+2+s1WgKNbXgbANrqMOi4=;
 b=eTVPVhdeyherxUvJSK5IGkZJpBPhn2xeuofXNrNzc3eGHyVAgNJasZIFhUkBIwr2Hb
 4TDpLXwb0BnID8zQIrUFfeXDs29DZuNh+xV8C/iUqf/F9tyZYktd7NpLsbAl9e6abXnb
 kTeoYjwKuRbN9GEG/3vSbRdDFUGf+3XjrdemUe2JHnNLnZI4CCHdz5psBJKv0G6rgRO9
 3PxcZSmUwP02PReFjLSCIXVDzuGw2+21IzqT7MH6ykiq7c5VbliEW5CcolLOayrNKQCy
 9BugsbcOEraMhLHtd8Ae+YFagJZry0TiJYeo8V4iUGMePi/EME5PjJh9W/oXcnJbeSkJ
 TAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=inhHrQ3AI5RlPujeD5LJ2O+2+s1WgKNbXgbANrqMOi4=;
 b=XI6K3h+0IrCznbD018JY5pU/0zW/9BoLJwH8j1aIBQSYen7CSSY5KWniY0tOihOJLn
 +tHQfhcrHtSLVH4cwxTPodau+m2/oXdhk5E25IaVnOegNzMz3fqZ+qwgYiwd9Pp+WFqi
 GRVJMpN7oxRUJGsj5wWH1NwZjpPXbvWHadNC4Qls8RlnVa7aak2pxlSAx5H5I6N/6+m4
 tqoeqRAxKhPV6xJMPQ4ti2UJrzaD+VRjBCS52x3eM4GpDOc09vhX69GnuPhbAFkoTQuV
 aV4pihiBqUVDacSjSEe537fySDrODjdvopOQGpXrjnAnjnCoredIKTFN2mVdSUWQmO7Y
 oc7Q==
X-Gm-Message-State: APjAAAUMDKx8nzzuQLNNgIhXp9g+P2Fo/keZ+TZprZzTKK0Zyf7Hz06g
 dYfqkxLdFbnxyUtRxm2Aqk9cu69ecSMZRA==
X-Google-Smtp-Source: APXvYqyqGzYOCvxpQ+6zCX+siHSIcHvRe7Vo/GSYtDSr+eKBFVH/gaorozOpBXc77asIoRpZLcTl1g==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr18643789wrv.219.1562592162974; 
 Mon, 08 Jul 2019 06:22:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v15sm13773744wrt.25.2019.07.08.06.22.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 08 Jul 2019 06:22:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  8 Jul 2019 14:22:37 +0100
Message-Id: <20190708132237.7911-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190708132237.7911-1-peter.maydell@linaro.org>
References: <20190708132237.7911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 4/4] target/arm/vfp_helper: Call
 set_fpscr_to_host before updating to FPSCR
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In commit e9d652824b0 we extracted the vfp_set_fpscr_to_host()
function but failed at calling it in the correct place, we call
it after xregs[ARM_VFP_FPSCR] is modified.

Fix by calling this function before we update FPSCR.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190705124318.1075-1-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 46041e32949..9710ef1c3e5 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -197,6 +197,8 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
         val &= 0xf7c0009f;
     }
 
+    vfp_set_fpscr_to_host(env, val);
+
     /*
      * We don't implement trapped exception handling, so the
      * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
@@ -217,8 +219,6 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
     env->vfp.qc[1] = 0;
     env->vfp.qc[2] = 0;
     env->vfp.qc[3] = 0;
-
-    vfp_set_fpscr_to_host(env, val);
 }
 
 void vfp_set_fpscr(CPUARMState *env, uint32_t val)
-- 
2.20.1


