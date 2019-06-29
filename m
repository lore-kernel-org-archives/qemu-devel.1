Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2A1C5B57A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 15:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA07208E3
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 15:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8suKO7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA07208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhEss-0004nt-W7
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 11:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37917)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhEql-00037k-3B
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 11:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhEqi-0007HI-UY
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 11:01:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhEqh-0007Ch-8w
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 11:01:07 -0400
Received: by mail-wr1-x442.google.com with SMTP id r16so7309798wrl.11
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OBGqUscJCP7fBbgEN2disVg7FXjg+Z9utLTLXFbxMGc=;
 b=g8suKO7Y/ReaSKnJL14Swf/K2VMWSzRvneZ+Lw96x8HvDg16WMnJ99MA0vd0HUqiBX
 5XftG/5XGTQPHBfu4oNPBDQwV+ry7MWhNGN1pscjbEbjXjpQTKARMMLtoMnW4KQw01HV
 aol08uejqMT/sdxr8UiUlx9gLYNanmOUdunpWMxkRTO7z1xE12bL/F7y/0bAJBvrht3n
 ax9COnJzkR6p3GxXkQTDWKMJBuBu6lqEPqjw/kE8qsGFnn29N/KamYkIU+8xIvHdWi5s
 626D3S0nmvzwv7BKuCtdyBSVkKK4eD4Rshhi7Lwpim2e4JAgTNevnBJTLvReOkADX9Lq
 xOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OBGqUscJCP7fBbgEN2disVg7FXjg+Z9utLTLXFbxMGc=;
 b=PwvNNAauHT4DQJjkM1CdFxv5BruP8qSWpyvyhPuADRLb2MX1pWoKafTVQQ4aaIHWkI
 XUZZz4aPWI+FS2p//Ue0y0nS7O5wpp/j6ykg763pG4/VLZAiieB5H/hChCt5XKfUxXht
 lcAYMpMJdIegHAsYGpaGhOiNcYWdJ07FfL/aAOvx8vj94aOykM6DZI84zZiqO4wKMOob
 2jLtW/CmniY+ZVJtxrL+gRpRvoVQowmsDsPMuU0sqGOJT58oZC+iH4V3myCRL6ffdsr9
 OYeGphyhZcF9+DtI/DMdcvEFlimGFtvkT9HauPn/Xh5pIdk4MLXNKPxo18sIfED+GxKJ
 5rgA==
X-Gm-Message-State: APjAAAUV45JxIkU4K9PN+Oe3DnTSQVdgdB7R332IcxjJ0J6rT3I94x9v
 tEY2xXZT3aCRK5OIfOn2H0xbxONH
X-Google-Smtp-Source: APXvYqyKpekdoc4VrYTBqfH38sA7QKr+X4okgFLqYN6Z4LTHiA/8o/d/JTfyYHpBi+JdEMZBBATXyg==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr11870158wrs.146.1561820462031; 
 Sat, 29 Jun 2019 08:01:02 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id h19sm5146231wrb.81.2019.06.29.08.01.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 08:01:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 17:00:56 +0200
Message-Id: <20190629150056.9071-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190629150056.9071-1-f4bug@amsat.org>
References: <20190629150056.9071-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 2/2] .travis.yml: Let the avocado job run the
 NeXTcube tests
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index aeb9b211cd..16907b5a78 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -231,7 +231,7 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
-        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
+        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,m68k-softmmu"
         - TEST_CMD="make check-acceptance"
       after_failure:
         - cat tests/results/latest/job.log
@@ -240,6 +240,9 @@ matrix:
           packages:
             - python3-pip
             - python3.5-venv
+            - tesseract-ocr
+
+
     # Using newer GCC with sanitizers
     - addons:
         apt:
-- 
2.19.1


