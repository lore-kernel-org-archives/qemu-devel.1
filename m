Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3CBC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9FF20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBbVtg0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9FF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NPV-0004eF-Vy
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKI-0004fb-MY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKH-0003iO-Mi
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:18 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:37297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKH-0003ge-C4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:17 -0500
Received: by mail-wm1-x330.google.com with SMTP id a6so8631829wme.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mRJBG/zc2GQpI0clN99w+344ScpJbk+vuaXsTd83iMo=;
 b=FBbVtg0B2DtHIda3Y16/vX49BMh0/hFDiAFf3H6iP8zj9TOi6IuWuGSjXOWdVBtDNT
 ibvl5q9JJltl62tVn1yLCo1z9AYydV86k9c0oK9QsjHKEiizGihoSYNte2fyMpoIw3Om
 8wegrkdFhlNjgDlvNAQ+6MqtgmuHHT6an7u+dwBmxFvh9//FTX5hTLA0vj5KxU84m0Dj
 T7532m+E2xMCoqDz23adm1BHdcd8Va8GbqhL5KhEjxmAPvBM2EymicUt8R4dtZ8/VIS6
 /D+5kJOhJk4zJeWyXWfLrVl+XNY1CfMS7PX+H7VPCmJuf+SfSF80dgIKaZw7wPqroj0q
 c9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mRJBG/zc2GQpI0clN99w+344ScpJbk+vuaXsTd83iMo=;
 b=AghUQe7slmrsP/KqrR5uuCXI4JvcVfQFhYZG7+gGVfqK4m6MLauET2eft5Un5m5kNc
 XjLR3B0xC9cyRhDHc5GwKJeHz43dGcYoFAM/Wpj3QxD24klOyu+V8VGZKScQrT3fz2ad
 AdtvCuCzen/Jn7gKiaTkCAAEe8VNDh7nWeSo5/8NhrbLZRRkoiZmB5oC1t0uAdDvozwM
 NEaWawNnV0A0p4WgN68XzPMBdWtPsqZcoeVD9wCj1pET92luLZWb+0diLHTtRmXYYFLz
 Jt9+zdrHe/8ZWS0GqabGgws8aFKKM9vGMwqY0XGut23Da29E9i13z+RvUsxvdg7qLBOn
 Lr6g==
X-Gm-Message-State: APjAAAW+AxiTEAFumRF+QzRQmDA7IZLDEPvK0pE9jfhukgv5b5RBUiEA
 HJXfRPHGLG4cqTzf8wEJAq1iEw==
X-Google-Smtp-Source: APXvYqynCNmkW4jS9MOXirlbbMMtt8nDRPORg7lrwtr18L2aQ1wi07FeVgLTIqy8rJN3vvjLfilJSg==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr299383wme.37.1581634276342;
 Thu, 13 Feb 2020 14:51:16 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a16sm4574682wrt.30.2020.02.13.14.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 150151FF92;
 Thu, 13 Feb 2020 22:51:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 05/19] travis.yml: Test the s390-ccw build, too
Date: Thu, 13 Feb 2020 22:50:55 +0000
Message-Id: <20200213225109.13120-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 robert.foley@linaro.org, pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, richard.henderson@linaro.org,
 f4bug@amsat.org, robhenry@microsoft.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Since we can now use a s390x host on Travis, we can also build and
test the s390-ccw bios images there. For this we have to make sure
that roms/SLOF is checked out, too, and then move the generated *.img
files to the right location before running the tests.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200206202543.7085-1-thuth@redhat.com>
---
 .travis.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 58870559515..ea13e071795 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -509,6 +509,16 @@ matrix:
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
+      script:
+        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
+        - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
+        - |
+          if [ "$BUILD_RC" -eq 0 ] ; then
+              mv pc-bios/s390-ccw/*.img pc-bios/ ;
+              ${TEST_CMD} ;
+          else
+              $(exit $BUILD_RC);
+          fi
 
     # Release builds
     # The make-release script expect a QEMU version, so our tag must start with a 'v'.
-- 
2.20.1


