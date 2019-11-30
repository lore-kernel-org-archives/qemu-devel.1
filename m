Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664BDC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF122084E
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/V4oXZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF122084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib8fo-00086i-Ta
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 14:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ib8dq-0006Qc-Al
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ib8dm-000549-Ss
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46272
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ib8dm-00052v-0J
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575142968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJaBWRixGViWAeulqiB62tyEcddZ3xek8SJVT6ZMmAA=;
 b=E/V4oXZIJAStWonGOKL12rASRYYsc2sa3+7LDBjkk1CNssCZIZggEE9GF/NRlmAW8qQv3n
 x/b6YTJBmmi9ft+40pKvSfqWgRwNKQKh2chjz9f6BdlVdCto8ucWG5bndLdOG6biHYqWVf
 eBocCHtzQr8l1BWxedpjZAAu3OniQDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-i1wNotwBOZ2_OPgq2EG6jw-1; Sat, 30 Nov 2019 14:42:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F4C7800D41;
 Sat, 30 Nov 2019 19:42:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59051611DB;
 Sat, 30 Nov 2019 19:42:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1134B11366CF; Sat, 30 Nov 2019 20:42:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/21] block/file-posix: Fix laio_init() error handling crash
 bug
Date: Sat, 30 Nov 2019 20:42:22 +0100
Message-Id: <20191130194240.10517-4-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-1-armbru@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: i1wNotwBOZ2_OPgq2EG6jw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Nishanth Aravamudan <naravamudan@digitalocean.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

raw_aio_attach_aio_context() passes uninitialized Error *local_err by
reference to laio_init() via aio_setup_linux_aio().  When laio_init()
fails, it passes it on to error_setg_errno(), tripping error_setv()'s
assertion unless @local_err is null by dumb luck.

Fix by initializing @local_err properly.

Fixes: ed6e2161715c527330f936d44af4c547f25f687e
Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 1f0f61a02b..1b805bd938 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1973,7 +1973,7 @@ static void raw_aio_attach_aio_context(BlockDriverSta=
te *bs,
 #ifdef CONFIG_LINUX_AIO
     BDRVRawState *s =3D bs->opaque;
     if (s->use_linux_aio) {
-        Error *local_err;
+        Error *local_err =3D NULL;
         if (!aio_setup_linux_aio(new_context, &local_err)) {
             error_reportf_err(local_err, "Unable to use native AIO, "
                                          "falling back to thread pool: ");
--=20
2.21.0


