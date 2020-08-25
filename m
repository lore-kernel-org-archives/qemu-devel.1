Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF878C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C15C2065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcXKgW6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C15C2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUbi-0005rm-SX
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPT-00055q-DE
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPH-0000gy-9S
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zC46cmj8HTn1ocCtjFNdHfAmOikSxd0rue+ib+ghsZY=;
 b=PcXKgW6GaL2vuefg+jWW5fC2ehVt0q6QCy4UbuT6z8QNwJbGoxYZM1GQncHPb24ikikieW
 ZoMTJsf+X938BI2zrnD/Eqf7MTr90CUhfwmsuQDNqCMKAeaUNG3IbnmOa8dFXK+VdwRcgT
 GpKNOIbFtAOFnv7T7HKFYEYwNMXlHhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328--0DLSeZkMMS-d_3MlRi0rA-1; Tue, 25 Aug 2020 04:34:12 -0400
X-MC-Unique: -0DLSeZkMMS-d_3MlRi0rA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A3051DDFD;
 Tue, 25 Aug 2020 08:34:11 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E34C17D939;
 Tue, 25 Aug 2020 08:34:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 25/34] qcow2: Update L2 bitmap in qcow2_alloc_cluster_link_l2()
Date: Tue, 25 Aug 2020 10:33:02 +0200
Message-Id: <20200825083311.1098442-26-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

The L2 bitmap needs to be updated after each write to indicate what
new subclusters are now allocated. This needs to happen even if the
cluster was already allocated and the L2 entry was otherwise valid.

In some cases however a write operation doesn't need change the L2
bitmap (because all affected subclusters were already allocated). This
is detected in calculate_l2_meta(), and qcow2_alloc_cluster_link_l2()
is never called in those cases.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <0875620d49f44320334b6a91c73b3f301f975f38.1594396418.git.berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a41351aba5..816ddc7639 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1062,6 +1062,24 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
         assert((offset & L2E_OFFSET_MASK) == offset);
 
         set_l2_entry(s, l2_slice, l2_index + i, offset | QCOW_OFLAG_COPIED);
+
+        /* Update bitmap with the subclusters that were just written */
+        if (has_subclusters(s)) {
+            uint64_t l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
+            unsigned written_from = m->cow_start.offset;
+            unsigned written_to = m->cow_end.offset + m->cow_end.nb_bytes ?:
+                m->nb_clusters << s->cluster_bits;
+            int first_sc, last_sc;
+            /* Narrow written_from and written_to down to the current cluster */
+            written_from = MAX(written_from, i << s->cluster_bits);
+            written_to   = MIN(written_to, (i + 1) << s->cluster_bits);
+            assert(written_from < written_to);
+            first_sc = offset_to_sc_index(s, written_from);
+            last_sc  = offset_to_sc_index(s, written_to - 1);
+            l2_bitmap |= QCOW_OFLAG_SUB_ALLOC_RANGE(first_sc, last_sc + 1);
+            l2_bitmap &= ~QCOW_OFLAG_SUB_ZERO_RANGE(first_sc, last_sc + 1);
+            set_l2_bitmap(s, l2_slice, l2_index + i, l2_bitmap);
+        }
      }
 
 
-- 
2.26.2


