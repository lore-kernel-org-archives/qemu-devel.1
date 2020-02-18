Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7692C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AFB2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAHB+J4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AFB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42In-0005RM-Fe
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42Dd-0004Ex-6h
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42Dc-00018a-68
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59126
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42Dc-00018I-1c
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRCesg5ctRaehReWF4NUGPXX1zvSZ0LHWpEnMJ2iZ30=;
 b=SAHB+J4vPDJuJAbKmSvZuUKEys3xL2zE+ZhwkO528hs/i/Je0RWdP2WusOjKWRUzK0MkrA
 xQNuJO4Xdrp1lf6Ag087kRKSa8NJJ93RFK7Zi+m5xmLshiRhkLPZkntX2Fz9jMSiC0LkWP
 3SbTYDDAdNoWZ828SmEJDgUFc4ZItE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-qhPDADBKMUupawNlGrda2w-1; Tue, 18 Feb 2020 07:43:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9545107ACCC;
 Tue, 18 Feb 2020 12:43:12 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26E8B10001AE;
 Tue, 18 Feb 2020 12:43:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 08/33] block: Rename bdrv_inherited_options()
Date: Tue, 18 Feb 2020 13:42:17 +0100
Message-Id: <20200218124242.584644-9-mreitz@redhat.com>
In-Reply-To: <20200218124242.584644-1-mreitz@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: qhPDADBKMUupawNlGrda2w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

The other two .inherit_options implementations specify exactly for what
case they are used in their name, so do it for this one as well.

(The actual intention behind this patch is to follow it up with a
generic bdrv_inherited_options() that works for all three cases.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 706fae355e..c33f0e9b42 100644
--- a/block.c
+++ b/block.c
@@ -1002,9 +1002,9 @@ static void bdrv_temp_snapshot_options(int *child_fla=
gs, QDict *child_options,
  * Returns the options and flags that bs->file should get if a protocol dr=
iver
  * is expected, based on the given options and flags for the parent BDS
  */
-static void bdrv_inherited_options(BdrvChildRole role, bool parent_is_form=
at,
-                                   int *child_flags, QDict *child_options,
-                                   int parent_flags, QDict *parent_options=
)
+static void bdrv_protocol_options(BdrvChildRole role, bool parent_is_forma=
t,
+                                  int *child_flags, QDict *child_options,
+                                  int parent_flags, QDict *parent_options)
 {
     int flags =3D parent_flags;
=20
@@ -1036,7 +1036,7 @@ static void bdrv_inherited_options(BdrvChildRole role=
, bool parent_is_format,
 const BdrvChildClass child_file =3D {
     .parent_is_bds   =3D true,
     .get_parent_desc =3D bdrv_child_get_parent_desc,
-    .inherit_options =3D bdrv_inherited_options,
+    .inherit_options =3D bdrv_protocol_options,
     .drained_begin   =3D bdrv_child_cb_drained_begin,
     .drained_poll    =3D bdrv_child_cb_drained_poll,
     .drained_end     =3D bdrv_child_cb_drained_end,
--=20
2.24.1


