Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27231CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20B12184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GreiRrDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20B12184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzlw-0003NQ-LA
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzeg-0002RH-8Z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzee-0005MG-Vh
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:18 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:44858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMzee-0005Ku-Oi
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id z9so19298818wrl.11
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vLJ2YSmOllt3Q5f6C9bffaEhtm/oTDIY5U5spBdjavA=;
 b=GreiRrDrn1dTZvi+EVPtSfZ2qeMn4Q1x/1sQt24uacUchA3poE31MCxyLvMX2LalGH
 goenCo2T7vnVJBeIQ4wNLz3Uxf0wKVOnuZj34sTjXDoqbY2FWRza+Ksq1jeCDsQ2/ORR
 vj8qJN+5U5BVBoVvudHtmcRnfX7iHXLtYOE3NYd3pLb4AN9BXXxsRko4yeA5F3D7aTjT
 ZLDhrajPKcx84Lfu9nMx+8SE1E9JF5ewdmaYV+nHRYhqErJVBrlsW1L3AKn7bewTtWgV
 xtRbspt8Nn4PIBgecefaSOD5nnfR2pmUdYB6cnznEdybTG0GNwORqekj3N+CPxPqcCr4
 bang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vLJ2YSmOllt3Q5f6C9bffaEhtm/oTDIY5U5spBdjavA=;
 b=PDnB4uyQLTKxnlZQaAIEYOEBW32ilSB084YzDUrORXHikyWhJd/T6+eo8ea2PrRkbx
 6BY4jnTXHDKOVVvmFMGoymQQFlwCQ647R9WaeLyswzyJrfsLYizuYQPwIjevTkW4VP61
 poOT+wQgJ4H0u6K5erCLxmd8zo6zsCIAOh9WJfp+t9jw2RQZbxhW+4RfPhg4dv/HfLPW
 2KHGxdbBtiRMWFj/FWqKIXDDVqHMYYIPAIEkpotMkAsbTqqIKhYD25G7NdMMEr7k4D6p
 RONX31HOzgV5fB0Mbxi/L9qI298/EGtQNGFnNLDjugy58+6A8TdOrq5K5cmbgjo3sJPL
 kE/w==
X-Gm-Message-State: APjAAAXeo76oZQ/RbzORBKsOt6ItR2E3rLd20BslwZCV9HgC+we0f+4b
 SLOWHadxEWq/7hwQMEaUleYuhw==
X-Google-Smtp-Source: APXvYqxqWOx/BjJJ6Jn6AI5kPJwHNVS6cL72N5MU/zfvRWNaiYHDL6lr3RxWJnT4Gk3Drrgj6yvL2w==
X-Received: by 2002:a5d:4003:: with SMTP id n3mr4596124wrp.95.1571771835578;
 Tue, 22 Oct 2019 12:17:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e3sm17592237wme.39.2019.10.22.12.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:17:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3CAC81FF9B;
 Tue, 22 Oct 2019 20:17:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 11/19] tests/vm: Let subclasses disable IPv6
Date: Tue, 22 Oct 2019 20:16:56 +0100
Message-Id: <20191022191704.6134-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

The mechanism will be used to work around issues related to IPv6
on the netbsd image builder.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191018181705.17957-3-ehabkost@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 4921e47f9f2..59bd1d31fbe 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -57,6 +57,8 @@ class BaseVM(object):
     arch = "#arch"
     # command to halt the guest, can be overridden by subclasses
     poweroff = "poweroff"
+    # enable IPv6 networking
+    ipv6 = True
     def __init__(self, debug=False, vcpus=None):
         self._guest = None
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
@@ -81,7 +83,8 @@ class BaseVM(object):
         self._args = [ \
             "-nodefaults", "-m", "4G",
             "-cpu", "max",
-            "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
+            "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22" +
+                       (",ipv6=no" if not self.ipv6 else ""),
             "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20"]
         if vcpus and vcpus > 1:
-- 
2.20.1


