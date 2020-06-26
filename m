Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D206C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F4A2089D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bag/F3a8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F4A2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jouuC-00061e-2F
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 16:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1joutD-0004QF-AN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:23:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23254
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1joutA-0008EK-MZ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593203034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ardjuL2aAdct5oh4Cr6oH/XNDTSpCc1hBoDeZFu6O5s=;
 b=Bag/F3a85nvmjo2QmJKL9cZeQXTnLx7yscfP+yV/0MvUKLnMZpLfn/hbPD2VtHtNvQOGJZ
 +Tb8R+w4PxXiMokFaS/QxmNNAXGvQmMdkruLuLcF1hEDFjvJEOwYG6QcMjgZ8SM3e5g9o6
 3DMNB6JFxNlFrUO2FbP1P4KVbXtEMeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-DtPYRSsJPdCuGXHlZuClyA-1; Fri, 26 Jun 2020 16:23:53 -0400
X-MC-Unique: DtPYRSsJPdCuGXHlZuClyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D2C3800597
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 20:23:52 +0000 (UTC)
Received: from probe.redhat.com (ovpn-119-184.rdu2.redhat.com [10.10.119.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E2D171671;
 Fri, 26 Jun 2020 20:23:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/3] python/machine.py: consolidate _post_shutdown()
Date: Fri, 26 Jun 2020 16:23:48 -0400
Message-Id: <20200626202350.11060-2-jsnow@redhat.com>
In-Reply-To: <20200626202350.11060-1-jsnow@redhat.com>
References: <20200626202350.11060-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, philmd@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move more cleanup actions into _post_shutdown. As a change, if QEMU
should so happen to be terminated during a call to wait(), that event
will now be logged.

This is not likely to occur during normative use.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 041c615052..f7e68191c2 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -283,6 +283,8 @@ def _post_launch(self):
             self._qmp.accept()
 
     def _post_shutdown(self):
+        self._load_io_log()
+
         if self._qemu_log_file is not None:
             self._qemu_log_file.close()
             self._qemu_log_file = None
@@ -296,6 +298,17 @@ def _post_shutdown(self):
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
@@ -344,7 +357,6 @@ def wait(self):
         self._popen.wait()
         if self._qmp:
             self._qmp.close()
-        self._load_io_log()
         self._post_shutdown()
 
     def shutdown(self, has_quit=False, hard=False):
@@ -371,21 +383,8 @@ def shutdown(self, has_quit=False, hard=False):
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


