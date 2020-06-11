Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE2BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742FD2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742FD2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUe9-0005VV-Lr
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 17:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjUbk-00036q-5m; Thu, 11 Jun 2020 17:19:32 -0400
Received: from relay.sw.ru ([185.231.240.75]:40352 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjUbf-00057m-8w; Thu, 11 Jun 2020 17:19:31 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjUbW-0001xE-TB; Fri, 12 Jun 2020 00:19:18 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 6/8] qcow2.py: Introduce '-j' key to dump in JSON format
Date: Fri, 12 Jun 2020 00:19:18 +0300
Message-Id: <1591910360-867499-7-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591910360-867499-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1591910360-867499-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 17:19:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the command key to the qcow2.py arguments list to dump QCOW2
metadata in JSON format. Here is the suggested way to do that. The
implementation of the dump in JSON format is in the patch that follows.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py        | 20 +++++++++++++++-----
 tests/qemu-iotests/qcow2_format.py | 18 +++++++++---------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 8c187e9..b08d8fc 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -24,16 +24,19 @@ from qcow2_format import (
 )
 
 
+dump_json = False
+
+
 def cmd_dump_header(fd):
     h = QcowHeader(fd)
-    h.dump()
+    h.dump(dump_json)
     print()
-    h.dump_extensions()
+    h.dump_extensions(dump_json)
 
 
 def cmd_dump_header_exts(fd):
     h = QcowHeader(fd)
-    h.dump_extensions()
+    h.dump_extensions(dump_json)
 
 
 def cmd_set_header(fd, name, value):
@@ -132,6 +135,11 @@ cmds = [
 
 
 def main(filename, cmd, args):
+    global dump_json
+    dump_json = '-j' in sys.argv
+    if dump_json:
+        sys.argv.remove('-j')
+        args.remove('-j')
     fd = open(filename, "r+b")
     try:
         for name, handler, num_args, desc in cmds:
@@ -149,12 +157,14 @@ def main(filename, cmd, args):
 
 
 def usage():
-    print("Usage: %s <file> <cmd> [<arg>, ...]" % sys.argv[0])
+    print("Usage: %s <file> <cmd> [<arg>, ...] [<key>, ...]" % sys.argv[0])
     print("")
     print("Supported commands:")
     for name, handler, num_args, desc in cmds:
         print("    %-20s - %s" % (name, desc))
-
+    print("")
+    print("Supported keys:")
+    print("    %-20s - %s" % ('-j', 'Dump in JSON format'))
 
 if __name__ == '__main__':
     if len(sys.argv) < 3:
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 2e7c058..95db7a9 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -92,7 +92,7 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
         self.__dict__ = dict((field[2], values[i])
                              for i, field in enumerate(self.fields))
 
-    def dump(self):
+    def dump(self, dump_json=None):
         for f in self.fields:
             value = self.__dict__[f[2]]
             if isinstance(f[1], str):
@@ -143,10 +143,10 @@ class Qcow2BitmapExt(Qcow2Struct):
     def load(self, fd):
         self.read_bitmap_directory(fd)
 
-    def dump(self):
-        super().dump()
+    def dump(self, dump_json=None):
+        super().dump(dump_json)
         for bm in self.bitmaps:
-            bm.dump_bitmap_dir_entry()
+            bm.dump_bitmap_dir_entry(dump_json)
 
 
 BME_FLAG_IN_USE = 1 << 0
@@ -190,7 +190,7 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
         table = [e[0] for e in struct.iter_unpack('>Q', fd.read(table_size))]
         self.bitmap_table = Qcow2BitmapTable(table)
 
-    def dump_bitmap_dir_entry(self):
+    def dump_bitmap_dir_entry(self, dump_json=None):
         print()
         print(f'{"Bitmap name":<25} {self.name}')
         for fl in self.bitmap_flags:
@@ -298,13 +298,13 @@ class QcowHeaderExtension(Qcow2Struct):
         else:
             self.obj = None
 
-    def dump(self):
+    def dump(self, dump_json=None):
         super().dump()
 
         if self.obj is None:
             print(f'{"data":<25} {self.data_str}')
         else:
-            self.obj.dump()
+            self.obj.dump(dump_json)
 
     @classmethod
     def create(cls, magic, data):
@@ -407,8 +407,8 @@ class QcowHeader(Qcow2Struct):
         buf = buf[0:header_bytes-1]
         fd.write(buf)
 
-    def dump_extensions(self):
+    def dump_extensions(self, dump_json=None):
         for ex in self.extensions:
             print('Header extension:')
-            ex.dump()
+            ex.dump(dump_json)
             print()
-- 
1.8.3.1


