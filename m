Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BF6C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 19:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3542177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 19:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjyP+tpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3542177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVJPS-0003e2-JT
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 15:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJE1-0006Dc-So
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDq-0008BL-5s
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603306341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YhF7QyFbEuVzv2X08ZIiQwxtTed607w0WuQG/bgH/uQ=;
 b=LjyP+tpVT0/NvdcSbdhqRBrcAX2PbUCREBzozrxS39Ub1g7a+IV7DOnZSq44QTwf4tB/JG
 zWNrGnl+UEOg5107sWCQZz8/o67Dd7Ffkwlq3psnIdpcTur7l0hDBJjfAj6rp7KFVfuWW/
 0BQ6RN6dPaXlLdm0ELIfAJKi9Ya3KNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-5aA2VmBGPaG0xIUFi17UFg-1; Wed, 21 Oct 2020 14:52:18 -0400
X-MC-Unique: 5aA2VmBGPaG0xIUFi17UFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 337AC804B79
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 18:52:17 +0000 (UTC)
Received: from scv.redhat.com (ovpn-116-160.rdu2.redhat.com [10.10.116.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EE9B10023A5;
 Wed, 21 Oct 2020 18:52:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/15] scripts/qom-fuse: Convert to QOMCommand
Date: Wed, 21 Oct 2020 14:52:02 -0400
Message-Id: <20201021185208.1611145-10-jsnow@redhat.com>
In-Reply-To: <20201021185208.1611145-1-jsnow@redhat.com>
References: <20201021185208.1611145-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
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
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
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
index 5b80da9df6..f9bf85f382 100755
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


