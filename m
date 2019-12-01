Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66232C43215
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BFD20725
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C132N3VR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BFD20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNUY-00033G-4I
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNFW-0002X4-Q8
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNFV-0001D4-N0
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:18:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39684
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNFT-0001AU-Px
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575199121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwiUbhLuP1WRZ1ab4L2uAUGEIcjwE3whw8zNymug5S0=;
 b=C132N3VRRjulirGGCo5Bv9KngNqNtGIZCwukNc7OmDQIpIapPjPFa1GFuwAhiOhBYqTUYx
 3lqXMf2PaQDImZb5m60ORrl/aMBW2npo7KBpaLQ7WXbOshDM/1CpIsk9QI6w7ntuJ43HbX
 X0EnUrdhwYvOKCaTQmRIQaiy1rfHsCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-XJQt6ZydMYKtOEq4qB8nIw-1; Sun, 01 Dec 2019 06:18:38 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7D3F800D4C
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:18:37 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BA545D6A0;
 Sun,  1 Dec 2019 11:18:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/26] object: return self in object_ref()
Date: Sun,  1 Dec 2019 15:15:23 +0400
Message-Id: <20191201111531.1136947-19-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: XJQt6ZydMYKtOEq4qB8nIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allow for simpler assignment with ref: foo =3D object_ref(bar)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 3 ++-
 qom/object.c         | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 6cafc5f368..aa2cf1ca75 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -994,8 +994,9 @@ GSList *object_class_get_list_sorted(const char *implem=
ents_type,
  *
  * Increase the reference count of a object.  A object cannot be freed as =
long
  * as its reference count is greater than zero.
+ * Returns: @obj
  */
-void object_ref(Object *obj);
+Object *object_ref(Object *obj);
=20
 /**
  * object_unref:
diff --git a/qom/object.c b/qom/object.c
index 10acf9bff9..c01cd54243 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1074,12 +1074,13 @@ GSList *object_class_get_list_sorted(const char *im=
plements_type,
                         object_class_cmp);
 }
=20
-void object_ref(Object *obj)
+Object *object_ref(Object *obj)
 {
     if (!obj) {
-        return;
+        return NULL;
     }
     atomic_inc(&obj->ref);
+    return obj;
 }
=20
 void object_unref(Object *obj)
--=20
2.24.0


