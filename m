Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72122C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBA0206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5k6Otud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBA0206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQRu1-0008Ci-BO
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56466 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRrB-0002sy-6p
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:45 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRr9-0006v0-TT
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36199
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQRr9-0006sq-G9
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587371562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fq3LoTXXybnbVOI/Fia1jToGdrSHqpKtobmIdURPVRg=;
 b=H5k6OtudWD+Jc2fVk02+pydwskTpK4VfX83r0XSY4ZFjQycguNfyXrtVatflMJdbWt19OL
 +wUhPuffncq2PvM08jp/YRJZBxdQitq0dWE+aCI2yO66y5zH6t8UFqbiX6+Ak6wkwKLnea
 Wid7qW0mmVOXYSm5cS6SOTCUx8t2idE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-FpQUGFKPNRqM2Zk1oV7LHg-1; Mon, 20 Apr 2020 04:32:39 -0400
X-MC-Unique: FpQUGFKPNRqM2Zk1oV7LHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7616D107ACC4;
 Mon, 20 Apr 2020 08:32:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AF3927BDA;
 Mon, 20 Apr 2020 08:32:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F34311358BD; Mon, 20 Apr 2020 10:32:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/11] cryptodev: Fix cryptodev_builtin_cleanup() error API
 violation
Date: Mon, 20 Apr 2020 10:32:26 +0200
Message-Id: <20200420083236.19309-2-armbru@redhat.com>
In-Reply-To: <20200420083236.19309-1-armbru@redhat.com>
References: <20200420083236.19309-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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


