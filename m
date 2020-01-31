Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBBEC35240
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DC5214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4a+Z5Ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DC5214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaMz-0004Sj-Jy
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLW-0002c5-H0
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLV-0004Ix-Kb
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27108
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLV-0004HX-HA
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y3UezPAkLNH5PjZcf6ESIZM+p07nrMqbwQwde4FJnfw=;
 b=P4a+Z5CenmRzFF7kNHrABm+O4/k00axnwZV1mkUgNgOLtmHwm1pb0Q7zm1YHMoRBZlnrE9
 /A4zn1EBMzh0HEcjFLwW8gVV4bThqEP3aAG6jk6xmgv2OwqL17hksUSmcY+U0+19mtVkfQ
 6T9dOESt7dWDdWhGBPqjmoj/lqhnDI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-WL7OkWzdOqKhTIAEP-OaqQ-1; Fri, 31 Jan 2020 12:44:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2DA013F9;
 Fri, 31 Jan 2020 17:44:41 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 530EC7FB60;
 Fri, 31 Jan 2020 17:44:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/17] block: Improve documentation of .bdrv_has_zero_init
Date: Fri, 31 Jan 2020 11:44:23 -0600
Message-Id: <20200131174436.2961874-5-eblake@redhat.com>
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: WL7OkWzdOqKhTIAEP-OaqQ-1
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
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Several drivers supply .bdrv_has_zero_init that returns 1, but lack
the .bdrv_has_zero_init_truncate callback (parallels and qed outright,
vdi in some scenarios).  A literal reading of the existing
documentation says such drivers are broken, because
bdrv_has_zero_init_truncate() defaults to zero if the callback is
missing; but in practice, the tie between the two functions is only
relevant when truncate is supported.  Clarify the documentation to
make it obvious that this is okay.

Fixes: 1dcaf527
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block_int.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 640fb82c789e..77ab45dc87cf 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -444,7 +444,8 @@ struct BlockDriver {
     /*
      * Returns 1 if newly created images are guaranteed to contain only
      * zeros, 0 otherwise.
-     * Must return 0 if .bdrv_has_zero_init_truncate() returns 0.
+     * Must return 0 if .bdrv_co_truncate is set and
+     * .bdrv_has_zero_init_truncate() returns 0.
      */
     int (*bdrv_has_zero_init)(BlockDriverState *bs);

--=20
2.24.1


