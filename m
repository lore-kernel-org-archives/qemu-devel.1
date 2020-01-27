Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44490C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA0D20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaaXDXwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA0D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwCyZ-0001wE-3M
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 17:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwCww-0000BS-Uq
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:33:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwCwv-00034O-Vq
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:33:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58123
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwCwv-00033j-Pl
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580164421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kT2L6VxmB9CUtPmFPT/LJn+MHUIQcZezXguF/sSZeps=;
 b=CaaXDXwIDVxea9D2oTfx7t5WT/eWQr/wP+USrdod9B9Wsjq4y02orf/uKK4s1uH8N/6OLK
 aDM+WostcD3AVtgeB5zB6BLXVb3/b1Pr4ggW+6kzlmDggHd6yX+exqfIX4VaPZUh5KttuK
 QaD/20+RSG6MfJoBUpZz1KiAIwA2A64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-qjBLXjhIOWy6hj6Sh6HHJA-1; Mon, 27 Jan 2020 17:33:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C66818017CC
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 22:33:35 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 267CA3B7;
 Mon, 27 Jan 2020 22:33:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/19] multifd: Make sure that we don't do any IO after an error
Date: Mon, 27 Jan 2020 23:33:04 +0100
Message-Id: <20200127223321.2742-3-quintela@redhat.com>
In-Reply-To: <20200127223321.2742-1-quintela@redhat.com>
References: <20200127223321.2742-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qjBLXjhIOWy6hj6Sh6HHJA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d2208b5534..f95d656c26 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3445,7 +3445,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque=
)
 {
     RAMState **temp =3D opaque;
     RAMState *rs =3D *temp;
-    int ret;
+    int ret =3D 0;
     int i;
     int64_t t0;
     int done =3D 0;
@@ -3524,12 +3524,14 @@ static int ram_save_iterate(QEMUFile *f, void *opaq=
ue)
     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
=20
 out:
-    multifd_send_sync_main(rs);
-    qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
-    qemu_fflush(f);
-    ram_counters.transferred +=3D 8;
+    if (ret >=3D 0) {
+        multifd_send_sync_main(rs);
+        qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+        qemu_fflush(f);
+        ram_counters.transferred +=3D 8;
=20
-    ret =3D qemu_file_get_error(f);
+        ret =3D qemu_file_get_error(f);
+    }
     if (ret < 0) {
         return ret;
     }
@@ -3581,9 +3583,11 @@ static int ram_save_complete(QEMUFile *f, void *opaq=
ue)
         ram_control_after_iterate(f, RAM_CONTROL_FINISH);
     }
=20
-    multifd_send_sync_main(rs);
-    qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
-    qemu_fflush(f);
+    if (ret >=3D 0) {
+        multifd_send_sync_main(rs);
+        qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+        qemu_fflush(f);
+    }
=20
     return ret;
 }
--=20
2.24.1


