Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7105C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A0A20856
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPr09lwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A0A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU76z-0001sj-M2
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 05:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1iU76E-0000vq-7s
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:39:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1iU76C-0003jg-2s
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:39:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43344
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1iU76B-0003iX-Pb
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573468747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2W9qkQmT80Ew2GlLeYb015BXhx5aOqc++2SvZrumetg=;
 b=MPr09lwYGS3y12Y6zzh/wAwEy5tTMqrw/f7rlFUGbp7HDjf+PC++kdrhd594GJB0bDtrpn
 Q46p9eylb5cV0MrLCWRJGSBkPJohfA4362ybKaCQtj50KKm0SHbweJO7Nxn77Q8w30OZ+H
 kc78k720wnfE3WYABnTNS58Mx+EoKys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-OkbK0SFPNAiG1CEpKP3qNg-1; Mon, 11 Nov 2019 05:38:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A920800D49
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 10:38:00 +0000 (UTC)
Received: from moe.redhat.com (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF02B4BB;
 Mon, 11 Nov 2019 10:37:59 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] vfio-helpers: Free QEMUVFIOState in qemu_vfio_close()
Date: Mon, 11 Nov 2019 11:37:42 +0100
Message-Id: <14247f68a13c7b9292b91eb7df02de9b9d248544.1573468531.git.mprivozn@redhat.com>
In-Reply-To: <cover.1573468531.git.mprivozn@redhat.com>
References: <cover.1573468531.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: OkbK0SFPNAiG1CEpKP3qNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: alex.williamson@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qemu_vfio_open_pci() allocates this QEMUVFIOState structure
but free counterpart is missing. Since we already have
qemu_vfio_close() which does cleanup of the state, it looks like
a perfect place to free the structure too.

=3D=3D178278=3D=3D 528 (360 direct, 168 indirect) bytes in 1 blocks are def=
initely lost in loss record 6,605 of 6,985
=3D=3D178278=3D=3D    at 0x4A35476: calloc (vg_replace_malloc.c:752)
=3D=3D178278=3D=3D    by 0x51B1158: g_malloc0 (in /usr/lib64/libglib-2.0.so=
.0.6000.6)
=3D=3D178278=3D=3D    by 0xA68613: qemu_vfio_open_pci (vfio-helpers.c:428)
=3D=3D178278=3D=3D    by 0x9779EA: nvme_init (nvme.c:606)
=3D=3D178278=3D=3D    by 0x97830F: nvme_file_open (nvme.c:795)
=3D=3D178278=3D=3D    by 0x8E9439: bdrv_open_driver (block.c:1293)
=3D=3D178278=3D=3D    by 0x8E9E1C: bdrv_open_common (block.c:1553)
=3D=3D178278=3D=3D    by 0x8ED264: bdrv_open_inherit (block.c:3083)
=3D=3D178278=3D=3D    by 0x8ED79D: bdrv_open (block.c:3176)
=3D=3D178278=3D=3D    by 0x5DA5C1: bds_tree_init (blockdev.c:670)
=3D=3D178278=3D=3D    by 0x5E2B64: qmp_blockdev_add (blockdev.c:4354)
=3D=3D178278=3D=3D    by 0x5ECB1D: configure_blockdev (vl.c:1202)

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 util/vfio-helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 813f7ec564..5ff91c1e5c 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -721,4 +721,5 @@ void qemu_vfio_close(QEMUVFIOState *s)
     close(s->device);
     close(s->group);
     close(s->container);
+    g_free(s);
 }
--=20
2.23.0


