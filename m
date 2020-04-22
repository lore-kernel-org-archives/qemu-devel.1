Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5624DC55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240C6206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrmND7L/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240C6206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRF7T-0005Pa-8W
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRF66-0003iW-Eu
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRF65-0003jn-Vo
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36151
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRF65-0003g1-IE
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587560844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fq3LoTXXybnbVOI/Fia1jToGdrSHqpKtobmIdURPVRg=;
 b=UrmND7L/+jBc41+KkLvAHVcbQXwoTufcqw51R8SqzueNuVhtoY0nWCnV5LtTF44zW7iMn/
 oY9Ht7Qv9fMvEbXJpmcNELdVA0wdnYxCym/zMwkGuUzL3lK7kWkyifTFuIcUj8itwoc521
 hJBdqr3t4MnOGcYp2C/FkWoHB0gFpuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-vbty6HNxPcmn3FmBfwzSjg-1; Wed, 22 Apr 2020 09:07:23 -0400
X-MC-Unique: vbty6HNxPcmn3FmBfwzSjg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E420818CA248;
 Wed, 22 Apr 2020 13:07:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1C6A277B5;
 Wed, 22 Apr 2020 13:07:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 00F3211358BD; Wed, 22 Apr 2020 15:07:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/14] cryptodev: Fix cryptodev_builtin_cleanup() error API
 violation
Date: Wed, 22 Apr 2020 15:07:06 +0200
Message-Id: <20200422130719.28225-2-armbru@redhat.com>
In-Reply-To: <20200422130719.28225-1-armbru@redhat.com>
References: <20200422130719.28225-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Gonglei <arei.gonglei@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

cryptodev_builtin_cleanup() passes @errp to
cryptodev_builtin_sym_close_session() in a loop.  Harmless, because
cryptodev_builtin_sym_close_session() can't actually fail.  Fix it
anyway.

Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 backends/cryptodev-builtin.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index c8ae3b9742..14316333fe 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -282,12 +282,7 @@ static int cryptodev_builtin_sym_close_session(
     CryptoDevBackendBuiltin *builtin =3D
                       CRYPTODEV_BACKEND_BUILTIN(backend);
=20
-    if (session_id >=3D MAX_NUM_SESSIONS ||
-              builtin->sessions[session_id] =3D=3D NULL) {
-        error_setg(errp, "Cannot find a valid session id: %" PRIu64 "",
-                      session_id);
-        return -1;
-    }
+    assert(session_id < MAX_NUM_SESSIONS && builtin->sessions[session_id])=
;
=20
     qcrypto_cipher_free(builtin->sessions[session_id]->cipher);
     g_free(builtin->sessions[session_id]);
@@ -356,8 +351,7 @@ static void cryptodev_builtin_cleanup(
=20
     for (i =3D 0; i < MAX_NUM_SESSIONS; i++) {
         if (builtin->sessions[i] !=3D NULL) {
-            cryptodev_builtin_sym_close_session(
-                    backend, i, 0, errp);
+            cryptodev_builtin_sym_close_session(backend, i, 0, &error_abor=
t);
         }
     }
=20
--=20
2.21.1


