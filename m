Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892B3C43215
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575A02086A
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRCu9a10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575A02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib8fp-00085G-20
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 14:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ib8dq-0006Qd-At
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ib8dm-000543-SE
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40585
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ib8dl-000531-US
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575142968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4N9e38HWdd95QkHzCa+MZyOQk8kGL3rr8n3UF0VKIQ=;
 b=PRCu9a10VKpLEXI7oP6nfig8Q4I9AY+ZZef/WGxnSSmTV/kRfEyA/XdeNIXG/9GEP5DrnJ
 gpz/f3dc8vJYycv4+qSn0yUyRWsRausD76bph6W2Xx8JhYNDoac5eNeOKsm0h0tiI/+IUO
 xciWDM/BKWv+LTeS/5zSRrrjOxEAeEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-AngOt7hSMNiyZx1pES8rMQ-1; Sat, 30 Nov 2019 14:42:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45E7F80183C;
 Sat, 30 Nov 2019 19:42:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 713FF19C58;
 Sat, 30 Nov 2019 19:42:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 11E5511366D1; Sat, 30 Nov 2019 20:42:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/21] crypto: Fix certificate file error handling crash bug
Date: Sat, 30 Nov 2019 20:42:23 +0100
Message-Id: <20191130194240.10517-5-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-1-armbru@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: AngOt7hSMNiyZx1pES8rMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: vsementsov@virtuozzo.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qcrypto_tls_creds_load_cert() passes uninitialized GError *gerr by
reference to g_file_get_contents().  When g_file_get_contents() fails,
it'll try to set a GError.  Unless @gerr is null by dumb luck, this
logs a ERROR_OVERWRITTEN_WARNING warning message and leaves @gerr
unchanged.  qcrypto_tls_creds_load_cert() then dereferences the
uninitialized @gerr.

Fix by initializing @gerr properly.

Fixes: 9a2fd4347c40321f5cbb4ab4220e759fcbf87d03
Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 crypto/tlscredsx509.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 01fc304e5d..53a4368f49 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -380,7 +380,7 @@ qcrypto_tls_creds_load_cert(QCryptoTLSCredsX509 *creds,
     gnutls_x509_crt_t cert =3D NULL;
     g_autofree char *buf =3D NULL;
     gsize buflen;
-    GError *gerr;
+    GError *gerr =3D NULL;
     int ret =3D -1;
     int err;
=20
--=20
2.21.0


