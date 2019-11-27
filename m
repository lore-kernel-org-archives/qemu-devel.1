Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78489C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3B22068E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqXt5+qM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3B22068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxQJ-0000cD-Rg
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxBd-0003u5-27
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxBX-0006KP-6F
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38727
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxBX-0006HA-2j
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZDd7OLdtrZb8YDc/Zs/Zu+YXZxfFmqwEYBIUNMWS4y8=;
 b=JqXt5+qMvvapzDuiYyjTAAspArsHHUnRHNg2pDYSj0+RQikG7MbKlDwnTT7HG2Lg3jvoTH
 m/648YtUXI/HxruWXi+Ljh0xBr6VPjLcDHsLb3xfavcdaPzpfgrfrwndUhWmlT15mvyog9
 rft/+skvvmorw1Io7XXwUTVI4Pd4ius=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-M8BoC09tNfqc9DdJIrF8CA-1; Wed, 27 Nov 2019 08:16:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E50E7184CAA9;
 Wed, 27 Nov 2019 13:16:41 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D5CD67646;
 Wed, 27 Nov 2019 13:16:41 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 06/31] block: Keep BDRV_O_NO_IO in
 *inherited_fmt_options
Date: Wed, 27 Nov 2019 14:15:59 +0100
Message-Id: <20191127131624.1062403-7-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: M8BoC09tNfqc9DdJIrF8CA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_inherited_fmt_options() is used only by (pseudo-)filter drivers,
namely quorum and blkverify.  Both should pass on BDRV_O_NO_IO to their
children.  There is no reason to clear it in
bdrv_inherited_fmt_options().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 6c50ad661e..58252007af 100644
--- a/block.c
+++ b/block.c
@@ -1034,7 +1034,7 @@ static void bdrv_inherited_fmt_options(int *child_fla=
gs, QDict *child_options,
     child_file.inherit_options(child_flags, child_options,
                                parent_flags, parent_options);
=20
-    *child_flags &=3D ~(BDRV_O_PROTOCOL | BDRV_O_NO_IO);
+    *child_flags &=3D ~BDRV_O_PROTOCOL;
 }
=20
 const BdrvChildClass child_format =3D {
--=20
2.23.0


