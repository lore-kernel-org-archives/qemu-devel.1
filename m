Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F13C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C435223AB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EArcuoQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C435223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7GH-0008Eq-25
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nc-00078i-40
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6na-0004vh-6N
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=67hPomjxNLOBu5xnnDcvEm19yDZAmkXyoM6jA1VmJsY=;
 b=EArcuoQDSav0lECru5ASNW9upmRMaatese0JPR90+EBaBT//zT9CwGAyzUIh3ED7RXK/Gz
 2I/Wb4l5+JvnBvLGhkfFR0hlNq6RrCSuVI7JZwGGZMxzUw66pw/ZfmPLdSSWum6+uPLzpD
 Mq1GLcSbBO5Iu5phfduWDnqE3mBsKnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-0xe8iIbpPAGRIsVXMv8yXg-1; Tue, 03 Nov 2020 19:37:11 -0500
X-MC-Unique: 0xe8iIbpPAGRIsVXMv8yXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C820B8015C3
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:37:10 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5366C55766;
 Wed,  4 Nov 2020 00:37:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 47/72] python/qmp: add parse_address classmethod
Date: Tue,  3 Nov 2020 19:35:37 -0500
Message-Id: <20201104003602.1293560-48-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This takes the place of qmp-shell's __get_address function.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/__init__.py | 26 ++++++++++++++++++++++++++
 scripts/qmp/qmp-shell       | 27 ++-------------------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/python/qemu/qmp/__init__.py b/python/qemu/qmp/__init__.py
index dd211e3f6511..a6e1a7b85775 100644
--- a/python/qemu/qmp/__init__.py
+++ b/python/qemu/qmp/__init__.py
@@ -97,6 +97,12 @@ def __init__(self, reply: QMPMessage):
         self.reply = reply
 
 
+class QMPBadPortError(QMPError):
+    """
+    Unable to parse socket address: Port was non-numerical.
+    """
+
+
 class QEMUMonitorProtocol:
     """
     Provide an API to connect to QEMU via QEMU Monitor Protocol (QMP) and then
@@ -224,6 +230,26 @@ def __exit__(self,
         # Implement context manager exit function.
         self.close()
 
+    @classmethod
+    def parse_address(cls, address: str) -> SocketAddrT:
+        """
+        Parse a string into a QMP address.
+
+        Figure out if the argument is in the port:host form.
+        If it's not, it's probably a file path.
+        """
+        components = address.split(':')
+        if len(components) == 2:
+            try:
+                port = int(components[1])
+            except ValueError:
+                msg = f"Bad port: '{components[1]}' in '{address}'."
+                raise QMPBadPortError(msg) from None
+            return (components[0], port)
+
+        # Treat as filepath.
+        return address
+
     def connect(self, negotiate: bool = True) -> Optional[QMPMessage]:
         """
         Connect to the QMP Monitor and perform capabilities negotiation.
diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index d5496aeac0bd..5a72b9d39502 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -92,10 +92,6 @@ class QMPShellError(Exception):
     pass
 
 
-class QMPShellBadPort(QMPShellError):
-    pass
-
-
 class FuzzyJSON(ast.NodeTransformer):
     """
     This extension of ast.NodeTransformer filters literal "true/false/null"
@@ -118,7 +114,7 @@ class FuzzyJSON(ast.NodeTransformer):
 #       _execute_cmd()). Let's design a better one.
 class QMPShell(qmp.QEMUMonitorProtocol):
     def __init__(self, address, pretty=False):
-        super().__init__(self.__get_address(address))
+        super().__init__(self.parse_address(address))
         self._greeting = None
         self._completer = None
         self._pretty = pretty
@@ -128,22 +124,6 @@ class QMPShell(qmp.QEMUMonitorProtocol):
                                       '.qmp-shell_history')
         self._verbose = False
 
-    @classmethod
-    def __get_address(cls, arg):
-        """
-        Figure out if the argument is in the port:host form, if it's not it's
-        probably a file path.
-        """
-        addr = arg.split(':')
-        if len(addr) == 2:
-            try:
-                port = int(addr[1])
-            except ValueError as err:
-                raise QMPShellBadPort from err
-            return addr[0], port
-        # socket path
-        return arg
-
     def _fill_completion(self):
         cmds = self.cmd('query-commands')
         if 'error' in cmds:
@@ -337,9 +317,6 @@ class QMPShell(qmp.QEMUMonitorProtocol):
 
         return self._execute_cmd(cmdline)
 
-    def set_verbosity(self, verbose):
-        self._verbose = verbose
-
 
 class HMPShell(QMPShell):
     def __init__(self, address):
@@ -447,7 +424,7 @@ def main():
             qemu = HMPShell(args.qmp_server)
         else:
             qemu = QMPShell(args.qmp_server, args.pretty)
-    except QMPShellBadPort:
+    except qmp.QMPBadPortError:
         parser.error(f"Bad port number: {args.qmp_server}")
         return  # pycharm doesn't know error() is noreturn
 
-- 
2.26.2


