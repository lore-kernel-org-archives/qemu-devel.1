Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37727C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037E32080C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwvSB2F8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037E32080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGiZZ-0005Pl-6D
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGiYD-00041O-CV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGiYC-0007sA-DX
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:20:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGiYC-0007rp-A9
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585052455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1PALZhzTZ/yxc7gxpribSfGldl+SWaMPLuS4AF6PbTk=;
 b=FwvSB2F8kfZ9dbTdtzBk3UZWykVivy4JdJWxLq8YvKq7gArdUjKRVU88czynXF6yMGZXaI
 FfaV1Qp23sVRtQHqhPAgLYK5M5Uvuo9l5M7rBhFBbryy81gWQx6eHRYlbZs92crnlKHvef
 CTQddVQ3Y73MBy6DZYcUJ3WcWdW1EII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-P_V8a761MNqStQBwKa3pdw-1; Tue, 24 Mar 2020 08:20:51 -0400
X-MC-Unique: P_V8a761MNqStQBwKa3pdw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98CBE801E67;
 Tue, 24 Mar 2020 12:20:50 +0000 (UTC)
Received: from localhost (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 338395D9E5;
 Tue, 24 Mar 2020 12:20:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/6] block: Avoid memleak on qcow2 image info failure
Date: Tue, 24 Mar 2020 13:20:39 +0100
Message-Id: <20200324122044.1131326-2-mreitz@redhat.com>
In-Reply-To: <20200324122044.1131326-1-mreitz@redhat.com>
References: <20200324122044.1131326-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

If we fail to get bitmap info, we must not leak the encryption info.

Fixes: b8968c875f403
Fixes: Coverity CID 1421894
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200320183620.1112123-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index d44b45633d..e08917ed84 100644
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


