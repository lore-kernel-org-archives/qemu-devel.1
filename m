Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E522C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE562054F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ha2NWr6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE562054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYzBA-0001HV-15
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 17:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYz8K-0006vV-0e
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:41:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38340
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYz8I-0005bg-GE
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589406101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11EItyxhwah0ZNUqpJ6iomtdgWv2ScwwGFBOkvnqQcU=;
 b=Ha2NWr6VvJFv32ee5/0Q0VrQMh3/nOFSTakMkWQfclq/YZbiy+6RZMI3HFvpjXauBdeE6s
 DmVE0HlxQ/Nu9kwXS21s3rldO/1R2K74Px4y5KiM1sXShqR9nnGD9qA2WDUOkDI3CpstWk
 VJNdyf3zVI6m7gp7t3OmRqzrL/C1mjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-5l-ljKviPSWO6g3F3fTmvA-1; Wed, 13 May 2020 17:41:38 -0400
X-MC-Unique: 5l-ljKviPSWO6g3F3fTmvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8058F100CCCC;
 Wed, 13 May 2020 21:41:37 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-80.rdu2.redhat.com [10.10.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7D4C2E055;
 Wed, 13 May 2020 21:41:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC WIP 5/6] qcow2.py: delint
Date: Wed, 13 May 2020 17:41:29 -0400
Message-Id: <20200513214130.15375-6-jsnow@redhat.com>
In-Reply-To: <20200513214130.15375-1-jsnow@redhat.com>
References: <20200513214130.15375-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/Makefile |   5 +-
 tests/qemu-iotests/pylintrc |   1 +
 tests/qemu-iotests/qcow2.py | 156 +++++++++++++++++++++++-------------
 3 files changed, 104 insertions(+), 58 deletions(-)

diff --git a/tests/qemu-iotests/Makefile b/tests/qemu-iotests/Makefile
index 5a3a1e8092..77da9fd96d 100644
--- a/tests/qemu-iotests/Makefile
+++ b/tests/qemu-iotests/Makefile
@@ -1,7 +1,5 @@
 PYMODULES = $(wildcard *.py)
 
-KNOWN_GOOD = iotests.py nbd-fault-injector.py qed.py
-
 CLEANFILES= *.out.bad *.notrun check.log check.time*
 
 # no default target
@@ -11,5 +9,4 @@ clean:
 	rm -f $(CLEANFILES)
 
 delint:
-	pylint $(KNOWN_GOOD)
-	pylint --disable=R,C,W $(filter-out $(KNOWN_GOOD), $(PYMODULES))
+	pylint $(PYMODULES)
diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
index 5481afe528..a334e242b6 100644
--- a/tests/qemu-iotests/pylintrc
+++ b/tests/qemu-iotests/pylintrc
@@ -17,6 +17,7 @@ disable=invalid-name,
         too-many-lines,
         too-many-locals,
         too-many-public-methods,
+        too-many-instance-attributes,
         # These are temporary, and should be removed:
         missing-docstring,
 
diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 94a07b2f6f..2840f4b661 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -11,14 +11,15 @@ def __init__(self, magic, length, data):
             padding = 8 - (length % 8)
             data += b"\0" * padding
 
-        self.magic  = magic
+        self.magic = magic
         self.length = length
-        self.data   = data
+        self.data = data
 
     @classmethod
     def create(cls, magic, data):
         return QcowHeaderExtension(magic, len(data), data)
 
+
 class QcowHeader:
 
     uint32_t = 'I'
@@ -26,30 +27,41 @@ class QcowHeader:
 
     fields = [
         # Version 2 header fields
-        [ uint32_t, '%#x',  'magic' ],
-        [ uint32_t, '%d',   'version' ],
-        [ uint64_t, '%#x',  'backing_file_offset' ],
-        [ uint32_t, '%#x',  'backing_file_size' ],
-        [ uint32_t, '%d',   'cluster_bits' ],
-        [ uint64_t, '%d',   'size' ],
-        [ uint32_t, '%d',   'crypt_method' ],
-        [ uint32_t, '%d',   'l1_size' ],
-        [ uint64_t, '%#x',  'l1_table_offset' ],
-        [ uint64_t, '%#x',  'refcount_table_offset' ],
-        [ uint32_t, '%d',   'refcount_table_clusters' ],
-        [ uint32_t, '%d',   'nb_snapshots' ],
-        [ uint64_t, '%#x',  'snapshot_offset' ],
+        # pylint: disable=bad-whitespace
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
 
         # Version 3 header fields
-        [ uint64_t, 'mask', 'incompatible_features' ],
-        [ uint64_t, 'mask', 'compatible_features' ],
-        [ uint64_t, 'mask', 'autoclear_features' ],
-        [ uint32_t, '%d',   'refcount_order' ],
-        [ uint32_t, '%d',   'header_length' ],
-    ];
+        [uint64_t, 'mask', 'incompatible_features'],
+        [uint64_t, 'mask', 'compatible_features'],
+        [uint64_t, 'mask', 'autoclear_features'],
+        [uint32_t, '%d',   'refcount_order'],
+        [uint32_t, '%d',   'header_length'],
+    ]
 
     fmt = '>' + ''.join(field[0] for field in fields)
 
+    @property
+    def backing_file_offset(self):
+        # Pylint struggles to verify dynamic properties.
+        # Dataclasses in 3.7 would make this easy.
+        return self.__dict__['backing_file_offset']
+
+    @backing_file_offset.setter
+    def backing_file_offset(self, val):
+        self.__dict__['backing_file_offset'] = val
+
     def __init__(self, fd):
 
         buf_size = struct.calcsize(QcowHeader.fmt)
@@ -59,22 +71,22 @@ def __init__(self, fd):
 
         header = struct.unpack(QcowHeader.fmt, buf)
         self.__dict__ = dict((field[2], header[i])
-            for i, field in enumerate(QcowHeader.fields))
+                             for i, field in enumerate(QcowHeader.fields))
 
         self.set_defaults()
-        self.cluster_size = 1 << self.cluster_bits
+        self.cluster_size = 1 << self.__dict__['cluster_bits']
 
         fd.seek(self.header_length)
         self.load_extensions(fd)
 
         if self.backing_file_offset:
             fd.seek(self.backing_file_offset)
-            self.backing_file = fd.read(self.backing_file_size)
+            self.backing_file = fd.read(self.__dict__['backing_file_size'])
         else:
             self.backing_file = None
 
     def set_defaults(self):
-        if self.version == 2:
+        if self.__dict__['version'] == 2:
             self.incompatible_features = 0
             self.compatible_features = 0
             self.autoclear_features = 0
@@ -93,10 +105,10 @@ def load_extensions(self, fd):
             (magic, length) = struct.unpack('>II', fd.read(8))
             if magic == 0:
                 break
-            else:
-                padded = (length + 7) & ~7
-                data = fd.read(padded)
-                self.extensions.append(QcowHeaderExtension(magic, length, data))
+            padded = (length + 7) & ~7
+            data = fd.read(padded)
+            extension = QcowHeaderExtension(magic, length, data)
+            self.extensions.append(extension)
 
     def update_extensions(self, fd):
 
@@ -108,7 +120,7 @@ def update_extensions(self, fd):
             fd.write(buf)
             fd.write(ex.data)
 
-        if self.backing_file != None:
+        if self.backing_file is None:
             self.backing_file_offset = fd.tell()
             fd.write(self.backing_file)
 
@@ -170,13 +182,13 @@ def cmd_dump_header_exts(fd):
 def cmd_set_header(fd, name, value):
     try:
         value = int(value, 0)
-    except:
-        print("'%s' is not a valid number" % value)
+    except ValueError:
+        print(f"'{value}' is not a valid number")
         sys.exit(1)
 
     fields = (field[2] for field in QcowHeader.fields)
     if not name in fields:
-        print("'%s' is not a known header field" % name)
+        print("'{name}' is not a known header field")
         sys.exit(1)
 
     h = QcowHeader(fd)
@@ -186,12 +198,13 @@ def cmd_set_header(fd, name, value):
 def cmd_add_header_ext(fd, magic, data):
     try:
         magic = int(magic, 0)
-    except:
-        print("'%s' is not a valid magic number" % magic)
+    except ValueError:
+        print(f"'{magic}' is not a valid magic number")
         sys.exit(1)
 
     h = QcowHeader(fd)
-    h.extensions.append(QcowHeaderExtension.create(magic, data.encode('ascii')))
+    ext = QcowHeaderExtension.create(magic, data.encode('ascii'))
+    h.extensions.append(ext)
     h.update(fd)
 
 def cmd_add_header_ext_stdio(fd, magic):
@@ -201,8 +214,8 @@ def cmd_add_header_ext_stdio(fd, magic):
 def cmd_del_header_ext(fd, magic):
     try:
         magic = int(magic, 0)
-    except:
-        print("'%s' is not a valid magic number" % magic)
+    except ValueError:
+        print(f"'{magic}' is not a valid magic number")
         sys.exit(1)
 
     h = QcowHeader(fd)
@@ -224,8 +237,8 @@ def cmd_set_feature_bit(fd, group, bit):
         bit = int(bit, 0)
         if bit < 0 or bit >= 64:
             raise ValueError
-    except:
-        print("'%s' is not a valid bit number in range [0, 64)" % bit)
+    except ValueError:
+        print(f"'{bit}' is not a valid bit number in range [0, 64)")
         sys.exit(1)
 
     h = QcowHeader(fd)
@@ -236,33 +249,68 @@ def cmd_set_feature_bit(fd, group, bit):
     elif group == 'autoclear':
         h.autoclear_features |= 1 << bit
     else:
-        print("'%s' is not a valid group, try 'incompatible', 'compatible', or 'autoclear'" % group)
+        print(f"'{group}' is not a valid group, "
+              "try 'incompatible', 'compatible', or 'autoclear'")
         sys.exit(1)
 
     h.update(fd)
 
 cmds = [
-    [ 'dump-header',          cmd_dump_header,          0, 'Dump image header and header extensions' ],
-    [ 'dump-header-exts',     cmd_dump_header_exts,     0, 'Dump image header extensions' ],
-    [ 'set-header',           cmd_set_header,           2, 'Set a field in the header'],
-    [ 'add-header-ext',       cmd_add_header_ext,       2, 'Add a header extension' ],
-    [ 'add-header-ext-stdio', cmd_add_header_ext_stdio, 1, 'Add a header extension, data from stdin' ],
-    [ 'del-header-ext',       cmd_del_header_ext,       1, 'Delete a header extension' ],
-    [ 'set-feature-bit',      cmd_set_feature_bit,      2, 'Set a feature bit'],
+    [
+        'dump-header',
+        cmd_dump_header,
+        0,
+        'Dump image header and header extensions'
+    ],
+    [
+        'dump-header-exts',
+        cmd_dump_header_exts,
+        0,
+        'Dump image header extensions'
+    ],
+    [
+        'set-header',
+        cmd_set_header,
+        2,
+        'Set a field in the header'
+    ],
+    [
+        'add-header-ext',
+        cmd_add_header_ext,
+        2,
+        'Add a header extension'
+    ],
+    [
+        'add-header-ext-stdio',
+        cmd_add_header_ext_stdio,
+        1,
+        'Add a header extension, data from stdin'
+    ],
+    [
+        'del-header-ext',
+        cmd_del_header_ext,
+        1,
+        'Delete a header extension'
+    ],
+    [
+        'set-feature-bit',
+        cmd_set_feature_bit,
+        2,
+        'Set a feature bit'
+    ],
 ]
 
 def main(filename, cmd, args):
     fd = open(filename, "r+b")
     try:
-        for name, handler, num_args, desc in cmds:
+        for name, handler, num_args, _desc in cmds:
             if name != cmd:
                 continue
-            elif len(args) != num_args:
+            if len(args) != num_args:
                 usage()
                 return
-            else:
-                handler(fd, *args)
-                return
+            handler(fd, *args)
+            return
         print("Unknown command '%s'" % cmd)
     finally:
         fd.close()
@@ -271,7 +319,7 @@ def usage():
     print("Usage: %s <file> <cmd> [<arg>, ...]" % sys.argv[0])
     print("")
     print("Supported commands:")
-    for name, handler, num_args, desc in cmds:
+    for name, _handler, _num_args, desc in cmds:
         print("    %-20s - %s" % (name, desc))
 
 if __name__ == '__main__':
-- 
2.21.1


