Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136C7C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC32421743
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC32421743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48969 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLV5D-0008F4-3s
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 11:54:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuq-00080k-4f
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuo-00025C-Jq
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUuk-0001vi-5J; Tue, 30 Apr 2019 11:43:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47AF63098557;
	Tue, 30 Apr 2019 15:43:21 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5F3A64C7;
	Tue, 30 Apr 2019 15:43:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:31 +0200
Message-Id: <20190430154244.30083-15-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 30 Apr 2019 15:43:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/27] qcow2: Fix qcow2_make_empty() with
 external data file
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430154231.Mus2MUw-vqNF8xZ6ayvQ9FwyuKVE5solTMfDFAleafo@z>

make_completely_empty() is an optimisated path for bdrv_make_empty()
where completely new metadata is created inside the image file instead
of going through all clusters and discarding them. For an external data
file, however, we actually need to do discard operations on the data
file; just overwriting the qcow2 file doesn't get rid of the data.

The necessary slow path with an explicit discard operation already
exists for other cases. Use it for external data files, too.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7fbef97aab..840f289a48 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4384,14 +4384,17 @@ static int qcow2_make_empty(BlockDriverState *bs)
=20
     if (s->qcow_version >=3D 3 && !s->snapshots && !s->nb_bitmaps &&
         3 + l1_clusters <=3D s->refcount_block_size &&
-        s->crypt_method_header !=3D QCOW_CRYPT_LUKS) {
+        s->crypt_method_header !=3D QCOW_CRYPT_LUKS &&
+        !has_data_file(bs)) {
         /* The following function only works for qcow2 v3 images (it
          * requires the dirty flag) and only as long as there are no
          * features that reserve extra clusters (such as snapshots,
          * LUKS header, or persistent bitmaps), because it completely
          * empties the image.  Furthermore, the L1 table and three
          * additional clusters (image header, refcount table, one
-         * refcount block) have to fit inside one refcount block. */
+         * refcount block) have to fit inside one refcount block. It
+         * only resets the image file, i.e. does not work with an
+         * external data file. */
         return make_completely_empty(bs);
     }
=20
--=20
2.20.1


