Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D024C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79E620734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hn2NLAhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79E620734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilNK-0005xC-5E
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 17:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEz-0001ly-6j
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:53:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55821
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEx-0005ce-2M
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591735978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SmaP7JFguXSYIUjpk3oKNGUpu9UHziHLNUscAdqJ86Y=;
 b=Hn2NLAhKINuTW2OLES3ulTnEXydO8QSEC+ORX6Dx4eWjZliP+D139UD5hwdY2XfC2kVnpK
 50LgJXD1j+KO1g+77d6wbwWBrbXlMDs9fIbAT9wWHqWFGn09E8cEidMy1HzkNlsvc+XnIP
 Dr8jl2w8nkwNqyHzoVlvSfv9k6JtyP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-aLbHigi-P5uHEZcn-u2EEw-1; Tue, 09 Jun 2020 16:52:52 -0400
X-MC-Unique: aLbHigi-P5uHEZcn-u2EEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43B006A2BE;
 Tue,  9 Jun 2020 20:52:51 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8A066116D;
 Tue,  9 Jun 2020 20:52:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/15] qcow2_format.py: use tuples instead of lists for fields
Date: Tue,  9 Jun 2020 15:52:36 -0500
Message-Id: <20200609205245.3548257-7-eblake@redhat.com>
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

No need in lists: it's a constant variable.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200606081806.23897-6-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/qcow2_format.py | 40 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 2b6c9612ae01..e2f08ed69194 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -39,29 +39,29 @@ class QcowHeader:
     uint32_t = 'I'
     uint64_t = 'Q'

-    fields = [
+    fields = (
         # Version 2 header fields
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
+        (uint32_t, '%#x',  'magic'),
+        (uint32_t, '%d',   'version'),
+        (uint64_t, '%#x',  'backing_file_offset'),
+        (uint32_t, '%#x',  'backing_file_size'),
+        (uint32_t, '%d',   'cluster_bits'),
+        (uint64_t, '%d',   'size'),
+        (uint32_t, '%d',   'crypt_method'),
+        (uint32_t, '%d',   'l1_size'),
+        (uint64_t, '%#x',  'l1_table_offset'),
+        (uint64_t, '%#x',  'refcount_table_offset'),
+        (uint32_t, '%d',   'refcount_table_clusters'),
+        (uint32_t, '%d',   'nb_snapshots'),
+        (uint64_t, '%#x',  'snapshot_offset'),

         # Version 3 header fields
-        [uint64_t, 'mask', 'incompatible_features'],
-        [uint64_t, 'mask', 'compatible_features'],
-        [uint64_t, 'mask', 'autoclear_features'],
-        [uint32_t, '%d',   'refcount_order'],
-        [uint32_t, '%d',   'header_length'],
-    ]
+        (uint64_t, 'mask', 'incompatible_features'),
+        (uint64_t, 'mask', 'compatible_features'),
+        (uint64_t, 'mask', 'autoclear_features'),
+        (uint32_t, '%d',   'refcount_order'),
+        (uint32_t, '%d',   'header_length'),
+    )

     fmt = '>' + ''.join(field[0] for field in fields)

-- 
2.27.0


