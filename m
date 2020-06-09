Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6201DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F9720737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHIZiVHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F9720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilQg-0001PS-BI
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 17:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilF2-0001vM-97
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:53:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21692
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilF0-0005du-Ct
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591735981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aURE4gYYAYgiIkkGHgjWzEuuUfdhbMunL1QWTJ63vro=;
 b=QHIZiVHsOFSGQXsWutVrOxkvZcpD9X+vYeZVSX461VwGmCaoE3XHEENdTEt9Bu7wxoefhj
 ntEdOThFi8SlILPqj53+MAMIbNsadXxeNtlOTGGj9LpoZ1Xsyv+OACc3SZkEcHKrCboZ5Z
 sCUZT+HFyi8dkut9RSSMDsl58otqIn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-phPRY5acP6u2AzWpf8CTcw-1; Tue, 09 Jun 2020 16:52:57 -0400
X-MC-Unique: phPRY5acP6u2AzWpf8CTcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D70519200C4;
 Tue,  9 Jun 2020 20:52:56 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8591D61983;
 Tue,  9 Jun 2020 20:52:55 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/15] qcow2: QcowHeaderExtension print names for extension
 magics
Date: Tue,  9 Jun 2020 15:52:43 -0500
Message-Id: <20200609205245.3548257-14-eblake@redhat.com>
In-Reply-To: <20200609205245.3548257-1-eblake@redhat.com>
References: <20200609205245.3548257-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Suggested-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200606081806.23897-13-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/031.out         | 22 +++++++++++-----------
 tests/qemu-iotests/036.out         |  4 ++--
 tests/qemu-iotests/061.out         | 14 +++++++-------
 tests/qemu-iotests/qcow2_format.py | 17 ++++++++++++++++-
 4 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index 5a4beda6a23c..4b21d6a9ba18 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -25,7 +25,7 @@ refcount_order            4
 header_length             72

 Header extension:
-magic                     0x12345678
+magic                     0x12345678 (<unknown>)
 length                    31
 data                      'This is a test header extension'

@@ -53,7 +53,7 @@ refcount_order            4
 header_length             72

 Header extension:
-magic                     0x12345678
+magic                     0x12345678 (<unknown>)
 length                    31
 data                      'This is a test header extension'

@@ -81,12 +81,12 @@ refcount_order            4
 header_length             72

 Header extension:
-magic                     0xe2792aca
+magic                     0xe2792aca (Backing format)
 length                    11
 data                      'host_device'

 Header extension:
-magic                     0x12345678
+magic                     0x12345678 (<unknown>)
 length                    31
 data                      'This is a test header extension'

@@ -116,12 +116,12 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>

 Header extension:
-magic                     0x12345678
+magic                     0x12345678 (<unknown>)
 length                    31
 data                      'This is a test header extension'

@@ -149,12 +149,12 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>

 Header extension:
-magic                     0x12345678
+magic                     0x12345678 (<unknown>)
 length                    31
 data                      'This is a test header extension'

@@ -182,17 +182,17 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0xe2792aca
+magic                     0xe2792aca (Backing format)
 length                    11
 data                      'host_device'

 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>

 Header extension:
-magic                     0x12345678
+magic                     0x12345678 (<unknown>)
 length                    31
 data                      'This is a test header extension'

diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index e409acf60e2b..a9bed828e525 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -25,7 +25,7 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        [63]
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>

@@ -37,7 +37,7 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        []
 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>

diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index a51ad1b5ba52..2f03cf045cce 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -25,7 +25,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>

@@ -83,7 +83,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>

@@ -139,7 +139,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>

@@ -194,7 +194,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>

@@ -263,7 +263,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>

@@ -325,7 +325,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>

@@ -354,7 +354,7 @@ refcount_order            4
 header_length             112

 Header extension:
-magic                     0x6803f857
+magic                     0x6803f857 (Feature table)
 length                    336
 data                      <binary>

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 32371e42da4e..40b5bf467b24 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -39,6 +39,12 @@ class Flags64(Qcow2Field):
         return str(bits)


+class Enum(Qcow2Field):
+
+    def __str__(self):
+        return f'{self.value:#x} ({self.mapping.get(self.value, "<unknown>")})'
+
+
 class Qcow2StructMeta(type):

     # Mapping from c types to python struct format
@@ -99,8 +105,17 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):

 class QcowHeaderExtension(Qcow2Struct):

+    class Magic(Enum):
+        mapping = {
+            0xe2792aca: 'Backing format',
+            0x6803f857: 'Feature table',
+            0x0537be77: 'Crypto header',
+            0x23852875: 'Bitmaps',
+            0x44415441: 'Data file'
+        }
+
     fields = (
-        ('u32', '{:#x}', 'magic'),
+        ('u32', Magic, 'magic'),
         ('u32', '{}', 'length')
         # length bytes of data follows
         # then padding to next multiply of 8
-- 
2.27.0


