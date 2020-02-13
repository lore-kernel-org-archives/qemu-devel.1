Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04301C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2EB20659
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHX3VCgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2EB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Isn-0005Xm-Vp
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijq-0000ix-5j
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijn-0002zk-SB
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:22 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Ijn-0002vL-Ko
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:19 -0500
Received: by mail-wr1-x435.google.com with SMTP id n10so5872493wrm.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qPc42rOU+K2bcRl791RJcPWPfU6tbDmR/D/lgmu3rFs=;
 b=RHX3VCgOjhNyk18lXE7UVhLw16go464p5KsFIKlYMwjq1hdnSq+sZrfjB7qj1bBE1e
 vyeWsf2H0UpvFFUItljZt0eoxGLMqwiJ4YR6Lv00VTnwNa/l36j1+ReKwA7cNBP4qLXM
 5EEiqCLWsk03i5qG0wjlOIuYde5GaBYD50CBtlskHGa89aR9wyIT+EKRBRvgN3MhS/yQ
 FgyZqC2qVWeryZ+laHJOsMy5znWBlGxO0+E4KWt6I6J8NK+N/OuIsFtwnAjqqe4OK7nz
 FouCCI0LlOAlVAi38BeOHyrpQHpvcKtK3EzCwaHSwT9qPiGPpin30WUh3/p0uDJVhz2h
 Lq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qPc42rOU+K2bcRl791RJcPWPfU6tbDmR/D/lgmu3rFs=;
 b=SKb5DaHrQGMtG9OF3Kf5j5pr/iORdTLE8eQnOd4Rv2ypMecfE07wgit4DL9i33Q6aj
 BTgAssXJ/qXt1W6panRiena57JSOLsXOfMPrkCG/brpMPJTpjqgGX/AsmkalRKhGRplX
 cBPRTkFp2ToTO+PzteBSAus5DEDjRYUednqk3IfJUN9GCppJ+TUdbnfQnTSrrMNUJAID
 XhubEuG9t5C9thG3oV8jQN6COabLVzF8cyAzeGdmRXzDqlVcsWUegvIjp2VV9JP1KDQt
 X3MQGtHw1fdPMH76dQp5ZYO7Qc8RlOViRbEAAD9vKCl6IQWR2ScwPgwkTUW6itPYerx6
 jJwA==
X-Gm-Message-State: APjAAAWcY5h9efKiAcIO8aTZ8is21hr92moBzjHgHi8xB5ojLW6AC+hL
 68+0iPA99T6m0JWJv+VPH+BXqd5OqOE=
X-Google-Smtp-Source: APXvYqwyq9NgrpGNC++7t24JAWMRYjkA1ynXFz5Oac6Ffiyrza0tjiHmWv0FaV31q19YJlQddFykWw==
X-Received: by 2002:adf:f606:: with SMTP id t6mr22828970wrp.304.1581616635653; 
 Thu, 13 Feb 2020 09:57:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/30] qapi: Delete all the "foo: dropped in n.n" notes
Date: Thu, 13 Feb 2020 17:56:35 +0000
Message-Id: <20200213175647.17628-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

A handful of QAPI doc comments include lines like
"ppcemb: dropped in 3.1". The doc comment parser will just
put these into whatever the preceding section was; sometimes
that's "Notes", and sometimes it's some random other section,
as with "NetClientDriver" where the "'dump': dropped in 2.12"
line ends up in the "Since:" section.

This tends to render wrongly, more so in the upcoming rST
generator, but sometimes even in the texinfo, as in the case
of QKeyCode:
   ac_bookmarks
       since 2.10 altgr, altgr_r: dropped in 2.10

We now have a better place to tell users about deprecated
and deleted functionality -- qemu-deprecated.texi.
So just remove all these "dropped in" remarks entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Perhaps qemu-deprecated.texi should be updated -- Markus
said he'd look into that. So this patch is to some extent
a placeholder to get these broken bits of doc comment out
of the way.
---
 qapi/machine.json | 2 --
 qapi/net.json     | 4 ----
 qapi/ui.json      | 1 -
 3 files changed, 7 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 704b2b0fe31..6c11e3cf3a4 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -20,8 +20,6 @@
 #        prefix to produce the corresponding QEMU executable name. This
 #        is true even for "qemu-system-x86_64".
 #
-# ppcemb: dropped in 3.1
-#
 # Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
diff --git a/qapi/net.json b/qapi/net.json
index 80dcf0df06e..1cb9a7d782b 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -446,8 +446,6 @@
 # Available netdev drivers.
 #
 # Since: 2.7
-#
-# 'dump': dropped in 2.12
 ##
 { 'enum': 'NetClientDriver',
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
@@ -493,8 +491,6 @@
 # @opts: device type specific properties (legacy)
 #
 # Since: 1.2
-#
-# 'vlan': dropped in 3.0
 ##
 { 'struct': 'NetLegacy',
   'data': {
diff --git a/qapi/ui.json b/qapi/ui.json
index 89126da395b..e16e98a060d 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -779,7 +779,6 @@
 # @ac_forward: since 2.10
 # @ac_refresh: since 2.10
 # @ac_bookmarks: since 2.10
-# altgr, altgr_r: dropped in 2.10
 #
 # @muhenkan: since 2.12
 # @katakanahiragana: since 2.12
-- 
2.20.1


