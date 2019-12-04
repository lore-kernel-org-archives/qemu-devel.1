Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5D5C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1748E20661
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 10:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPNoEvEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1748E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icRz2-0003b7-7X
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 05:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icR5T-0007DC-NM
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icR5I-0000MB-Hk
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56174
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icR5H-0008RY-8E
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575452190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qt7qBgRXYhoBRK/lPeVpvCp1AuGz4zh1UbVQfAOPcQ0=;
 b=FPNoEvEINRbcugiawStgrMnyaTfM642xzzc03DtKq4JfIP38pEI7w8c3IxNdfXs7CYyQhS
 KdHQMw9uQxisoY9gcTDOwKDJZSCV5tDsl3K7HJlHL2yb3Mi1ufFFfw28IQVaigkxrk+oCo
 G2MMAddOib/w0jHpusIt/6C2+Rcs0XM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-x70HgSxxMCC-9t5ZNuCpoA-1; Wed, 04 Dec 2019 04:36:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A367B100550E
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 09:36:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73A2A5D6B7
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 09:36:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 98B5311366DF; Wed,  4 Dec 2019 10:36:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/18] hw/core: Fix fit_load_fdt() error handling violations
Date: Wed,  4 Dec 2019 10:36:14 +0100
Message-Id: <20191204093625.14836-8-armbru@redhat.com>
In-Reply-To: <20191204093625.14836-1-armbru@redhat.com>
References: <20191204093625.14836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: x70HgSxxMCC-9t5ZNuCpoA-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fit_load_fdt() passes @errp to fit_image_addr(), then recovers from
ENOENT failures.  Passing @errp is wrong, because it works only as
long as @errp is neither @error_fatal nor @error_abort.  Messed up in
commit 3eb99edb48 "loader-fit: Wean off error_printf()".

No caller actually passes such values.

Fix anyway: splice in a local Error *err, and error_propagate().

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


