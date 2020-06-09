Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB18C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC9C20737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrjoJdSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC9C20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilI3-000711-Dg
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEv-0001gX-O5
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:52:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49864
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEu-0005ba-6c
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591735975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FC9Ai7LaHjc2u5ALIBTpHFl/XEM6Scc3lWiNTmCw0Yw=;
 b=LrjoJdSjczZ5ggnBcVqYvAXnC7B4ar5Y5VLeseu+PnNYGgTWgk+jI+9uJM4zgFJSd4tafw
 YFP+k6yP0F0e3StawdIDqN5tXAu3ianxqd7NtR06OfmTmiC+31eVqOAh+25/q7dpQKiF3T
 PKm6zoOlijGZLqOpSzDe/BNpAv/P2kk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-Vdep5_0aMqOIcpAaSxyXhQ-1; Tue, 09 Jun 2020 16:52:50 -0400
X-MC-Unique: Vdep5_0aMqOIcpAaSxyXhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8B7E1005510;
 Tue,  9 Jun 2020 20:52:49 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B1466116D;
 Tue,  9 Jun 2020 20:52:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/15] qcow2.py: move qcow2 format classes to separate module
Date: Tue,  9 Jun 2020 15:52:34 -0500
Message-Id: <20200609205245.3548257-5-eblake@redhat.com>
In-Reply-To: <20200609205245.3548257-1-eblake@redhat.com>
References: <20200609205245.3548257-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We are going to enhance qcow2 format parsing by adding more structure
classes. Let's split format parsing from utility code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200606081806.23897-4-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/qcow2.py        | 160 +-------------------------
 tests/qemu-iotests/qcow2_format.py | 173 +++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+), 156 deletions(-)
 create mode 100644 tests/qemu-iotests/qcow2_format.py

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 2da434a013ef..e968869ea6b2 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -17,163 +17,11 @@
 #

 import sys
-import struct
-import string

-
-class QcowHeaderExtension:
-
-    def __init__(self, magic, length, data):
-        if length % 8 != 0:
-            padding = 8 - (length % 8)
-            data += b"\0" * padding
-
-        self.magic = magic
-        self.length = length
-        self.data = data
-
-    @classmethod
-    def create(cls, magic, data):
-        return QcowHeaderExtension(magic, len(data), data)
-
-
-class QcowHeader:
-
-    uint32_t = 'I'
-    uint64_t = 'Q'
-
-    fields = [
-        # Version 2 header fields
-        [uint32_t, '%#x',  'magic'],
-        [uint32_t, '%d',   'version'],
-        [uint64_t, '%#x',  'backing_file_offset'],
-        [uint32_t, '%#x',  'backing_file_size'],
-        [uint32_t, '%d',   'cluster_bits'],
-        [uint64_t, '%d',   'size'],
-        [uint32_t, '%d',   'crypt_method'],
-        [uint32_t, '%d',   'l1_size'],
-        [uint64_t, '%#x',  'l1_table_offset'],
-        [uint64_t, '%#x',  'refcount_table_offset'],
-        [uint32_t, '%d',   'refcount_table_clusters'],
-        [uint32_t, '%d',   'nb_snapshots'],
-        [uint64_t, '%#x',  'snapshot_offset'],
-
-        # Version 3 header fields
-        [uint64_t, 'mask', 'incompatible_features'],
-        [uint64_t, 'mask', 'compatible_features'],
-        [uint64_t, 'mask', 'autoclear_features'],
-        [uint32_t, '%d',   'refcount_order'],
-        [uint32_t, '%d',   'header_length'],
-    ]
-
-    fmt = '>' + ''.join(field[0] for field in fields)
-
-    def __init__(self, fd):
-
-        buf_size = struct.calcsize(QcowHeader.fmt)
-
-        fd.seek(0)
-        buf = fd.read(buf_size)
-
-        header = struct.unpack(QcowHeader.fmt, buf)
-        self.__dict__ = dict((field[2], header[i])
-                             for i, field in enumerate(QcowHeader.fields))
-
-        self.set_defaults()
-        self.cluster_size = 1 << self.cluster_bits
-
-        fd.seek(self.header_length)
-        self.load_extensions(fd)
-
-        if self.backing_file_offset:
-            fd.seek(self.backing_file_offset)
-            self.backing_file = fd.read(self.backing_file_size)
-        else:
-            self.backing_file = None
-
-    def set_defaults(self):
-        if self.version == 2:
-            self.incompatible_features = 0
-            self.compatible_features = 0
-            self.autoclear_features = 0
-            self.refcount_order = 4
-            self.header_length = 72
-
-    def load_extensions(self, fd):
-        self.extensions = []
-
-        if self.backing_file_offset != 0:
-            end = min(self.cluster_size, self.backing_file_offset)
-        else:
-            end = self.cluster_size
-
-        while fd.tell() < end:
-            (magic, length) = struct.unpack('>II', fd.read(8))
-            if magic == 0:
-                break
-            else:
-                padded = (length + 7) & ~7
-                data = fd.read(padded)
-                self.extensions.append(QcowHeaderExtension(magic, length,
-                                                           data))
-
-    def update_extensions(self, fd):
-
-        fd.seek(self.header_length)
-        extensions = self.extensions
-        extensions.append(QcowHeaderExtension(0, 0, b""))
-        for ex in extensions:
-            buf = struct.pack('>II', ex.magic, ex.length)
-            fd.write(buf)
-            fd.write(ex.data)
-
-        if self.backing_file is not None:
-            self.backing_file_offset = fd.tell()
-            fd.write(self.backing_file)
-
-        if fd.tell() > self.cluster_size:
-            raise Exception("I think I just broke the image...")
-
-    def update(self, fd):
-        header_bytes = self.header_length
-
-        self.update_extensions(fd)
-
-        fd.seek(0)
-        header = tuple(self.__dict__[f] for t, p, f in QcowHeader.fields)
-        buf = struct.pack(QcowHeader.fmt, *header)
-        buf = buf[0:header_bytes-1]
-        fd.write(buf)
-
-    def dump(self):
-        for f in QcowHeader.fields:
-            value = self.__dict__[f[2]]
-            if f[1] == 'mask':
-                bits = []
-                for bit in range(64):
-                    if value & (1 << bit):
-                        bits.append(bit)
-                value_str = str(bits)
-            else:
-                value_str = f[1] % value
-
-            print("%-25s" % f[2], value_str)
-        print("")
-
-    def dump_extensions(self):
-        for ex in self.extensions:
-
-            data = ex.data[:ex.length]
-            if all(c in string.printable.encode('ascii') for c in data):
-                data = "'%s'" % data.decode('ascii')
-            else:
-                data = "<binary>"
-
-            print("Header extension:")
-            print("%-25s %#x" % ("magic", ex.magic))
-            print("%-25s %d" % ("length", ex.length))
-            print("%-25s %s" % ("data", data))
-            print("")
+from qcow2_format import (
+    QcowHeader,
+    QcowHeaderExtension
+)


 def cmd_dump_header(fd):
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
new file mode 100644
index 000000000000..0e517c1bbc5a
--- /dev/null
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -0,0 +1,173 @@
+# Library for manipulations with qcow2 image
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import struct
+import string
+
+
+class QcowHeaderExtension:
+
+    def __init__(self, magic, length, data):
+        if length % 8 != 0:
+            padding = 8 - (length % 8)
+            data += b"\0" * padding
+
+        self.magic = magic
+        self.length = length
+        self.data = data
+
+    @classmethod
+    def create(cls, magic, data):
+        return QcowHeaderExtension(magic, len(data), data)
+
+
+class QcowHeader:
+
+    uint32_t = 'I'
+    uint64_t = 'Q'
+
+    fields = [
+        # Version 2 header fields
+        [uint32_t, '%#x',  'magic'],
+        [uint32_t, '%d',   'version'],
+        [uint64_t, '%#x',  'backing_file_offset'],
+        [uint32_t, '%#x',  'backing_file_size'],
+        [uint32_t, '%d',   'cluster_bits'],
+        [uint64_t, '%d',   'size'],
+        [uint32_t, '%d',   'crypt_method'],
+        [uint32_t, '%d',   'l1_size'],
+        [uint64_t, '%#x',  'l1_table_offset'],
+        [uint64_t, '%#x',  'refcount_table_offset'],
+        [uint32_t, '%d',   'refcount_table_clusters'],
+        [uint32_t, '%d',   'nb_snapshots'],
+        [uint64_t, '%#x',  'snapshot_offset'],
+
+        # Version 3 header fields
+        [uint64_t, 'mask', 'incompatible_features'],
+        [uint64_t, 'mask', 'compatible_features'],
+        [uint64_t, 'mask', 'autoclear_features'],
+        [uint32_t, '%d',   'refcount_order'],
+        [uint32_t, '%d',   'header_length'],
+    ]
+
+    fmt = '>' + ''.join(field[0] for field in fields)
+
+    def __init__(self, fd):
+
+        buf_size = struct.calcsize(QcowHeader.fmt)
+
+        fd.seek(0)
+        buf = fd.read(buf_size)
+
+        header = struct.unpack(QcowHeader.fmt, buf)
+        self.__dict__ = dict((field[2], header[i])
+                             for i, field in enumerate(QcowHeader.fields))
+
+        self.set_defaults()
+        self.cluster_size = 1 << self.cluster_bits
+
+        fd.seek(self.header_length)
+        self.load_extensions(fd)
+
+        if self.backing_file_offset:
+            fd.seek(self.backing_file_offset)
+            self.backing_file = fd.read(self.backing_file_size)
+        else:
+            self.backing_file = None
+
+    def set_defaults(self):
+        if self.version == 2:
+            self.incompatible_features = 0
+            self.compatible_features = 0
+            self.autoclear_features = 0
+            self.refcount_order = 4
+            self.header_length = 72
+
+    def load_extensions(self, fd):
+        self.extensions = []
+
+        if self.backing_file_offset != 0:
+            end = min(self.cluster_size, self.backing_file_offset)
+        else:
+            end = self.cluster_size
+
+        while fd.tell() < end:
+            (magic, length) = struct.unpack('>II', fd.read(8))
+            if magic == 0:
+                break
+            else:
+                padded = (length + 7) & ~7
+                data = fd.read(padded)
+                self.extensions.append(QcowHeaderExtension(magic, length,
+                                                           data))
+
+    def update_extensions(self, fd):
+
+        fd.seek(self.header_length)
+        extensions = self.extensions
+        extensions.append(QcowHeaderExtension(0, 0, b""))
+        for ex in extensions:
+            buf = struct.pack('>II', ex.magic, ex.length)
+            fd.write(buf)
+            fd.write(ex.data)
+
+        if self.backing_file is not None:
+            self.backing_file_offset = fd.tell()
+            fd.write(self.backing_file)
+
+        if fd.tell() > self.cluster_size:
+            raise Exception("I think I just broke the image...")
+
+    def update(self, fd):
+        header_bytes = self.header_length
+
+        self.update_extensions(fd)
+
+        fd.seek(0)
+        header = tuple(self.__dict__[f] for t, p, f in QcowHeader.fields)
+        buf = struct.pack(QcowHeader.fmt, *header)
+        buf = buf[0:header_bytes-1]
+        fd.write(buf)
+
+    def dump(self):
+        for f in QcowHeader.fields:
+            value = self.__dict__[f[2]]
+            if f[1] == 'mask':
+                bits = []
+                for bit in range(64):
+                    if value & (1 << bit):
+                        bits.append(bit)
+                value_str = str(bits)
+            else:
+                value_str = f[1] % value
+
+            print("%-25s" % f[2], value_str)
+        print("")
+
+    def dump_extensions(self):
+        for ex in self.extensions:
+
+            data = ex.data[:ex.length]
+            if all(c in string.printable.encode('ascii') for c in data):
+                data = "'%s'" % data.decode('ascii')
+            else:
+                data = "<binary>"
+
+            print("Header extension:")
+            print("%-25s %#x" % ("magic", ex.magic))
+            print("%-25s %d" % ("length", ex.length))
+            print("%-25s %s" % ("data", data))
+            print("")
-- 
2.27.0


