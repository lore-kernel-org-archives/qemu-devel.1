Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A59C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C9E20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+nXSBYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C9E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxN1-0001aY-S3
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHM-0003BF-8z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHK-0003DS-QQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55553)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHK-00038y-Kd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NTHE5XrNCt2Y1BWJERvCGNKHLBh/laOkgh5BdDwVuzQ=;
 b=I+nXSBYYYYjr5k+DAxYeZ+QFctar0dXp7ZWWod3Ef/aMWwnYd5eCkqnEXO44V1dskcNmB3
 m69LRulz+0t8ng8MWlVoYKoQ6uTZsrZgfSrVMzC2sIUr2Agzbkv+RdBa4x7TnobBPfheX1
 uuyMmyajZXX/+s4G7ANQZHSLT9T0QEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-iQNIO709NBe2-3ONOnAMkA-1; Mon, 16 Mar 2020 17:27:54 -0400
X-MC-Unique: iQNIO709NBe2-3ONOnAMkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF6208017DF
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:27:53 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67CC619C4F;
 Mon, 16 Mar 2020 21:27:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/61] build-sys: do not make qemu-ga link with pixman
Date: Mon, 16 Mar 2020 22:26:39 +0100
Message-Id: <1584394048-44994-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Since commit d52c454aadcdae74506f315ebf8b58bb79a05573 ("contrib: add
vhost-user-gpu"), qemu-ga is linking with pixman.

This is because the Make-based build-system use a global namespace for
variables, and we rely on "main.o-libs" for different linking targets.

Note: this kind of variable clashing is hard to fix or prevent
currently.  meson should help, as declarations have a linear
dependency and doesn't rely so much on variables and clever tricks.

Note2: we have a lot of main.c (or other duplicated names!) in
tree. Imho, it would be annoying and a bad workaroud to rename all
those to avoid conflicts like I did here.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1811670

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200311160923.882474-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/vhost-user-gpu/Makefile.objs                | 6 +++---
 contrib/vhost-user-gpu/{main.c =3D> vhost-user-gpu.c} | 0
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename contrib/vhost-user-gpu/{main.c =3D> vhost-user-gpu.c} (100%)

diff --git a/contrib/vhost-user-gpu/Makefile.objs b/contrib/vhost-user-gpu/=
Makefile.objs
index 6170c91..0929609 100644
--- a/contrib/vhost-user-gpu/Makefile.objs
+++ b/contrib/vhost-user-gpu/Makefile.objs
@@ -1,7 +1,7 @@
-vhost-user-gpu-obj-y =3D main.o virgl.o vugbm.o
+vhost-user-gpu-obj-y =3D vhost-user-gpu.o virgl.o vugbm.o
=20
-main.o-cflags :=3D $(PIXMAN_CFLAGS) $(GBM_CFLAGS)
-main.o-libs :=3D $(PIXMAN_LIBS)
+vhost-user-gpu.o-cflags :=3D $(PIXMAN_CFLAGS) $(GBM_CFLAGS)
+vhost-user-gpu.o-libs :=3D $(PIXMAN_LIBS)
=20
 virgl.o-cflags :=3D $(VIRGL_CFLAGS) $(GBM_CFLAGS)
 virgl.o-libs :=3D $(VIRGL_LIBS)
diff --git a/contrib/vhost-user-gpu/main.c b/contrib/vhost-user-gpu/vhost-u=
ser-gpu.c
similarity index 100%
rename from contrib/vhost-user-gpu/main.c
rename to contrib/vhost-user-gpu/vhost-user-gpu.c
--=20
1.8.3.1



