Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC331C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 14:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D0F206E9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 14:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bd2P9VNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D0F206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDUaB-0007NR-FI
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 10:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDUXd-0005Wj-JD
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDUXc-0002Aj-3y
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26195
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDUXb-00027H-UI
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584283619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNM4FcuvpDlHlX1gsPH6mZYVPEgw3i0rjSojdcghyfE=;
 b=Bd2P9VNZ+jeyurr59qZpMJ8ZNi8PzmsZLKFDa9GKpZrUta8iGvPyBm0moNj9JQaqBLrVGX
 hNi/dhwLR+iaCDmtoj2C+EcZTo0FD96aGJcOHP/1GALJ9kHiZ/MK7KtNEcY+6f9scbB/UY
 t2Tf1NWGZCj/ccStQIRx9GqkKbKIMQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-YL2lcZQ5PpWjrDmbAC_pWQ-1; Sun, 15 Mar 2020 10:46:57 -0400
X-MC-Unique: YL2lcZQ5PpWjrDmbAC_pWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC129801E53;
 Sun, 15 Mar 2020 14:46:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BDB392D4F;
 Sun, 15 Mar 2020 14:46:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9175511366EC; Sun, 15 Mar 2020 15:46:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/34] tests/test-qmp-event: Use qobject_is_equal()
Date: Sun, 15 Mar 2020 15:46:28 +0100
Message-Id: <20200315144653.22660-10-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-1-armbru@redhat.com>
References: <20200315144653.22660-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Locally defined helper qdict_cmp_simple() implements just enough of a
comparison to serve here.  Replace it by qobject_is_equal(), which
implements all of it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


