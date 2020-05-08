Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9DBC47254
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F74206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gi+hHt+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F74206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2Qg-0001yz-SK
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2KN-00008c-U4
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24960
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2KL-000836-PY
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588941724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/hbRce6sDGxan+/ZWSy5h0qW/KVQwihCeQwZmQw17qY=;
 b=Gi+hHt+6CSyEjCQoXtaALHYu/eULfNrPXRCST3n71U7beLrOCnqNZr56ejz8b0W2HEHa1B
 JFwJzk42+Pht+4c99xa63OdIxuoOamKIajiyQRO5JesuipCQxZuCxU51HuuA1U0S8CMWyO
 7DMvKmEUIH4St/Q0PMXjvdhGlijhxcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-4ZfoG7wYMPKHX9Ja-lPwIg-1; Fri, 08 May 2020 08:41:57 -0400
X-MC-Unique: 4ZfoG7wYMPKHX9Ja-lPwIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1880EC1A2;
 Fri,  8 May 2020 12:41:56 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-190.ams2.redhat.com
 [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C198019167;
 Fri,  8 May 2020 12:41:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 11/30] vmdk: Fix zero cluster allocation
Date: Fri,  8 May 2020 14:41:16 +0200
Message-Id: <20200508124135.252565-12-kwolf@redhat.com>
In-Reply-To: <20200508124135.252565-1-kwolf@redhat.com>
References: <20200508124135.252565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

m_data must contain valid data even for zero clusters when no cluster
was allocated in the image file. Without this, zero writes segfault with
images that have zeroed_grain=3Don.

For zero writes, we don't want to allocate a cluster in the image file
even in compressed files.

Fixes: 524089bce43fd1cd3daaca979872451efa2cf7c6
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200430133007.170335-3-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index ecfb4a86d2..fcd6b38d64 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1572,6 +1572,12 @@ static int get_cluster_offset(BlockDriverState *bs,
     extent->l2_cache_counts[min_index] =3D 1;
  found:
     l2_index =3D ((offset >> 9) / extent->cluster_sectors) % extent->l2_si=
ze;
+    if (m_data) {
+        m_data->l1_index =3D l1_index;
+        m_data->l2_index =3D l2_index;
+        m_data->l2_offset =3D l2_offset;
+        m_data->l2_cache_entry =3D ((uint32_t *)l2_table) + l2_index;
+    }
=20
     if (extent->sesparse) {
         cluster_sector =3D le64_to_cpu(((uint64_t *)l2_table)[l2_index]);
@@ -1631,10 +1637,6 @@ static int get_cluster_offset(BlockDriverState *bs,
         }
         if (m_data) {
             m_data->new_allocation =3D true;
-            m_data->l1_index =3D l1_index;
-            m_data->l2_index =3D l2_index;
-            m_data->l2_offset =3D l2_offset;
-            m_data->l2_cache_entry =3D ((uint32_t *)l2_table) + l2_index;
         }
     }
     *cluster_offset =3D cluster_sector << BDRV_SECTOR_BITS;
@@ -1990,7 +1992,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_=
t offset,
                 error_report("Could not write to allocated cluster"
                               " for streamOptimized");
                 return -EIO;
-            } else {
+            } else if (!zeroed) {
                 /* allocate */
                 ret =3D get_cluster_offset(bs, extent, &m_data, offset,
                                          true, &cluster_offset, 0, 0);
--=20
2.25.3


