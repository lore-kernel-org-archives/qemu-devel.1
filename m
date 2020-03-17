Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C627C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFC1205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hc6Abksm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFC1205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8Rq-0006uD-1n
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jE8R5-0006JI-DO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jE8R4-0003jq-9P
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:22:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jE8R4-0003eS-5L
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584436973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ib5dRezRyf4fCuvPYTQ13QWckytTsm4J7u7VLnTIegc=;
 b=Hc6AbksmpfB/eFwG0/aemEQNG8IuWZ2OYKydrGcsnteBtfoQ5D2CeTh6pG83xtRpgr4Vmm
 G1IC4GDjfphVJpqx5ZheJn9XFXEj5KY6EAPlp4KLVgr1MUhNfRPo5x65rNyrjBchIcsmDK
 L4buyevObTbpCPx2Qsn227wAUWNWrZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-G-f2Tik0N9mzduBeMcZykA-1; Tue, 17 Mar 2020 05:22:51 -0400
X-MC-Unique: G-f2Tik0N9mzduBeMcZykA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B894010883B7
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 09:22:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F6D110027AA;
 Tue, 17 Mar 2020 09:22:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CBDD11138404; Tue, 17 Mar 2020 10:22:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qom-qmp-cmds: Fix another memory leak in qmp_object_add()
Date: Tue, 17 Mar 2020 10:22:41 +0100
Message-Id: <20200317092241.31660-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When user_creatable_add_type() fails, qmp_object_add() returns both
its error and the usual empty QDict success value.  The QMP core
handles the error, and ignores the success value, leaking it.  Exposed
by qmp-cmd-test case /x86_64/qmp/object-add-without-props, and duly
reported both by ASan and valgrind.

To plug the leak, set the success value only on success.

Fixes: 5f07c4d60d091320186e7b0edaf9ed2cc16b2d1e
Cc: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/qom-qmp-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 435193b036..6bd137ccbf 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -287,8 +287,8 @@ void qmp_object_add(QDict *qdict, QObject **ret_data, E=
rror **errp)
     visit_free(v);
     if (obj) {
         object_unref(obj);
+        *ret_data =3D QOBJECT(qdict_new());
     }
-    *ret_data =3D QOBJECT(qdict_new());
 }
=20
 void qmp_object_del(const char *id, Error **errp)
--=20
2.21.1


