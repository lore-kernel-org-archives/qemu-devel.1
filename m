Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9538C76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7108208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuUiua8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7108208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkLp-0000pS-Ge
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57820)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKg-0004XM-5D
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKf-00012e-6n
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:58 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkKe-00011l-Vr
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:57 -0400
Received: by mail-wr1-x42f.google.com with SMTP id 31so24964562wrm.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K3Wy/ye/eKVXgXA5uUlnNSPRyeCvrtd7wt/0KqJUCpc=;
 b=SuUiua8FgyBDal1XtjZN522lafFOH+OattI6ZNjg/Hvfmu5sl0VHqX+PF+1haPCc/m
 sXQy4tv7IXnhygMNpdIc02smwP2otyqT3v79mm8vaXo8YrYRhdXAMXzRFWHbcPVIjP5U
 GYyphmMaSAeFMUWXWpYASOCa7mFDy4RlcDNECxn72IZfmNQ4Ihjxf3AC7gu2TkseQDPz
 88q9eT8UMBLfmN9cHeFr85kvaqpqTk5UQO+FUVmOeWlfRsceDC3tH4ndtf7FFeP4dl4W
 wygDokojP4ntMDAF+653qEC+cpCtlXvNFmedhWXBHyKFnFhlVdWiqk/r5/L2+ljWY0V2
 wu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K3Wy/ye/eKVXgXA5uUlnNSPRyeCvrtd7wt/0KqJUCpc=;
 b=WYDfqp/Zq+QOpJZ3BzDU4X3a8svL403qZnE25+ANXpXCX8RJEIbbiZIaG8J6DlrM0C
 w6j1YwHXPF6y8V8vVuGZwXKpsm0LviZ1gOrzkWmm8LeZUgCHGcdo0WnIO8r0M+179+It
 feTT1RoBLaOTougpgXxI2X1+aPmimUJdALma9Dq/QHv1LVGXhwM2NseWk8rVY3JVenvR
 g00pOEJOQ6MQoBRpJW/Gkv43X2+BdbVwNoKfxmwkkeW8XxU3YexzEOg6WUfJ39rYDAed
 L5ufOIfI6cYNnlVGGCVVYYvglI3KJVzhCEGWAcdccjnWt3eSDJjm8CiGqrdiCeyWhHWK
 WTVA==
X-Gm-Message-State: APjAAAWkXZ9hWYDYbFI47E+cEIH5vYfm9WyHWSGBhepHCodmCVZ+SJHP
 IYBhlRHmciM7UiTryVCyDkra9A==
X-Google-Smtp-Source: APXvYqxrevXP9Ss97FaL5bURFIAvNNj2oamCqJw+O93Ac8KqbkXRTQ7v3GtxteMBMhaviFNkoQcquw==
X-Received: by 2002:a5d:4108:: with SMTP id l8mr42603309wrp.113.1563371455854; 
 Wed, 17 Jul 2019 06:50:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c6sm22425483wma.25.2019.07.17.06.50.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:50:52 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9343D1FFA6;
 Wed, 17 Jul 2019 14:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:32 +0100
Message-Id: <20190717134335.15351-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PATCH v2 20/23] tests/qemu-iotests/check: Allow tests
 without groups
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The regular expressions in the "check" script currently expect that there
is always a space after the test number in the group file, so you can't
have a test in there without a group unless the line still ends with a
space - which is quite error prone since some editors might remove spaces
at the end of lines automatically.
Thus let's fix the regular expressions so that it is also possible to
have lines with one test number only in the group file.

Suggested-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190717111947.30356-2-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qemu-iotests/check | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index f925606cc52..c24874ff4aa 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -488,7 +488,7 @@ testlist options
 BEGIN        { for (t='$start'; t<='$end'; t++) printf "%03d\n",t }' \
         | while read id
         do
-            if grep -s "^$id " "$source_iotests/group" >/dev/null
+            if grep -s "^$id\( \|\$\)" "$source_iotests/group" >/dev/null
             then
                 # in group file ... OK
                 echo $id >>$tmp.list
@@ -547,7 +547,7 @@ else
         touch $tmp.list
     else
         # no test numbers, do everything from group file
-        sed -n -e '/^[0-9][0-9][0-9]*/s/[         ].*//p' <"$source_iotests/group" >$tmp.list
+        sed -n -e '/^[0-9][0-9][0-9]*/s/^\([0-9]*\).*/\1/p' <"$source_iotests/group" >$tmp.list
     fi
 fi
 
-- 
2.20.1


