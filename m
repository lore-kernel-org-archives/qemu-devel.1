Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDEBC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5917721741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpMWSTqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5917721741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgiI-0005h7-IS
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgdF-0002sP-D0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgdE-0000VP-El
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgdE-0000Su-Ap
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dwii1VXFXuBSLbNUd7nBhxt5bLCws2jTWAihBOa9gQ4=;
 b=CpMWSTqxWwL3/ImCp+40K+b6SzpZ6xA5bLurf5T49rpG4EAA4JYSGUy9ACxObVi20UP5p8
 DOTnHGGQXk0WFMEed9ERhpuClrYDswk1WLf3XynVLnvEQCspKnEV+JHAmC3Suxolnl32Jf
 UjaNJC9qoqDYfVvxZF86Jwc1qTb/dZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-_NItlok6NFirMP_0AtouIQ-1; Thu, 06 Feb 2020 07:51:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B486801A1B;
 Thu,  6 Feb 2020 12:51:38 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E42A1001B09;
 Thu,  6 Feb 2020 12:51:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/17] block: Use a GString in bdrv_perm_names()
Date: Thu,  6 Feb 2020 13:51:17 +0100
Message-Id: <20200206125132.594625-3-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
References: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: _NItlok6NFirMP_0AtouIQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

This is a bit more efficient than having to allocate and free memory
for each new permission.

The default size (30) is enough for "consistent read, write, resize".

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 20200110171518.22168-1-berto@igalia.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 6c2b2bd2e2..fe5050c53f 100644
--- a/block.c
+++ b/block.c
@@ -1998,18 +1998,19 @@ char *bdrv_perm_names(uint64_t perm)
         { 0, NULL }
     };
=20
-    char *result =3D g_strdup("");
+    GString *result =3D g_string_sized_new(30);
     struct perm_name *p;
=20
     for (p =3D permissions; p->name; p++) {
         if (perm & p->perm) {
-            char *old =3D result;
-            result =3D g_strdup_printf("%s%s%s", old, *old ? ", " : "", p-=
>name);
-            g_free(old);
+            if (result->len > 0) {
+                g_string_append(result, ", ");
+            }
+            g_string_append(result, p->name);
         }
     }
=20
-    return result;
+    return g_string_free(result, FALSE);
 }
=20
 /*
--=20
2.24.1


