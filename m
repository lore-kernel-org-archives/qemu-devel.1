Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B81C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4242F20734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrfPwt5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4242F20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilLH-0003Cz-Ie
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEy-0001nN-Oj
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:53:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44726
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEx-0005cu-FW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591735978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xT7Dl2Np4lOx6956wQcDiocA0YR43F2Wm7BjuOHNaGo=;
 b=NrfPwt5BkCmfKj5dTmk2+Got1gQtRDEHzZV7xZ7WiZLZ0iPiG4v0S4EzJt6+3P64hTjKx2
 Z/QQmSaJ29mJ03H96MoaT/oRV/bnjm1mlxUQkpNwTQleN53CUDxZQhgPovxZaVtvhsFuqP
 OdV7Di0bqPwpHUEjvd5KjURMXJWD/dI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-hK0iZE50NXuPlW9nJy6RyA-1; Tue, 09 Jun 2020 16:52:56 -0400
X-MC-Unique: hK0iZE50NXuPlW9nJy6RyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 554AA8015CE;
 Tue,  9 Jun 2020 20:52:55 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD94F60C80;
 Tue,  9 Jun 2020 20:52:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/15] qcow2_format: refactor QcowHeaderExtension as a subclass
 of Qcow2Struct
Date: Tue,  9 Jun 2020 15:52:42 -0500
Message-Id: <20200609205245.3548257-13-eblake@redhat.com>
In-Reply-To: <20200609205245.3548257-1-eblake@redhat.com>
References: <20200609205245.3548257-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 16:46:48
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

Only two fields we can parse by generic code, but that is better than
nothing. Keep further refactoring of variable-length fields for another
day.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200606081806.23897-12-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/qcow2_format.py | 53 +++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index d4ad5431b296..32371e42da4e 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -97,16 +97,41 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
             print('{:<25} {}'.format(f[2], value_str))


-class QcowHeaderExtension:
+class QcowHeaderExtension(Qcow2Struct):

-    def __init__(self, magic, length, data):
-        if length % 8 != 0:
-            padding = 8 - (length % 8)
-            data += b'\0' * padding
+    fields = (
+        ('u32', '{:#x}', 'magic'),
+        ('u32', '{}', 'length')
+        # length bytes of data follows
+        # then padding to next multiply of 8
+    )

-        self.magic = magic
-        self.length = length
-        self.data = data
+    def __init__(self, magic=None, length=None, data=None, fd=None):
+        """
+        Support both loading from fd and creation from user data.
+        For fd-based creation current position in a file will be used to read
+        the data.
+
+        This should be somehow refactored and functionality should be moved to
+        superclass (to allow creation of any qcow2 struct), but then, fields
+        of variable length (data here) should be supported in base class
+        somehow. So, it's a TODO. We'll see how to properly refactor this when
+        we have more qcow2 structures.
+        """
+        if fd is None:
+            assert all(v is not None for v in (magic, length, data))
+            self.magic = magic
+            self.length = length
+            if length % 8 != 0:
+                padding = 8 - (length % 8)
+                data += b'\0' * padding
+            self.data = data
+        else:
+            assert all(v is None for v in (magic, length, data))
+            super().__init__(fd=fd)
+            padded = (self.length + 7) & ~7
+            self.data = fd.read(padded)
+            assert self.data is not None

     def dump(self):
         data = self.data[:self.length]
@@ -115,8 +140,7 @@ class QcowHeaderExtension:
         else:
             data = '<binary>'

-        print(f'{"magic":<25} {self.magic:#x}')
-        print(f'{"length":<25} {self.length}')
+        super().dump()
         print(f'{"data":<25} {data}')

     @classmethod
@@ -182,14 +206,11 @@ class QcowHeader(Qcow2Struct):
             end = self.cluster_size

         while fd.tell() < end:
-            (magic, length) = struct.unpack('>II', fd.read(8))
-            if magic == 0:
+            ext = QcowHeaderExtension(fd=fd)
+            if ext.magic == 0:
                 break
             else:
-                padded = (length + 7) & ~7
-                data = fd.read(padded)
-                self.extensions.append(QcowHeaderExtension(magic, length,
-                                                           data))
+                self.extensions.append(ext)

     def update_extensions(self, fd):

-- 
2.27.0


