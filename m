Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3FDC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DAFC20730
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8HC60UY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAFC20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWegh-0003I6-S7
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 05:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iWef1-0001Uc-Sx
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iWef0-0004Q2-MT
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:53:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58077
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iWef0-0004Pk-IH
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574074414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pLrU9p2DhgfzE1DkGTpdrKbhTRnMgTbOYODJyOf3fEw=;
 b=K8HC60UYwuxTI7PEAqDt47hCc9TqeGPF4Cdf7VOBHNaAaLatWm5pIK7QzLJf+8rV0IUo42
 Hrrqmd4JvJcePZXdC8iic/IL+5TWxRf3Hx3xCFeHWFXNOznqEQaVPpoHEO1mJY9GFscXkd
 Jl7HUh3c+poAIlcwEmJM4yklX/EULt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-KMEOusV4Mh2lGGDBIrOphw-1; Mon, 18 Nov 2019 05:53:29 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70FF6801FD2;
 Mon, 18 Nov 2019 10:53:28 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-117-32.ams2.redhat.com [10.36.117.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AE5A60856;
 Mon, 18 Nov 2019 10:53:25 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 2/6] xive, xics: Fix reference counting on CPU objects
Date: Mon, 18 Nov 2019 11:53:15 +0100
Message-Id: <20191118105319.7658-3-lvivier@redhat.com>
In-Reply-To: <20191118105319.7658-1-lvivier@redhat.com>
References: <20191118105319.7658-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: KMEOusV4Mh2lGGDBIrOphw-1
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Greg Kurz <groug@kaod.org>,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

When a VCPU gets connected to the XIVE interrupt controller, we add a
const link targetting the CPU object to the TCTX object. Similar links
are added to the ICP object when using the XICS interrupt controller.

As explained in <qom/object.h>:

 * The caller must ensure that @target stays alive as long as
 * this property exists.  In the case @target is a child of @obj,
 * this will be the case.  Otherwise, the caller is responsible for
 * taking a reference.

We're in the latter case for both XICS and XIVE. Add the missing
calls to object_ref() and object_unref().

This doesn't fix any known issue because the life cycle of the TCTX or
ICP happens to be shorter than the one of the CPU or XICS fabric, but
better safe than sorry.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <157192724770.3146912.15400869269097231255.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/intc/xics.c | 8 +++++++-
 hw/intc/xive.c | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 935f325749cb..5f746079be46 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -388,8 +388,10 @@ Object *icp_create(Object *cpu, const char *type, XICS=
Fabric *xi, Error **errp)
     obj =3D object_new(type);
     object_property_add_child(cpu, type, obj, &error_abort);
     object_unref(obj);
+    object_ref(OBJECT(xi));
     object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
                                    &error_abort);
+    object_ref(cpu);
     object_property_add_const_link(obj, ICP_PROP_CPU, cpu, &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
@@ -403,7 +405,11 @@ Object *icp_create(Object *cpu, const char *type, XICS=
Fabric *xi, Error **errp)
=20
 void icp_destroy(ICPState *icp)
 {
-    object_unparent(OBJECT(icp));
+    Object *obj =3D OBJECT(icp);
+
+    object_unref(object_property_get_link(obj, ICP_PROP_CPU, &error_abort)=
);
+    object_unref(object_property_get_link(obj, ICP_PROP_XICS, &error_abort=
));
+    object_unparent(obj);
 }
=20
 /*
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 38257aa02083..952a461d5329 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -682,6 +682,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr,=
 Error **errp)
     obj =3D object_new(TYPE_XIVE_TCTX);
     object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
     object_unref(obj);
+    object_ref(cpu);
     object_property_add_const_link(obj, "cpu", cpu, &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
@@ -698,7 +699,10 @@ error:
=20
 void xive_tctx_destroy(XiveTCTX *tctx)
 {
-    object_unparent(OBJECT(tctx));
+    Object *obj =3D OBJECT(tctx);
+
+    object_unref(object_property_get_link(obj, "cpu", &error_abort));
+    object_unparent(obj);
 }
=20
 /*
--=20
2.23.0


