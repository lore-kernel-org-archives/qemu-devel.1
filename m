Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA67C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3467F2073C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SE4VSPAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3467F2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib8k6-00058y-Ks
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 14:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ib8du-0006Ug-LI
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ib8ds-0005BO-PU
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ib8dq-000572-QQ
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575142973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRKNw1DGxjyDjzaLKcSU2qGKWJyyolVCSyH6uayqbcM=;
 b=SE4VSPALqjk1leivEw7G6OuZwKCx5c3HEUZwYYvaZAvfqbxk4sbEUafQU3mCjHeMiFL1Ix
 aeJ3GKnSyyVpAatmKMfIRewsocFWoeoxxPChFdnm6m2m+AL7qZsDK2P9kMWYxEy/o7LU/g
 RmZacnCtuagHZDJPVCPZbPj1OKoZp6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-eB47qqh7M8uHcTaxg42vVQ-1; Sat, 30 Nov 2019 14:42:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A914800D4E;
 Sat, 30 Nov 2019 19:42:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFAEA5D9E1;
 Sat, 30 Nov 2019 19:42:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2675D11366F1; Sat, 30 Nov 2019 20:42:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/21] hw/core: Fix latent fit_load_fdt() error handling bug
Date: Sat, 30 Nov 2019 20:42:29 +0100
Message-Id: <20191130194240.10517-11-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-1-armbru@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: eB47qqh7M8uHcTaxg42vVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fit_load_fdt() recovers from fit_image_addr() failing with ENOENT.
Except it doesn't when its @errp argument is &error_fatal or
&error_abort, because it blindly passes @errp to fit_image_addr().
Messed up in commit 3eb99edb48 "loader-fit: Wean off error_printf()".

The bug can't bite as no caller actually passes &error_fatal or
&error_abort.  Fix it anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/loader-fit.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 953b16bc82..c465921b8f 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -178,11 +178,12 @@ static int fit_load_fdt(const struct fit_loader *ldr,=
 const void *itb,
                         int cfg, void *opaque, const void *match_data,
                         hwaddr kernel_end, Error **errp)
 {
+    Error *err =3D NULL;
     const char *name;
     const void *data;
     const void *load_data;
     hwaddr load_addr;
-    int img_off, err;
+    int img_off;
     size_t sz;
     int ret;
=20
@@ -197,13 +198,13 @@ static int fit_load_fdt(const struct fit_loader *ldr,=
 const void *itb,
         return -EINVAL;
     }
=20
-    err =3D fit_image_addr(itb, img_off, "load", &load_addr, errp);
-    if (err =3D=3D -ENOENT) {
+    ret =3D fit_image_addr(itb, img_off, "load", &load_addr, &err);
+    if (ret =3D=3D -ENOENT) {
         load_addr =3D ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
-        error_free(*errp);
-    } else if (err) {
-        error_prepend(errp, "unable to read FDT load address from FIT: ");
-        ret =3D err;
+        error_free(err);
+    } else if (ret) {
+        error_propagate_prepend(errp, err,
+                                "unable to read FDT load address from FIT:=
 ");
         goto out;
     }
=20
--=20
2.21.0


