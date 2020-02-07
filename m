Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6F5C352A3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD4E21741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJUUtTAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD4E21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02hj-00086I-Be
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j02gj-0006Yp-0W
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j02gi-0002w9-1s
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:24:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33828
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j02gh-0002vj-Up
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581078287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUpdSrva6ybtVdXqDRbs/3cFnte1QM0OTgG2ckmSAr4=;
 b=eJUUtTAa/jXGJ0b2G4LU01HNK/UsQ9hYExLpfqaO0fPQrgzpljqC2QnetY6kWixDW/JOjU
 axR6TjlxxjhSK9aoOjZQiLE+BcGbcLpvZRX7ZcylCp8W9WNwvKmUl2aHscWTajVZlB9Fpi
 pFDE7PHtd4ZygN/TextHvTG3LpuOVI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-dsuzRuKAO1mCxuGTrlsf7A-1; Fri, 07 Feb 2020 07:24:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63911DBA5;
 Fri,  7 Feb 2020 12:24:44 +0000 (UTC)
Received: from dhcp-16-105.lcy.redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90B7F7FB60;
 Fri,  7 Feb 2020 12:24:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] authz: fix usage of bool in listfile.c
Date: Fri,  7 Feb 2020 12:24:39 +0000
Message-Id: <20200207122440.2650229-3-berrange@redhat.com>
In-Reply-To: <20200207122440.2650229-1-berrange@redhat.com>
References: <20200207122440.2650229-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: dsuzRuKAO1mCxuGTrlsf7A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Jafar Abdi <cafer.abdi@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jafar Abdi <cafer.abdi@gmail.com>

Clean up wrong usage of FALSE and TRUE in places that use "bool" from stdbo=
ol.h.

FALSE and TRUE (with capital letters) are the constants defined by glib for
being used with the "gboolean" type of glib. But some parts of the code als=
o use
TRUE and FALSE for variables that are declared as "bool" (the type from <st=
dbool.h>).

Signed-off-by: Jafar Abdi <cafer.abdi@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 authz/listfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/authz/listfile.c b/authz/listfile.c
index e7a8c19bcb..b71f57d30a 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -239,7 +239,7 @@ qauthz_list_file_init(Object *obj)
=20
     authz->file_watch =3D -1;
 #ifdef CONFIG_INOTIFY1
-    authz->refresh =3D TRUE;
+    authz->refresh =3D true;
 #endif
 }
=20
--=20
2.24.1


