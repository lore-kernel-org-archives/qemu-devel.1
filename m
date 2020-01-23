Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C58C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8430722522
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGVBBobi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8430722522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufLP-000693-1M
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuO-0001NT-7d
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucuN-0001He-6c
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24629
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucuN-0001HR-37
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppgAxw9SO7HGyY8uV4plx7AC+/cE4ShpaHOxwMrlAfY=;
 b=bGVBBobi/xJnBBiPz88SMlnLJ3ZASPbeiXB4f3BNa+9t7/Fi3WiMfMhO6GayAPNZ54nJMO
 O0IEjEiWVEkoZlstlnxsI9MpHdl6YQDLMuIzKLbyg/SPXdnFEyFuidZIIi77VnAQ980hrU
 SbbhSJl1dPcLTiyHmtMwITa7eai4Ax4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-RLXnwoC4OS-_QTbOQFWwAg-1; Thu, 23 Jan 2020 08:52:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84CEF8024D3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:28 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82F118575C;
 Thu, 23 Jan 2020 13:52:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 47/59] object: return self in object_ref()
Date: Thu, 23 Jan 2020 14:50:37 +0100
Message-Id: <1579787449-27599-48-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: RLXnwoC4OS-_QTbOQFWwAg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This allow for simpler assignment with ref: foo =3D object_ref(bar)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200110153039.1379601-19-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 3 ++-
 qom/object.c         | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 5e2f60d..18660fd 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1005,8 +1005,9 @@ GSList *object_class_get_list_sorted(const char *impl=
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
index 66c4a5f..555c8b9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1107,12 +1107,13 @@ GSList *object_class_get_list_sorted(const char *im=
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
1.8.3.1



