Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5454C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19BD2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjwoGtLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19BD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97pv-0005LK-Oj
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97j0-0007OT-RF
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51482
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97iy-0004YK-G8
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bb4fvTMSCItB9jUwQLJKgqwZGCl+g+KP57d0VMWcbPo=;
 b=JjwoGtLbAlU82lLk6X0OwibPL7l9ROUwSR5PRbvjCeoch9ve6I/B2HVGri64SmLwk8UkCy
 6pg1jUqpfp1GuWjmpnSygHa668dpkYzhJi3oSxICcc3OBixhoLmPGvRgc6USJIauTl1hMr
 7uerL2ol7FuEMyMA3a9sEWsllnTw/9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-FSEnJA6-NSu7NVfGIRUuPg-1; Fri, 21 Aug 2020 10:08:38 -0400
X-MC-Unique: FSEnJA6-NSu7NVfGIRUuPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D69781F03E;
 Fri, 21 Aug 2020 14:08:37 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-220.phx2.redhat.com [10.3.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E1067AEC9;
 Fri, 21 Aug 2020 14:08:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/14] qcow2_format.py: collect fields to dump in JSON format
Date: Fri, 21 Aug 2020 09:08:21 -0500
Message-Id: <20200821140826.194322-10-eblake@redhat.com>
In-Reply-To: <20200821140826.194322-1-eblake@redhat.com>
References: <20200821140826.194322-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

As __dict__ is being extended with class members we do not want to
print, add the to_json() method to classes that returns a json-dumpable
object with desired fields and their values. Extend it in subclass when
necessary to print the final dictionary in the JSON output which
follows.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <1596742557-320265-10-git-send-email-andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/qcow2_format.py | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index de0adcbf9db0..5a298b2f1357 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -119,6 +119,9 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):

             print('{:<25} {}'.format(f[2], value_str))

+    def to_json(self):
+        return dict((f[2], self.__dict__[f[2]]) for f in self.fields)
+

 class Qcow2BitmapExt(Qcow2Struct):

@@ -151,6 +154,11 @@ class Qcow2BitmapExt(Qcow2Struct):
             print()
             entry.dump()

+    def to_json(self):
+        fields_dict = super().to_json()
+        fields_dict['bitmap_directory'] = self.bitmap_directory
+        return fields_dict
+

 class Qcow2BitmapDirEntry(Qcow2Struct):

@@ -189,6 +197,14 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
         super(Qcow2BitmapDirEntry, self).dump()
         self.bitmap_table.dump()

+    def to_json(self):
+        # Put the name ahead of the dict
+        return {
+            'name': self.name,
+            **super().to_json(),
+            'bitmap_table': self.bitmap_table
+        }
+

 class Qcow2BitmapTableEntry(Qcow2Struct):

@@ -214,6 +230,10 @@ class Qcow2BitmapTableEntry(Qcow2Struct):
         else:
             self.type = 'all-zeroes'

+    def to_json(self):
+        return {'type': self.type, 'offset': self.offset,
+                'reserved': self.reserved}
+

 class Qcow2BitmapTable:

@@ -234,6 +254,9 @@ class Qcow2BitmapTable:
                 size = 0
             print(f'{i:<14} {entry.type:<15} {size:<12} {entry.offset}')

+    def to_json(self):
+        return self.entries
+

 QCOW2_EXT_MAGIC_BITMAPS = 0x23852875

@@ -249,6 +272,9 @@ class QcowHeaderExtension(Qcow2Struct):
             0x44415441: 'Data file'
         }

+        def to_json(self):
+            return self.mapping.get(self.value, "<unknown>")
+
     fields = (
         ('u32', Magic, 'magic'),
         ('u32', '{}', 'length')
@@ -311,6 +337,16 @@ class QcowHeaderExtension(Qcow2Struct):
         else:
             self.obj.dump()

+    def to_json(self):
+        # Put the name ahead of the dict
+        res = {'name': self.Magic(self.magic), **super().to_json()}
+        if self.obj is not None:
+            res['data'] = self.obj
+        else:
+            res['data_str'] = self.data_str
+
+        return res
+
     @classmethod
     def create(cls, magic, data):
         return QcowHeaderExtension(magic, len(data), data)
-- 
2.28.0


