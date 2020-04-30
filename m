Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92264C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611EC2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzdmCoyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611EC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9Q5-0003Jz-HP
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jU9KS-0007yv-DF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jU9Gi-0004CC-KD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:34:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36823
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jU9Gh-00044M-Vb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588253422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDYZ/edZH6mxqJLMYiIk3JMWOXwnpwPCJ2Glil1Gqtg=;
 b=fzdmCoyx6lhX2CuBqHlJylnaMeVwBBD+VhjCAvkwf5lNlETG+2ro4ntfho35R7dKmptzWg
 gTeeiXdkVx0dtfcI25trA3I/aJcgxbgSdJeTyyhWFhVFmN2Z6Bo34VfBet3eMZ7mFnf78D
 kK4c6lDcvmMD+BucjKBSi3c0/ejrJyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-9Ud6x9WkOGeHZLqI0Usr5A-1; Thu, 30 Apr 2020 09:30:19 -0400
X-MC-Unique: 9Ud6x9WkOGeHZLqI0Usr5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ABD3EC1A1;
 Thu, 30 Apr 2020 13:30:18 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19D7666071;
 Thu, 30 Apr 2020 13:30:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/6] vmdk: Rename VmdkMetaData.valid to new_allocation
Date: Thu, 30 Apr 2020 15:30:02 +0200
Message-Id: <20200430133007.170335-2-kwolf@redhat.com>
In-Reply-To: <20200430133007.170335-1-kwolf@redhat.com>
References: <20200430133007.170335-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

m_data is used for zero clusters even though valid =3D=3D 0. It really only
means that a new cluster was allocated in the image file. Rename it to
reflect this.

While at it, change it from int to bool, too.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 8ec18f35a5..5b09275578 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -180,7 +180,7 @@ typedef struct VmdkMetaData {
     unsigned int l1_index;
     unsigned int l2_index;
     unsigned int l2_offset;
-    int valid;
+    bool new_allocation;
     uint32_t *l2_cache_entry;
 } VmdkMetaData;
=20
@@ -1492,7 +1492,7 @@ static int get_cluster_offset(BlockDriverState *bs,
     unsigned int l2_size_bytes =3D extent->l2_size * extent->entry_size;
=20
     if (m_data) {
-        m_data->valid =3D 0;
+        m_data->new_allocation =3D false;
     }
     if (extent->flat) {
         *cluster_offset =3D extent->flat_start_offset;
@@ -1630,7 +1630,7 @@ static int get_cluster_offset(BlockDriverState *bs,
             return ret;
         }
         if (m_data) {
-            m_data->valid =3D 1;
+            m_data->new_allocation =3D true;
             m_data->l1_index =3D l1_index;
             m_data->l2_index =3D l2_index;
             m_data->l2_offset =3D l2_offset;
@@ -2021,7 +2021,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_=
t offset,
             if (ret) {
                 return ret;
             }
-            if (m_data.valid) {
+            if (m_data.new_allocation) {
                 /* update L2 tables */
                 if (vmdk_L2update(extent, &m_data,
                                   cluster_offset >> BDRV_SECTOR_BITS)
--=20
2.25.3


