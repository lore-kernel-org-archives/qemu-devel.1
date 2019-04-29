Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC76C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 11:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3A220673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 11:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3A220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55739 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL41K-0002x4-Ei
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 07:00:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL40B-0002XI-IW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL3zk-0000vo-Cw
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:59:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hL3yl-0000Jk-UA; Mon, 29 Apr 2019 06:57:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5E1085A03;
	Mon, 29 Apr 2019 10:57:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-63.ams2.redhat.com
	[10.36.116.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 44816608C2;
	Mon, 29 Apr 2019 10:57:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 29 Apr 2019 12:57:41 +0200
Message-Id: <20190429105741.31033-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 29 Apr 2019 10:57:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] qcow2: Fix qcow2_make_empty() with external
 data file
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429105741.L_CkzN1tVe_ERVxRjpOQfHLrL5vb1FU40WI5_mZi2ec@z>

make_completely_empty() is an optimisated path for bdrv_make_empty()
where completely new metadata is created inside the image file instead
of going through all clusters and discarding them. For an external data
file, however, we actually need to do discard operations on the data
file; just overwriting the qcow2 file doesn't get rid of the data.

The necessary slow path with an explicit discard operation already
exists for other cases. Use it for external data files, too.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7fbef97aab..097fde56f9 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4384,7 +4384,8 @@ static int qcow2_make_empty(BlockDriverState *bs)
=20
     if (s->qcow_version >=3D 3 && !s->snapshots && !s->nb_bitmaps &&
         3 + l1_clusters <=3D s->refcount_block_size &&
-        s->crypt_method_header !=3D QCOW_CRYPT_LUKS) {
+        s->crypt_method_header !=3D QCOW_CRYPT_LUKS &&
+        !has_data_file(bs)) {
         /* The following function only works for qcow2 v3 images (it
          * requires the dirty flag) and only as long as there are no
          * features that reserve extra clusters (such as snapshots,
--=20
2.20.1


