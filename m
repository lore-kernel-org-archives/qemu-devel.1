Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9599BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:49:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6820C2068D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6820C2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfkoS-0004oO-MQ
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 09:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfknd-0003oP-St; Mon, 01 Jun 2020 09:48:21 -0400
Received: from relay.sw.ru ([185.231.240.75]:38780 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfknc-0001k8-4a; Mon, 01 Jun 2020 09:48:21 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfknN-0005dY-Lf; Mon, 01 Jun 2020 16:48:05 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 2/6] iotests: move check for printable data to
 QcowHeaderExtension class
Date: Mon,  1 Jun 2020 16:48:09 +0300
Message-Id: <1591019293-211155-3-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 09:48:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let us differ binary data type from string one for the extension data
variable and keep the string as the QcowHeaderExtension class member
in the script qcow2.py.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index e824b09..18e4923 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -13,6 +13,12 @@ class QcowHeaderExtension:
     QCOW2_EXT_MAGIC_DATA_FILE = 0x44415441
 
     def __init__(self, magic, length, data):
+        data_str = data[:length]
+        if all(c in string.printable.encode('ascii') for c in data_str):
+            data_str = "'%s'" % data_str.decode('ascii')
+        else:
+            data_str = "<binary>"
+
         if length % 8 != 0:
             padding = 8 - (length % 8)
             data += b"\0" * padding
@@ -21,6 +27,7 @@ class QcowHeaderExtension:
         self.length = length
         self.data = data
         self.name = self.extension_name(magic)
+        self.data_str = data_str
 
     @classmethod
     def create(cls, magic, data):
@@ -162,16 +169,10 @@ class QcowHeader:
     def dump_extensions(self):
         for ex in self.extensions:
 
-            data = ex.data[:ex.length]
-            if all(c in string.printable.encode('ascii') for c in data):
-                data = "'%s'" % data.decode('ascii')
-            else:
-                data = "<binary>"
-
             print("%-25s %s" % ("Header extension:", ex.name))
             print("%-25s %#x" % ("magic", ex.magic))
             print("%-25s %d" % ("length", ex.length))
-            print("%-25s %s" % ("data", data))
+            print("%-25s %s" % ("data", ex.data_str))
             print("")
 
 
-- 
1.8.3.1


