Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47764C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162D020675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1g9p+2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162D020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyTA-0007w3-82
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVyOd-00010z-JB
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:18:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34000
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVyOc-00063b-GK
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588688285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hH03BKYFA32+IuJAFdD5wimyl3JSc0sP2Sl7UDkkxEw=;
 b=S1g9p+2rixusiGgM9uTRSvF9+BlhaIeLcGmMFD8l0U0l6/VWmGqh/0YoOhJ8y0Q+o9QvlX
 f5oQqiLv0WLhRqSJFTIUHh7+e7PoXuRf82iAtOkQYACeVKzxszggCs0IcDf7uEOMkCTgzk
 r4+wL7Z/2bLKzKDQPKSoz9Se+Unfwu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-nJOh9PsUMPafUOv7U2NrIg-1; Tue, 05 May 2020 10:18:04 -0400
X-MC-Unique: nJOh9PsUMPafUOv7U2NrIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2095B460;
 Tue,  5 May 2020 14:18:03 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B569D10013D9;
 Tue,  5 May 2020 14:18:02 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] qcow2: Fix preallocation on block devices
Date: Tue,  5 May 2020 16:18:01 +0200
Message-Id: <20200505141801.1096763-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Calling bdrv_getlength() to get the pre-truncate file size will not
really work on block devices, because they have always the same length,
and trying to write beyond it will fail with a rather cryptic error
message.

Instead, we should use qcow2_get_last_cluster() and bdrv_getlength()
only as a fallback.

Before this patch:
$ truncate -s 1G test.img
$ sudo losetup -f --show test.img
/dev/loop0
$ sudo qemu-img create -f qcow2 -o preallocation=3Dfull /dev/loop0 64M
Formatting '/dev/loop0', fmt=3Dqcow2 size=3D67108864 cluster_size=3D65536
preallocation=3Dfull lazy_refcounts=3Doff refcount_bits=3D16
qemu-img: /dev/loop0: Could not resize image: Failed to resize refcount
structures: No space left on device

With this patch:
$ sudo qemu-img create -f qcow2 -o preallocation=3Dfull /dev/loop0 64M
Formatting '/dev/loop0', fmt=3Dqcow2 size=3D67108864 cluster_size=3D65536
preallocation=3Dfull lazy_refcounts=3Doff refcount_bits=3D16
qemu-img: /dev/loop0: Could not resize image: Failed to resize
underlying file: Preallocation mode 'full' unsupported for this
non-regular file

So as you can see, it still fails, but now the problem is missing
support on the block device level, so we at least get a better error
message.

Note that we cannot preallocate block devices on truncate by design,
because we do not know what area to preallocate.  Their length is always
the same, the truncate operation does not change it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ad934109a8..c1a9edd6dc 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4107,7 +4107,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriver=
State *bs, int64_t offset,
     {
         int64_t allocation_start, host_offset, guest_offset;
         int64_t clusters_allocated;
-        int64_t old_file_size, new_file_size;
+        int64_t old_file_size, last_cluster, new_file_size;
         uint64_t nb_new_data_clusters, nb_new_l2_tables;
=20
         /* With a data file, preallocation means just allocating the metad=
ata
@@ -4127,7 +4127,13 @@ static int coroutine_fn qcow2_co_truncate(BlockDrive=
rState *bs, int64_t offset,
             ret =3D old_file_size;
             goto fail;
         }
-        old_file_size =3D ROUND_UP(old_file_size, s->cluster_size);
+
+        last_cluster =3D qcow2_get_last_cluster(bs, old_file_size);
+        if (last_cluster >=3D 0) {
+            old_file_size =3D (last_cluster + 1) * s->cluster_size;
+        } else {
+            old_file_size =3D ROUND_UP(old_file_size, s->cluster_size);
+        }
=20
         nb_new_data_clusters =3D DIV_ROUND_UP(offset - old_length,
                                             s->cluster_size);
--=20
2.26.2


