Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE727C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EB720818
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EB720818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52189 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG3yl-0000Xo-3A
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 11:57:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hG3x5-0007fq-7o
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hG3x3-0003Ug-1l
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:55:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hG3wx-0003Nj-Av; Mon, 15 Apr 2019 11:55:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71CA681E0F;
	Mon, 15 Apr 2019 15:55:14 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-113.ams2.redhat.com
	[10.36.117.113])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 605DA60123;
	Mon, 15 Apr 2019 15:55:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 15 Apr 2019 17:54:50 +0200
Message-Id: <20190415155452.5115-3-kwolf@redhat.com>
In-Reply-To: <20190415155452.5115-1-kwolf@redhat.com>
References: <20190415155452.5115-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 15 Apr 2019 15:55:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.0? 2/4] qcow2: Fix preallocation
 bdrv_pwrite to wrong file
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415155450.ZQaITsbd0FTpGO390zmIN-8vElb_pLQeUbwqTCHWHj4@z>

With an external data file, preallocate_co() must write the final byte
to the external data file, not to the qcow2 image file.

This is harmless for preallocation of newly created images (only the
qcow2 file size is increased to the virtual disk size while it should be
much smaller), but with preallocated resize, it could in theory cause
visible corruption if the metadata of the image is larger than the data
(e.g. lots of bitmaps).

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c8400e9712..dfac74c264 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2772,7 +2772,7 @@ static int coroutine_fn preallocate_co(BlockDriverS=
tate *bs, uint64_t offset,
      */
     if (host_offset !=3D 0) {
         uint8_t data =3D 0;
-        ret =3D bdrv_pwrite(bs->file, (host_offset + cur_bytes) - 1,
+        ret =3D bdrv_pwrite(s->data_file, (host_offset + cur_bytes) - 1,
                           &data, 1);
         if (ret < 0) {
             return ret;
--=20
2.20.1


