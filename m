Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B172C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FAC205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYir+Y03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FAC205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6qG-0006Rs-49
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6oy-0004N4-Td
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30604
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6ox-0001aB-Qg
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A6LXeGnA7xEQmC4DWM+/mMqjngkV8ZV220khpw1JxO8=;
 b=JYir+Y03bdsAGV7TacPfBTZBh1g+gG8/KxBAO6vYPMqwq+sZXw1/GhoYngqpUL3X02lzGp
 FAEgAnjeQkF36XOi8PWcaH661N626be4zeXBjRHJkDMmRpXd7uyX8dezDmmhb4bFCLvwwA
 CBsOx/8m6bZhQcz4JlnLbYeRGdngaEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-oo8X7B_ZNEuqm5xZV0bOlA-1; Thu, 14 May 2020 01:54:13 -0400
X-MC-Unique: oo8X7B_ZNEuqm5xZV0bOlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A98D8014D7;
 Thu, 14 May 2020 05:54:12 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCAD57D952;
 Thu, 14 May 2020 05:54:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 04/32] python/qemu/lib: delint, add pylintrc
Date: Thu, 14 May 2020 01:53:35 -0400
Message-Id: <20200514055403.18902-5-jsnow@redhat.com>
In-Reply-To: <20200514055403.18902-1-jsnow@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bring our these files up to speed with pylint 2.5.0.
Add a pylintrc file to formalize which pylint subset
we are targeting.

The similarity ignore is there to suppress similarity
reports across imports, which for typing constants,
are going to trigger this report erroneously.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/lib/machine.py |  6 ++--
 python/qemu/lib/pylintrc   | 58 ++++++++++++++++++++++++++++++++++++++
 python/qemu/lib/qtest.py   | 42 +++++++++++++++++----------
 3 files changed, 88 insertions(+), 18 deletions(-)
 create mode 100644 python/qemu/lib/pylintrc

diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
index e3ea523571..c79fc8fb89 100644
--- a/python/qemu/lib/machine.py
+++ b/python/qemu/lib/machine.py
@@ -58,7 +58,7 @@ def __init__(self, reply):
         self.reply = reply
 
 
-class QEMUMachine(object):
+class QEMUMachine:
     """
     A QEMU VM
 
@@ -242,7 +242,7 @@ def _base_args(self):
                          'chardev=mon,mode=control'])
         if self._machine is not None:
             args.extend(['-machine', self._machine])
-        for i in range(self._console_index):
+        for _ in range(self._console_index):
             args.extend(['-serial', 'null'])
         if self._console_set:
             self._console_address = os.path.join(self._sock_dir,
@@ -383,7 +383,7 @@ def shutdown(self, has_quit: bool = False) -> None:
                 command = ' '.join(self._qemu_full_args)
             else:
                 command = ''
-            LOG.warning(msg, -exitcode, command)
+            LOG.warning(msg, -int(exitcode), command)
 
         self._launched = False
 
diff --git a/python/qemu/lib/pylintrc b/python/qemu/lib/pylintrc
new file mode 100644
index 0000000000..5d6ae7367d
--- /dev/null
+++ b/python/qemu/lib/pylintrc
@@ -0,0 +1,58 @@
+[MASTER]
+
+[MESSAGES CONTROL]
+
+# Disable the message, report, category or checker with the given id(s). You
+# can either give multiple identifiers separated by comma (,) or put this
+# option multiple times (only on the command line, not in the configuration
+# file where it should appear only once). You can also use "--disable=all" to
+# disable everything first and then reenable specific checks. For example, if
+# you want to run only the similarities checker, you can use "--disable=all
+# --enable=similarities". If you want to run only the classes checker, but have
+# no Warning level messages displayed, use "--disable=all --enable=classes
+# --disable=W".
+disable=too-many-arguments,
+        too-many-instance-attributes,
+        too-many-public-methods,
+
+[REPORTS]
+
+[REFACTORING]
+
+[MISCELLANEOUS]
+
+[LOGGING]
+
+[BASIC]
+
+# Good variable names which should always be accepted, separated by a comma.
+good-names=i,
+           j,
+           k,
+           ex,
+           Run,
+           _,
+           fd,
+
+[VARIABLES]
+
+[STRING]
+
+[SPELLING]
+
+[FORMAT]
+
+[SIMILARITIES]
+
+# Ignore imports when computing similarities.
+ignore-imports=yes
+
+[TYPECHECK]
+
+[CLASSES]
+
+[IMPORTS]
+
+[DESIGN]
+
+[EXCEPTIONS]
diff --git a/python/qemu/lib/qtest.py b/python/qemu/lib/qtest.py
index d24ad04256..53d814c064 100644
--- a/python/qemu/lib/qtest.py
+++ b/python/qemu/lib/qtest.py
@@ -1,5 +1,11 @@
-# QEMU qtest library
-#
+"""
+QEMU qtest library
+
+qtest offers the QEMUQtestProtocol and QEMUQTestMachine classes, which
+offer a connection to QEMU's qtest protocol socket, and a qtest-enabled
+subclass of QEMUMachine, respectively.
+"""
+
 # Copyright (C) 2015 Red Hat Inc.
 #
 # Authors:
@@ -17,19 +23,21 @@
 from .machine import QEMUMachine
 
 
-class QEMUQtestProtocol(object):
+class QEMUQtestProtocol:
+    """
+    QEMUQtestProtocol implements a connection to a qtest socket.
+
+    :param address: QEMU address, can be either a unix socket path (string)
+                    or a tuple in the form ( address, port ) for a TCP
+                    connection
+    :param server: server mode, listens on the socket (bool)
+    :raise socket.error: on socket connection errors
+
+    .. note::
+       No conection is estabalished by __init__(), this is done
+       by the connect() or accept() methods.
+    """
     def __init__(self, address, server=False):
-        """
-        Create a QEMUQtestProtocol object.
-
-        @param address: QEMU address, can be either a unix socket path (string)
-                        or a tuple in the form ( address, port ) for a TCP
-                        connection
-        @param server: server mode, listens on the socket (bool)
-        @raise socket.error on socket connection errors
-        @note No connection is established, this is done by the connect() or
-              accept() methods
-        """
         self._address = address
         self._sock = self._get_sock()
         self._sockfile = None
@@ -73,15 +81,19 @@ def cmd(self, qtest_cmd):
         return resp
 
     def close(self):
+        """Close this socket."""
         self._sock.close()
         self._sockfile.close()
 
     def settimeout(self, timeout):
+        """Set a timeout, in seconds."""
         self._sock.settimeout(timeout)
 
 
 class QEMUQtestMachine(QEMUMachine):
-    '''A QEMU VM'''
+    """
+    A QEMU VM, with a qtest socket available.
+    """
 
     def __init__(self, binary, args=None, name=None, test_dir="/var/tmp",
                  socket_scm_helper=None, sock_dir=None):
-- 
2.21.1


