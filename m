Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49E0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8702065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAorV+eJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8702065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUgC-0005Sx-PN
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPf-0005VZ-JM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41041
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPa-0000kY-2n
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPJQtlo4rKGVw4Py8ASiQq+WHa7VYt9+5uBjw3j7744=;
 b=iAorV+eJJUFw7OttKSTpayHKR5gA7b1RiRklLB8pN0KvPcyaCwrBiP3V7CEM4mL9H7UICG
 HyoSI8EOgKrPIpF3tDEvxgccdH8EjMOmNqlQRYcD5QVKOzdhkSp7bhAPp3fu8KwyyEfE6P
 C48v7EQC0gutdHA4oXp2fnXyHDTn9Xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-Z9Rws37rMAGeWFzDGsMafw-1; Tue, 25 Aug 2020 04:34:31 -0400
X-MC-Unique: Z9Rws37rMAGeWFzDGsMafw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 387E881F01A;
 Tue, 25 Aug 2020 08:34:30 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEBE360E1C;
 Tue, 25 Aug 2020 08:34:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 33/34] qcow2: Assert that expand_zero_clusters_in_l1() does not
 support subclusters
Date: Tue, 25 Aug 2020 10:33:10 +0200
Message-Id: <20200825083311.1098442-34-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:37:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

This function is only used by qcow2_expand_zero_clusters() to
downgrade a qcow2 image to a previous version. This would require
transforming all extended L2 entries into normal L2 entries but this
is not a simple task and there are no plans to implement this at the
moment.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <15e65112b4144381b4d8c0bdf8fb76b0d813e3d1.1594396418.git.berto@igalia.com>
[mreitz: Fixed comment style]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c      | 14 ++++++++++++--
 tests/qemu-iotests/061     |  6 ++++++
 tests/qemu-iotests/061.out |  5 +++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index fd506b4cb3..996b3314f4 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2166,6 +2166,9 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
     int ret;
     int i, j;
 
+    /* qcow2_downgrade() is not allowed in images with subclusters */
+    assert(!has_subclusters(s));
+
     slice_size2 = s->l2_slice_size * l2_entry_size(s);
     n_slices = s->cluster_size / slice_size2;
 
@@ -2233,8 +2236,11 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
 
                 if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
                     if (!bs->backing) {
-                        /* not backed; therefore we can simply deallocate the
-                         * cluster */
+                        /*
+                         * not backed; therefore we can simply deallocate the
+                         * cluster. No need to call set_l2_bitmap(), this
+                         * function doesn't support images with subclusters.
+                         */
                         set_l2_entry(s, l2_slice, j, 0);
                         l2_dirty = true;
                         continue;
@@ -2305,6 +2311,10 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 } else {
                     set_l2_entry(s, l2_slice, j, offset);
                 }
+                /*
+                 * No need to call set_l2_bitmap() after set_l2_entry() because
+                 * this function doesn't support images with subclusters.
+                 */
                 l2_dirty = true;
             }
 
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 08ddbdd10c..5747beb7ed 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -303,6 +303,12 @@ $QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
 _img_info --format-specific
 _check_test_img
 
+echo
+echo "=== Testing version downgrade with extended L2 entries ==="
+echo
+_make_test_img -o "compat=1.1,extended_l2=on" 64M
+$QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
+
 echo
 echo "=== Try changing the external data file ==="
 echo
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index b0a1382046..ee30da2665 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -533,6 +533,11 @@ Format specific information:
     extended l2: false
 No errors were found on the image.
 
+=== Testing version downgrade with extended L2 entries ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+qemu-img: Cannot downgrade an image with incompatible features 0x10 set
+
 === Try changing the external data file ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-- 
2.26.2


