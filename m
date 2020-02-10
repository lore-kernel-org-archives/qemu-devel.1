Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90387C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A70220733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvA0tjRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A70220733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j15Kk-0001aS-JE
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 04:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j15IU-00078g-5j
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j15IS-00043b-Tg
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:24:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46105
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j15IS-00043M-Qm
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581326644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ej1OXP0ubMj+W5hQDxGY0iRN2cG3s7blczjtv9jCItc=;
 b=WvA0tjRbjX8v/sCIA65wnys0B7ySQZDHuOs2ob9/jmJ7McUmEF2CwQxCTf+s+Px3YhcY8B
 /lYdEqXdwVcxCLy7hlEEGT25TlkP73aqXLHa89OSjyXiy3sX4chXiP5z851IiRr+hQQC/L
 qc6CJ/p7YtvObg/VYg7nGkdNGRGFA3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-2pXXpCU0OJyV6kLxmap8xw-1; Mon, 10 Feb 2020 04:24:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9168D13E6;
 Mon, 10 Feb 2020 09:23:58 +0000 (UTC)
Received: from localhost (unknown [10.36.118.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78F6987054;
 Mon, 10 Feb 2020 09:23:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] block: fix crash on zero-length unaligned write and read
Date: Mon, 10 Feb 2020 09:23:47 +0000
Message-Id: <20200210092348.398611-2-stefanha@redhat.com>
In-Reply-To: <20200210092348.398611-1-stefanha@redhat.com>
References: <20200210092348.398611-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 2pXXpCU0OJyV6kLxmap8xw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Commit 7a3f542fbd "block/io: refactor padding" occasionally dropped
aligning for zero-length request: bdrv_init_padding() blindly return
false if bytes =3D=3D 0, like there is nothing to align.

This leads the following command to crash:

./qemu-io --image-opts -c 'write 1 0' \
  driver=3Dblkdebug,align=3D512,image.driver=3Dnull-co,image.size=3D512

>> qemu-io: block/io.c:1955: bdrv_aligned_pwritev: Assertion
    `(offset & (align - 1)) =3D=3D 0' failed.
>> Aborted (core dumped)

Prior to 7a3f542fbd we does aligning of such zero requests. Instead of
recovering this behavior let's just do nothing on such requests as it
is useless.

Note that driver may have special meaning of zero-length reqeusts, like
qcow2_co_pwritev_compressed_part, so we can't skip any zero-length
operation. But for unaligned ones, we can't pass it to driver anyway.

This commit also fixes crash in iotest 80 running with -nocache:

./check -nocache -qcow2 80

which crashes on same assertion due to trying to read empty extra data
in qcow2_do_read_snapshots().

Cc: qemu-stable@nongnu.org # v4.2
Fixes: 7a3f542fbd
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20200206164245.17781-1-vsementsov@virtuozzo.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 1eb2b2bddc..7e4cb74cf4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1565,10 +1565,12 @@ static bool bdrv_init_padding(BlockDriverState *bs,
         pad->tail =3D align - pad->tail;
     }
=20
-    if ((!pad->head && !pad->tail) || !bytes) {
+    if (!pad->head && !pad->tail) {
         return false;
     }
=20
+    assert(bytes); /* Nothing good in aligning zero-length requests */
+
     sum =3D pad->head + bytes + pad->tail;
     pad->buf_len =3D (sum > align && pad->head && pad->tail) ? 2 * align :=
 align;
     pad->buf =3D qemu_blockalign(bs, pad->buf_len);
@@ -1706,6 +1708,18 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *chil=
d,
         return ret;
     }
=20
+    if (bytes =3D=3D 0 && !QEMU_IS_ALIGNED(offset, bs->bl.request_alignmen=
t)) {
+        /*
+         * Aligning zero request is nonsense. Even if driver has special m=
eaning
+         * of zero-length (like qcow2_co_pwritev_compressed_part), we can'=
t pass
+         * it to driver due to request_alignment.
+         *
+         * Still, no reason to return an error if someone do unaligned
+         * zero-length read occasionally.
+         */
+        return 0;
+    }
+
     bdrv_inc_in_flight(bs);
=20
     /* Don't do copy-on-read if we read data before write operation */
@@ -2116,6 +2130,18 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *chi=
ld,
         return -ENOTSUP;
     }
=20
+    if (bytes =3D=3D 0 && !QEMU_IS_ALIGNED(offset, bs->bl.request_alignmen=
t)) {
+        /*
+         * Aligning zero request is nonsense. Even if driver has special m=
eaning
+         * of zero-length (like qcow2_co_pwritev_compressed_part), we can'=
t pass
+         * it to driver due to request_alignment.
+         *
+         * Still, no reason to return an error if someone do unaligned
+         * zero-length write occasionally.
+         */
+        return 0;
+    }
+
     bdrv_inc_in_flight(bs);
     /*
      * Align write if necessary by performing a read-modify-write cycle.
--=20
2.24.1


