Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF56C3F2D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4D620842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOl9Imkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4D620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j99Bb-0002eT-Pr
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j997u-00036I-2X
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j997t-0001jd-5e
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:30 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j997t-0001jP-0N
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:29 -0500
Received: by mail-wm1-x331.google.com with SMTP id a132so3628158wme.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 07:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dCr0Z8PfAqS4rx+S0HXKAf2zVkW9ZlqRt2oF49qU2FA=;
 b=wOl9ImkwaY3Uqjx0tIh0Q63lHkfUPR6yweTUt9tJHAqBQ5v9Y4ko5P/5CsurSJA4Sq
 uUuH4NeHPSzoAK/uIXymRvMdJLxF1o0IVlTXvYKTqFdWdEl8A+IZs/emEvoY6XDD9Tbu
 HL/N/bvnALbE2cRwquf5OBtHkD/fYdH9Mn1K9vMX+hIVsR5AvjoTCl2HQGUX/xqjUNrg
 3pFkyzwUR3PtYs64tGdES+bpKwm7xUaalr0vloknaXwaX+a6dPk6VPqk9QFODwKvlAGz
 0fTTS62U3ywqV5qWO96WjAT/5JNnVSbJa/PMlFH1pD9s2QKgbD9kWjdeNgidupVfRSJK
 8G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dCr0Z8PfAqS4rx+S0HXKAf2zVkW9ZlqRt2oF49qU2FA=;
 b=MJE71CAkEOqe73zuSnCJlFemj+QukWK1hzhH4gOWGilDe+ZAceiutbL04MXIZkuRAp
 Prr3NF5jSOoM+43IvLMXabyNjz+jwAcPT881ACquUbeUEk/jrqxbvfGyvSO+QWfaFgHg
 2RooJL5GHcqMjW+CZpIhrVNxjJEzLGAmHXH+TOkXjDFVe+okO6J4bQUOguRYTItN/Yd3
 yf74bNKHTuUeMEi7CAjUJmpKH4tWEbYDLVH39Ty5t/rDEd1ZyfPHUE+LWsqBj6sJ2pux
 +yQXkmOJD0/gEc5WrsshPzxOUv4iOkkB1BhQBfzAcNYlrlQvYNhCf/gQ0vhQxC+PMF5T
 PA+w==
X-Gm-Message-State: ANhLgQ3k8WAgIDDwbK4O0bdPPZpM7uSa/z6eyHmDhjYvwO0YTtExTmjQ
 lBdA3I+prYqTCTn05gvo+5DMWQ==
X-Google-Smtp-Source: ADFU+vu6vflnd0d4QlJjgvPsUQAN7AYLQm66RsQDhuVvuZzyiU39BuHGVMR6kqiP1OvLfdWq8Y5XHw==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr4455926wmi.45.1583247987858;
 Tue, 03 Mar 2020 07:06:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v16sm16264948wrp.84.2020.03.03.07.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 07:06:25 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F26351FF90;
 Tue,  3 Mar 2020 15:06:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 3/9] tests/vm: increased max timeout for vm boot.
Date: Tue,  3 Mar 2020 15:06:16 +0000
Message-Id: <20200303150622.20133-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150622.20133-1-alex.bennee@linaro.org>
References: <20200303150622.20133-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Add change to increase timeout waiting for VM to boot.
Needed for some emulation cases where it can take longer
than 5 minutes to boot.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200219163537.22098-4-robert.foley@linaro.org>
---
 tests/vm/basevm.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index c99725b8c0d..5ca445e29af 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -57,6 +57,10 @@ class BaseVM(object):
     poweroff = "poweroff"
     # enable IPv6 networking
     ipv6 = True
+    # Scale up some timeouts under TCG.
+    # 4 is arbitrary, but greater than 2,
+    # since we found we need to wait more than twice as long.
+    tcg_ssh_timeout_multiplier = 4
     def __init__(self, debug=False, vcpus=None):
         self._guest = None
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
@@ -309,6 +313,9 @@ class BaseVM(object):
         sys.stderr.write("### %s ...\n" % text)
 
     def wait_ssh(self, seconds=300):
+        # Allow more time for VM to boot under TCG.
+        if not kvm_available(self.arch):
+            seconds *= self.tcg_ssh_timeout_multiplier
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
         guest_up = False
-- 
2.20.1


