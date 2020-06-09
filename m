Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F527C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285E220734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Msv7N1Og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285E220734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilNu-0006vT-BP
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 17:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilF1-0001uQ-Sw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:53:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20377
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilF0-0005e8-Qq
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591735981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vd5iKc9l3vMpfq7EOYBUtsqLeuqfAegPZm3hExgksoQ=;
 b=Msv7N1Ogg9dBGOyaymXMBvgXeGwgT545VVITTZOTcwtPtnNehA40qrx02RAH5edPTxAmsz
 KMP+uvp/0vAIeJB0ikAVOermYj2O3enCNH9pjYc/99JoMc6IUErFESvTcyDGEWc2jx++zQ
 4EGOT1Vfatxp2AdoYBcInxoM72NBD/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-R2Q4JwMCNHaOSunymNcBpA-1; Tue, 09 Jun 2020 16:52:57 -0400
X-MC-Unique: R2Q4JwMCNHaOSunymNcBpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBF898F4E5;
 Tue,  9 Jun 2020 20:52:56 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FCE860C80;
 Tue,  9 Jun 2020 20:52:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/15] qcow2_format.py: dump bitmaps header extension
Date: Tue,  9 Jun 2020 15:52:44 -0500
Message-Id: <20200609205245.3548257-15-eblake@redhat.com>
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

Add class for bitmap extension and dump its fields. Further work is to
dump bitmap directory.

Test new functionality inside 291 iotest.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200606081806.23897-14-vsementsov@virtuozzo.com>
[eblake: fix iotest output]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/291             |  4 +++
 tests/qemu-iotests/291.out         | 33 +++++++++++++++++++++++
 tests/qemu-iotests/qcow2_format.py | 42 +++++++++++++++++++++++-------
 3 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
index 3ca83b9cd1f7..e0cffc7cb119 100755
--- a/tests/qemu-iotests/291
+++ b/tests/qemu-iotests/291
@@ -62,6 +62,8 @@ $QEMU_IO -c 'w 1M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
 $QEMU_IMG bitmap --disable -f $IMGFMT "$TEST_IMG" b1
 $QEMU_IMG bitmap --enable -f $IMGFMT "$TEST_IMG" b2
 $QEMU_IO -c 'w 2M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
+echo "Check resulting qcow2 header extensions:"
+$PYTHON qcow2.py "$TEST_IMG" dump-header-exts

 echo
 echo "=== Bitmap preservation not possible to non-qcow2 ==="
@@ -88,6 +90,8 @@ $QEMU_IMG bitmap --merge tmp -f $IMGFMT "$TEST_IMG" b0
 $QEMU_IMG bitmap --remove --image-opts \
     driver=$IMGFMT,file.driver=file,file.filename="$TEST_IMG" tmp
 $QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
+echo "Check resulting qcow2 header extensions:"
+$PYTHON qcow2.py "$TEST_IMG" dump-header-exts

 echo
 echo "=== Check bitmap contents ==="
diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
index 8c62017567e9..ccfcdc5e35ce 100644
--- a/tests/qemu-iotests/291.out
+++ b/tests/qemu-iotests/291.out
@@ -14,6 +14,25 @@ wrote 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1048576/1048576 bytes at offset 2097152
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Check resulting qcow2 header extensions:
+Header extension:
+magic                     0xe2792aca (Backing format)
+length                    5
+data                      'qcow2'
+
+Header extension:
+magic                     0x6803f857 (Feature table)
+length                    336
+data                      <binary>
+
+Header extension:
+magic                     0x23852875 (Bitmaps)
+length                    24
+nb_bitmaps                2
+reserved32                0
+bitmap_directory_size     0x40
+bitmap_directory_offset   0x510000
+

 === Bitmap preservation not possible to non-qcow2 ===

@@ -65,6 +84,20 @@ Format specific information:
             granularity: 65536
     refcount bits: 16
     corrupt: false
+Check resulting qcow2 header extensions:
+Header extension:
+magic                     0x6803f857 (Feature table)
+length                    336
+data                      <binary>
+
+Header extension:
+magic                     0x23852875 (Bitmaps)
+length                    24
+nb_bitmaps                3
+reserved32                0
+bitmap_directory_size     0x60
+bitmap_directory_offset   0x520000
+

 === Check bitmap contents ===

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 40b5bf467b24..0f65fd161d5b 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -103,6 +103,19 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
             print('{:<25} {}'.format(f[2], value_str))


+class Qcow2BitmapExt(Qcow2Struct):
+
+    fields = (
+        ('u32', '{}', 'nb_bitmaps'),
+        ('u32', '{}', 'reserved32'),
+        ('u64', '{:#x}', 'bitmap_directory_size'),
+        ('u64', '{:#x}', 'bitmap_directory_offset')
+    )
+
+
+QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
+
+
 class QcowHeaderExtension(Qcow2Struct):

     class Magic(Enum):
@@ -110,7 +123,7 @@ class QcowHeaderExtension(Qcow2Struct):
             0xe2792aca: 'Backing format',
             0x6803f857: 'Feature table',
             0x0537be77: 'Crypto header',
-            0x23852875: 'Bitmaps',
+            QCOW2_EXT_MAGIC_BITMAPS: 'Bitmaps',
             0x44415441: 'Data file'
         }

@@ -130,8 +143,11 @@ class QcowHeaderExtension(Qcow2Struct):
         This should be somehow refactored and functionality should be moved to
         superclass (to allow creation of any qcow2 struct), but then, fields
         of variable length (data here) should be supported in base class
-        somehow. So, it's a TODO. We'll see how to properly refactor this when
-        we have more qcow2 structures.
+        somehow. Note also, that we probably want to parse different
+        extensions. Should they be subclasses of this class, or how to do it
+        better? Should it be something like QAPI union with discriminator field
+        (magic here). So, it's a TODO. We'll see how to properly refactor this
+        when we have more qcow2 structures.
         """
         if fd is None:
             assert all(v is not None for v in (magic, length, data))
@@ -148,15 +164,23 @@ class QcowHeaderExtension(Qcow2Struct):
             self.data = fd.read(padded)
             assert self.data is not None

-    def dump(self):
-        data = self.data[:self.length]
-        if all(c in string.printable.encode('ascii') for c in data):
-            data = f"'{ data.decode('ascii') }'"
+        if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
+            self.obj = Qcow2BitmapExt(data=self.data)
         else:
-            data = '<binary>'
+            self.obj = None

+    def dump(self):
         super().dump()
-        print(f'{"data":<25} {data}')
+
+        if self.obj is None:
+            data = self.data[:self.length]
+            if all(c in string.printable.encode('ascii') for c in data):
+                data = f"'{ data.decode('ascii') }'"
+            else:
+                data = '<binary>'
+            print(f'{"data":<25} {data}')
+        else:
+            self.obj.dump()

     @classmethod
     def create(cls, magic, data):
-- 
2.27.0


