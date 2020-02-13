Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3EBC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59AD920873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="su5TYmbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AD920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NQr-0006h2-KS
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKR-0004z0-3R
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKP-0003yj-M7
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKP-0003wz-G9
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:25 -0500
Received: by mail-wm1-x344.google.com with SMTP id q9so8048988wmj.5
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4d2JrUPmJz37MvIYKDE4vOLfs/ja0Fe0BZeISYiAcVI=;
 b=su5TYmbTV8EqVUvI5Rbzg++xTc3zln8HoL8+32e74qkFtxFme3rZfFMUwB/bqqArwH
 zeQxSZhMgsuIr17uoNkk/20cAJMM6CH5UnQ19MBBZmnDq0Lg3gL+fHJT+75eCJxeFwxO
 PIhowZcu76IyzM9NsrvaWdy8r27lcM3VBUgUMv3MTHiGHzyFbIyI9WvZjUwlpke7r5jj
 kWw26qdmvjevrml5wdm8ANmhvBQUNTSxUmuto9Ve7a2aKBMZUDAfUm8VFiKVhi+Tc6WX
 xdLZOBrFWT/WSC3NUM/8aoiCauYCbOd2v6Rb36iYPohrByQhXtHPFBMl4Bml/qCGlsTh
 kG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4d2JrUPmJz37MvIYKDE4vOLfs/ja0Fe0BZeISYiAcVI=;
 b=YQH13jI1GsuZPpmKfnem/Ie1yup1PT6ucVWNxRydMH7enAce/oT9drM3qAdbN5PTJc
 kno/RZaI1Njkt1vAk4U+F6hAQN/C0/LTzOWn0LNczg9ly01/lLir+jmWHcWholtzFQ52
 Hm41oIyTtCgkZywS5mrRPsRKQoGdGrckuS2L05t47hPTUyI2jmb9EbP0KpvBtVUjxcb7
 ROwA+TSn7Qx93nQJuEOLM0fmJrCubBvwxrtFH3fr4tJcAZiH8cOXxWRTSqbcNHhaUE/G
 buz81o+TfgmIcDIc/SadOuTH1++ZboiHSsXek50ZSf2zKTgbFw6AWAMY+bAz6n2IsgYb
 /mSg==
X-Gm-Message-State: APjAAAVzUa36OO/SgxQD77HbHs63irtKrJf9oOSYhj1DfknF9pqmhH64
 Lki2th2slAeOl8YXV5jlmkHjDg==
X-Google-Smtp-Source: APXvYqyIlGEVz8lwt+iG+rKsHv3uASXqYYYTgX9jLrt1lS2pAlGaccGZda8LAL5AvITmv7GSkEBUjQ==
X-Received: by 2002:a05:600c:2207:: with SMTP id
 z7mr322928wml.138.1581634284473; 
 Thu, 13 Feb 2020 14:51:24 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l132sm4922715wmf.16.2020.02.13.14.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:20 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7FC8E1FF9A;
 Thu, 13 Feb 2020 22:51:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 10/19] docs/devel: document query handle lifetimes
Date: Thu, 13 Feb 2020 22:51:00 +0000
Message-Id: <20200213225109.13120-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I forgot to document the lifetime of handles in the developer
documentation. Do so now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
---
 docs/devel/tcg-plugins.rst | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 718eef00f22..a05990906cc 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -51,8 +51,17 @@ about how QEMU's translation works to the plugins. While there are
 conceptions such as translation time and translation blocks the
 details are opaque to plugins. The plugin is able to query select
 details of instructions and system configuration only through the
-exported *qemu_plugin* functions. The types used to describe
-instructions and events are opaque to the plugins themselves.
+exported *qemu_plugin* functions.
+
+Query Handle Lifetime
+---------------------
+
+Each callback provides an opaque anonymous information handle which
+can usually be further queried to find out information about a
+translation, instruction or operation. The handles themselves are only
+valid during the lifetime of the callback so it is important that any
+information that is needed is extracted during the callback and saved
+by the plugin.
 
 Usage
 =====
-- 
2.20.1


