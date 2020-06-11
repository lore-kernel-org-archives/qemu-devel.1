Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5677FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DA42074B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DA42074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUf0-000710-AK
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 17:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjUbh-00033a-RD; Thu, 11 Jun 2020 17:19:29 -0400
Received: from relay.sw.ru ([185.231.240.75]:40354 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjUbe-00057q-P2; Thu, 11 Jun 2020 17:19:28 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjUbW-0001xE-UE; Fri, 12 Jun 2020 00:19:18 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 7/8] qcow2_format.py: collect fields to dump in JSON format
Date: Fri, 12 Jun 2020 00:19:19 +0300
Message-Id: <1591910360-867499-8-git-send-email-andrey.shinkevich@virtuozzo.com>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

As __dict__ is being extended with class members we do not want to
print in JSON format dump, make a light copy of the initial __dict__
and extend the copy by adding lists we have to print in the JSON
output.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 95db7a9..bb2f13b 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -92,6 +92,8 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
         self.__dict__ = dict((field[2], values[i])
                              for i, field in enumerate(self.fields))
 
+        self.fields_dict = self.__dict__.copy()
+
     def dump(self, dump_json=None):
         for f in self.fields:
             value = self.__dict__[f[2]]
@@ -102,7 +104,6 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
 
             print('{:<25} {}'.format(f[2], value_str))
 
-
 # seek relative to the current position in the file
 FROM_CURRENT = 1
 
@@ -142,6 +143,7 @@ class Qcow2BitmapExt(Qcow2Struct):
 
     def load(self, fd):
         self.read_bitmap_directory(fd)
+        self.fields_dict.update(entries=self.bitmaps)
 
     def dump(self, dump_json=None):
         super().dump(dump_json)
@@ -189,6 +191,7 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
         table_size = self.bitmap_table_bytes * struct.calcsize('Q')
         table = [e[0] for e in struct.iter_unpack('>Q', fd.read(table_size))]
         self.bitmap_table = Qcow2BitmapTable(table)
+        self.fields_dict.update(bitmap_table=self.bitmap_table)
 
     def dump_bitmap_dir_entry(self, dump_json=None):
         print()
-- 
1.8.3.1


