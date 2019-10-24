Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EB5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECA52084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ki98oVAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECA52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNd2w-0001al-OV
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKi-0003uy-Q6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKh-0006Au-CR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54236
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKh-0006AT-7G
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VwkGbCv7Og2OBZVs11s5/f+xm7Uo964VHovW0vL2Pa4=;
 b=Ki98oVAXV/10HRyVEbfsC+oECOt7SYx6TKJTN7NsJjs7Y3dwyq/1BfTusRR5Bb7vOVpJFq
 eocIq2T/j9SG9PPXvQuVfB9Y1Efy+6X2GnHty4hQgWLSRG2xJhDq8Cj3lXXtOTC/hWGSmK
 J6OidU8rmmvjB5p4DhqImT+1R1egyis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-oULp1_mRNAieugi6TVf_Gg-1; Thu, 24 Oct 2019 08:35:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 104DA801E5C;
 Thu, 24 Oct 2019 12:35:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9CBD10027A1;
 Thu, 24 Oct 2019 12:35:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1B371113294C; Thu, 24 Oct 2019 14:34:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 10/19] qapi: Simplify how qmp_dispatch() deals with
 QCO_NO_SUCCESS_RESP
Date: Thu, 24 Oct 2019 14:34:49 +0200
Message-Id: <20191024123458.13505-11-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: oULp1_mRNAieugi6TVf_Gg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: libvir-list@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qmp-dispatch.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index a69d5b5a96..d1643fe37a 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -151,31 +151,31 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *re=
quest,
         args =3D qdict_get_qdict(dict, "arguments");
         qobject_ref(args);
     }
-
     cmd->fn(args, &ret, &err);=20
+    qobject_unref(args);
     if (err) {
-        ;
-    } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
+        goto out;
+    }
+
+    if (cmd->options & QCO_NO_SUCCESS_RESP) {
         g_assert(!ret);
+        return NULL;
     } else if (!ret) {
         /* TODO turn into assertion */
         ret =3D QOBJECT(qdict_new());
     }
=20
-    qobject_unref(args);
-
 out:
+    assert(!err !=3D !ret);
+
     if (err) {
         rsp =3D qmp_error_response(err);
-    } else if (ret) {
+    } else {
         rsp =3D qdict_new();
         qdict_put_obj(rsp, "return", ret);
-    } else {
-        /* Can only happen for commands with QCO_NO_SUCCESS_RESP */
-        rsp =3D NULL;
     }
=20
-    if (rsp && id) {
+    if (id) {
         qdict_put_obj(rsp, "id", qobject_ref(id));
     }
=20
--=20
2.21.0


