Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B4AC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7512084D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRjwBzqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7512084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irIj4-0001PH-U3
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 04:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1irIXV-0002s7-QC
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1irIXS-0007S5-4U
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:31:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39105
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1irIXS-0007Rt-1Q
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578994265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bim/vjqkhwVx1YNAeaFTvQoQEI+0/v595gvGn1+RKpg=;
 b=bRjwBzqdjZ3wX59AmkzXBG+qhV9TGzWP0hrNckJ5Ea+Qpa/xSx+XlWmSKoXX0i5zYJZGAx
 IfOWtescGbF8lvgoUDPje68CvqCJCt7xVSYQU9Hu0+QZXTkKCVHZpQNSYo41aOnufIyg/l
 cb4Xh42/yWjLHpEFHzlYzM+/0L7K/xA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-GcMKfJgOMBGk4M79E1WwZw-1; Tue, 14 Jan 2020 04:31:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39F07107ACCA;
 Tue, 14 Jan 2020 09:31:00 +0000 (UTC)
Received: from localhost (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8420F8068E;
 Tue, 14 Jan 2020 09:30:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] linux-aio: increasing MAX_EVENTS to a larger hardcoded
 value
Date: Tue, 14 Jan 2020 09:30:52 +0000
Message-Id: <20200114093052.117848-2-stefanha@redhat.com>
In-Reply-To: <20200114093052.117848-1-stefanha@redhat.com>
References: <20200114093052.117848-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GcMKfJgOMBGk4M79E1WwZw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wangyong <wang.yongD@h3c.com>

Since commit 6040aedddb5f474a9c2304b6a432a652d82b3d3c "virtio-blk:
make queue size configurable",if the user set the queue size to
more than 128 ,it will not take effect. That's because linux aio's
maximum outstanding requests at a time is always less than or equal
to 128.

This patch simply increase MAX_EVENTS to a larger hardcoded value of
1024 as a shortterm fix.

Signed-off-by: wangyong <wang.yongD@h3c.com>
Message-id: faa5781afd354a96a0be152b288f636f@h3c.com
Message-Id: <faa5781afd354a96a0be152b288f636f@h3c.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/linux-aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/linux-aio.c b/block/linux-aio.c
index c7eca9a256..91204a25a2 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -26,7 +26,7 @@
  *      than this we will get EAGAIN from io_submit which is communicated =
to
  *      the guest as an I/O error.
  */
-#define MAX_EVENTS 128
+#define MAX_EVENTS 1024
=20
 struct qemu_laiocb {
     Coroutine *co;
--=20
2.24.1


