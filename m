Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6E3C34037
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF032173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3oRPKJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF032173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42EK-0005dP-B6
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42DM-0003qC-BP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42DL-0000zH-6D
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46856
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42DL-0000yt-2f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGOeRG4Lx+pTp0i14plka3WDezKrZb39267MP8MsP8c=;
 b=W3oRPKJG0x+r3YDL5lqmGd7irl9lwILZ9jsm9uNwyKhQUS+FgkisrZlsawT97QHNWkubSa
 tLco7R1N4FrNtJJ8hppQgKeAswFM++F0FTdu3JBF/v4ffUI/CpmqXsY/gb72Sx6rzSXitD
 yxiW7Y16+r/RNuz75Uv47K3QIc8fzjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-LbrfguFlOG2CaDugLou4VA-1; Tue, 18 Feb 2020 07:42:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C043B100550E;
 Tue, 18 Feb 2020 12:42:55 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D44560C80;
 Tue, 18 Feb 2020 12:42:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 03/33] block: Add BdrvChildRole and BdrvChildRoleBits
Date: Tue, 18 Feb 2020 13:42:12 +0100
Message-Id: <20200218124242.584644-4-mreitz@redhat.com>
In-Reply-To: <20200218124242.584644-1-mreitz@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: LbrfguFlOG2CaDugLou4VA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This mask will supplement BdrvChildClass when it comes to what role (or
combination of roles) a child takes for its parent.  It consists of
BdrvChildRoleBits values (which is an enum).

Because empty enums are not allowed, let us just start with it filled.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index fd89eb6c75..8c23948d08 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -268,6 +268,44 @@ enum {
     DEFAULT_PERM_UNCHANGED      =3D BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROU=
GH,
 };
=20
+enum BdrvChildRoleBits {
+    /* Child stores data */
+    BDRV_CHILD_DATA         =3D (1 << 0),
+
+    /* Child stores metadata */
+    BDRV_CHILD_METADATA     =3D (1 << 1),
+
+    /*
+     * A child to which the parent forwards all reads and writes.  It
+     * must present exactly the same visible data as the parent.
+     * Any node may have at most one filtered child at a time.
+     */
+    BDRV_CHILD_FILTERED     =3D (1 << 2),
+
+    /*
+     * Child from which to read all data that isn=E2=80=99t allocated in t=
he
+     * parent (i.e., the backing child); such data is copied to the
+     * parent through COW (and optionally COR).
+     */
+    BDRV_CHILD_COW          =3D (1 << 3),
+
+    /*
+     * The primary child.  For most drivers, this is the child whose
+     * filename applies best to the parent node.
+     * Each parent must give this flag to no more than one child at a
+     * time.
+     */
+    BDRV_CHILD_PRIMARY      =3D (1 << 4),
+
+    /* Useful combination of flags */
+    BDRV_CHILD_IMAGE        =3D BDRV_CHILD_DATA
+                              | BDRV_CHILD_METADATA
+                              | BDRV_CHILD_PRIMARY,
+};
+
+/* Mask of BdrvChildRoleBits values */
+typedef unsigned int BdrvChildRole;
+
 char *bdrv_perm_names(uint64_t perm);
 uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm);
=20
--=20
2.24.1


