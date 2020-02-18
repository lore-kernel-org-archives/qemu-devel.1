Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CF8C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C775121D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnntBPv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C775121D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43c6-0000AP-UG
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Xr-0007Dw-KT
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Xq-0001Vs-Gu
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Xq-0001VX-DN
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIhvzQoBh+EPQPKlF8iCvQ7VeSgLPKNkkcqNRm4qOPs=;
 b=PnntBPv07FnKTQWP+GRLDKqW7nSEkjZ2r5AI75zaBozmWuTFJuNq2pJSA6h1AnoR7ynQc1
 Pi8lG+YE31ZXw//1mYH+EQZAwji2Gl6tFJMiSzFUBZTzOMYcYhQJpk98+Ks1GxHvGaOVo6
 HojetNYq96je4HlJDVcPjhidAqloGLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-s96yyLuBMgulK8XLXzmaHQ-1; Tue, 18 Feb 2020 09:08:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91F67107ACC5;
 Tue, 18 Feb 2020 14:08:06 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8ED0019E9C;
 Tue, 18 Feb 2020 14:08:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 11/36] commit: Fix argument order for block_job_error_action()
Date: Tue, 18 Feb 2020 15:06:57 +0100
Message-Id: <20200218140722.23876-12-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: s96yyLuBMgulK8XLXzmaHQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The block_job_error_action() error call in the commit job gives the
on_err and is_read arguments in the wrong order. Fix this.

(Of course, hard-coded is_read =3D false is wrong, too, but that's a
separate problem for a separate patch.)

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200214200812.28180-4-kwolf@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/commit.c b/block/commit.c
index cce898a4f3..8189f079d2 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -182,7 +182,7 @@ static int coroutine_fn commit_run(Job *job, Error **er=
rp)
         }
         if (ret < 0) {
             BlockErrorAction action =3D
-                block_job_error_action(&s->common, false, s->on_error, -re=
t);
+                block_job_error_action(&s->common, s->on_error, false, -re=
t);
             if (action =3D=3D BLOCK_ERROR_ACTION_REPORT) {
                 goto out;
             } else {
--=20
2.20.1


