Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F01FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2CB20578
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjLlRgNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2CB20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNwiX-0000iw-Vh
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iNwNG-0006Za-EO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iNwNF-0004j7-9a
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:59:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37515
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iNwNF-0004ip-5i
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571997552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUHZOaRNOqcyKMqpJaNBzFYvFemyltC6wzDCezpuH3U=;
 b=ZjLlRgNyjv4jqeZSQMzvFF8BSnpveY2vi1g053s8b+xb/V6YOaaj2hyq9q4Ac59QRK69tX
 4nmWoNUCd2cVJ7yh00ihPXALCDB7K92jbFN5Y38ZRWSuNVFvtCdt6dhk2rcPcW8kGwHh+r
 nBHguMHDPUzkfhCRfm8gsjiQ5w5Vr74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-kiF3_ktUONuk8iqS5BoS_Q-1; Fri, 25 Oct 2019 05:59:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A459B107AD31;
 Fri, 25 Oct 2019 09:59:08 +0000 (UTC)
Received: from localhost (ovpn-117-205.ams2.redhat.com [10.36.117.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75886600CD;
 Fri, 25 Oct 2019 09:59:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC 2/3] block/file-posix: Detect XFS with CONFIG_FALLOCATE
Date: Fri, 25 Oct 2019 11:58:48 +0200
Message-Id: <20191025095849.25283-3-mreitz@redhat.com>
In-Reply-To: <20191025095849.25283-1-mreitz@redhat.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kiF3_ktUONuk8iqS5BoS_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will need this for the next patch.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 695fcf740d..5cd54c8bff 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -149,7 +149,7 @@ typedef struct BDRVRawState {
     int perm_change_flags;
     BDRVReopenState *reopen_state;
=20
-#ifdef CONFIG_XFS
+#if defined(CONFIG_XFS) || defined(CONFIG_FALLOCATE)
     bool is_xfs:1;
 #endif
     bool has_discard:1;
@@ -667,7 +667,7 @@ static int raw_open_common(BlockDriverState *bs, QDict =
*options,
     }
 #endif
=20
-#ifdef CONFIG_XFS
+#if defined(CONFIG_XFS) || defined(CONFIG_FALLOCATE)
     if (platform_test_xfs_fd(s->fd)) {
         s->is_xfs =3D true;
     }
--=20
2.21.0


