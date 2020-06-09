Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C742C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB54920734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQs/iJAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB54920734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilNv-0006wy-2c
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 17:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilF0-0001rE-Mg
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:53:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31418
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEy-0005d7-8V
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591735979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9PmOd7xwEkBNsPkTefS2k9IpwawVFjlu2IH+kxt7Nxk=;
 b=hQs/iJADU/3rt8J0dq3LzkiM5HOvZebRC1/7stU+0PMLErXAUiv4b1S4bmdx45BWhyQfFd
 K3noMCh8QYwspO+Dh1H0b9un62+ySFn+JesjTzN26XSnan4p3FUpUYTPewIabsP2WGZBgd
 6bfng9ShTEE7fyDXB5ETOLRFA8ydwf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-3nvfOYgAMIOH8-ZCVXoV1w-1; Tue, 09 Jun 2020 16:52:53 -0400
X-MC-Unique: 3nvfOYgAMIOH8-ZCVXoV1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B2F719200C2;
 Tue,  9 Jun 2020 20:52:52 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F8B06116D;
 Tue,  9 Jun 2020 20:52:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/15] qcow2_format.py: use strings to specify c-type of struct
 fields
Date: Tue,  9 Jun 2020 15:52:38 -0500
Message-Id: <20200609205245.3548257-9-eblake@redhat.com>
In-Reply-To: <20200609205245.3548257-1-eblake@redhat.com>
References: <20200609205245.3548257-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
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

We are going to move field-parsing to super-class, this will be simpler
with simple string specifiers instead of variables.

For some reason, python doesn't allow the definition of ctypes variable
in the class alongside fields: it would not be available then for use
by the 'for' operator. Don't worry: ctypes will be moved to metaclass
soon.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200606081806.23897-8-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/qcow2_format.py | 50 +++++++++++++++++-------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index da66df340876..28f2bfa63bc7 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -34,36 +34,42 @@ class QcowHeaderExtension:
         return QcowHeaderExtension(magic, len(data), data)


+# Mapping from c types to python struct format
+ctypes = {
+    'u8': 'B',
+    'u16': 'H',
+    'u32': 'I',
+    'u64': 'Q'
+}
+
+
 class QcowHeader:

-    uint32_t = 'I'
-    uint64_t = 'Q'
-
     fields = (
         # Version 2 header fields
-        (uint32_t, '{:#x}', 'magic'),
-        (uint32_t, '{}', 'version'),
-        (uint64_t, '{:#x}', 'backing_file_offset'),
-        (uint32_t, '{:#x}', 'backing_file_size'),
-        (uint32_t, '{}', 'cluster_bits'),
-        (uint64_t, '{}', 'size'),
-        (uint32_t, '{}', 'crypt_method'),
-        (uint32_t, '{}', 'l1_size'),
-        (uint64_t, '{:#x}', 'l1_table_offset'),
-        (uint64_t, '{:#x}', 'refcount_table_offset'),
-        (uint32_t, '{}', 'refcount_table_clusters'),
-        (uint32_t, '{}', 'nb_snapshots'),
-        (uint64_t, '{:#x}', 'snapshot_offset'),
+        ('u32', '{:#x}', 'magic'),
+        ('u32', '{}', 'version'),
+        ('u64', '{:#x}', 'backing_file_offset'),
+        ('u32', '{:#x}', 'backing_file_size'),
+        ('u32', '{}', 'cluster_bits'),
+        ('u64', '{}', 'size'),
+        ('u32', '{}', 'crypt_method'),
+        ('u32', '{}', 'l1_size'),
+        ('u64', '{:#x}', 'l1_table_offset'),
+        ('u64', '{:#x}', 'refcount_table_offset'),
+        ('u32', '{}', 'refcount_table_clusters'),
+        ('u32', '{}', 'nb_snapshots'),
+        ('u64', '{:#x}', 'snapshot_offset'),

         # Version 3 header fields
-        (uint64_t, 'mask', 'incompatible_features'),
-        (uint64_t, 'mask', 'compatible_features'),
-        (uint64_t, 'mask', 'autoclear_features'),
-        (uint32_t, '{}', 'refcount_order'),
-        (uint32_t, '{}', 'header_length'),
+        ('u64', 'mask', 'incompatible_features'),
+        ('u64', 'mask', 'compatible_features'),
+        ('u64', 'mask', 'autoclear_features'),
+        ('u32', '{}', 'refcount_order'),
+        ('u32', '{}', 'header_length'),
     )

-    fmt = '>' + ''.join(field[0] for field in fields)
+    fmt = '>' + ''.join(ctypes[f[0]] for f in fields)

     def __init__(self, fd):

-- 
2.27.0


