Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F84CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59EE420734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Usu1/nPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EE420734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilGR-0004He-Im
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEw-0001iC-Gn
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:52:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35399
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEv-0005c0-AO
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591735976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gkJQrcmtu07hJLZsxNO23mQmGAJYFCopm0+MuaUKqc=;
 b=Usu1/nPwyYbGuyytT90DVsmfscEHol8W22WbBHRUJFD1Z2JsXU1kWHoZqFdumcIzPPDku9
 2Qv5sALQD/dnOxnvpDL0Rk+7ra+ewIoSgu2pusIRn1GqAhFtrS98KfckGq1qgbnBE8sfsA
 pIbzVoa38hAUF3vtHk0s6YVZ4xhEdOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-MYBpZcgiMV2PJGRKG4T0cw-1; Tue, 09 Jun 2020 16:52:54 -0400
X-MC-Unique: MYBpZcgiMV2PJGRKG4T0cw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53185835B44;
 Tue,  9 Jun 2020 20:52:53 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C959C6116D;
 Tue,  9 Jun 2020 20:52:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/15] qcow2_format.py: separate generic functionality of
 structure classes
Date: Tue,  9 Jun 2020 15:52:39 -0500
Message-Id: <20200609205245.3548257-10-eblake@redhat.com>
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
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We are going to introduce more Qcow2 structure types, defined like
QcowHeader. Move generic functionality into base class to be reused for
further structure classes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200606081806.23897-9-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/qcow2_format.py | 101 +++++++++++++++++++----------
 1 file changed, 66 insertions(+), 35 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 28f2bfa63bc7..898d388b8adf 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -1,5 +1,7 @@
 # Library for manipulations with qcow2 image
 #
+# Copyright (c) 2020 Virtuozzo International GmbH.
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation; either version 2 of the License, or
@@ -18,6 +20,68 @@ import struct
 import string


+class Qcow2StructMeta(type):
+
+    # Mapping from c types to python struct format
+    ctypes = {
+        'u8': 'B',
+        'u16': 'H',
+        'u32': 'I',
+        'u64': 'Q'
+    }
+
+    def __init__(self, name, bases, attrs):
+        if 'fields' in attrs:
+            self.fmt = '>' + ''.join(self.ctypes[f[0]] for f in self.fields)
+
+
+class Qcow2Struct(metaclass=Qcow2StructMeta):
+
+    """Qcow2Struct: base class for qcow2 data structures
+
+    Successors should define fields class variable, which is: list of tuples,
+    each of three elements:
+        - c-type (one of 'u8', 'u16', 'u32', 'u64')
+        - format (format_spec to use with .format() when dump or 'mask' to dump
+                  bitmasks)
+        - field name
+    """
+
+    def __init__(self, fd=None, offset=None, data=None):
+        """
+        Two variants:
+            1. Specify data. fd and offset must be None.
+            2. Specify fd and offset, data must be None. offset may be omitted
+               in this case, than current position of fd is used.
+        """
+        if data is None:
+            assert fd is not None
+            buf_size = struct.calcsize(self.fmt)
+            if offset is not None:
+                fd.seek(offset)
+            data = fd.read(buf_size)
+        else:
+            assert fd is None and offset is None
+
+        values = struct.unpack(self.fmt, data)
+        self.__dict__ = dict((field[2], values[i])
+                             for i, field in enumerate(self.fields))
+
+    def dump(self):
+        for f in self.fields:
+            value = self.__dict__[f[2]]
+            if f[1] == 'mask':
+                bits = []
+                for bit in range(64):
+                    if value & (1 << bit):
+                        bits.append(bit)
+                value_str = str(bits)
+            else:
+                value_str = f[1].format(value)
+
+            print('{:<25} {}'.format(f[2], value_str))
+
+
 class QcowHeaderExtension:

     def __init__(self, magic, length, data):
@@ -34,16 +98,7 @@ class QcowHeaderExtension:
         return QcowHeaderExtension(magic, len(data), data)


-# Mapping from c types to python struct format
-ctypes = {
-    'u8': 'B',
-    'u16': 'H',
-    'u32': 'I',
-    'u64': 'Q'
-}
-
-
-class QcowHeader:
+class QcowHeader(Qcow2Struct):

     fields = (
         # Version 2 header fields
@@ -69,18 +124,8 @@ class QcowHeader:
         ('u32', '{}', 'header_length'),
     )

-    fmt = '>' + ''.join(ctypes[f[0]] for f in fields)
-
     def __init__(self, fd):
-
-        buf_size = struct.calcsize(QcowHeader.fmt)
-
-        fd.seek(0)
-        buf = fd.read(buf_size)
-
-        header = struct.unpack(QcowHeader.fmt, buf)
-        self.__dict__ = dict((field[2], header[i])
-                             for i, field in enumerate(QcowHeader.fields))
+        super().__init__(fd=fd, offset=0)

         self.set_defaults()
         self.cluster_size = 1 << self.cluster_bits
@@ -148,20 +193,6 @@ class QcowHeader:
         buf = buf[0:header_bytes-1]
         fd.write(buf)

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
-                value_str = f[1].format(value)
-
-            print(f'{f[2]:<25} {value_str}')
-
     def dump_extensions(self):
         for ex in self.extensions:

-- 
2.27.0


