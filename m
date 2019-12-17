Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEA8C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B24A20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BqKnVI2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B24A20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4vo-00020L-Bi
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ia-0000Li-KQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iZ-0005w8-D1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:20 -0500
Received: from ozlabs.org ([203.11.71.1]:54015)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4iZ-0005tU-1C; Mon, 16 Dec 2019 23:44:19 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWX35gKz9sSt; Tue, 17 Dec 2019 15:43:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557816;
 bh=F/pFA7MC0rZHFbacZZRgPrkJ9ewpdL3GjV0RoZQA0C0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BqKnVI2b5Fn1Dp09/40N9Xt6TaYQLY4o5qGsue9fTTYSSr7WVEgGR93zmBlKHGgJT
 WRmAx5ofDYx3u8ck2a0pD/owR1kapApgBMs/v9T/0a7v/QyVNqWZmwin/oo0B/DauF
 b72kSy362ZmmX4szv6NUwoTC66+yy18t2hbYLzlY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 34/88] ppc/xive: Introduce a XiveFabric interface
Date: Tue, 17 Dec 2019 15:42:28 +1100
Message-Id: <20191217044322.351838-35-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The XiveFabric QOM interface acts as the PowerBUS interface between
the interrupt controller and the system and should be implemented by
the QEMU machine. On HW, the XIVE sub-engine is responsible for the
communication with the other chip is the Common Queue (CQ) bridge
unit.

This interface offers a 'match_nvt' handler to perform the CAM line
matching when looking for a XIVE Presenter with a dispatched NVT.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-9-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c        | 10 ++++++++++
 include/hw/ppc/xive.h | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index da6196ca95..1c9e58f8de 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1893,8 +1893,18 @@ static const TypeInfo xive_presenter_info =3D {
     .class_size =3D sizeof(XivePresenterClass),
 };
=20
+/*
+ * XIVE Fabric
+ */
+static const TypeInfo xive_fabric_info =3D {
+    .name =3D TYPE_XIVE_FABRIC,
+    .parent =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(XiveFabricClass),
+};
+
 static void xive_register_types(void)
 {
+    type_register_static(&xive_fabric_info);
     type_register_static(&xive_source_info);
     type_register_static(&xive_notifier_info);
     type_register_static(&xive_presenter_info);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index f9aa0fa0da..b00af98877 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -399,6 +399,28 @@ int xive_presenter_tctx_match(XivePresenter *xptr, X=
iveTCTX *tctx,
                               uint8_t nvt_blk, uint32_t nvt_idx,
                               bool cam_ignore, uint32_t logic_serv);
=20
+/*
+ * XIVE Fabric (Interface between Interrupt Controller and Machine)
+ */
+
+typedef struct XiveFabric XiveFabric;
+
+#define TYPE_XIVE_FABRIC "xive-fabric"
+#define XIVE_FABRIC(obj)                                     \
+    INTERFACE_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
+#define XIVE_FABRIC_CLASS(klass)                                     \
+    OBJECT_CLASS_CHECK(XiveFabricClass, (klass), TYPE_XIVE_FABRIC)
+#define XIVE_FABRIC_GET_CLASS(obj)                                   \
+    OBJECT_GET_CLASS(XiveFabricClass, (obj), TYPE_XIVE_FABRIC)
+
+typedef struct XiveFabricClass {
+    InterfaceClass parent;
+    int (*match_nvt)(XiveFabric *xfb, uint8_t format,
+                     uint8_t nvt_blk, uint32_t nvt_idx,
+                     bool cam_ignore, uint8_t priority,
+                     uint32_t logic_serv, XiveTCTXMatch *match);
+} XiveFabricClass;
+
 /*
  * XIVE END ESBs
  */
--=20
2.23.0


