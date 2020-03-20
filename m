Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E8C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5133720739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwuHfOnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5133720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFMZ4-0000OX-FE
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 14:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jFMY2-0007oR-P1
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jFMY1-0007c0-Q7
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:39:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38029)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jFMY1-0007bs-MR
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584729549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EutNwFsyjeaXeA3EhXfpOGaVfEBZjcEDXfgqw2Lku1s=;
 b=VwuHfOnrEAKg9Arnn/3aTe6/87BFnvPEgRVr++15fUO60IpfQHH7VpSJO+wcG9xOlytpL8
 5MHRngIuCl8MtkwmDyUlP8Xol2TSUH4E2RE2wEOnonMXRm38BViW/mPCbx7VUsU0DCFEoc
 gTL/Q5E3supS7RSZ/OP3Jz/G3iK9p20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-1dN82exbOIavQ4Di44cGTw-1; Fri, 20 Mar 2020 14:36:24 -0400
X-MC-Unique: 1dN82exbOIavQ4Di44cGTw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4799D100550D;
 Fri, 20 Mar 2020 18:36:23 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B681460BFB;
 Fri, 20 Mar 2020 18:36:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block: Avoid memleak on qcow2 image info failure
Date: Fri, 20 Mar 2020 13:36:20 -0500
Message-Id: <20200320183620.1112123-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 Max Reitz <mreitz@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>,
 andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we fail to get bitmap info, we must not leak the encryption info.

Fixes: b8968c875f403
Fixes: Coverity CID 1421894
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index d44b45633dbb..e08917ed8462 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4811,6 +4811,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(Blo=
ckDriverState *bs,
         if (local_err) {
             error_propagate(errp, local_err);
             qapi_free_ImageInfoSpecific(spec_info);
+            qapi_free_QCryptoBlockInfo(encrypt_info);
             return NULL;
         }
         *spec_info->u.qcow2.data =3D (ImageInfoSpecificQCow2){
--=20
2.25.1


