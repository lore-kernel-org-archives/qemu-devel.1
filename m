Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F687FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14642178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0nGYUQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14642178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT60u-0002so-3J
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5nd-0004Jz-Dp
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iT5nc-0004RF-Be
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:03:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38876
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iT5nc-0004R5-6Y
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zvIOX9sTV8g3eSq1Z5naFU5517bwNh6zcozKMv6s9c0=;
 b=a0nGYUQl/zB3T6c4yTEIElVem2V3naygq2au+bPI1OjK0Hq2uqmvykTa5uBu6BmgI20O6D
 hMj8rJmmTboVB8IWCPDXwY3MbUym64+AF6G0QBAwzQV9tSfo7ctXe2a7dZLrDinkpfRVik
 NW049wsIohH1wB1KlQFMDyvZmUX2xrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-nJi0IT7iMj-CQRu7_tJwsQ-1; Fri, 08 Nov 2019 10:03:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93E32477
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 15:03:41 +0000 (UTC)
Received: from localhost (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F2DD5C1BB;
 Fri,  8 Nov 2019 15:03:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/25] qmp: simplify qmp_return_error()
Date: Fri,  8 Nov 2019 19:01:07 +0400
Message-Id: <20191108150123.12213-10-marcandre.lureau@redhat.com>
In-Reply-To: <20191108150123.12213-1-marcandre.lureau@redhat.com>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: nJi0IT7iMj-CQRu7_tJwsQ-1
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

It's simple, probably more efficient, to hand-craft the dict.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qmp-dispatch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 188b5680b6..fcf6cb0bf8 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -50,10 +50,10 @@ void qmp_return(QmpReturn *qret, QObject *rsp)
=20
 void qmp_return_error(QmpReturn *qret, Error *err)
 {
-    qdict_put_obj(qret->rsp, "error",
-                  qobject_from_jsonf_nofail("{ 'class': %s, 'desc': %s }",
-                      QapiErrorClass_str(error_get_class(err)),
-                      error_get_pretty(err)));
+    QDict *qdict =3D qdict_new();
+    qdict_put_str(qdict, "class", QapiErrorClass_str(error_get_class(err))=
);
+    qdict_put_str(qdict, "desc", error_get_pretty(err));
+    qdict_put_obj(qret->rsp, "error", QOBJECT(qdict));
     error_free(err);
     qret->session->return_cb(qret->session, qret->rsp);
     qmp_return_free(qret);
--=20
2.24.0


