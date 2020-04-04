Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9BBC2BA1A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EE8206E9
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F810NgXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EE8206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKhra-0003P8-6K
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 08:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jKhqZ-00024o-H8
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jKhqY-00032e-Ak
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:24:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33805
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jKhqY-00031p-46
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586003061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eb23JDY2ph7uUo2FAF/JWbKPJXBxBkM6ynhU6yd5bws=;
 b=F810NgXwj+CKA5+rkOH1YZF7kAkOp39wQjn5htUvZENE/An5dg4p3XaZrrKMbbOVS0R5Vl
 eKy9Zzkx5d6+e7r5gJwmKJqMiGe9LnbHBHBewHyGKwMjJ2KRebMSH8qtRYHPfW3wjWJoZ+
 V/qHxjsEfhDjem57R2Ek7mklpJcRl44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-4-kmmRRdMXWzon6wn58yIg-1; Sat, 04 Apr 2020 08:24:19 -0400
X-MC-Unique: 4-kmmRRdMXWzon6wn58yIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25D59800D4E;
 Sat,  4 Apr 2020 12:24:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-152.ams2.redhat.com
 [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D94CE1000322;
 Sat,  4 Apr 2020 12:24:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5F56C11384A9; Sat,  4 Apr 2020 14:24:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] dump/win_dump: fix use after free of err
Date: Sat,  4 Apr 2020 14:24:15 +0200
Message-Id: <20200404122416.1837-3-armbru@redhat.com>
In-Reply-To: <20200404122416.1837-1-armbru@redhat.com>
References: <20200404122416.1837-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

It's possible that we'll try to set err twice (or more). It's bad, it
will crash.

Instead, use warn_report().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200324153630.11882-4-vsementsov@virtuozzo.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 dump/win_dump.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/dump/win_dump.c b/dump/win_dump.c
index eda2a48974..652c7bad99 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -304,13 +304,11 @@ static void restore_context(WinDumpHeader64 *h,
                             struct saved_context *saved_ctx)
 {
     int i;
-    Error *err =3D NULL;
=20
     for (i =3D 0; i < h->NumberProcessors; i++) {
         if (cpu_memory_rw_debug(first_cpu, saved_ctx[i].addr,
                 (uint8_t *)&saved_ctx[i].ctx, sizeof(WinContext), 1)) {
-            error_setg(&err, "win-dump: failed to restore CPU #%d context"=
, i);
-            warn_report_err(err);
+            warn_report("win-dump: failed to restore CPU #%d context", i);
         }
     }
 }
--=20
2.21.1


