Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FF3C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0031D21848
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bkJ07THd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0031D21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIF8b-0002ng-J3
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59C-0001XO-04
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iI59A-0006UN-Cs
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:08:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51559 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iI599-0006PG-DG; Wed, 09 Oct 2019 02:08:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46p3gD0r2pz9sDB; Wed,  9 Oct 2019 17:08:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570601304;
 bh=5KV84r29nIJXr/A9Jl+oWqntFxHPYStDWAbStjFb6C0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bkJ07THdIuVgBT3JyE3rvy4J2z1bS07D2dYYlF0NuI76gF2qBT2Ie8VRgRgCqxNKc
 SlNPgz8YrpCJHkSmMGaJMQE0LNpHgpb+cT5vp0JegZ4DM7j3W2YOsjKecfhNeVOy8g
 iC6YmQCxd5+TuIjEDa2ka0DR3HbuePfnXdMJAI3s=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	clg@kaod.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v4 01/19] xive: Make some device types not user creatable
Date: Wed,  9 Oct 2019 17:08:00 +1100
Message-Id: <20191009060818.29719-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009060818.29719-1-david@gibson.dropbear.id.au>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Some device types of the XIVE model are exposed to the QEMU command
line:

$ ppc64-softmmu/qemu-system-ppc64 -device help | grep xive
name "xive-end-source", desc "XIVE END Source"
name "xive-source", desc "XIVE Interrupt Source"
name "xive-tctx", desc "XIVE Interrupt Thread Context"

These are internal devices that shouldn't be instantiable by the
user. By the way, they can't be because their respective realize
functions expect link properties that can't be set from the command
line:

qemu-system-ppc64: -device xive-source: required link 'xive' not found:
 Property '.xive' not found
qemu-system-ppc64: -device xive-end-source: required link 'xive' not foun=
d:
 Property '.xive' not found
qemu-system-ppc64: -device xive-tctx: required link 'cpu' not found:
 Property '.cpu' not found

Hide them by setting dc->user_creatable to false in their respective
class init functions.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157017473006.331610.2983143972519884544.stgit@bahia.lan>
Message-Id: <157045578401.865784.6058183726552779559.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
[dwg: Folded comment update into base patch]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 29df06df11..453d389848 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -670,6 +670,11 @@ static void xive_tctx_class_init(ObjectClass *klass,=
 void *data)
     dc->realize =3D xive_tctx_realize;
     dc->unrealize =3D xive_tctx_unrealize;
     dc->vmsd =3D &vmstate_xive_tctx;
+    /*
+     * Reason: part of XIVE interrupt controller, needs to be wired up
+     * by xive_tctx_create().
+     */
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo xive_tctx_info =3D {
@@ -1118,6 +1123,11 @@ static void xive_source_class_init(ObjectClass *kl=
ass, void *data)
     dc->props   =3D xive_source_properties;
     dc->realize =3D xive_source_realize;
     dc->vmsd    =3D &vmstate_xive_source;
+    /*
+     * Reason: part of XIVE interrupt controller, needs to be wired up,
+     * e.g. by spapr_xive_instance_init().
+     */
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo xive_source_info =3D {
@@ -1853,6 +1863,11 @@ static void xive_end_source_class_init(ObjectClass=
 *klass, void *data)
     dc->desc    =3D "XIVE END Source";
     dc->props   =3D xive_end_source_properties;
     dc->realize =3D xive_end_source_realize;
+    /*
+     * Reason: part of XIVE interrupt controller, needs to be wired up,
+     * e.g. by spapr_xive_instance_init().
+     */
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo xive_end_source_info =3D {
--=20
2.21.0


