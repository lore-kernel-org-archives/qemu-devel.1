Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0F2C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9836220732
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sk7mbq8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9836220732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib8me-0000a9-Cg
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 14:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ib8dw-0006X5-8v
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ib8dv-0005DP-2B
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51061
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ib8du-00058G-MK
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575142974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKOFNJ7AKoAjW1m5Bz8AzZ1gisR6NMx4PnfY9PjImjo=;
 b=Sk7mbq8uLtDNw0dOLDyNggIIUhjTvk64G4UPcZR9rF/kA81Pk47S04XfSjVUY3khWJbeRi
 X3v26Wh7JRd4MF/ACkpx00wT1EpIkI8STgbiJ+xt1UFPr6Ba6taC1Pd3ono8XPRlw0oZTs
 jeL5AKwhis0yWoL1sO06GoLd0wnoVoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-woFdMWQ7PjWaBHd1tkYDmg-1; Sat, 30 Nov 2019 14:42:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2611800D4E;
 Sat, 30 Nov 2019 19:42:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A18D600C1;
 Sat, 30 Nov 2019 19:42:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 36A201135A56; Sat, 30 Nov 2019 20:42:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/21] s390x/cpu_models: Fix latent feature property error
 handling bugs
Date: Sat, 30 Nov 2019 20:42:34 +0100
Message-Id: <20191130194240.10517-16-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-1-armbru@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: woFdMWQ7PjWaBHd1tkYDmg-1
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
Cc: Cornelia Huck <cohuck@redhat.com>, vsementsov@virtuozzo.com,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

s390x-cpu property setters set_feature() and set_feature_group() crash
when the visitor fails and its @errp argument is null.  Messed up in
commit 0754f60429 "s390x/cpumodel: expose features and feature groups
as properties".

The bug can't bite as no caller actually passes null.  Fix it anyway.

Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/s390x/cpu_models.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7e92fb2e15..6a29fd3ab1 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -987,6 +987,7 @@ static void get_feature(Object *obj, Visitor *v, const =
char *name,
 static void set_feature(Object *obj, Visitor *v, const char *name,
                         void *opaque, Error **errp)
 {
+    Error *err =3D NULL;
     S390Feat feat =3D (S390Feat) opaque;
     DeviceState *dev =3D DEVICE(obj);
     S390CPU *cpu =3D S390_CPU(obj);
@@ -1002,8 +1003,9 @@ static void set_feature(Object *obj, Visitor *v, cons=
t char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, errp);
-    if (*errp) {
+    visit_type_bool(v, name, &value, &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
     if (value) {
@@ -1043,6 +1045,7 @@ static void get_feature_group(Object *obj, Visitor *v=
, const char *name,
 static void set_feature_group(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
+    Error *err =3D NULL;
     S390FeatGroup group =3D (S390FeatGroup) opaque;
     const S390FeatGroupDef *def =3D s390_feat_group_def(group);
     DeviceState *dev =3D DEVICE(obj);
@@ -1059,8 +1062,9 @@ static void set_feature_group(Object *obj, Visitor *v=
, const char *name,
         return;
     }
=20
-    visit_type_bool(v, name, &value, errp);
-    if (*errp) {
+    visit_type_bool(v, name, &value, &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
     if (value) {
--=20
2.21.0


