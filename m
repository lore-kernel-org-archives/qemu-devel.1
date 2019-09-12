Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0F9C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F1F2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F1F2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PjT-0005WO-Uo
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8PR8-0003Gq-RB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8PR7-0001d5-Jh
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:47:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8PR5-0001ag-0g; Thu, 12 Sep 2019 09:46:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C7A2308421A;
 Thu, 12 Sep 2019 13:46:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DE38600C8;
 Thu, 12 Sep 2019 13:46:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 15:46:04 +0200
Message-Id: <20190912134604.22019-23-kwolf@redhat.com>
In-Reply-To: <20190912134604.22019-1-kwolf@redhat.com>
References: <20190912134604.22019-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 12 Sep 2019 13:46:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 22/22] qcow2: Stop overwriting compressed
 clusters one by one
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

From: Alberto Garcia <berto@igalia.com>

handle_alloc() tries to find as many contiguous clusters that need
copy-on-write as possible in order to allocate all of them at the same
time.

However, compressed clusters are only overwritten one by one, so let's
say that we have an image with 1024 consecutive compressed clusters:

   qemu-img create -f qcow2 hd.qcow2 64M
   for f in `seq 0 64 65472`; do
      qemu-io -c "write -c ${f}k 64k" hd.qcow2
   done

In this case trying to overwrite the whole image with one large write
request results in 1024 separate allocations:

   qemu-io -c "write 0 64M" hd.qcow2

This restriction comes from commit 095a9c58ce12afeeb90c2 from 2008.
Nowadays QEMU can overwrite multiple compressed clusters just fine,
and in fact it already does: as long as the first cluster that
handle_alloc() finds is not compressed, all other compressed clusters
in the same batch will be overwritten in one go:

   qemu-img create -f qcow2 hd.qcow2 64M
   qemu-io -c "write -z 0 64k" hd.qcow2
   for f in `seq 64 64 65472`; do
      qemu-io -c "write -c ${f}k 64k" hd.qcow2
   done

Compared to the previous one, overwriting this image on my computer
goes from 8.35s down to 230ms.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: John Snow <jsnow@redhat.com
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f09cc992af..dcacd3c450 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1351,13 +1351,7 @@ static int handle_alloc(BlockDriverState *bs, uint=
64_t guest_offset,
     }
=20
     entry =3D be64_to_cpu(l2_slice[l2_index]);
-
-    /* For the moment, overwrite compressed clusters one by one */
-    if (entry & QCOW_OFLAG_COMPRESSED) {
-        nb_clusters =3D 1;
-    } else {
-        nb_clusters =3D count_cow_clusters(bs, nb_clusters, l2_slice, l2=
_index);
-    }
+    nb_clusters =3D count_cow_clusters(bs, nb_clusters, l2_slice, l2_ind=
ex);
=20
     /* This function is only called when there were no non-COW clusters,=
 so if
      * we can't find any unallocated or COW clusters either, something i=
s
--=20
2.20.1


