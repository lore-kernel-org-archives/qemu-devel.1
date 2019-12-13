Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0CCC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C119D21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJbEcC/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C119D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifmE0-0006MM-9L
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ifmDH-0005sf-4I
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ifmDG-0004MS-2w
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:46:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ifmDF-0004LM-VB
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576248397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kJ9Lft/7dKkUQWK1jf/+7AbsIekSxQ17L0r0bN/D1og=;
 b=CJbEcC/uFtWRFZv7UfuCTi9jVHbAjLn1yRRldwpRskHZDH98L4y13UHmbXrUO0or/A+P0N
 hlH9+C5y7Kes94TQiKGhrY4hlD7bu8NnclJdeG6mYeyeHipuE0PNpSDdo7DJf8w20nrVwG
 7kkSAvv5B3q4kps5bmqfZ4jDFwEm+as=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-9-mQl40DO_mlnftUVTHu8w-1; Fri, 13 Dec 2019 09:46:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A0F0107ACFA;
 Fri, 13 Dec 2019 14:46:35 +0000 (UTC)
Received: from localhost (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60325196AE;
 Fri, 13 Dec 2019 14:46:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] virtio-blk: deprecate SCSI passthrough
Date: Fri, 13 Dec 2019 14:46:26 +0000
Message-Id: <20191213144626.1208237-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 9-mQl40DO_mlnftUVTHu8w-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Hellwig <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux virtio_blk.ko guest driver is removing legacy SCSI passthrough
support.  Deprecate this feature in QEMU too.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-deprecated.texi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 4b4b7425ac..ef94d497da 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -285,6 +285,17 @@ spec you can use the ``-cpu rv64gcsu,priv_spec=3Dv1.9.=
1`` command line argument.
=20
 @section Device options
=20
+@subsection Emulated device options
+
+@subsubsection -device virtio-blk,scsi=3Don|off (since 5.0.0)
+
+The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTI=
O 1.0
+and later do not support it because the virtio-scsi device was introduced =
for
+full SCSI support.  Use virtio-scsi instead when SCSI passthrough is requi=
red.
+
+Note this also applies to ``-device virtio-blk-pci,scsi=3Don|off'', which =
is an
+alias.
+
 @subsection Block device options
=20
 @subsubsection "backing": "" (since 2.12.0)
--=20
2.23.0


