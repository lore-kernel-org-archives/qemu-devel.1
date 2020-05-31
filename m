Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2F4C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FD92074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5N7RJjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FD92074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR8t-0008GK-BK
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0Y-0003Iv-Qv
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34597
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0X-00070T-Oi
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hSfG89j1yh/LShH9lpHtA4pkqoFK62nXlpymRDXmlAY=;
 b=b5N7RJjFuuWrIr+V9i7OtyNwqMBSSg319w3mPCn7pU966l4zRypHyyw9QfmgMET+ETTIS5
 LZ455pFlLGPLkvzA1+KTuMy4Zv/jC2rs0qCeEW8U6MKYxPJ9Rzg1/R9EuM2OW82IRqnU99
 sf/9T6OC2jJdW9XefN5fWpMu8bp/ZUw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-4f6vSCdRMB69ERWZvM-fxQ-1; Sun, 31 May 2020 12:40:17 -0400
X-MC-Unique: 4f6vSCdRMB69ERWZvM-fxQ-1
Received: by mail-wr1-f72.google.com with SMTP id m14so1789919wrj.12
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hSfG89j1yh/LShH9lpHtA4pkqoFK62nXlpymRDXmlAY=;
 b=IQYYbK3GQLuPhA97Ed7qJsatq3ckj5ksIGHe1XJpQYr1WVIt51TSiXS/SDDrhAEWDi
 xTpaI0eO+8suLudnlwQL/plHdhDfC5j1bsIGVqGe7bKuZqBun3ViVPzRnisO2EqJhKKW
 SQLulQDzWMB9A8pV45SIYJpQdSE7Z3nj2v886ogaOewDVX/xKh/ohDbFGI3yklOdMhha
 kzNhrw5fYqke+q4MylXPwYCjowcbKwfbEXKb0Fbd08B9H5UGWVj44HhuTq343OlPkqfO
 2OLvhILppxR2Gc5GzeVRLY5GkrmC3tLCWC90fqkxaKn0D8a8/70KKGNJHa7cb2SbmadD
 uOIQ==
X-Gm-Message-State: AOAM531r4qRFnr8um8Ny0xv5SDgvErPYhxGmLYWa971nmdjZIp25jFde
 1ku8lRdsFUZFJ9SQS+uAiQ+cOFGuYliuEU15yZms6nRArvfsRBF6/CKsVCqGPAUUh06edYEMFFs
 lzY3nlA3ApPljlsI=
X-Received: by 2002:a7b:c5d7:: with SMTP id n23mr19218271wmk.185.1590943216327; 
 Sun, 31 May 2020 09:40:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzh77KlO64phqJTcDuJt0gPKNWkW2egnQKIXztLKi9l6mDsg1cRYoXGChGRkZq/Axxfqzi/sw==
X-Received: by 2002:a7b:c5d7:: with SMTP id n23mr19218248wmk.185.1590943216159; 
 Sun, 31 May 2020 09:40:16 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id b187sm8297281wmd.26.2020.05.31.09.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:40:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/25] python/qemu/qtest: Check before accessing _qtest
Date: Sun, 31 May 2020 18:38:38 +0200
Message-Id: <20200531163846.25363-18-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:39:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

It can be None; so add assertions or exceptions where appropriate to
guard the access accordingly.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200514055403.18902-30-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/qtest.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
index 4c88590eb0..888c8bd2f6 100644
--- a/python/qemu/qtest.py
+++ b/python/qemu/qtest.py
@@ -121,7 +121,8 @@ def _pre_launch(self):
         super()._pre_launch()
         self._qtest = QEMUQtestProtocol(self._qtest_path, server=True)
 
-    def _post_launch(self):
+    def _post_launch(self) -> None:
+        assert self._qtest is not None
         super()._post_launch()
         self._qtest.accept()
 
@@ -129,6 +130,13 @@ def _post_shutdown(self):
         super()._post_shutdown()
         self._remove_if_exists(self._qtest_path)
 
-    def qtest(self, cmd):
-        '''Send a qtest command to guest'''
+    def qtest(self, cmd: str) -> str:
+        """
+        Send a qtest command to the guest.
+
+        :param cmd: qtest command to send
+        :return: qtest server response
+        """
+        if self._qtest is None:
+            raise RuntimeError("qtest socket not available")
         return self._qtest.cmd(cmd)
-- 
2.21.3


