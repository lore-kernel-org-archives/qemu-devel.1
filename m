Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE4CC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0988D2080D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USCFHEvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0988D2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwcZ-0002vn-82
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwIv-0001N3-3d
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwIs-0004j9-MV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:34:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55205
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwIr-0004gU-AT
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mm78GU9uoQYaLz+WJKZTuaIvHha4mHrrKwq72KJ4AQc=;
 b=USCFHEvvs3Lqd6zGPRgEw5DZLJLycbJzu2AIMklPqUJ1KAG1ePRk3HE9FSuvx/x0Ogx4sH
 hoxHPPytj8qI9BDIzPENR18gskgX6eHsmq7Kr5gp5LfINkEAqc7Gil8PeAYRdqwmAOy711
 JWy/oAXKl2r3H6dzuZyFoZotPyqE2z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-bPX5vVwvPL-rbHBP7t3WVQ-1; Fri, 10 Jan 2020 10:34:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ABF41800D6B
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:34:21 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A4095C1B5;
 Fri, 10 Jan 2020 15:34:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/26] object: return self in object_ref()
Date: Fri, 10 Jan 2020 19:30:31 +0400
Message-Id: <20200110153039.1379601-19-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: bPX5vVwvPL-rbHBP7t3WVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
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
index ead9129ac8..933e5c6cb9 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1013,8 +1013,9 @@ GSList *object_class_get_list_sorted(const char *impl=
ements_type,
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
index 3924678ec3..9f76a330ff 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1098,12 +1098,13 @@ GSList *object_class_get_list_sorted(const char *im=
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
2.25.0.rc1.20.g2443f3f80d.dirty


