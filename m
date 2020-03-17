Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8412FC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 06:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C6D20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 06:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bv0SoAmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C6D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE5uG-0003G2-E6
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 02:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jE5tW-0002XK-BZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jE5tV-0008Ru-49
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:40:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jE5tU-0008KP-UV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584427204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JzbifADAR9QXEf7kc0HEivqB4g6tSlbyT5OBc1ZLeCY=;
 b=bv0SoAmySYQzXnMspYJvt3tvTWQryMimV1NrK0LpX5mzgblrw3WpbcemNS4lgUIYdjTsEX
 Ci3xGhDSQTQyvvjn4hQUIe2DrXdOhQsjGfg++ZOGlygYjWvRANMQjywoa/Civ3DRBPbItR
 lMfSQvC1f1AGvc/efI+XD9DeWzN6D/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-nIBrQjQgMiOh1Gv6-83q2g-1; Tue, 17 Mar 2020 02:40:02 -0400
X-MC-Unique: nIBrQjQgMiOh1Gv6-83q2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79104800EB6;
 Tue, 17 Mar 2020 06:40:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26FDD8F343;
 Tue, 17 Mar 2020 06:40:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ACD251138404; Tue, 17 Mar 2020 07:39:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v3 23/34] qapi: Simplify how qmp_dispatch() gets the
 request ID
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-24-armbru@redhat.com>
 <CAJ+F1CLUikxRN2nH8h_9zGXLLpsxz4H-cMxxLbctAzavWjAcWw@mail.gmail.com>
Date: Tue, 17 Mar 2020 07:39:59 +0100
In-Reply-To: <CAJ+F1CLUikxRN2nH8h_9zGXLLpsxz4H-cMxxLbctAzavWjAcWw@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 16 Mar 2020
 18:33:09 +0100")
Message-ID: <874kunv60w.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Sun, Mar 15, 2020 at 3:51 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> We convert the request object to a QDict twice: first in
>> qmp_dispatch() to get the request ID, and then again in
>> qmp_dispatch_check_obj(), which converts to QDict, then checks and
>> returns it.  We can't get the request ID from the latter, because it's
>> null when the qdict flunks the checks.
>>
>> Move getting the request ID into qmp_dispatch_check_obj().
>>
>
> I don't see this is a an improvement. qmp_dispatch_check_obj() doesn't
> care about id.
>
> And it doesn't look like it is saving cycles either.
>
> Is that worth it?
>
> Code change is ok otherwise,

The duplicated conversion to QDict annoys me, mostly because both copies
can fail.

But you're right, my solution is hamfisted.  What about this one?


From 46a1719be9503f86636ff672325c5430d4063b8b Mon Sep 17 00:00:00 2001
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 21 Oct 2019 15:52:20 +0200
Subject: [PATCH] qapi: Simplify how qmp_dispatch() gets the request ID

We convert the request object to a QDict twice: first in
qmp_dispatch() to get the request ID, and then again in
qmp_dispatch_check_obj(), which converts to QDict, then checks and
returns it.  We can't get the request ID from the latter, because it's
null when the qdict flunks the checks.

Move the checked conversion to QDict from qmp_dispatch_check_obj() to
qmp_dispatch(), and drop the duplicate there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qmp-dispatch.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 550d1fe8d2..91e50fa0dd 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -19,20 +19,13 @@
 #include "sysemu/runstate.h"
 #include "qapi/qmp/qbool.h"
=20
-static QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_oo=
b,
+static QDict *qmp_dispatch_check_obj(QDict *dict, bool allow_oob,
                                      Error **errp)
 {
     const char *exec_key =3D NULL;
     const QDictEntry *ent;
     const char *arg_name;
     const QObject *arg_obj;
-    QDict *dict;
-
-    dict =3D qobject_to(QDict, request);
-    if (!dict) {
-        error_setg(errp, "QMP input must be a JSON object");
-        return NULL;
-    }
=20
     for (ent =3D qdict_first(dict); ent;
          ent =3D qdict_next(dict, ent)) {
@@ -103,13 +96,21 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *req=
uest,
     const char *command;
     QDict *args;
     QmpCommand *cmd;
-    QDict *dict =3D qobject_to(QDict, request);
-    QObject *id =3D dict ? qdict_get(dict, "id") : NULL;
+    QDict *dict;
+    QObject *id;
     QObject *ret =3D NULL;
     QDict *rsp =3D NULL;
=20
-    dict =3D qmp_dispatch_check_obj(request, allow_oob, &err);
+    dict =3D qobject_to(QDict, request);
     if (!dict) {
+        id =3D NULL;
+        error_setg(&err, "QMP input must be a JSON object");
+        goto out;
+    }
+
+    id =3D qdict_get(dict, "id");
+
+    if (!qmp_dispatch_check_obj(dict, allow_oob, &err)) {
         goto out;
     }
=20
--=20
2.21.1


