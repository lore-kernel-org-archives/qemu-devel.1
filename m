Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D815C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D392080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cYoQGpq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D392080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyV4A-0006hU-H5
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxP-0002Uf-R4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxO-0002cf-Hs
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:39 -0500
Received: from ozlabs.org ([203.11.71.1]:50805)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxO-0002XI-57; Mon, 03 Feb 2020 01:11:38 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBp2f9zz9sSW; Mon,  3 Feb 2020 17:11:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710290;
 bh=T5HcPQ8r1av4lIVQhAhCglYzvv+qvm2F5/heyqORLNc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cYoQGpq9NOtWRV12IE0lzEg2ag4eJW9qUeNeMbisWq214womXOOdvY/h5Y3U9VDze
 RO8nuhVC5rTdPYICftp7UqCH0fjtZtKAIRn0S3YknnuMmBDXPfQqUirxD2Yv4yfiq2
 0FD0pIZVOcSUJUUlOos7+rHyAf3Spwq7raMhts+c=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 14/35] spapr: Implement get_dt_compatible() callback
Date: Mon,  3 Feb 2020 17:11:02 +1100
Message-Id: <20200203061123.59150-15-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

For devices that cannot be statically initialized, implement a
get_dt_compatible() callback that allows us to ask the device for
the 'compatible' value.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20200121152935.649898-3-stefanb@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_vio.c         | 11 +++++++++--
 include/hw/ppc/spapr_vio.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index f14944e900..0b085eabe4 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -87,6 +87,7 @@ static int vio_make_devnode(SpaprVioDevice *dev,
     SpaprVioDeviceClass *pc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
     int vdevice_off, node_off, ret;
     char *dt_name;
+    const char *dt_compatible;
=20
     vdevice_off =3D fdt_path_offset(fdt, "/vdevice");
     if (vdevice_off < 0) {
@@ -113,9 +114,15 @@ static int vio_make_devnode(SpaprVioDevice *dev,
         }
     }
=20
-    if (pc->dt_compatible) {
+    if (pc->get_dt_compatible) {
+        dt_compatible =3D pc->get_dt_compatible(dev);
+    } else {
+        dt_compatible =3D pc->dt_compatible;
+    }
+
+    if (dt_compatible) {
         ret =3D fdt_setprop_string(fdt, node_off, "compatible",
-                                 pc->dt_compatible);
+                                 dt_compatible);
         if (ret < 0) {
             return ret;
         }
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index ce6d9b0c66..bed7df60e3 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -58,6 +58,7 @@ typedef struct SpaprVioDeviceClass {
     void (*realize)(SpaprVioDevice *dev, Error **errp);
     void (*reset)(SpaprVioDevice *dev);
     int (*devnode)(SpaprVioDevice *dev, void *fdt, int node_off);
+    const char *(*get_dt_compatible)(SpaprVioDevice *dev);
 } SpaprVioDeviceClass;
=20
 struct SpaprVioDevice {
--=20
2.24.1


