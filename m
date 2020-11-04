Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76403C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056D4223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivAHj1e+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056D4223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka6w8-0001ud-UI
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6mt-0006F3-TC
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6mr-0004ob-U1
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=za4rE4qH6a3IQrOThgWqsc64uRgYKF2HZZqGYd/r9FY=;
 b=ivAHj1e+xksz5UaJRUImgrOxH2fu0pR/Oalq7lq5gWeFy75R1gcZuJLMi1YFJtzV0a7Vlb
 uRHfF68XwVpz09e/4oUpNsXnyMSZQhB0qpHsqe+BM9oo4xffcjBnMIxK9cb1ns0v2J2nKW
 LMqZD80/vsvQlikaj0ts5+A1t0sq4/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-uUKHd0VmPoiN976UBPs3rQ-1; Tue, 03 Nov 2020 19:36:27 -0500
X-MC-Unique: uUKHd0VmPoiN976UBPs3rQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A26C3100F949
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:23 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 857E755766;
 Wed,  4 Nov 2020 00:36:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/72] scripts/qom-fuse: Convert to QOMCommand
Date: Tue,  3 Nov 2020 19:34:59 -0500
Message-Id: <20201104003602.1293560-10-jsnow@redhat.com>
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

Move qom-fuse onto the QOMCommand base established in
python/qemu/qmp/qom_common.py. The interface doesn't change
incompatibly, "qom-fuse mountpoint" still works as an invocation, and
QMP_SOCKET is still used as the environment variable.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qom-fuse | 59 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index 5b80da9df66b..f9bf85f38217 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -8,11 +8,19 @@ may be browsed, queried and edited using traditional shell tooling.
 This script requires the 'fusepy' python package;
 you may install it by using ``pip3 install --user fusepy``.
 
-ENV:
-    QMP_SOCKET: Path to the QMP server socket
 
-Usage:
-    qom-fuse /mount/to/here
+usage: qom-fuse [-h] [--socket SOCKET] <mount>
+
+Mount a QOM tree as a FUSE filesystem
+
+positional arguments:
+  <mount>               Mount point
+
+optional arguments:
+  -h, --help            show this help message and exit
+  --socket SOCKET, -s SOCKET
+                        QMP socket path or address (addr:port). May also be
+                        set via QMP_SOCKET environment variable.
 """
 ##
 # Copyright IBM, Corp. 2012
@@ -26,30 +34,56 @@ Usage:
 # See the COPYING file in the top-level directory.
 ##
 
+import argparse
 from errno import ENOENT, EPERM
 import os
 import stat
 import sys
+from typing import Dict
 
 import fuse
 from fuse import FUSE, FuseOSError, Operations
 
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QEMUMonitorProtocol, QMPResponseError
+from qemu.qmp import QMPResponseError
+from qemu.qmp.qom_common import QOMCommand
 
 
 fuse.fuse_python_api = (0, 2)
 
 
-class QOMFS(Operations):
-    """QOMFS implements fuse.Operations to provide a QOM filesystem."""
-    def __init__(self, qmp):
-        self.qmp = qmp
-        self.qmp.connect()
-        self.ino_map = {}
+class QOMFuse(QOMCommand, Operations):
+    """
+    QOMFuse implements both fuse.Operations and QOMCommand.
+
+    Operations implements the FS, and QOMCommand implements the CLI command.
+    """
+    name = 'fuse'
+    help = 'Mount a QOM tree as a FUSE filesystem'
+    fuse: FUSE
+
+    @classmethod
+    def configure_parser(cls, parser: argparse.ArgumentParser) -> None:
+        super().configure_parser(parser)
+        parser.add_argument(
+            'mount',
+            metavar='<mount>',
+            action='store',
+            help="Mount point",
+        )
+
+    def __init__(self, args: argparse.Namespace):
+        super().__init__(args)
+        self.mount = args.mount
+        self.ino_map: Dict[str, int] = {}
         self.ino_count = 1
 
+    def run(self) -> int:
+        print(f"Mounting QOMFS to '{self.mount}'", file=sys.stderr)
+        self.fuse = FUSE(self, self.mount, foreground=True)
+        return 0
+
     def get_ino(self, path):
         """Get an inode number for a given QOM path."""
         if path in self.ino_map:
@@ -172,5 +206,4 @@ class QOMFS(Operations):
 
 
 if __name__ == '__main__':
-    fuse = FUSE(QOMFS(QEMUMonitorProtocol(os.environ['QMP_SOCKET'])),
-                sys.argv[1], foreground=True)
+    sys.exit(QOMFuse.entry_point())
-- 
2.26.2


