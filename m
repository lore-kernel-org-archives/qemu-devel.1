Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39814C2BA12
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055D520719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8ibEDN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055D520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5Fz-0002od-6b
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B3-0002Xh-7A
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B2-0000Su-3R
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22021
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5B1-0000S9-Vz
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cgUCuiQImsO71G7idTK9arqrOSPOAEA79IR0k9B/Lbo=;
 b=X8ibEDN0T9BUfGnvIzruq8ImgjviqE3CETv5YuMI3+auHMf/Ex7+3Hp8wxs2MJFRmNsr+/
 nPyMxYdrdXJ1vKvOJhH2VehCXfkhPej2LIvfnTWDCHKpGEsygrN+m5EBr85SDnaAWN01od
 qHBesv46NDdmPk6/Bd7Y1Oq2IOvb7Ew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-8jS2BQlkMKyzO7HfZlNJXg-1; Thu, 02 Apr 2020 15:06:53 -0400
X-MC-Unique: 8jS2BQlkMKyzO7HfZlNJXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71628108442D
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 19:06:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D53750BEE
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 19:06:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/15] object-add: don't create return value if failed
Date: Thu,  2 Apr 2020 15:06:39 -0400
Message-Id: <20200402190640.1693-15-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No need to return an empty value from object-add (it would also leak
if the command failed).  While at it, remove the "if" around object_unref
since object_unref handles NULL arguments just fine.

Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200325184723.2029630-4-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/qom-qmp-cmds.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 435193b036..e47ebe8ed1 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -285,10 +285,7 @@ void qmp_object_add(QDict *qdict, QObject **ret_data, =
Error **errp)
     v =3D qobject_input_visitor_new(QOBJECT(qdict));
     obj =3D user_creatable_add_type(type, id, qdict, v, errp);
     visit_free(v);
-    if (obj) {
-        object_unref(obj);
-    }
-    *ret_data =3D QOBJECT(qdict_new());
+    object_unref(obj);
 }
=20
 void qmp_object_del(const char *id, Error **errp)
--=20
2.18.2



