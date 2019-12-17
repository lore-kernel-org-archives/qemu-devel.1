Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A19C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44CB206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="J5JVpA4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44CB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4n0-0005rq-Fq
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hu-0007y1-Hz
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hs-0005I0-Ui
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:38 -0500
Received: from ozlabs.org ([203.11.71.1]:50079)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4hs-0005CB-IV; Mon, 16 Dec 2019 23:43:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWP0gYRz9sS9; Tue, 17 Dec 2019 15:43:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557809;
 bh=kTPVeY0vCORU7ueoqjo8nwZLHGxRXqP2NzL13CPE7ns=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J5JVpA4V4LjkTSEk/4grQ+tcnmQyaFZH/yU8cO83cIWPmDu9As4IXhTqN8+R03WOG
 Y6JRi0okZekzJ8+hn3YxHRgt2/1kaoT9eV67Y0o7BxRiHFXw524Y1uOeMkifCVYwuW
 AaYgPYLQutx6S2vJp5IJi1vyq5U5I0VRa0aLoD+M=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 06/88] xive: Link "xive" property to XiveEndSource::xrtr pointer
Date: Tue, 17 Dec 2019 15:42:00 +1100
Message-Id: <20191217044322.351838-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The END source object has both a pointer and a "xive" property pointing t=
o
the router object. Confusing bugs could arise if these ever go out of syn=
c.

Change the property definition so that it explicitely sets the pointer.
The property isn't optional : not being able to set the link is a bug
and QEMU should rather abort than exit in this case.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157383333784.165747.5298512574054268786.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c   |  4 ++--
 hw/intc/spapr_xive.c |  4 ++--
 hw/intc/xive.c       | 13 +++----------
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 9e23dc705d..6aa7aeed6f 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1705,8 +1705,8 @@ static void pnv_xive_realize(DeviceState *dev, Erro=
r **errp)
=20
     object_property_set_int(OBJECT(end_xsrc), PNV_XIVE_NR_ENDS, "nr-ends=
",
                             &error_fatal);
-    object_property_add_const_link(OBJECT(end_xsrc), "xive", OBJECT(xive=
),
-                                   &error_fatal);
+    object_property_set_link(OBJECT(end_xsrc), OBJECT(xive), "xive",
+                             &error_abort);
     object_property_set_bool(OBJECT(end_xsrc), true, "realized", &local_=
err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 10890aeeeb..729246e906 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -290,8 +290,8 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
      */
     object_property_set_int(OBJECT(end_xsrc), xive->nr_irqs, "nr-ends",
                             &error_fatal);
-    object_property_add_const_link(OBJECT(end_xsrc), "xive", OBJECT(xive=
),
-                                   &error_fatal);
+    object_property_set_link(OBJECT(end_xsrc), OBJECT(xive), "xive",
+                             &error_abort);
     object_property_set_bool(OBJECT(end_xsrc), true, "realized", &local_=
err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 2eac15efa6..3d472e29c8 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1814,17 +1814,8 @@ static const MemoryRegionOps xive_end_source_ops =3D=
 {
 static void xive_end_source_realize(DeviceState *dev, Error **errp)
 {
     XiveENDSource *xsrc =3D XIVE_END_SOURCE(dev);
-    Object *obj;
-    Error *local_err =3D NULL;
-
-    obj =3D object_property_get_link(OBJECT(dev), "xive", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'xive' not found: ");
-        return;
-    }
=20
-    xsrc->xrtr =3D XIVE_ROUTER(obj);
+    assert(xsrc->xrtr);
=20
     if (!xsrc->nr_ends) {
         error_setg(errp, "Number of interrupt needs to be greater than 0=
");
@@ -1850,6 +1841,8 @@ static Property xive_end_source_properties[] =3D {
     DEFINE_PROP_UINT8("block-id", XiveENDSource, block_id, 0),
     DEFINE_PROP_UINT32("nr-ends", XiveENDSource, nr_ends, 0),
     DEFINE_PROP_UINT32("shift", XiveENDSource, esb_shift, XIVE_ESB_64K),
+    DEFINE_PROP_LINK("xive", XiveENDSource, xrtr, TYPE_XIVE_ROUTER,
+                     XiveRouter *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.23.0


