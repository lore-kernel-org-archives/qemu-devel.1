Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF85C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE9B222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rr8mjyvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE9B222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzlO-00056v-5v
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzXt-0006LJ-FQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzXs-0006GX-9N
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38533
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzXr-0006Cr-Me
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sG0XuUChJEQSJU/a3p0A//zbruXfiZigtw/szYBi2gI=;
 b=Rr8mjyvcns1OUyXCkamYyMULAiHQJ6PsrqwlMP4ytteyMtTQX+vkRVhBhapgh2kqVfs3G3
 2q/8Mz2vq+Www7uiRmLER1qsKuPL0iUs6owt8FZTEOeNCZ7FhzlyGQNiz/E8AOoImrdVBY
 NtHUWjAziN0U8DEuSbvkv+CmqoNOQac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-8hRECqWvN72RhYraW81ing-1; Thu, 19 Dec 2019 12:24:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECC10800D41;
 Thu, 19 Dec 2019 17:24:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 055AD620C0;
 Thu, 19 Dec 2019 17:24:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 08/30] qcow2: Declare BDRV_REQ_NO_FALLBACK supported
Date: Thu, 19 Dec 2019 18:24:19 +0100
Message-Id: <20191219172441.7289-9-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 8hRECqWvN72RhYraW81ing-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

In the common case, qcow2_co_pwrite_zeroes() already only modifies
metadata case, so we're fine with or without BDRV_REQ_NO_FALLBACK set.

The only exception is when using an external data file, where the
request is passed down to the block driver of the external data file. We
are forwarding the BDRV_REQ_NO_FALLBACK flag there, though, so this is
fine, too.

Declare the flag supported therefore.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7c18721741..de0e89cf25 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1722,7 +1722,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverStat=
e *bs, QDict *options,
         }
     }
=20
-    bs->supported_zero_flags =3D header.version >=3D 3 ? BDRV_REQ_MAY_UNMA=
P : 0;
+    bs->supported_zero_flags =3D header.version >=3D 3 ?
+                               BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK :=
 0;
=20
     /* Repair image if dirty */
     if (!(flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) && !bs->read_only &&
--=20
2.20.1


