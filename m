Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D379EC4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB602067D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMfMurhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB602067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9c34-0001f9-Pz
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 17:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bw5-0003Ll-0v
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bw4-0000oi-29
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:19:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9bw1-0000ma-Up; Sun, 15 Sep 2019 17:19:54 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 7so7887962wme.1;
 Sun, 15 Sep 2019 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o3lreOGB3oKiEQ1zhlghj+GrZGYnvfsMTogCZwdbj7M=;
 b=PMfMurhnfE8N/63pBTT49jdZUvoX62sLdiWrA+FO+S+hFtB11mdpjF7bCulDp0Elt4
 yy19RqKw8iXN0CS5nKh8XMm21sQv+GLVOpzlif0ZWzYA2V8mmDzrNfNdNby7xBF4HgAK
 ILJBDwUqU89HCwJYBZl/bATvLZJ05O9ASd801wdAXkIEANZ7zNgKeSlGE08WvMeXg/+y
 ttYylw1UgRY4nu7GNOU3+bRODxxdCqSUZOfxmGtZ6c6ziziqNWb3LG5tqY5Bu2pUgedH
 SRhuVx++P+RXOe8swcfKF+VwTrSl2He9oWk8bcEMOBBOB3+RfW8St8oi00O6rJTEROih
 mIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=o3lreOGB3oKiEQ1zhlghj+GrZGYnvfsMTogCZwdbj7M=;
 b=lSvGT2xVUxs02ucjljz1KR4v40ebrWE9VBT7xxYGHX7guj0M+xqX1s2xKOn5C9hwYQ
 p28hlj64feW63/ESbTaMYGBtx15DUccro5GSC7j9rJggFAQyxo2PN+v6Rj380zQaGqbb
 /fO6SawsBi3OGLPpWIPtfomK2GdzcJZruS7rsBMyM5Js8aUPoFB8MROkp9aJ1/cBzoCW
 OPLW9inG3D0P0qkiI1GQlUlCIlCiQAR+qo15fcLGe1EBJCM8TTeQ5LjpMejOuaA3yl6g
 iVJCkDotmwz0PslRaJfmxYAIOeEMA6p2NVF6U+FLdLSFSswf4oZnUFiszBduIBcD95Pa
 BgbA==
X-Gm-Message-State: APjAAAUQgjGiox1RVMFrApzzE61OIbOn917r8k+pNgGqEZlpLzkZS+Ka
 a2w/PHaEiRqD4HR150piE7bLt6ne
X-Google-Smtp-Source: APXvYqzvX81CL2DvSUxY3lAbL/LOf2CSlHlLUbWF19hSKdbrIs8OHCHFHkQa825Ib0fNb9Y3q2QENQ==
X-Received: by 2002:a05:600c:295d:: with SMTP id
 n29mr10890290wmd.36.1568582392814; 
 Sun, 15 Sep 2019 14:19:52 -0700 (PDT)
Received: from localhost.localdomain (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id s1sm50271021wrg.80.2019.09.15.14.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 14:19:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 23:19:39 +0200
Message-Id: <20190915211940.30427-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190915211940.30427-1-f4bug@amsat.org>
References: <20190915211940.30427-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PATCH v2 5/6] .travis.yml: Let the avocado job run
 the 40p tests
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
If this list continues to grow we can
- split it (as other jobs)
- move them to GitLab where we can have multi-stage jobs,
  avocado tests run on top of build jobs.
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index d0b9e099b9..69a37f7387 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -267,7 +267,7 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
-        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc64-softmmu,m68k-softmmu"
+        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu"
         - TEST_CMD="make check-acceptance"
       after_failure:
         - cat tests/results/latest/job.log
-- 
2.20.1


