Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8367C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE33220830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE33220830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8OQt-0001gF-P6
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i8OAG-0002sM-Ga
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i8OAF-0007OG-IS
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:25:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1i8OAF-0007O8-D6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:25:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BAF0230A7B89
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:25:30 +0000 (UTC)
Received: from localhost (ovpn-112-63.ams2.redhat.com [10.36.112.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8A1560F82;
 Thu, 12 Sep 2019 12:25:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 16:25:09 +0400
Message-Id: <20190912122514.22504-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190912122514.22504-1-marcandre.lureau@redhat.com>
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 12 Sep 2019 12:25:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/6] migration: fix vmdesc leak on
 vmstate_save() error
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
Cc: berrange@redhat.com, quintela@redhat.com, mprivozn@redhat.com,
 dgilbert@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 migration/qjson.h  | 2 ++
 migration/savevm.c | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/qjson.h b/migration/qjson.h
index 41664f2d71..1786bb5864 100644
--- a/migration/qjson.h
+++ b/migration/qjson.h
@@ -24,4 +24,6 @@ void json_start_object(QJSON *json, const char *name);
 const char *qjson_get_str(QJSON *json);
 void qjson_finish(QJSON *json);
=20
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QJSON, qjson_destroy)
+
 #endif /* QEMU_QJSON_H */
diff --git a/migration/savevm.c b/migration/savevm.c
index 4a86128ac4..6caa35a679 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1290,7 +1290,7 @@ int qemu_savevm_state_complete_precopy_non_iterable=
(QEMUFile *f,
                                                     bool in_postcopy,
                                                     bool inactivate_disk=
s)
 {
-    QJSON *vmdesc;
+    g_autoptr(QJSON) vmdesc =3D NULL;
     int vmdesc_len;
     SaveStateEntry *se;
     int ret;
@@ -1351,7 +1351,6 @@ int qemu_savevm_state_complete_precopy_non_iterable=
(QEMUFile *f,
         qemu_put_be32(f, vmdesc_len);
         qemu_put_buffer(f, (uint8_t *)qjson_get_str(vmdesc), vmdesc_len)=
;
     }
-    qjson_destroy(vmdesc);
=20
     return 0;
 }
--=20
2.23.0


