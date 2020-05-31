Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA43C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0583E2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJXSb9Hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0583E2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfRHQ-0004fs-81
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR12-00043p-Is
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26170
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR11-0007FH-Kp
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EasuWk6m0BoiPz6F4JYRddSpg6v+5LpuTCzT8S/4Pwk=;
 b=fJXSb9HjW5MmGm2PZQ06uvMiUfD+VODIITASVSayBRS2ecBmZnbJDX0mv/hkj00tUfPFUk
 r8Tru4nQqt6oEioKD4LY6CIJEFpOxsATcm2vUu1jfmNo56hN/3Wf4IjxG2iSeZhUBHbzOH
 3V7YrRH0yuOmEy134h9149d7TAgnnQ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-C5zn4DK-OWqosy5c5PB1fw-1; Sun, 31 May 2020 12:40:48 -0400
X-MC-Unique: C5zn4DK-OWqosy5c5PB1fw-1
Received: by mail-wr1-f70.google.com with SMTP id o1so3590852wrm.17
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EasuWk6m0BoiPz6F4JYRddSpg6v+5LpuTCzT8S/4Pwk=;
 b=h3mJIN+t3p5Gz5pSeKhbLlKHc2oOlAkwIWGm+uQxRTQ4GYMWWZ/tmmQJfsXKIL7ofQ
 WoVjXo4Nrc0PdSDqF5a+jN1ePmGSfr1TzsnjqF6HYyQKpGhqqJLqLWW3Og8vhsG29iHC
 uPZdPyPl/w43TucY732NFK5Vqpn6ASvjVK11oW8Ppq7k02nWzCbBBz2ViDBPUNSlHQ/U
 iwdy1bj+WJo8GH7816AjC+C6d0idiaa26sHcdl9TlBZNpSyPwfNyv2xNs3M6isZFlC08
 Xg6UN7o5uD5Rachpni1TFn6iGXp/NfJh20kdIVuOX6fypMZV4QATXfZRl5sp2UJG2HeR
 qy2w==
X-Gm-Message-State: AOAM533Wv/cOOnqHnxL0SfPrFQ1j7Pw4kF/pQJFfDMTvMrEcq7Z4wuJI
 PoqWf46uBeWgy7tBLEHSQaJ/MR9GauZW4+9FVUVfnMK9A1xZYjCOzUOkHCQnGULFf4Qej7t42NV
 Dcw9msUc7FFdORTI=
X-Received: by 2002:a05:600c:2147:: with SMTP id
 v7mr17849639wml.101.1590943246922; 
 Sun, 31 May 2020 09:40:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI6LDvlfCZPK9wwqdms85yxMc4JSYt7zQlkz8yplSypRhy6I1JyG6cFZgTmZSSCpBd31os2g==
X-Received: by 2002:a05:600c:2147:: with SMTP id
 v7mr17849613wml.101.1590943246702; 
 Sun, 31 May 2020 09:40:46 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a6sm17634729wrn.38.2020.05.31.09.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:40:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/25] tests/acceptance: allow console interaction with
 specific VMs
Date: Sun, 31 May 2020 18:38:44 +0200
Message-Id: <20200531163846.25363-24-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 11:09:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Willian Rampazzo <willianr@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

Console interaction in avocado scripts was possible only with single
default VM.
This patch modifies the function parameters to allow passing a specific
VM as a parameter to interact with it.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Reviewed-by: Willian Rampazzo <willianr@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <159073587933.20809.5122618715976660635.stgit@pasha-ThinkPad-X280>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index 59e7b4f763..77d1c1d9ff 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -69,13 +69,15 @@ def pick_default_qemu_bin(arch=None):
 
 
 def _console_interaction(test, success_message, failure_message,
-                         send_string, keep_sending=False):
+                         send_string, keep_sending=False, vm=None):
     assert not keep_sending or send_string
-    console = test.vm.console_socket.makefile()
+    if vm is None:
+        vm = test.vm
+    console = vm.console_socket.makefile()
     console_logger = logging.getLogger('console')
     while True:
         if send_string:
-            test.vm.console_socket.sendall(send_string.encode())
+            vm.console_socket.sendall(send_string.encode())
             if not keep_sending:
                 send_string = None # send only once
         msg = console.readline().strip()
@@ -115,7 +117,8 @@ def interrupt_interactive_console_until_pattern(test, success_message,
     _console_interaction(test, success_message, failure_message,
                          interrupt_string, True)
 
-def wait_for_console_pattern(test, success_message, failure_message=None):
+def wait_for_console_pattern(test, success_message, failure_message=None,
+                             vm=None):
     """
     Waits for messages to appear on the console, while logging the content
 
@@ -125,7 +128,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None):
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
     """
-    _console_interaction(test, success_message, failure_message, None)
+    _console_interaction(test, success_message, failure_message, None, vm=vm)
 
 def exec_command_and_wait_for_pattern(test, command,
                                       success_message, failure_message=None):
-- 
2.21.3


