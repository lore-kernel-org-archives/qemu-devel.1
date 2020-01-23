Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2EDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6852071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZ7rnfsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6852071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufsc-000449-3w
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucu8-0000yV-PX
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucu7-00012f-P7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44723
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucu7-00012D-MK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gtlhalq0fbK5m4my9MiVYhdXV3346mpyFNYm5Qsi5uc=;
 b=UZ7rnfsExxae89+iY2Uk4/NO4Sc0th9lbWujF7clCV6/s1PWxCH18KsbVQkeq0APm1H+oH
 DLqrhbYySuaR1WEbrKmPJvytcMz0y0sQZ0ES/MKQE9pCYgs6fgh0CkFCEWMQ45J2BO9yjg
 fXMkGnRdjWFFD8UPxQ06LpsgzU4T1Wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-Buzxx_PIP-yhXfKKUjoIvg-1; Thu, 23 Jan 2020 08:52:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD0FE100F0E7
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:12 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8A691CB;
 Thu, 23 Jan 2020 13:52:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/59] qstring: add qstring_free()
Date: Thu, 23 Jan 2020 14:50:28 +0100
Message-Id: <1579787449-27599-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Buzxx_PIP-yhXfKKUjoIvg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Similar to g_string_free(), optionally return the underlying char*.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-10-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qapi/qmp/qstring.h |  1 +
 qobject/qstring.c          | 27 ++++++++++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index 3e83e3a..e2e356e 100644
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
index 1c6897d..b66a2c3 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -150,15 +150,32 @@ bool qstring_is_equal(const QObject *x, const QObject=
 *y)
 }
=20
 /**
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
+/**
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
1.8.3.1



