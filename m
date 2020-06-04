Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB274C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E90206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R933rOlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E90206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgvwG-0001o1-Hy
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 15:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgvvB-0000Ts-HB
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:53:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36955
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgvvA-0008QT-QO
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591300380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLqubNkTzAVF+ZRyry1ntH7wP+KHNAFbKjinvGwumGE=;
 b=R933rOlQXYMY+wssWRuqMqJDRSaxvGTYo8xvk9U5qQlUbUQgEYr3DczluN1DB51NJgxmWf
 Yvjq8EtpoAguynNbFmJxlQuKcuVzCBYdqsTMzFF2e40uiWKGDkY5PbHoBfuu2Tw/X39dZS
 UaST3vzxDawT+JyIn562n6fu+OTHxY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-hfi549JvPKCMhCa4Q_oKFw-1; Thu, 04 Jun 2020 15:52:58 -0400
X-MC-Unique: hfi549JvPKCMhCa4Q_oKFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 784AA107ACCD
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 19:52:57 +0000 (UTC)
Received: from probe.redhat.com (ovpn-117-188.rdu2.redhat.com [10.10.117.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CC7B78F1B;
 Thu,  4 Jun 2020 19:52:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] python/machine.py: re-add sigkill warning suppression
Date: Thu,  4 Jun 2020 15:52:52 -0400
Message-Id: <20200604195252.20739-4-jsnow@redhat.com>
In-Reply-To: <20200604195252.20739-1-jsnow@redhat.com>
References: <20200604195252.20739-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
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
Cc: kwolf@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, philmd@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the user kills QEMU on purpose, we don't need to warn them about that
having happened: they know already.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index a2abd2c35e3..99bcb499878 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -22,6 +22,7 @@
 import os
 import subprocess
 import shutil
+import signal
 import socket
 import tempfile
 from typing import Optional, Type
@@ -122,6 +123,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         self._console_address = None
         self._console_socket = None
         self._remove_files = []
+        self._killed = False
 
     def __enter__(self):
         return self
@@ -282,7 +284,7 @@ def _post_launch(self):
         if self._qmp:
             self._qmp.accept()
 
-    def _post_shutdown(self):
+    def _post_shutdown(self) -> None:
         self._load_io_log()
 
         if self._qemu_log_file is not None:
@@ -299,7 +301,8 @@ def _post_shutdown(self):
             self._remove_if_exists(self._remove_files.pop())
 
         exitcode = self.exitcode()
-        if exitcode is not None and exitcode < 0:
+        if (exitcode is not None and exitcode < 0
+                and not (self._killed and exitcode == -signal.SIGKILL)):
             msg = 'qemu received signal %i; command: "%s"'
             if self._qemu_full_args:
                 command = ' '.join(self._qemu_full_args)
@@ -307,6 +310,7 @@ def _post_shutdown(self):
                 command = ''
             LOG.warning(msg, -int(exitcode), command)
 
+        self._killed = False
         self._launched = False
 
     def launch(self):
@@ -414,6 +418,7 @@ def shutdown(self, has_quit: bool = False, hard: bool = False) -> None:
 
         try:
             if hard:
+                self._killed = True
                 self._hard_shutdown()
             else:
                 self._do_shutdown(has_quit)
-- 
2.21.3


