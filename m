Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353A3C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7C42415A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9M0Votm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7C42415A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVJKX-000636-Cn
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 14:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDx-000637-O4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDq-0008Bg-32
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603306343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lYuhgc6Ini505W+2SdHEnBn3PgIxfMCYvg25xVXtmRU=;
 b=a9M0Votmz9oK4aT5N6jn35IjE7aYh+G9M3HhjMVPotxZyWBvfPZIRkdaQGSqF8mJC1ONPY
 8WzddsjkYKxN7qs7kN78iXwampH2uVpsZKqM4IQlwcYSBTUUJSObD0Qon5Hn/5CPJStFBn
 3qWuPXLQvFDsDlKoBN1nMJAJURGQTbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-t_sVU9KJN2yOdgm0Qcts-Q-1; Wed, 21 Oct 2020 14:52:21 -0400
X-MC-Unique: t_sVU9KJN2yOdgm0Qcts-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F5A1804B62
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 18:52:20 +0000 (UTC)
Received: from scv.redhat.com (ovpn-116-160.rdu2.redhat.com [10.10.116.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79C5410002A6;
 Wed, 21 Oct 2020 18:52:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/15] scripts/qom-fuse: add static type hints
Date: Wed, 21 Oct 2020 14:52:05 -0400
Message-Id: <20201021185208.1611145-13-jsnow@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because fusepy does not have type hints, add some targeted warning
suppressions.

NOTE: Prior to this change, running 'mypy qemu' from the python
directory worked OK, but only coincidentally. Going forward, you will
need to run 'mypy -p qemu' instead. These invocation forms will be
codified in a CI test soon.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/setup.cfg     |  8 ++++++++
 scripts/qmp/qom-fuse | 26 +++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/python/setup.cfg b/python/setup.cfg
index 58cf48aaed..9592ac91df 100755
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -35,6 +35,14 @@ python_version = 3.6
 warn_unused_configs = True
 namespace_packages = True
 
+[mypy-qemu.qmp.qom_fuse]
+# fusepy has no type stubs:
+allow_subclassing_any = True
+
+[mypy-fuse]
+# fusepy has no type stubs:
+ignore_missing_imports = True
+
 [pylint.messages control]
 # Disable the message, report, category or checker with the given id(s). You
 # can either give multiple identifiers separated by comma (,) or put this
diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index b120b93391..22be366349 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -39,7 +39,14 @@ from errno import ENOENT, EPERM
 import os
 import stat
 import sys
-from typing import Dict
+from typing import (
+    IO,
+    Dict,
+    Iterator,
+    Mapping,
+    Optional,
+    Union,
+)
 
 import fuse
 from fuse import FUSE, FuseOSError, Operations
@@ -84,7 +91,7 @@ class QOMFuse(QOMCommand, Operations):
         self.fuse = FUSE(self, self.mount, foreground=True)
         return 0
 
-    def get_ino(self, path):
+    def get_ino(self, path: str) -> int:
         """Get an inode number for a given QOM path."""
         if path in self.ino_map:
             return self.ino_map[path]
@@ -92,7 +99,7 @@ class QOMFuse(QOMCommand, Operations):
         self.ino_count += 1
         return self.ino_map[path]
 
-    def is_object(self, path):
+    def is_object(self, path: str) -> bool:
         """Is the given QOM path an object?"""
         try:
             self.qom_list(path)
@@ -100,7 +107,7 @@ class QOMFuse(QOMCommand, Operations):
         except QMPResponseError:
             return False
 
-    def is_property(self, path):
+    def is_property(self, path: str) -> bool:
         """Is the given QOM path a property?"""
         path, prop = path.rsplit('/', 1)
         if path == '':
@@ -113,7 +120,7 @@ class QOMFuse(QOMCommand, Operations):
         except QMPResponseError:
             return False
 
-    def is_link(self, path):
+    def is_link(self, path: str) -> bool:
         """Is the given QOM path a link?"""
         path, prop = path.rsplit('/', 1)
         if path == '':
@@ -126,7 +133,7 @@ class QOMFuse(QOMCommand, Operations):
         except QMPResponseError:
             return False
 
-    def read(self, path, size, offset, fh):
+    def read(self, path: str, size: int, offset: int, fh: IO[bytes]) -> bytes:
         if not self.is_property(path):
             raise FuseOSError(ENOENT)
 
@@ -144,7 +151,7 @@ class QOMFuse(QOMCommand, Operations):
 
         return bytes(data[offset:][:size], encoding='utf-8')
 
-    def readlink(self, path):
+    def readlink(self, path: str) -> Union[bool, str]:
         if not self.is_link(path):
             return False
         path, prop = path.rsplit('/', 1)
@@ -152,7 +159,8 @@ class QOMFuse(QOMCommand, Operations):
         return prefix + str(self.qmp.command('qom-get', path=path,
                                              property=prop))
 
-    def getattr(self, path, fh=None):
+    def getattr(self, path: str,
+                fh: Optional[IO[bytes]] = None) -> Mapping[str, object]:
         if self.is_link(path):
             value = {
                 'st_mode': 0o755 | stat.S_IFLNK,
@@ -196,7 +204,7 @@ class QOMFuse(QOMCommand, Operations):
             raise FuseOSError(ENOENT)
         return value
 
-    def readdir(self, path, fh):
+    def readdir(self, path: str, fh: IO[bytes]) -> Iterator[str]:
         yield '.'
         yield '..'
         for item in self.qom_list(path):
-- 
2.26.2


