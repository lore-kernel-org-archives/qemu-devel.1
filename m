Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13015C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF87E2464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzmPi3jZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF87E2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Smi-00056W-28
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j4SOA-0002pw-UT
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j4SO9-0007zx-Tp
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:54 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:38207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j4SO9-0007zO-Nn
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:53 -0500
Received: by mail-pl1-x634.google.com with SMTP id t6so285333plj.5
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 08:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yQ3ZiDck9TzFgYxsZULoxW3XRdOrweY+xSvjOe2by5c=;
 b=bzmPi3jZ+1BBc3nQpP0QhJiCHk9wFOLMkO8ci6dKpKTXJGTKPFADfqYQrm+OoEeSiZ
 te1KGDTyktKWiojvFAJAiAam9VC9Z0X2rXuuPrt2zmY3aHFlNNoXEhhDqj77UBF7uyCw
 7urHk92yyp5MdAvjMzvOfrDaAozfD/KyXOJ57Hu8GeofDvBDIvbfsGHdLLP/Wk5H1m66
 6okFgAZsEc2ynK1Ag2Hxk6aB+f50phn9XekZB43Md5webK0lPLytA1Xo0urDie+fd+OL
 x/wc1I00JSxS4M+Y1EPvWFgqauw/PltqCaPHSEirwS9HHXzqZJkXQj3tCACsg1uLFfv8
 ZmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yQ3ZiDck9TzFgYxsZULoxW3XRdOrweY+xSvjOe2by5c=;
 b=reP/EWr2KDXFO+awzrzWtlnHvgHBs8RYz7mbO6cwGmGwYKZ/zINLoo2T3Shq4ZTD14
 pdI1eJ/FMUzN03bLRi8d7xlaaf12+pb9sF5N9+Am3QMjjCNOBXLvCBgKkLaIPOD5DjA4
 Lmbm06/jeL5I80M4umwjTpNsdYnStv7HECpmn5gIeWb7LfplRJ7z3tK6doSlJdCl6DR6
 gv1391HGmhX9VxPUIe/z+Fd24EWESr/nt2bZC1+g1xW4TPNXdYWhtDTxEEOVhdbh+NoF
 cqovqEOMRgJ/PH32ZyJhnafIYODFal3ijVU1uaTjY6ANMDK5/vaL6l4vDKGwebdyQOsa
 LWww==
X-Gm-Message-State: APjAAAUdr58xmGQuGWjwJWXJqPzcPBl25BkekJ2VMapN4HA349oxR0x3
 ypu9mhyvxDdpX6A7TPD1GgMfrmsFtN0=
X-Google-Smtp-Source: APXvYqwqQDE2gZLRa5M5tjYOZ0UCQxV3q3kLyJ8gU2Hi21Db1t4rdFOSeoYF5J6G2LN5fSbrA/9wKQ==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr9525559pjw.3.1582130392452; 
 Wed, 19 Feb 2020 08:39:52 -0800 (PST)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:3cc2:5eb7:e248:ad23])
 by smtp.gmail.com with ESMTPSA id a69sm112362pfa.129.2020.02.19.08.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 08:39:51 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/14] tests/vm: give wait_ssh() option to wait for root
Date: Wed, 19 Feb 2020 11:35:27 -0500
Message-Id: <20200219163537.22098-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219163537.22098-1-robert.foley@linaro.org>
References: <20200219163537.22098-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::634
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow wait_ssh to wait for root user to be ready.
This solves the issue where we perform a wait_ssh()
successfully, but the root user is not yet ready
to be logged in.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/basevm.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5ca445e29a..7f26892268 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -312,7 +312,7 @@ class BaseVM(object):
     def print_step(self, text):
         sys.stderr.write("### %s ...\n" % text)
 
-    def wait_ssh(self, seconds=300):
+    def wait_ssh(self, wait_root=False, seconds=300):
         # Allow more time for VM to boot under TCG.
         if not kvm_available(self.arch):
             seconds *= self.tcg_ssh_timeout_multiplier
@@ -320,7 +320,10 @@ class BaseVM(object):
         endtime = starttime + datetime.timedelta(seconds=seconds)
         guest_up = False
         while datetime.datetime.now() < endtime:
-            if self.ssh("exit 0") == 0:
+            if wait_root and self.ssh_root("exit 0") == 0:
+                guest_up = True
+                break
+            elif self.ssh("exit 0") == 0:
                 guest_up = True
                 break
             seconds = (endtime - datetime.datetime.now()).total_seconds()
-- 
2.17.1


