Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A10C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6003206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXKTSTLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6003206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTO6-0000Jk-W8
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJA-0000EQ-Ka
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:21:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55051
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJ7-0004VZ-5a
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FhXd9jo3ZykzUIegSI6TSb8wRrSAAOgjzX+n7PAM3E=;
 b=YXKTSTLdNTip89ad/saQckhVTe7tUqq6Xt0YNSYR3QeUkLH+KTsOxQwb5I0Kyo71fFQypn
 okxGdwsBgcK1PJMUI/vevpaPzmyXIc4eEvT47I1E95pN8YZ+QcYznOeg/PrO+Yo9WnS51y
 KAkDpX8wyVIqaqG2kJrUoDB0AVNvaqE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-RryxhGZ0PHyIl952Tn3-gQ-1; Tue, 14 Jul 2020 18:21:45 -0400
X-MC-Unique: RryxhGZ0PHyIl952Tn3-gQ-1
Received: by mail-wr1-f71.google.com with SMTP id v3so19812wrq.10
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8FhXd9jo3ZykzUIegSI6TSb8wRrSAAOgjzX+n7PAM3E=;
 b=IPHoVHYi+E6SWhYkYpDQampYrawK+APcck3/Frg+DVvTW2Z7EOw425oyWbKgvppW0o
 3PguIkXMhMIN7Y1ePY1SBu5V76z9NgZlfMpTeQX8aTCshS/R1wsquE9ApEJl/ehrmIZB
 u4k80aUQeM69RL81tl3eyswcEKfBS048dZmiC1EftljnafdrwRDBDQc5PsGiGEDyxOIU
 42T7SCijjINCeEEmnmy5P2FUquAEU2MP5WjOLejqBCwG4tKWF9eN6Ze+tKJ8X0K1r7A+
 ntLOXL8XKvO7S+vwL90UvCGGGc9Ne+N+xEcwxnXtOLsm12sX857m4ziJpDTVz4FFrrHM
 ryuw==
X-Gm-Message-State: AOAM5315lHBst/6txZFzgqxUfUEL7pW/QRhnzFQOlrljjX2G561BHxCg
 qbv1K9drVjRpLDJMlY3l9hDeGXyyX4YSoktKxWPeR0z7ntM+cqV+ZTTy2eb2eJzHt4oJH+TWdPD
 PqhFWQ0acdcjHwD0=
X-Received: by 2002:a5d:628b:: with SMTP id k11mr8159969wru.107.1594765304163; 
 Tue, 14 Jul 2020 15:21:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzzUFgb07Cm3+x5Qosv7eEcZqNJKwtfLwh3QJmI2BohpotIatfLAm2GmCtHEnR79ejMueHeQ==
X-Received: by 2002:a5d:628b:: with SMTP id k11mr8159951wru.107.1594765303957; 
 Tue, 14 Jul 2020 15:21:43 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j145sm351404wmj.7.2020.07.14.15.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:21:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/19] python/machine.py: consolidate _post_shutdown()
Date: Wed, 15 Jul 2020 00:21:15 +0200
Message-Id: <20200714222132.10815-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:02:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Move more cleanup actions into _post_shutdown. As a change, if QEMU
should so happen to be terminated during a call to wait(), that event
will now be logged.

This is not likely to occur during normative use.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200710050649.32434-2-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index c25f0b42cf..ca1f2114e6 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -294,6 +294,8 @@ def _post_launch(self):
             self._qmp.accept()
 
     def _post_shutdown(self):
+        self._load_io_log()
+
         if self._qemu_log_file is not None:
             self._qemu_log_file.close()
             self._qemu_log_file = None
@@ -307,6 +309,17 @@ def _post_shutdown(self):
         while len(self._remove_files) > 0:
             self._remove_if_exists(self._remove_files.pop())
 
+        exitcode = self.exitcode()
+        if exitcode is not None and exitcode < 0:
+            msg = 'qemu received signal %i; command: "%s"'
+            if self._qemu_full_args:
+                command = ' '.join(self._qemu_full_args)
+            else:
+                command = ''
+            LOG.warning(msg, -int(exitcode), command)
+
+        self._launched = False
+
     def launch(self):
         """
         Launch the VM and make sure we cleanup and expose the
@@ -355,7 +368,6 @@ def wait(self):
         self._popen.wait()
         if self._qmp:
             self._qmp.close()
-        self._load_io_log()
         self._post_shutdown()
 
     def shutdown(self, has_quit=False, hard=False):
@@ -382,21 +394,8 @@ def shutdown(self, has_quit=False, hard=False):
                     self._popen.kill()
             self._popen.wait()
 
-        self._load_io_log()
         self._post_shutdown()
 
-        exitcode = self.exitcode()
-        if exitcode is not None and exitcode < 0 and \
-                not (exitcode == -9 and hard):
-            msg = 'qemu received signal %i: %s'
-            if self._qemu_full_args:
-                command = ' '.join(self._qemu_full_args)
-            else:
-                command = ''
-            LOG.warning(msg, -int(exitcode), command)
-
-        self._launched = False
-
     def kill(self):
         self.shutdown(hard=True)
 
-- 
2.21.3


