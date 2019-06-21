Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF406C48BE0
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFD621530
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFD621530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34820 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heJY2-0008WB-S7
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 09:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50452)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1heJWE-0006KF-QI
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1heJW9-0004Wo-7C
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:23:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1heJW0-0004QZ-Jf; Fri, 21 Jun 2019 09:23:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E838B30F1BC4;
 Fri, 21 Jun 2019 13:23:39 +0000 (UTC)
Received: from localhost (ovpn-204-30.brq.redhat.com [10.40.204.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8153A5B68B;
 Fri, 21 Jun 2019 13:23:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 21 Jun 2019 15:23:21 +0200
Message-Id: <20190621132324.2165-6-mreitz@redhat.com>
In-Reply-To: <20190621132324.2165-1-mreitz@redhat.com>
References: <20190621132324.2165-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 21 Jun 2019 13:23:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/8] vmdk: Reduce the max bound for L1 table size
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

From: Sam Eiderman <shmuel.eiderman@oracle.com>

512M of L1 entries is a very loose bound, only 32M are required to store
the maximal supported VMDK file size of 2TB.

Fixed qemu-iotest 59# - now failure occures before on impossible L1
table size.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-id: 20190620091057.47441-3-shmuel.eiderman@oracle.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/vmdk.c               | 13 +++++++------
 tests/qemu-iotests/059.out |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 0f2e453bf5..931eb2759c 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -425,15 +425,16 @@ static int vmdk_add_extent(BlockDriverState *bs,
         error_setg(errp, "Invalid granularity, image may be corrupt");
         return -EFBIG;
     }
-    if (l1_size > 512 * 1024 * 1024) {
+    if (l1_size > 32 * 1024 * 1024) {
         /*
          * Although with big capacity and small l1_entry_sectors, we can=
 get a
          * big l1_size, we don't want unbounded value to allocate the ta=
ble.
-         * Limit it to 512M, which is:
-         *     16PB - for default "Hosted Sparse Extent" (VMDK4)
-         *            cluster size: 64KB, L2 table size: 512 entries
-         *     1PB  - for default "ESXi Host Sparse Extent" (VMDK3/vmfsS=
parse)
-         *            cluster size: 512B, L2 table size: 4096 entries
+         * Limit it to 32M, which is enough to store:
+         *     8TB  - for both VMDK3 & VMDK4 with
+         *            minimal cluster size: 512B
+         *            minimal L2 table size: 512 entries
+         *            8 TB is still more than the maximal value supporte=
d for
+         *            VMDK3 & VMDK4 which is 2TB.
          */
         error_setg(errp, "L1 size too big");
         return -EFBIG;
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index f51394ae8e..4fab42a28c 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2358,5 +2358,5 @@ Offset          Length          Mapped to       Fil=
e
 0x140000000     0x10000         0x50000         TEST_DIR/t-s003.vmdk
=20
 =3D=3D=3D Testing afl image with a very large capacity =3D=3D=3D
-qemu-img: Can't get image size 'TEST_DIR/afl9.IMGFMT': File too large
+qemu-img: Could not open 'TEST_DIR/afl9.IMGFMT': L1 size too big
 *** done
--=20
2.21.0


