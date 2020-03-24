Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAB3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5E22080C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqKVZids"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5E22080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGian-0007bB-11
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGiYE-00042f-JI
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGiYD-0007sp-I2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:20:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37883)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGiYD-0007sY-E8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585052457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnS7vaFSkjphTxcTGdbglpjhLyF05h3cx+k7Q4E8TXg=;
 b=IqKVZidsgeo7Yo6lpopiXp8807FV0sdybsaVDRMyKBda9y7E1lY+zQz0Rt7hKBVd6fgJRQ
 3AVf8Z1bjikOL5kZtOpx02QWEBhPSHvlp2leBljJISQO4xfsxBHvMdAzObwZMDrkMBNPDA
 U2QMAPW/YabIMZPfCLBS5czRBuDNP/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-RO_T6sxhMCOuPw_wKTjobQ-1; Tue, 24 Mar 2020 08:20:54 -0400
X-MC-Unique: RO_T6sxhMCOuPw_wKTjobQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9658800D50;
 Tue, 24 Mar 2020 12:20:53 +0000 (UTC)
Received: from localhost (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DEDF9497D;
 Tue, 24 Mar 2020 12:20:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 2/6] block: Assert BlockDriver::format_name is not NULL
Date: Tue, 24 Mar 2020 13:20:40 +0100
Message-Id: <20200324122044.1131326-3-mreitz@redhat.com>
In-Reply-To: <20200324122044.1131326-1-mreitz@redhat.com>
References: <20200324122044.1131326-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

bdrv_do_find_format() calls strcmp() using BlockDriver::format_name
as argument, which must not be NULL. Assert this field is not null
when we register a block driver in bdrv_register().

Reported-by: Mansour Ahmadi <ManSoSec@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200318222235.23856-1-philmd@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block.c b/block.c
index a2542c977b..6b984dc883 100644
--- a/block.c
+++ b/block.c
@@ -363,6 +363,7 @@ char *bdrv_get_full_backing_filename(BlockDriverState *=
bs, Error **errp)
=20
 void bdrv_register(BlockDriver *bdrv)
 {
+    assert(bdrv->format_name);
     QLIST_INSERT_HEAD(&bdrv_drivers, bdrv, list);
 }
=20
--=20
2.25.1


