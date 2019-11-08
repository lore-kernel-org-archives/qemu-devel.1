Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACC6FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A83215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtR8vfgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A83215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5p9-00058W-Pp
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5m4-0002oe-Cc
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5m3-0003U3-9h
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5m1-0003Sr-Ld
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=idH6Lctnz6gUEPfhrh3e0GxtIlG3tIR/wVTbHh5fUtY=;
 b=DtR8vfggYqpU+Sss7X2J5hWPR8o6gv4u+RWSAkrpYdIl9dJh1QNyfibfZfSx12EFYLEEqN
 m43NczBnrSTwRxl8OaG0I+YaqlhWRCUpctXPY0YREX9g9e7men0OzArHeO6tn2/FgcLUnK
 AmFp4mlRGRUeHhG+z/whmDTf/GmbTjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-LoBFHHMCMXGgzrwgXXSpFA-1; Fri, 08 Nov 2019 10:02:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10117477
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:02:00 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DC5160C18;
 Fri,  8 Nov 2019 15:01:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 02/25] json-lexer: make it safe to call destroy multiple
 times
Date: Fri,  8 Nov 2019 19:01:00 +0400
Message-Id: <20191108150123.12213-3-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: LoBFHHMCMXGgzrwgXXSpFA-1
X-Mimecast-Spam-Score: 0
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 armbru@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can easily avoid the burden of checking if the lexer was
initialized prior to calling destroy by the caller, let's do it.

This allows simplification in state tracking with the following patch,
"qmp: add QmpSession" can call qmp_session_destroy() multiple times,
which in turns calls json_lexer_destroy().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/json-lexer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 632320d72d..fa7a2c43a8 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -361,5 +361,8 @@ void json_lexer_flush(JSONLexer *lexer)
=20
 void json_lexer_destroy(JSONLexer *lexer)
 {
-    g_string_free(lexer->token, true);
+    if (lexer->token) {
+        g_string_free(lexer->token, true);
+        lexer->token =3D NULL;
+    }
 }
--=20
2.24.0


