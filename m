Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33732C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F373D20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MsEINU9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F373D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bzC-0002hs-Mo
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkj-0003Kt-Rq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bki-0006Ix-Lf
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:42853)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bki-0006I2-Ei
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:56 -0400
Received: by mail-wr1-x429.google.com with SMTP id q14so18350524wrm.9
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lJs9UKE8HXcOx9xjKy24gbynY7ISo7SHYCDV/WLV+lc=;
 b=MsEINU9jvfhgqNyp2/SlybrJQelHOXbTLMKyRCpm1cagvMnr/aheTKikpc70WkT2Md
 elEjaatKEctqg0Kvk5KV/Vizd8mtcEuxhooeKBXVSXKgurV2PNuMqp2tAA3lHQB4yTha
 fANv8Yv8y3Gns3itbYRKC80OoNmDaq7E+Z/9jhYQQiXjo7yXJGZPXpPnlIxt+nCvMGKS
 GBIJJnebscjs++ARhIGXj5ws5VHX06WEphr34bLv+DhyIjBReAx8KXkwRMnwxYrMCTYP
 AAn4+jmbgoKkua+599Z5Qavk6F7jJTEH32FqR6590rLw4bYuk1KeLTUAGftw5kDniF1c
 L7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lJs9UKE8HXcOx9xjKy24gbynY7ISo7SHYCDV/WLV+lc=;
 b=e61W+jN7XqXy2Si8xcBokEEu/XZjsS/CM6O2IZ6aMCC7PbYfeu8DSeDjsY3JRyLsdM
 U3khJx+66yNSw3Xk3aPAETyUNoGpfz7gzDnyqRvpjIvk8w+3sepX8LPRQ2TQs6I6XrRf
 1NGqigu4B8t6FmlzuJIYRVXDj4Adw3qXoFhmfTySyqFYTPQ3pYnnumr1cAPTGfirDBX+
 BJF7F5xMGd34Q0sEiCIkflqxj+tCxMnUUXhNYGWL/vMmX+TZ2br0SdENUihHPLiBNpLB
 CyZsRULBecRwcz/eOQgPBoSa4dpdGFuApK8zX56eIznIkU6SkETkv4ueS4h3v7qsPJqB
 Lfaw==
X-Gm-Message-State: APjAAAW0NZti9zsEPR38VD+JU+8HAjuDGClyt+duqj89rq+9k3+Xcmh3
 v1BMUqJe4LJ0GY9+5bkEzRV76w==
X-Google-Smtp-Source: APXvYqwIasS6CIUXaG8hZrSWpIZALJHNyZ759pJqaK0DOR3EIqg9t72NFlq4NeT9BxPQsLsMsYgTGg==
X-Received: by 2002:adf:fc05:: with SMTP id i5mr19337868wrr.134.1568105035327; 
 Tue, 10 Sep 2019 01:43:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b16sm25580521wrh.5.2019.09.10.01.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F0C501FF93;
 Tue, 10 Sep 2019 09:43:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:10 +0100
Message-Id: <20190910084349.28817-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 06/45] tests/docker: fix final missing .encode
 when parsing solibs
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 417b0cdce13..29613afd489 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -111,7 +111,7 @@ def _get_so_libs(executable):
     libs = []
     ldd_re = re.compile(r"(/.*/)(\S*)")
     try:
-        ldd_output = subprocess.check_output(["ldd", executable])
+        ldd_output = subprocess.check_output(["ldd", executable]).decode('utf-8')
         for line in ldd_output.split("\n"):
             search = ldd_re.search(line)
             if search and len(search.groups()) == 2:
-- 
2.20.1


