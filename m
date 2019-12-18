Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1466DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 05:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F4021582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 05:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZ+CU7xb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F4021582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihRXT-0008Fc-Oc
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 00:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihRW1-0006vZ-Qi
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihRW0-0003l6-L1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:04:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihRW0-0003ap-Gx
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576645488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VrGzzfv5NC3Zj64RUvUmQx8W98nbwIJZg4x0dPWCbpQ=;
 b=CZ+CU7xb2F01Ixa+igQG5PDKMzvwiPJEpzH9+DEeQ2ragY10fnK97mY119Jb9CRaD7Fwf4
 QADlbdxmb9BVZgfB+wgXDbm+UolJ2oQ7u+5MYhJqrCdLVzOpXbCQLOQchuGjDwVIFWm8dP
 99y9pwCCptMIG7P/7Y7zCuuP8WuWBFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-re28d7dYOy-keMArZ5BGTw-1; Wed, 18 Dec 2019 00:04:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33DE518543CC
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 05:04:46 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACB625D9E1;
 Wed, 18 Dec 2019 05:04:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] multifd: Make sure that we don't do any IO after an error
Date: Wed, 18 Dec 2019 06:04:37 +0100
Message-Id: <20191218050439.5989-3-quintela@redhat.com>
In-Reply-To: <20191218050439.5989-1-quintela@redhat.com>
References: <20191218050439.5989-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: re28d7dYOy-keMArZ5BGTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index db90237977..4b44578e57 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4132,7 +4132,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque=
)
 {
     RAMState **temp =3D opaque;
     RAMState *rs =3D *temp;
-    int ret;
+    int ret =3D 0;
     int i;
     int64_t t0;
     int done =3D 0;
@@ -4203,12 +4203,14 @@ static int ram_save_iterate(QEMUFile *f, void *opaq=
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
@@ -4260,9 +4262,11 @@ static int ram_save_complete(QEMUFile *f, void *opaq=
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
2.23.0


