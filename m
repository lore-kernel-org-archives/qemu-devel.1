Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB197C32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74862071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9pdxXEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74862071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5m2-00019K-Sr
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5ko-0007wb-PV
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5kn-0005nD-Qq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:34 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv5kn-0005lW-KD
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:33 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so735661wmb.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M9KSOTkD2gWoA2RLWk5PfVdgjpzXgtuWL43hbZNcZ5Q=;
 b=h9pdxXENG7y50uVISzLTnObe532HLU5wgItqVak7A5tEm2uqR7ysHPmGY4mxqZ52hP
 BTUwcYDEfLg8WD3BeYKpZTLnFkkIh6GQoP6jk9UDIyDbNZaLssiMpz9EWbhd/1jL8CB/
 0ZAuheS9Ip0YDgJM0e3JOK7qUGamegINtLENztloRbnNn0IcSlHnwNFt/ApTUY6pUSdP
 BQ/iJJo8DIIqft06a+E4mqoEptHcPytrT81s4mcHDXq0xmOG+XGVajXwhdadRc1PHVPa
 I8I+Nl60b4DX/xd6f9WVttyIJMwAEda5882pctMQseTJyOaDLZ6jInJSu3YPx01FhTJG
 Gcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M9KSOTkD2gWoA2RLWk5PfVdgjpzXgtuWL43hbZNcZ5Q=;
 b=pcwwgp6Qaqp7EQKzVphiGAUr80pI8pZJLph7wju3JuZGJoE2bH5xorB51JUuWIdl1r
 fhZhBUyz2vlkqvmDGlRRCDplVP6PlWVtA3Zp0Ol4aHvVFOWXiOOVv67He2CxBOCP319G
 gaJzV+F6LANUnJOSfvWRMtq0mfKLDDmyTkA6Ehbr+H0PVyOKBgbEAopojCZHjB0HgAvj
 zX7EA/P+mUqBAPga+lTtm+tvx/N2CYsG3XeHTGnn/clYt66lg27Ym1/xvLdEomZ6uOAf
 2XpCDVWVuwRCvUgXkKSLGgIw6Rd7mfJ4LvSgqvC9Oq7TsJyO8igb3cIEyiq5IZwZu7Pc
 6MXw==
X-Gm-Message-State: APjAAAVZ+Ppp8vB2hvzGhsMGt07y9n9Wii0YdwvUzuzGNRxcbpCEK2ZK
 rhJyRCKPstZzSDTaDtaGT2Skdw==
X-Google-Smtp-Source: APXvYqwLelqZrGseqeCL+awyAD46/2VWzrO3c4XFAou8BqfOcEs1+5L+EujXEcxfMxXJ4G6YGKgI9w==
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr889923wmg.151.1579898431008; 
 Fri, 24 Jan 2020 12:40:31 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h17sm9497814wrs.18.2020.01.24.12.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 12:40:27 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 94B2F1FF8F;
 Fri, 24 Jan 2020 20:40:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 02/13] tests/docker: better handle symlinked libs
Date: Fri, 24 Jan 2020 20:40:15 +0000
Message-Id: <20200124204026.2107-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124204026.2107-1-alex.bennee@linaro.org>
References: <20200124204026.2107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we are copying we want to ensure we grab the first
resolution (the found in path section). However even that binary might
be a symlink so lets make sure we chase the symlinks to copy the right
binary to where it can be found.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 31d8adf836..7dfca63fe4 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -109,7 +109,7 @@ def _get_so_libs(executable):
     ensure theright data is copied."""
 
     libs = []
-    ldd_re = re.compile(r"(/.*/)(\S*)")
+    ldd_re = re.compile(r"(?:\S+ => )?(\S*) \(:?0x[0-9a-f]+\)")
     try:
         ldd_output = subprocess.check_output(["ldd", executable]).decode('utf-8')
         for line in ldd_output.split("\n"):
@@ -145,7 +145,8 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir):
     if libs:
         for l in libs:
             so_path = os.path.dirname(l)
-            _copy_with_mkdir(l, dest_dir, so_path)
+            real_l = os.path.realpath(l)
+            _copy_with_mkdir(real_l, dest_dir, so_path)
 
 
 def _check_binfmt_misc(executable):
-- 
2.20.1


