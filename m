Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04C4C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8B8246A3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APr+t7WP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8B8246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7f41-0002Ku-Oc
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1j7f11-0007f8-Gs
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1j7f10-000083-Ey
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:45:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38376
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1j7f10-00007x-Bt
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582893914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CwLQqse83511sZxyxLXj0O3RrUg6kH/4VcWWgUAjDqg=;
 b=APr+t7WPquW22Z155PNs5s6QNPTZ2k1rILvpzQx4DCC3dYm4apaC17ybGfQ+I3hNm22m0j
 tjnDGRB9v0ouAfU+az2/SaCR1kWl0dtqMhIfhJQ2hA8hMZq0gJ3arvxx75hHtWHKD/AtpX
 aT61BVboBb7i8YeaWeJcH+eM/loCWdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-LmA-iKE2PsGbMR_Cj-Fb-A-1; Fri, 28 Feb 2020 07:45:10 -0500
X-MC-Unique: LmA-iKE2PsGbMR_Cj-Fb-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46171800D55;
 Fri, 28 Feb 2020 12:45:09 +0000 (UTC)
Received: from angien.redhat.com (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E248819C7F;
 Fri, 28 Feb 2020 12:45:07 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] block/qcow2: Move bitmap reopen into
 bdrv_reopen_commit_post
Date: Fri, 28 Feb 2020 13:44:47 +0100
Message-Id: <db118dbafe1955afbc0a18d3dd220931074ce349.1582893284.git.pkrempa@redhat.com>
In-Reply-To: <cover.1582893284.git.pkrempa@redhat.com>
References: <cover.1582893284.git.pkrempa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bitmap code requires writing the 'file' child when the qcow2 driver
is reopened in read-write mode.

If the 'file' child is being reopened due to a permissions change, the
modification is commited yet when qcow2_reopen_commit is called. This
means that any attempt to write the 'file' child will end with EBADFD
as the original fd was already closed.

Moving bitmap reopening to the new callback which is called after
permission modifications are commited fixes this as the file descriptor
will be replaced with the correct one.

The above problem manifests itself when reopening 'qcow2' format layer
which uses a 'file-posix' file child which was opened with the
'auto-read-only' property set.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 block/qcow2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3c754f616b..3640e8c07d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1884,6 +1884,11 @@ fail:
 static void qcow2_reopen_commit(BDRVReopenState *state)
 {
     qcow2_update_options_commit(state->bs, state->opaque);
+    g_free(state->opaque);
+}
+
+static void qcow2_reopen_commit_post(BDRVReopenState *state)
+{
     if (state->flags & BDRV_O_RDWR) {
         Error *local_err =3D NULL;

@@ -1898,7 +1903,6 @@ static void qcow2_reopen_commit(BDRVReopenState *stat=
e)
                               bdrv_get_node_name(state->bs));
         }
     }
-    g_free(state->opaque);
 }

 static void qcow2_reopen_abort(BDRVReopenState *state)
@@ -5534,6 +5538,7 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_close         =3D qcow2_close,
     .bdrv_reopen_prepare  =3D qcow2_reopen_prepare,
     .bdrv_reopen_commit   =3D qcow2_reopen_commit,
+    .bdrv_reopen_commit_post =3D qcow2_reopen_commit_post,
     .bdrv_reopen_abort    =3D qcow2_reopen_abort,
     .bdrv_join_options    =3D qcow2_join_options,
     .bdrv_child_perm      =3D bdrv_format_default_perms,
--=20
2.24.1


