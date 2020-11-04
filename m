Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC18C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB08E223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7tuQP2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB08E223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7O5-0002jB-WE
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nw-0007P3-DD
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nt-0004xk-9m
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9FRDK9RDXP1gvYcLKnDz5U4uhB4JEcP2LMYKIEAfCM=;
 b=I7tuQP2qUJQaLHe58S5shN6iNyL48a4aNiQdQtrO8jAXyfRoVhAE9i2MSFv9qbiMqFBP37
 dzj8KnJZKc+hKXQNSb7wx5ykv85xIfwdxQkvVKXafKeZkACtg6Bd4AIQxuRr70z2fyqj+o
 m27A+mEgELc4s9Np5NUmler+jmTArHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-noO3gqbbOrWcxtyHMvo6gg-1; Tue, 03 Nov 2020 19:37:29 -0500
X-MC-Unique: noO3gqbbOrWcxtyHMvo6gg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA075108E1A8
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:37:28 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00CD855766;
 Wed,  4 Nov 2020 00:37:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 61/72] scripts/qmp-shell: Use context manager instead of
 atexit
Date: Tue,  3 Nov 2020 19:35:51 -0500
Message-Id: <20201104003602.1293560-62-jsnow@redhat.com>
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

We can invoke the shell history writing when we leave the QMPShell scope
instead of relying on atexit. Doing so may be preferable to avoid global
state being registered from within a class instead of from the
application logic directly.

Use QMP's context manager to hook this history saving at close time,
which gets invoked when we leave the context block.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index f14fe211cca4..ec028d662e8e 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -66,7 +66,6 @@
 # sent to QEMU, which is useful for debugging and documentation generation.
 import argparse
 import ast
-import atexit
 import json
 import os
 import re
@@ -142,6 +141,11 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         self.pretty = pretty
         self.verbose = verbose
 
+    def close(self) -> None:
+        # Hook into context manager of parent to save shell history.
+        self._save_history()
+        super().close()
+
     def _fill_completion(self) -> None:
         cmds = self.cmd('query-commands')
         if 'error' in cmds:
@@ -164,9 +168,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
             pass
         except IOError as err:
             print(f"Failed to read history '{self._histfile}': {err!s}")
-        atexit.register(self.__save_history)
 
-    def __save_history(self) -> None:
+    def _save_history(self) -> None:
         try:
             readline.write_history_file(self._histfile)
         except IOError as err:
@@ -448,25 +451,25 @@ def main() -> None:
         parser.error("QMP socket or TCP address must be specified")
 
     shell_class = HMPShell if args.hmp else QMPShell
+
     try:
         address = shell_class.parse_address(args.qmp_server)
     except qmp.QMPBadPortError:
         parser.error(f"Bad port number: {args.qmp_server}")
         return  # pycharm doesn't know error() is noreturn
 
-    qemu = shell_class(address, args.pretty, args.verbose)
+    with shell_class(address, args.pretty, args.verbose) as qemu:
+        try:
+            qemu.connect(negotiate=not args.skip_negotiation)
+        except qmp.QMPConnectError:
+            die("Didn't get QMP greeting message")
+        except qmp.QMPCapabilitiesError:
+            die("Couldn't negotiate capabilities")
+        except OSError as err:
+            die(f"Couldn't connect to {args.qmp_server}: {err!s}")
 
-    try:
-        qemu.connect(negotiate=not args.skip_negotiation)
-    except qmp.QMPConnectError:
-        die("Didn't get QMP greeting message")
-    except qmp.QMPCapabilitiesError:
-        die("Couldn't negotiate capabilities")
-    except OSError as err:
-        die(f"Couldn't connect to {args.qmp_server}: {err!s}")
-
-    for _ in qemu.repl():
-        pass
+        for _ in qemu.repl():
+            pass
 
 
 if __name__ == '__main__':
-- 
2.26.2


