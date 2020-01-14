Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91394C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6008D24676
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+kCV2S1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6008D24676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJy3-0001Ym-Q3
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1irJvZ-0007uj-GP
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1irJvV-0006IB-Je
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:00:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31360
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1irJvV-0006HO-FL
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578999601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SSeF+o79dj546tdyssQpY1m/UU1zuXExvq+5OMwrnZc=;
 b=F+kCV2S1VD/NdvXCriJgKOfOJ6PIIZIZes/rAqALqOVcWuZotvBujAg32ctSZ1loejrj3w
 7kjkIEhFDaeWkaLt1hrOdnyJwW2TLhVXjyBj09DLEIUlGhe7L36jDYOSu4w02qM6kJ7xiL
 5OiSBAIwLMY+2VnUwMEq9i6Za80OI8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-Cdo8aiMCPSK3kpbbiTS2eA-1; Tue, 14 Jan 2020 05:59:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2E5A800A02;
 Tue, 14 Jan 2020 10:59:57 +0000 (UTC)
Received: from localhost (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A8327C456;
 Tue, 14 Jan 2020 10:59:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/15] block/block: add BDRV flag for io_uring
Date: Tue, 14 Jan 2020 10:59:09 +0000
Message-Id: <20200114105921.131880-4-stefanha@redhat.com>
In-Reply-To: <20200114105921.131880-1-stefanha@redhat.com>
References: <20200114105921.131880-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Cdo8aiMCPSK3kpbbiTS2eA-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Maxim Levitsky <maximlevitsky@gmail.com>, qemu-block@nongnu.org,
 oleksandr@redhat.com, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/block/block.h b/include/block/block.h
index e9dcfef7fa..ea155da45a 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -126,6 +126,7 @@ typedef struct HDGeometry {
                                       ignoring the format layer */
 #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
 #define BDRV_O_AUTO_RDONLY 0x20000 /* degrade to read-only if opening read=
-write fails */
+#define BDRV_O_IO_URING    0x40000 /* use io_uring instead of the thread p=
ool */
=20
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
=20
--=20
2.24.1


