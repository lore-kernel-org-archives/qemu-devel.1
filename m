Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16405C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDABE206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gk5b5oP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDABE206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaTf-0008FB-23
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLl-0003CB-78
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLk-0004iP-0O
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34232
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLj-0004ha-T9
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jf6rrmMMkG7rUq9+VULR4sD8iT5fg6b7OJ1gXa5pIec=;
 b=Gk5b5oP4N4bFG43EDlIrhGL6hAM4w6gK9nwiAMMqIS9u/YmpD8dalMVDOvT9EGTc/v6Dk6
 uwOHre1290MBb1+pXLMgFNYWpSvnpwKz+B+HKiA1h/kY/WdgqLg/D6stdaOp+mwJ6MgZrL
 OAMoEbDLnSUv7rpl5zmyZLM+ECSCydo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-9WEUHAjVO7OdEaS2C4nYeA-1; Fri, 31 Jan 2020 12:44:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFB998F4964;
 Fri, 31 Jan 2020 17:44:54 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2835C7FB60;
 Fri, 31 Jan 2020 17:44:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/17] gluster: Support BDRV_ZERO_OPEN
Date: Fri, 31 Jan 2020 11:44:31 -0600
Message-Id: <20200131174436.2961874-13-eblake@redhat.com>
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 9WEUHAjVO7OdEaS2C4nYeA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 "open list:GLUSTER" <integration@gluster.org>, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since gluster already copies file-posix for lseek usage in block
status, it also makes sense to copy it for learning if the image
currently reads as all zeroes.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/gluster.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/block/gluster.c b/block/gluster.c
index 9d952c70981b..0417a86547c8 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1464,6 +1464,22 @@ exit:
     return -ENOTSUP;
 }

+static int qemu_gluster_known_zeroes(BlockDriverState *bs)
+{
+    /*
+     * GlusterFS volume could be backed by a block device, with no way
+     * to query if regions added by creation or truncation will read
+     * as zeroes.  However, we can use lseek(SEEK_DATA) to check if
+     * contents currently read as zero.
+     */
+    off_t data, hole;
+
+    if (find_allocation(bs, 0, &data, &hole) =3D=3D -ENXIO) {
+        return BDRV_ZERO_OPEN;
+    }
+    return 0;
+}
+
 /*
  * Returns the allocation status of the specified offset.
  *
@@ -1561,6 +1577,7 @@ static BlockDriver bdrv_gluster =3D {
     .bdrv_co_readv                =3D qemu_gluster_co_readv,
     .bdrv_co_writev               =3D qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
+    .bdrv_known_zeroes            =3D qemu_gluster_known_zeroes,
 #ifdef CONFIG_GLUSTERFS_DISCARD
     .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
 #endif
@@ -1591,6 +1608,7 @@ static BlockDriver bdrv_gluster_tcp =3D {
     .bdrv_co_readv                =3D qemu_gluster_co_readv,
     .bdrv_co_writev               =3D qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
+    .bdrv_known_zeroes            =3D qemu_gluster_known_zeroes,
 #ifdef CONFIG_GLUSTERFS_DISCARD
     .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
 #endif
@@ -1621,6 +1639,7 @@ static BlockDriver bdrv_gluster_unix =3D {
     .bdrv_co_readv                =3D qemu_gluster_co_readv,
     .bdrv_co_writev               =3D qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
+    .bdrv_known_zeroes            =3D qemu_gluster_known_zeroes,
 #ifdef CONFIG_GLUSTERFS_DISCARD
     .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
 #endif
@@ -1657,6 +1676,7 @@ static BlockDriver bdrv_gluster_rdma =3D {
     .bdrv_co_readv                =3D qemu_gluster_co_readv,
     .bdrv_co_writev               =3D qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
+    .bdrv_known_zeroes            =3D qemu_gluster_known_zeroes,
 #ifdef CONFIG_GLUSTERFS_DISCARD
     .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
 #endif
--=20
2.24.1


