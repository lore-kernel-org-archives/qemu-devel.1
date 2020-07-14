Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC833C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24182068F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsRDyt9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24182068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTKY-0001wO-Ht
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJI-0000Ic-Mg
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37396
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJH-0004Wn-7G
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ieea/9qJdXQlkW1JakEFibi3dTSnv+m6I0AuJj8UjYg=;
 b=SsRDyt9tGqJ86hTatVRIlYRbUPiJFeSjKcLXpqnh/8NRFW6V6/pcrjAyvpfpum2jitCoLg
 LTNZegyzDBlogrEX4qTGIvqysF1j8GCOQ9A0DX0d8T/rQlqODsaFP85E7crzGiV8E6PY9k
 aI7hNfE26atJSMBUnbizeNbBvcCi+4Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-1Eq9Bf-vM86VZ1garop8iQ-1; Tue, 14 Jul 2020 18:21:54 -0400
X-MC-Unique: 1Eq9Bf-vM86VZ1garop8iQ-1
Received: by mail-wr1-f69.google.com with SMTP id c6so21754wru.7
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ieea/9qJdXQlkW1JakEFibi3dTSnv+m6I0AuJj8UjYg=;
 b=fj47+WhnQ2/5oLoWFgvyggIw3VKI6uQyDu2z+nZtZh7bwj+J553JyBIE6aZab6rNrM
 Uf71T7xT3JI1ICrBoshcyfgn8zQDYG6TpUb30G3ua7VTorAKk7Vxe/SWKP4+yXa82qSk
 5fBChwbXh0ZO5rugTDNPJ0pl0y/mCWV0ZRL6dTqfXLgYxvhjxH3hgxO8QlxnvNH1WBXk
 EoGkxV+Q51ZNZfHaqWbWtVOo7542gy/PUTF4aIUsItp3Zxxj3HVEBAOgsLM5VRUn6bN0
 spwoGN3XNsFRksgSInGIKeSl/bGPi6SEFhJRLuyvLXT4Kbizbms+xJ8QvBQltwWXSijS
 m1LA==
X-Gm-Message-State: AOAM533r0ka1bopatUODwyODV1irLKSSZG8Ca/WV84eWUM2up5S221C1
 VpI6rfH/SeZO4rfXl6YlJeDMxa+M7pRKBO6iohYBQuABHOgVN8JsxcFpe2Dc/IItThI0ycPyrvv
 IJgymXvP6meLJSR0=
X-Received: by 2002:adf:ed02:: with SMTP id a2mr8044793wro.110.1594765313494; 
 Tue, 14 Jul 2020 15:21:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvCAgT5kcc/CujbqK+Zpvl+tmQT6xu1hLeTJx9kHTc/umP+5RKIB6eSZUJIChYoiEzyDWxEQ==
X-Received: by 2002:adf:ed02:: with SMTP id a2mr8044778wro.110.1594765313300; 
 Tue, 14 Jul 2020 15:21:53 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d13sm134916wrq.89.2020.07.14.15.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:21:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/19] python/machine.py: Add _early_cleanup hook
Date: Wed, 15 Jul 2020 00:21:17 +0200
Message-Id: <20200714222132.10815-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 18:21:58
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

Some parts of cleanup need to occur prior to shutdown, otherwise
shutdown might break. Move this into a suitably named method/callback.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200710050649.32434-4-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index d3faa9a84c..127926b276 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -365,6 +365,17 @@ def _launch(self):
                                        close_fds=False)
         self._post_launch()
 
+    def _early_cleanup(self) -> None:
+        """
+        Perform any cleanup that needs to happen before the VM exits.
+        """
+        # If we keep the console socket open, we may deadlock waiting
+        # for QEMU to exit, while QEMU is waiting for the socket to
+        # become writeable.
+        if self._console_socket is not None:
+            self._console_socket.close()
+            self._console_socket = None
+
     def wait(self):
         """
         Wait for the VM to power off
@@ -376,12 +387,7 @@ def shutdown(self, has_quit=False, hard=False):
         """
         Terminate the VM and clean up
         """
-        # If we keep the console socket open, we may deadlock waiting
-        # for QEMU to exit, while QEMU is waiting for the socket to
-        # become writeable.
-        if self._console_socket is not None:
-            self._console_socket.close()
-            self._console_socket = None
+        self._early_cleanup()
 
         if self.is_running():
             if hard:
-- 
2.21.3


