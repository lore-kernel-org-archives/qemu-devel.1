Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EDCC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6772068F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EACixxg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6772068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTL3-0002Y7-4f
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJa-0000jh-RT
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33163
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJX-0004dP-QU
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mKUySCAcl1J3a1/0hxVxVX3VFabMkB3Xo8GnjHPY21Y=;
 b=EACixxg1dXb7lBqpxHFPhxt9Ddwy3I9OXGiHKvBGiqB+y4SNYhUNn1NaVwT+VhPxfYeepz
 gRZOhWiPzRduAYuSQkQBrQ/VewaWORFkimE+jEs2SYMZXDs9avH4fk4l5DDw6AvFjOR/tD
 lxktpk/5Gt1m0OjFaiYVJ08MG/FaYdI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-sAQGjZmUORCucyulk8DwHA-1; Tue, 14 Jul 2020 18:22:13 -0400
X-MC-Unique: sAQGjZmUORCucyulk8DwHA-1
Received: by mail-wm1-f70.google.com with SMTP id l5so90519wml.7
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mKUySCAcl1J3a1/0hxVxVX3VFabMkB3Xo8GnjHPY21Y=;
 b=T/xOPObsdI26r3yWXxzuxBDQl8byiWvN0kG32d06t0hucoC0PXBc+N6V9ywcZjhEfS
 4gLKBtZ3Ih9ThZyO1K+JNNBxrKxhTNNCDX8M9n3aM1BlzQVfi7KOYBb7G5b9/LHoShEk
 dhmtC/9uyhSEL6d5oGDZrL16w8Gr38VRuy56KimlDZJscm5SlNcHNe49634h1saR9FU5
 QoVw4TpxgMw8AFSDAyY+SrSzTMCSie0vYJcdVTxp/HpLQAlmL1p2gXoXOvnhBnURNBWL
 2EbM2WJlrMn2J7erZqdTg55ElhPKwNHzMSjdwZbQDtgHng5K4pcvqUXvhBJ5NhBnbHgO
 /P1w==
X-Gm-Message-State: AOAM5306Odag63nOHFvNtEu3U97yZvHgz65feZ0Sp5JJT8ZlRmPykxfG
 QCValDRh8taggdS+NvokNvHqK7TKE+kveV/cCFSB2tC45cdNht0Dm/rUkNPah4aQf8Eyf/v4Qte
 t0C01ql84QUYOtDo=
X-Received: by 2002:a5d:408c:: with SMTP id o12mr8088770wrp.412.1594765332170; 
 Tue, 14 Jul 2020 15:22:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXwwxysFJ5iRQmTLqaL20VRf1rWyYdiTmWhT9ROP3DgVZ3r+9Zewj8UNG56cgKfC15v/KHog==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr8088756wrp.412.1594765331998; 
 Tue, 14 Jul 2020 15:22:11 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id z1sm195816wru.30.2020.07.14.15.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:22:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/19] python/machine.py: Make wait() call shutdown()
Date: Wed, 15 Jul 2020 00:21:21 +0200
Message-Id: <20200714222132.10815-9-philmd@redhat.com>
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

At this point, shutdown(has_quit=True) and wait() do essentially the
same thing; they perform cleanup without actually instructing QEMU to
quit.

Define one in terms of the other.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200710050649.32434-8-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index e825f0bdc6..3f0b873f58 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -385,14 +385,6 @@ def _early_cleanup(self) -> None:
             self._console_socket.close()
             self._console_socket = None
 
-    def wait(self):
-        """
-        Wait for the VM to power off
-        """
-        self._early_cleanup()
-        self._popen.wait()
-        self._post_shutdown()
-
     def shutdown(self, has_quit: bool = False,
                  hard: bool = False,
                  timeout: Optional[int] = 3) -> None:
@@ -421,6 +413,15 @@ def shutdown(self, has_quit: bool = False,
     def kill(self):
         self.shutdown(hard=True)
 
+    def wait(self, timeout: Optional[int] = None) -> None:
+        """
+        Wait for the VM to power off and perform post-shutdown cleanup.
+
+        :param timeout: Optional timeout in seconds.
+                        Default None, an infinite wait.
+        """
+        self.shutdown(has_quit=True, timeout=timeout)
+
     def set_qmp_monitor(self, enabled=True):
         """
         Set the QMP monitor.
-- 
2.21.3


