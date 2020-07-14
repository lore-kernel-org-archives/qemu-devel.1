Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDC3C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34ABE20658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxpO4jti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34ABE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTNM-00073y-CW
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJS-0000S9-Ds
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35561
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJQ-0004ZP-EA
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BU6nod1vM4pdn4SPezq8/eYZ42x6gm5zwkT0DnjVtk8=;
 b=JxpO4jtioAOcSprGNqN9dBRVFdvpDWx9durKxeXBZAICWfld9qMJgoSDp17v4ElAEXhFx2
 U+onLolH8bVIRrGcBGlAULCGHIKxQYKXZXZstrTgMXIJrhPb5kWvjlsuGqaTIjN0kCphft
 Nfrgk1v4cF7I1lUkNEw/U9spaWOfnu4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-OoMyNabxON60kxlWWYieQA-1; Tue, 14 Jul 2020 18:22:04 -0400
X-MC-Unique: OoMyNabxON60kxlWWYieQA-1
Received: by mail-wm1-f72.google.com with SMTP id z11so93311wmg.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BU6nod1vM4pdn4SPezq8/eYZ42x6gm5zwkT0DnjVtk8=;
 b=BvSLivyuS2D9SdeazwTnbt9FEMMWK19n/u0sZ3mzpH/+IVbECDR+oX4PJ8M2R4s/7l
 I1weB52WEsZxlo8rqLdievgQKikCp5jmm8NN4GxNsOWcM7nrKhyC7g3Vl4Ln2ZdKU9z4
 xksANsoZFqceM/o2qUa+cJx8Ge8wv+gMeiSGTAJniu7KB0If4s9rhyET01vRntuYSl8M
 yTYHd4gIAyYMG+iNCZ9BiXR++MH4u8x6v99mWa2PMi3SizJFbPtaC3hRAXXA08nTLGyf
 U1SAwTzbmV6CO6rLJtStcq5ETPcG6PamZeU8wFyna7Nz3LqIfICPGN29hAjo6/oCQQhv
 4jSA==
X-Gm-Message-State: AOAM53362Oe3RujRks64mXw39PrDEit2p50t7xaC6vSjDBm+DsYaUYiK
 ryEh5Ekl9lTe3ccFEt02vki9itpNhiuKYkq7Eo4bN91JDFtafxc1XTXevME0XdnYG8YFhg3xZ8B
 KY5BA6SfQin7uzQw=
X-Received: by 2002:a1c:2805:: with SMTP id o5mr5869292wmo.25.1594765322791;
 Tue, 14 Jul 2020 15:22:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO+o9WWeKqimo9LUqmtJnuajZ1bjM96ascLKDdWwmNVtnXDAetXuaTx2RX6+lxxOrv9TG7LA==
X-Received: by 2002:a1c:2805:: with SMTP id o5mr5869275wmo.25.1594765322529;
 Tue, 14 Jul 2020 15:22:02 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v11sm8783316wmb.3.2020.07.14.15.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:22:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/19] python/machine.py: Prohibit multiple shutdown() calls
Date: Wed, 15 Jul 2020 00:21:19 +0200
Message-Id: <20200714222132.10815-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

If the VM is not launched, don't try to shut it down. As a change,
_post_shutdown now unconditionally also calls _early_cleanup in order to
offer comprehensive object cleanup in failure cases.

As a courtesy, treat it as a NOP instead of rejecting it as an
error. This is slightly nicer for acceptance tests where vm.shutdown()
is issued unconditionally in tearDown callbacks.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200710050649.32434-6-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 63e40879e2..c28957ee82 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -294,6 +294,13 @@ def _post_launch(self):
             self._qmp.accept()
 
     def _post_shutdown(self):
+        """
+        Called to cleanup the VM instance after the process has exited.
+        May also be called after a failed launch.
+        """
+        # Comprehensive reset for the failed launch case:
+        self._early_cleanup()
+
         if self._qmp:
             self._qmp.close()
             self._qmp = None
@@ -339,7 +346,7 @@ def launch(self):
             self._launch()
             self._launched = True
         except:
-            self.shutdown()
+            self._post_shutdown()
 
             LOG.debug('Error launching VM')
             if self._qemu_full_args:
@@ -368,6 +375,8 @@ def _launch(self):
     def _early_cleanup(self) -> None:
         """
         Perform any cleanup that needs to happen before the VM exits.
+
+        Called additionally by _post_shutdown for comprehensive cleanup.
         """
         # If we keep the console socket open, we may deadlock waiting
         # for QEMU to exit, while QEMU is waiting for the socket to
@@ -388,6 +397,9 @@ def shutdown(self, has_quit=False, hard=False):
         """
         Terminate the VM and clean up
         """
+        if not self._launched:
+            return
+
         self._early_cleanup()
 
         if self.is_running():
-- 
2.21.3


