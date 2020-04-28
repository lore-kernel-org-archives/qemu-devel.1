Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BF2C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E9E20731
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWE1SEj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E9E20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWto-00058K-5C
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWr5-0000Mt-4H
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWr2-0005ow-QU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45248
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTWr2-0005kl-CX
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588105758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o2JUTzEydDfOORdLh9vv53eEmG1/bHkJajTUdAvdkC8=;
 b=ZWE1SEj4ahMcpjoQxkv8CkEvWHBFccQfObWqEpCzboN6ZFwexERq7VhnWac0yISpEg0mdF
 XCu4T71ZF8+K/4lxxD6yxC5kns8Wk0yzPEwB6GId5ux/YKHxj/slgkL7xmR3RVYRpofS7P
 JhBFKco0ZE9/O/LOd1xBVMkasYk/yyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-KHbDp6KWMxOLg7eVKY20QQ-1; Tue, 28 Apr 2020 16:29:15 -0400
X-MC-Unique: KHbDp6KWMxOLg7eVKY20QQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DD4E801504;
 Tue, 28 Apr 2020 20:29:13 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 083EC5C1D4;
 Tue, 28 Apr 2020 20:29:10 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/9] gluster: Drop useless has_zero_init callback
Date: Tue, 28 Apr 2020 15:28:57 -0500
Message-Id: <20200428202905.770727-2-eblake@redhat.com>
In-Reply-To: <20200428202905.770727-1-eblake@redhat.com>
References: <20200428202905.770727-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, "open list:GLUSTER" <integration@gluster.org>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

block.c already defaults to 0 if we don't provide a callback; there's
no need to write a callback that always fails.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/gluster.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index d06df900f692..31233cac696a 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1359,12 +1359,6 @@ static int64_t qemu_gluster_allocated_file_size(Bloc=
kDriverState *bs)
     }
 }

-static int qemu_gluster_has_zero_init(BlockDriverState *bs)
-{
-    /* GlusterFS volume could be backed by a block device */
-    return 0;
-}
-
 /*
  * Find allocation range in @bs around offset @start.
  * May change underlying file descriptor's file offset.
@@ -1569,8 +1563,6 @@ static BlockDriver bdrv_gluster =3D {
     .bdrv_co_readv                =3D qemu_gluster_co_readv,
     .bdrv_co_writev               =3D qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
-    .bdrv_has_zero_init           =3D qemu_gluster_has_zero_init,
-    .bdrv_has_zero_init_truncate  =3D qemu_gluster_has_zero_init,
 #ifdef CONFIG_GLUSTERFS_DISCARD
     .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
 #endif
@@ -1601,8 +1593,6 @@ static BlockDriver bdrv_gluster_tcp =3D {
     .bdrv_co_readv                =3D qemu_gluster_co_readv,
     .bdrv_co_writev               =3D qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
-    .bdrv_has_zero_init           =3D qemu_gluster_has_zero_init,
-    .bdrv_has_zero_init_truncate  =3D qemu_gluster_has_zero_init,
 #ifdef CONFIG_GLUSTERFS_DISCARD
     .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
 #endif
@@ -1633,8 +1623,6 @@ static BlockDriver bdrv_gluster_unix =3D {
     .bdrv_co_readv                =3D qemu_gluster_co_readv,
     .bdrv_co_writev               =3D qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
-    .bdrv_has_zero_init           =3D qemu_gluster_has_zero_init,
-    .bdrv_has_zero_init_truncate  =3D qemu_gluster_has_zero_init,
 #ifdef CONFIG_GLUSTERFS_DISCARD
     .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
 #endif
@@ -1671,8 +1659,6 @@ static BlockDriver bdrv_gluster_rdma =3D {
     .bdrv_co_readv                =3D qemu_gluster_co_readv,
     .bdrv_co_writev               =3D qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
-    .bdrv_has_zero_init           =3D qemu_gluster_has_zero_init,
-    .bdrv_has_zero_init_truncate  =3D qemu_gluster_has_zero_init,
 #ifdef CONFIG_GLUSTERFS_DISCARD
     .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
 #endif
--=20
2.26.2


