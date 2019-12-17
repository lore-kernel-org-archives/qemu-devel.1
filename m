Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A743DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7078121739
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1fACMkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7078121739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6O5-0006Di-D2
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6Jx-0000iP-LD
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6Jw-0000xT-1x
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40450
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6Jv-0000tn-UE
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KaXK1sLPfIPPUrPRoQaoOCLoMDQhgCjGoky0wIOIPBk=;
 b=b1fACMkvt7ZKjeBsKIEot6kyqhR1g0b9WS8VPTqZ0MXk8nciiZB1Ga4UisB7lXNB5EOzP+
 xm8/DGyDY0cPOjyRu9vwht7SGOV2nSrPx7hlw0kiprA//7tI5khN/H9++p4WH0nNt+dCR+
 M46ZVqq+xVW5xPINF6wptM1zNpM8ipo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-rCva-4vPMM--5Qv_67EZbg-1; Tue, 17 Dec 2019 01:26:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 050BD800D4E;
 Tue, 17 Dec 2019 06:26:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D0E55C1D6;
 Tue, 17 Dec 2019 06:26:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5EB0011385D5; Tue, 17 Dec 2019 07:26:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/34] hw/core: Fix fit_load_fdt() error API violations
Date: Tue, 17 Dec 2019 07:26:25 +0100
Message-Id: <20191217062651.9687-9-armbru@redhat.com>
In-Reply-To: <20191217062651.9687-1-armbru@redhat.com>
References: <20191217062651.9687-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: rCva-4vPMM--5Qv_67EZbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fit_load_fdt() passes @errp to fit_image_addr(), then recovers from
ENOENT failures.  Passing @errp is wrong, because it works only as
long as @errp is neither @error_fatal nor @error_abort.  Error
recovery dereferences @errp.  That's also wrong; see the big comment
in error.h.  Error recovery can leave *errp pointing to a freed
Error object.  Wrong, it must be null on success.  Messed up in
commit 3eb99edb48 "loader-fit: Wean off error_printf()".

No caller actually passes such values, or uses *errp on success.

Fix anyway: splice in a local Error *err, and error_propagate().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191204093625.14836-8-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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


