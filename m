Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A4C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CDF21D56
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNOlks/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CDF21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKjt-0000yO-Fz
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKa5-0002T9-RB
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKa4-0001c7-R3
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBKa4-0001ba-Kb
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id e26so10089917wme.5
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qaePRTDVUqiKI0GPXX/XP44aWtRXgQAztnFoJ62x+fU=;
 b=jNOlks/Dgt/ock/7nTRQTj3mYYaXzwoe2DVSy/WXPPqdE55coeVguewIDqq9lT/8+N
 O5fUE1UhBe1BL2VOGQl0IUMgMxxmazm0pSheH3bz6QHdko8PAv9aFlSHS0NuptuXDLND
 597nv1wX8QPJCoWqvMzK0oq48k+fYxUGxKq4wVhEbx9rQ+rzLfOvXWR+PDlJnA2sDg0m
 BR7raLn3X30LQUFNO+10+r0nx0I3+U1lEq0RdPv2AArr0kWWH4uSNmaa16S2dZ8hifsx
 pB1Tu5lKbFnWrRvNgQeUpIkOqXVyckfM+/Q8TbSDGo8s/Ou+dVQ1eYBwN4G7TEarHIjz
 S33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qaePRTDVUqiKI0GPXX/XP44aWtRXgQAztnFoJ62x+fU=;
 b=kad2NcLuGOV2KllZ0Er/3UNaUvRBHGnGyqItAf2QkBrKeMeoXSlJ8IY302xfs4XCRt
 oQsoGk0gOJM5OPaCOByT4NLtURvkFriJsiCUPCn5s13UD7XUXw3TM4HuumMSIJWtH8J4
 LVWsCYwYTC2dwjMXL9wz195jjnIoVfJqPkceddvqrEo2sR9jUgPWBqkuRmOkQMjK8aRP
 ljmwRGdi3VvsMFHX73e7DG3JjagKnupJLKr3rxBkiRyeHanjfQnnmYjxx4C30m0Bpw8D
 8lJzlklDQiqZlBQuzsK04+B8wvrvBASc8RRjjny15/hBT+CnwwIThdUTsbGIVrs3/sJ8
 9oKw==
X-Gm-Message-State: ANhLgQ2gV5pPMGmuFbBq/862XkCZEwaEowJ77LVJQiUttY1zRkPvsCIo
 pIfw30mfbBoU0TIllBRGwxLVejQRdMpoRQ==
X-Google-Smtp-Source: ADFU+vuH4twHShWG6tz19R0ZEBxWgCrcJDHcDZfiq9V1T0wTloArYlWNdmw9ChwsIzQzIj4UdHcybQ==
X-Received: by 2002:a1c:a384:: with SMTP id m126mr20634123wme.84.1583768675315; 
 Mon, 09 Mar 2020 08:44:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm25932166wmd.44.2020.03.09.08.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 08:44:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 17/18] configure: Drop texinfo requirement
Date: Mon,  9 Mar 2020 15:44:04 +0000
Message-Id: <20200309154405.13548-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309154405.13548-1-peter.maydell@linaro.org>
References: <20200309154405.13548-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need the texinfo and pod2man programs to build our documentation
any more, so remove them from configure's tests.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index fab6281eb70..3b642136211 100755
--- a/configure
+++ b/configure
@@ -4888,14 +4888,14 @@ if test "$docs" != "no" ; then
   else
     sphinx_ok=no
   fi
-  if has makeinfo && has pod2man && test "$sphinx_ok" = "yes"; then
+  if test "$sphinx_ok" = "yes"; then
     docs=yes
   else
     if test "$docs" = "yes" ; then
       if has $sphinx_build && test "$sphinx_ok" != "yes"; then
         echo "Warning: $sphinx_build exists but it is either too old or uses too old a Python version" >&2
       fi
-      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and a Python 3 version of python-sphinx"
+      feature_not_found "docs" "Install a Python 3 version of python-sphinx"
     fi
     docs=no
   fi
@@ -6273,13 +6273,6 @@ if test "$solaris" = "no" ; then
     fi
 fi
 
-# test if pod2man has --utf8 option
-if pod2man --help | grep -q utf8; then
-    POD2MAN="pod2man --utf8"
-else
-    POD2MAN="pod2man"
-fi
-
 # Use ASLR, no-SEH and DEP if available
 if test "$mingw32" = "yes" ; then
     for flag in --dynamicbase --no-seh --nxcompat; do
@@ -7672,7 +7665,6 @@ echo "LDFLAGS_SHARED=$LDFLAGS_SHARED" >> $config_host_mak
 echo "LIBS_QGA+=$libs_qga" >> $config_host_mak
 echo "TASN1_LIBS=$tasn1_libs" >> $config_host_mak
 echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
-echo "POD2MAN=$POD2MAN" >> $config_host_mak
 if test "$gcov" = "yes" ; then
   echo "CONFIG_GCOV=y" >> $config_host_mak
   echo "GCOV=$gcov_tool" >> $config_host_mak
-- 
2.20.1


