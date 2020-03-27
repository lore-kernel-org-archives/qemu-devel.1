Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B82C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37B52083E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXWLUWWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37B52083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtXP-00074j-Qu
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtU0-0001ll-Lx
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtTz-0000ib-Ov
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:50681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHtTz-0000h9-JF
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:27 -0400
Received: by mail-wm1-x332.google.com with SMTP id d198so12436020wmd.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gyO7FMb6Kog7HFYI2emP9ylf6WG5qE9183WrVkkssuU=;
 b=JXWLUWWDRFiD3ptFdy/HuWqTIY4aC8tmTMIbODVAEFnJCWV20yIYn3/gRJ22Y4NRt2
 vOnm0ewqvTnptRuf/mx3hug//Bd1XhIqPmU4YVrK1q9KMsN+5aX6BBhN5b7zaA9s4UjX
 bICQ1/Bjp2InROzJHfB5+G2+yKmMjtYCBV6VAjaZfryisunxgN4CowxK8n4cvkN3jbrA
 dsxByfeBaTwatrWwRHBsUjCCRepCkYu4T95dO4USLt1D2OYSpUA2GaH0kNqDrOiKTZhi
 TfEtrsTNqqC8h5c8XHwZwl2fAgV50YoJ3krE2XITEteFq9hGczaeyQBrLsMR6Kd62ccN
 h/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gyO7FMb6Kog7HFYI2emP9ylf6WG5qE9183WrVkkssuU=;
 b=cszCjVe67sopQ7D/Tvx2LXlpZk9JQPl/bMYpboXSSUiWOCyowiJ4fLgLV88eUqXFgA
 r7rloYJuWej5jPtho+iT7tXZ1e9Az8/FuE+VWJL/k6NL7M9uElQP8w/8EQn1mCVq0hF6
 gTGu3Ga+hmrqciPFDMUtSRrPWJr3Qda6378GmKqn9QW9uaELWEn0tjPjs3SeUUcp9xoh
 baYgvk7vranUthMNfpJx1XHCJAT2DphL66D6bM1AhNTq4mJx7+il6elTXHvfA0whb5B8
 +uuSZnpM8nvy8UFPqFETR748/Z5x4P36XHNOOcn45BMsyOSqSUOAebYxNyfUU8mjld/r
 4pNw==
X-Gm-Message-State: ANhLgQ1sfTgMd4LAQnxOQgW3pSXxd7pxasigO19e+aF5M4CaN5Kl1Go+
 VhVknTbDbix3uHMxt1PcUw//s0dwyrg=
X-Google-Smtp-Source: ADFU+vvedPAJFVLXPsshlqRMdHNq58JkBTBDWkZOommE7vWFVGnpb1B0ss/ctXgsjD6BAJtZ64esuA==
X-Received: by 2002:a1c:5641:: with SMTP id k62mr6953630wmb.82.1585332806566; 
 Fri, 27 Mar 2020 11:13:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l4sm7998434wru.1.2020.03.27.11.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:13:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 709911FF8C;
 Fri, 27 Mar 2020 18:13:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 02/12] tests/vm: write raw console log
Date: Fri, 27 Mar 2020 18:13:10 +0000
Message-Id: <20200327181320.23329-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327181320.23329-1-alex.bennee@linaro.org>
References: <20200327181320.23329-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Run "tail -f /var/tmp/*/qemu*console.raw" in another terminal
to watch the install console.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200310083218.26355-2-kraxel@redhat.com>
Message-Id: <20200323161514.23952-2-alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 8400b0e07f6..c53fd354d95 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -213,6 +213,9 @@ class BaseVM(object):
     def console_init(self, timeout = 120):
         vm = self._guest
         vm.console_socket.settimeout(timeout)
+        self.console_raw_path = os.path.join(vm._temp_dir,
+                                             vm._name + "-console.raw")
+        self.console_raw_file = open(self.console_raw_path, 'wb')
 
     def console_log(self, text):
         for line in re.split("[\r\n]", text):
@@ -234,6 +237,9 @@ class BaseVM(object):
         while True:
             try:
                 chars = vm.console_socket.recv(1)
+                if self.console_raw_file:
+                    self.console_raw_file.write(chars)
+                    self.console_raw_file.flush()
             except socket.timeout:
                 sys.stderr.write("console: *** read timeout ***\n")
                 sys.stderr.write("console: waiting for: '%s'\n" % expect)
-- 
2.20.1


