Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6379FC432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DBA20725
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btUKoCBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DBA20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNNL-00038R-Kg
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNDw-0001fH-NB
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNDv-0000G6-Hn
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:17:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48650
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNDv-0000FX-Dn
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5dSVQLjVail4scWe0BcLaOGlLN2baG+Nh8SgHef6BU=;
 b=btUKoCBOXVgP1EzFDgERdJRa0xiVrD//s0HtBZpG6wq056GXKn2rZoF2/xfV46mjxlTXHC
 EiAgU1J109OjyeIdYUp/LgOFw4lT59KjCwZxbw9WKbpTOo0ANkQfp/R2zsNEDyUQ5mYSA+
 r3ROBDl/EwouyTI/0747qEZ8XsKHP08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-yk_XX_vnMfuJn23LGqJ01A-1; Sun, 01 Dec 2019 06:17:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18E7D10054E3
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:17:04 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97BC260BF7;
 Sun,  1 Dec 2019 11:16:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/26] qstring: add qstring_free()
Date: Sun,  1 Dec 2019 15:15:14 +0400
Message-Id: <20191201111531.1136947-10-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: yk_XX_vnMfuJn23LGqJ01A-1
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to g_string_free(), optionally return the underlying char*.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qstring.h |  1 +
 qobject/qstring.c          | 27 ++++++++++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index 3e83e3a95d..e2e356e5e7 100644
--- a/include/qapi/qmp/qstring.h
+++ b/include/qapi/qmp/qstring.h
@@ -33,6 +33,7 @@ void qstring_append_int(QString *qstring, int64_t value);
 void qstring_append(QString *qstring, const char *str);
 void qstring_append_chr(QString *qstring, int c);
 bool qstring_is_equal(const QObject *x, const QObject *y);
+char *qstring_free(QString *qstring, bool return_str);
 void qstring_destroy_obj(QObject *obj);
=20
 #endif /* QSTRING_H */
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 1c6897df00..b66a2c35f2 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -149,16 +149,33 @@ bool qstring_is_equal(const QObject *x, const QObject=
 *y)
                    qobject_to(QString, y)->string);
 }
=20
+/**
+ * qstring_free(): Free the memory allocated by a QString object
+ *
+ * Return: if @return_str, return the underlying string, to be
+ * g_free(), otherwise NULL is returned.
+ */
+char *qstring_free(QString *qstring, bool return_str)
+{
+    char *rv =3D NULL;
+
+    if (return_str) {
+        rv =3D qstring->string;
+    } else {
+        g_free(qstring->string);
+    }
+
+    g_free(qstring);
+
+    return rv;
+}
+
 /**
  * qstring_destroy_obj(): Free all memory allocated by a QString
  * object
  */
 void qstring_destroy_obj(QObject *obj)
 {
-    QString *qs;
-
     assert(obj !=3D NULL);
-    qs =3D qobject_to(QString, obj);
-    g_free(qs->string);
-    g_free(qs);
+    qstring_free(qobject_to(QString, obj), FALSE);
 }
--=20
2.24.0


