Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27707C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E709E20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKeApxuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E709E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAub-0000wp-11
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoU-00081S-RS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoT-0006GJ-Jg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34303)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoT-0006DT-Dz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oOhxt0yl3sOJGHT6J/7kewazDZ/vpEGtMZrn+xQsExI=;
 b=YKeApxuFBcdzzgDPPVWWGTI4ev7XDAlMRVn7VkFmPRA4TQs1I79AC5qxcRjdO23Iwt53Ot
 ksp5j1jTMogDM/4DLX0eGSJwEdX6eHNeW7QekH7OZWZpfnx7XXNs+G8XgR7/k50l+lgoev
 p0H09zzHCr7mlRTHvSWgsouyZ4LdcHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-YrHJBRC9NMWidYBGconcxQ-1; Tue, 17 Mar 2020 07:55:09 -0400
X-MC-Unique: YrHJBRC9NMWidYBGconcxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89F911922053;
 Tue, 17 Mar 2020 11:55:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FAC167154;
 Tue, 17 Mar 2020 11:55:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1352A11366EC; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/34] tests/test-qmp-event: Use qobject_is_equal()
Date: Tue, 17 Mar 2020 12:54:34 +0100
Message-Id: <20200317115459.31821-10-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Locally defined helper qdict_cmp_simple() implements just enough of a
comparison to serve here.  Replace it by qobject_is_equal(), which
implements all of it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-qmp-event.c | 66 +-----------------------------------------
 1 file changed, 1 insertion(+), 65 deletions(-)

diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 430001e622..d64066139c 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -28,73 +28,9 @@ typedef struct TestEventData {
     QDict *expect;
 } TestEventData;
=20
-typedef struct QDictCmpData {
-    QDict *expect;
-    bool result;
-} QDictCmpData;
-
 TestEventData *test_event_data;
 static GMutex test_event_lock;
=20
-/* Only compares bool, int, string */
-static
-void qdict_cmp_do_simple(const char *key, QObject *obj1, void *opaque)
-
-{
-    QObject *obj2;
-    QDictCmpData d_new, *d =3D opaque;
-    int64_t val1, val2;
-
-    if (!d->result) {
-        return;
-    }
-
-    obj2 =3D qdict_get(d->expect, key);
-    if (!obj2) {
-        d->result =3D false;
-        return;
-    }
-
-    if (qobject_type(obj1) !=3D qobject_type(obj2)) {
-        d->result =3D false;
-        return;
-    }
-
-    switch (qobject_type(obj1)) {
-    case QTYPE_QBOOL:
-        d->result =3D (qbool_get_bool(qobject_to(QBool, obj1)) =3D=3D
-                     qbool_get_bool(qobject_to(QBool, obj2)));
-        return;
-    case QTYPE_QNUM:
-        g_assert(qnum_get_try_int(qobject_to(QNum, obj1), &val1));
-        g_assert(qnum_get_try_int(qobject_to(QNum, obj2), &val2));
-        d->result =3D val1 =3D=3D val2;
-        return;
-    case QTYPE_QSTRING:
-        d->result =3D g_strcmp0(qstring_get_str(qobject_to(QString, obj1))=
,
-                              qstring_get_str(qobject_to(QString, obj2))) =
=3D=3D 0;
-        return;
-    case QTYPE_QDICT:
-        d_new.expect =3D qobject_to(QDict, obj2);
-        d_new.result =3D true;
-        qdict_iter(qobject_to(QDict, obj1), qdict_cmp_do_simple, &d_new);
-        d->result =3D d_new.result;
-        return;
-    default:
-        abort();
-    }
-}
-
-static bool qdict_cmp_simple(QDict *a, QDict *b)
-{
-    QDictCmpData d;
-
-    d.expect =3D b;
-    d.result =3D true;
-    qdict_iter(a, qdict_cmp_do_simple, &d);
-    return d.result;
-}
-
 void test_qapi_event_emit(test_QAPIEvent event, QDict *d)
 {
     QDict *t;
@@ -115,7 +51,7 @@ void test_qapi_event_emit(test_QAPIEvent event, QDict *d=
)
=20
     qdict_del(d, "timestamp");
=20
-    g_assert(qdict_cmp_simple(d, test_event_data->expect));
+    g_assert(qobject_is_equal(QOBJECT(d), QOBJECT(test_event_data->expect)=
));
=20
 }
=20
--=20
2.21.1


