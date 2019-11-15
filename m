Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B62C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 22:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FB720733
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 22:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmRjAF0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FB720733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVkBo-0005bE-Vv
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 17:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iVk9d-0003iP-G3
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iVk9c-0000lL-A5
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32900
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iVk9c-0000l2-7E
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573857203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LE+/wVr4p6NjNVOjx41d0Zol9m8QWVM27Ffs17tDDwQ=;
 b=WmRjAF0kmkUQA3TpU0PFltacFzYrKVABm2NvgQIV6hhxSMnIs5fOUIcc/+xWJsshcx5nq3
 ydFG27qWZI17L0bj+2o/c9CcVrw5AguTmHY/y2uqi5HWJRVTwEkJm4748jDSD6x+Ihcd1Z
 xcgAw7rGLBxOs1lCjRmCYy/itL+vuus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-vUiUiVRXOlKjFWG3b1Zp3A-1; Fri, 15 Nov 2019 17:33:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ADA2107ACC4;
 Fri, 15 Nov 2019 22:33:19 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-194.ams2.redhat.com
 [10.36.116.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A192075E39;
 Fri, 15 Nov 2019 22:33:17 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] xive, xics: Fix reference counting on CPU objects
Date: Fri, 15 Nov 2019 23:33:08 +0100
Message-Id: <20191115223312.204979-3-lvivier@redhat.com>
In-Reply-To: <20191115223312.204979-1-lvivier@redhat.com>
References: <20191115223312.204979-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vUiUiVRXOlKjFWG3b1Zp3A-1
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
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


