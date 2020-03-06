Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F864C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBA720658
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8BrNCbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBA720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGev-000463-BS
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZD-0004h1-5b
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZC-0007Hv-5p
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21390
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZC-0007Ex-2A
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mED3aCkYiMSUsfHVjrDKAg1Ygoiy0OacRIuAmzD2Uus=;
 b=F8BrNCbJkbjMTKR+9zyKeHVMZqEsnDlxOMgRo2+lWp/FYJTMVzSjqZJNW5AJHMI6QP2cFU
 NbH2NhjNsMXVPqEgUo9pC2lKEcmsjhamgYw4gn1ZhCmw4Gca+Kef0FzJ0xxYNBDZM7gwlW
 5odaAowcv2fxCdtDBE/aA6SYGIJTW1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-VUZmDRUaNlqjEFGKsyAt-Q-1; Fri, 06 Mar 2020 12:15:13 -0500
X-MC-Unique: VUZmDRUaNlqjEFGKsyAt-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 056F41005510;
 Fri,  6 Mar 2020 17:15:11 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 080B973873;
 Fri,  6 Mar 2020 17:15:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/29] block: Fix leak in bdrv_create_file_fallback()
Date: Fri,  6 Mar 2020 18:14:33 +0100
Message-Id: <20200306171458.1848-5-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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

From: Max Reitz <mreitz@redhat.com>

@options is leaked by the first two return statements in this function.

Note that blk_new_open() takes the reference to @options even on
failure, so all we need to do to fix the leak is to move the QDict
allocation down to where we actually need it.

Reported-by: Coverity (CID 1419884)
Fixes: fd17146cd93d1704cd96d7c2757b325fc7aac6fd
       ("block: Generic file creation fallback")
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200225155618.133412-1-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 1bdb9c679d..876bd45182 100644
--- a/block.c
+++ b/block.c
@@ -600,7 +600,7 @@ static int bdrv_create_file_fallback(const char *filena=
me, BlockDriver *drv,
                                      QemuOpts *opts, Error **errp)
 {
     BlockBackend *blk;
-    QDict *options =3D qdict_new();
+    QDict *options;
     int64_t size =3D 0;
     char *buf =3D NULL;
     PreallocMode prealloc;
@@ -623,6 +623,7 @@ static int bdrv_create_file_fallback(const char *filena=
me, BlockDriver *drv,
         return -ENOTSUP;
     }
=20
+    options =3D qdict_new();
     qdict_put_str(options, "driver", drv->format_name);
=20
     blk =3D blk_new_open(filename, NULL, options,
--=20
2.20.1


