Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7A9C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:44:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3180223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiTjd1cY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3180223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka6uR-0006lZ-Gr
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6n4-0006KF-5Y
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6mz-0004p9-8j
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OoUf1st3MKD0IcbpFlD7Ia+O2+OCjeATl4hUL6sx0k=;
 b=SiTjd1cYKDw4mUY2vYODzjExaUgOUZSUrSqW5xIOvPBy72cT0sfs8SkOjR0RVujW4xwJDo
 DSKcV9SUzhwYkaAfM9lFm1rGdMtP4Y5wRTQUChhqzRS3FoXr/2Gb5w3UXtcBLDi6CU2cvX
 osuh3ZpOYclLvDJPmfGkqQPf9RQ1pj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-XbrXsa8NPhKMtkV07kXhHQ-1; Tue, 03 Nov 2020 19:36:34 -0500
X-MC-Unique: XbrXsa8NPhKMtkV07kXhHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F32418A62AB
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:28 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAA6455766;
 Wed,  4 Nov 2020 00:36:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/72] scripts/qom-fuse: move to python/qemu/qmp/qom_fuse.py
Date: Tue,  3 Nov 2020 19:35:03 -0500
Message-Id: <20201104003602.1293560-14-jsnow@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Move qom-fuse over to the python package now that it passes the
linter. Update the import paradigms so that it passes.

Immediately add 'fusepy' to the development requirements and re-lock the
pipenv so that the test suite continues to pass.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/Pipfile.lock                                 | 13 ++++++++++---
 scripts/qmp/qom-fuse => python/qemu/qmp/qom_fuse.py | 12 ++----------
 python/setup.cfg                                    |  1 +
 3 files changed, 13 insertions(+), 13 deletions(-)
 rename scripts/qmp/qom-fuse => python/qemu/qmp/qom_fuse.py (95%)
 mode change 100755 => 100644

diff --git a/python/Pipfile.lock b/python/Pipfile.lock
index 0352a628ef6f..d1e56cbcafc6 100644
--- a/python/Pipfile.lock
+++ b/python/Pipfile.lock
@@ -46,6 +46,12 @@
             "markers": "python_version >= '2.7' and python_version not in '3.0, 3.1, 3.2, 3.3'",
             "version": "==3.8.4"
         },
+        "fusepy": {
+            "hashes": [
+                "sha256:72ff783ec2f43de3ab394e3f7457605bf04c8cf288a2f4068b4cde141d4ee6bd"
+            ],
+            "version": "==3.0.1"
+        },
         "importlib-metadata": {
             "hashes": [
                 "sha256:77a540690e24b0305878c37ffd421785a6f7e53c8b5720d211b211de8d0e95da",
@@ -208,10 +214,11 @@
         },
         "toml": {
             "hashes": [
-                "sha256:926b612be1e5ce0634a2ca03470f95169cf16f939018233a670519cb4ac58b0f",
-                "sha256:bda89d5935c2eac546d648028b9901107a595863cb36bae0c73ac804a9b4ce88"
+                "sha256:806143ae5bfb6a3c6e736a764057db0e6a0e05e338b5630894a5f779cabb4f9b",
+                "sha256:b3bda1d108d5dd99f4a20d24d9c348e91c4db7ab1b749200bded2f839ccbe68f"
             ],
-            "version": "==0.10.1"
+            "markers": "python_version >= '2.6' and python_version not in '3.0, 3.1, 3.2'",
+            "version": "==0.10.2"
         },
         "typed-ast": {
             "hashes": [
diff --git a/scripts/qmp/qom-fuse b/python/qemu/qmp/qom_fuse.py
old mode 100755
new mode 100644
similarity index 95%
rename from scripts/qmp/qom-fuse
rename to python/qemu/qmp/qom_fuse.py
index 22be36634967..b0adcc1f8e62
--- a/scripts/qmp/qom-fuse
+++ b/python/qemu/qmp/qom_fuse.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python3
 """
 QEMU Object Model FUSE filesystem tool
 
@@ -36,7 +35,6 @@
 
 import argparse
 from errno import ENOENT, EPERM
-import os
 import stat
 import sys
 from typing import (
@@ -51,10 +49,8 @@
 import fuse
 from fuse import FUSE, FuseOSError, Operations
 
-
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QMPResponseError
-from qemu.qmp.qom_common import QOMCommand
+from . import QMPResponseError
+from .qom_common import QOMCommand
 
 
 fuse.fuse_python_api = (0, 2)
@@ -209,7 +205,3 @@ def readdir(self, path: str, fh: IO[bytes]) -> Iterator[str]:
         yield '..'
         for item in self.qom_list(path):
             yield item.name
-
-
-if __name__ == '__main__':
-    sys.exit(QOMFuse.entry_point())
diff --git a/python/setup.cfg b/python/setup.cfg
index 831555552f16..a9a76784d45a 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -27,6 +27,7 @@ devel =
     mypy >= 0.770
     pylint >= 2.6.0
     pytest >= 3.0.0
+    fusepy >= 2.0.4
 
 [options.entry_points]
 console_scripts =
-- 
2.26.2


