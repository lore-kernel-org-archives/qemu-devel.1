Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BADC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4744F2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4744F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD985-0003zV-Fn
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iD8na-0000Zj-JH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iD8nY-0004YC-Jh
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:01:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56705)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iD8nV-0004XC-RA
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:01:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6CD5B8A1CB9;
 Wed, 25 Sep 2019 15:01:40 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-251.ams2.redhat.com
 [10.36.117.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 179995C21F;
 Wed, 25 Sep 2019 15:01:38 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
 marcandre.lureau@redhat.com, richardw.yang@linux.intel.com,
 alex.benee@linaro.org
Subject: [PULL 1/9] migration: fix vmdesc leak on vmstate_save() error
Date: Wed, 25 Sep 2019 16:01:22 +0100
Message-Id: <20190925150130.12303-2-dgilbert@redhat.com>
In-Reply-To: <20190925150130.12303-1-dgilbert@redhat.com>
References: <20190925150130.12303-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Wed, 25 Sep 2019 15:01:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190912122514.22504-2-marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
index ee06f91d42..bb9462a54d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1314,7 +1314,7 @@ int qemu_savevm_state_complete_precopy_non_iterable=
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
@@ -1375,7 +1375,6 @@ int qemu_savevm_state_complete_precopy_non_iterable=
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
2.21.0


