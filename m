Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4297AC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01BB82074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJMOogfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BB82074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfRAv-0002Az-7B
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzq-0001aF-EE
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57330
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzp-0006ki-Lu
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjbH7teVMtjBh+T5ufCfzeY9CyBEBHGmfbosO+YUVTM=;
 b=LJMOogfas/QwkWNesSoisfhrcvCctKiljwog5gh0Z8LiVo/IGG6ygEcRIQc10oEMcLnqgA
 jg2wes8RT9fiehXoyQWqr7UmCv0aYX8P2jp9tlR0YsZQTcdeiGSOHaPtvOqorpUPo9FY1o
 VjXvf52bUwqPZEJzYo5B71POwLb4u1Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-xVuduibAOY2n20UrIfFcMg-1; Sun, 31 May 2020 12:39:32 -0400
X-MC-Unique: xVuduibAOY2n20UrIfFcMg-1
Received: by mail-wr1-f70.google.com with SMTP id c14so3591278wrw.11
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rjbH7teVMtjBh+T5ufCfzeY9CyBEBHGmfbosO+YUVTM=;
 b=PrC2Pfqx6/NexE/RcWPWPhstlxsr5voM0bxWai9F9rggC4AqSwHgKx/v+GoOSX+1MH
 kOPFlgdyq0iT/o+jufl6TKl3rXxMeJOHnmz8NqXrOlBdsM1C568oqZMX4OsUFwSAq2Nm
 CXwtWypQnZu/dOZw7Ox+SIWEvLuNkuWg+MObrf1yFPSvNiWcGA2m/rZAH9pxFbyiONsd
 AzXxAX4N7txFfOEom7BN6/1TJh0rkhQfbUALltiTSrg0RJFTFqabeRz+79XDXa/IZFUQ
 CDpbUBI6QHkg3x15ce04GdOqLQ22wQ1ZE6NkjnTXRj3caiACs/MI1ORYzjLqjgvjzTkm
 FnUw==
X-Gm-Message-State: AOAM5321jWf7whiltzmZgBwMjQYPlSLiVL/qvto0WpgJuE2mb4SYOnu4
 F7R0A4rXVBcYDmU2iKahbQ4uWoOI1ZjStog/YJQmuDyqBHVZoyUOfIXTobV5MZLMK1Pg1KcFcvo
 QVWqql3ZqJKIV5XE=
X-Received: by 2002:a5d:5112:: with SMTP id s18mr17632632wrt.160.1590943170818; 
 Sun, 31 May 2020 09:39:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxviLkgXrjUX2NcNJC5mie2lsvP1IrSShLdDDtm64dQg0NFzJSb44/ioBt+ym943Nm0qZ2SIA==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr17632616wrt.160.1590943170658; 
 Sun, 31 May 2020 09:39:30 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id k26sm9409518wmi.27.2020.05.31.09.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:39:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/25] python/qemu/machine: add kill() method
Date: Sun, 31 May 2020 18:38:29 +0200
Message-Id: <20200531163846.25363-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:39:18
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add method to hard-kill vm, without any quit commands.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200217150246.29180-19-vsementsov@virtuozzo.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index b9a98e2c86..d2f531f1b4 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -342,7 +342,7 @@ def wait(self):
         self._load_io_log()
         self._post_shutdown()
 
-    def shutdown(self, has_quit=False):
+    def shutdown(self, has_quit=False, hard=False):
         """
         Terminate the VM and clean up
         """
@@ -354,7 +354,9 @@ def shutdown(self, has_quit=False):
             self._console_socket = None
 
         if self.is_running():
-            if self._qmp:
+            if hard:
+                self._popen.kill()
+            elif self._qmp:
                 try:
                     if not has_quit:
                         self._qmp.cmd('quit')
@@ -368,7 +370,8 @@ def shutdown(self, has_quit=False):
         self._post_shutdown()
 
         exitcode = self.exitcode()
-        if exitcode is not None and exitcode < 0:
+        if exitcode is not None and exitcode < 0 and \
+                not (exitcode == -9 and hard):
             msg = 'qemu received signal %i: %s'
             if self._qemu_full_args:
                 command = ' '.join(self._qemu_full_args)
@@ -378,6 +381,9 @@ def shutdown(self, has_quit=False):
 
         self._launched = False
 
+    def kill(self):
+        self.shutdown(hard=True)
+
     def set_qmp_monitor(self, enabled=True):
         """
         Set the QMP monitor.
-- 
2.21.3


