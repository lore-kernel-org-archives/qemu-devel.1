Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA98CC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 22:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5A420733
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 22:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gmz3lTv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5A420733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVkC2-000602-C5
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 17:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iVk9f-0003lz-Jx
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iVk9e-0000mk-Io
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iVk9e-0000mJ-Fb
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573857205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpRt2bKJHxs5WpBFBkL7lknNLi+Y8CrPC3LLiBRxjdw=;
 b=Gmz3lTv89/hkTsHKjI4c/t9wLcPOgTt4LEPandzmswyQwpYUJWb2q4Lk7zph+kICbHxgTC
 kbXJIOM21+40zrKLQh+9RWWwJjag92m0U+E9g4sw0kG0yp74jdrtGuxkzYUYwEaglXRVZc
 UnySxHiEyneQZaTldTp4PEcb4vCtUoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-GAOzM_JNM8aSMLwCrfx42w-1; Fri, 15 Nov 2019 17:33:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D7B41883523;
 Fri, 15 Nov 2019 22:33:21 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-194.ams2.redhat.com
 [10.36.116.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8218375E39;
 Fri, 15 Nov 2019 22:33:19 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] ppc: Skip partially initialized vCPUs in 'info pic'
Date: Fri, 15 Nov 2019 23:33:09 +0100
Message-Id: <20191115223312.204979-4-lvivier@redhat.com>
In-Reply-To: <20191115223312.204979-1-lvivier@redhat.com>
References: <20191115223312.204979-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: GAOzM_JNM8aSMLwCrfx42w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

CPU_FOREACH() can race with vCPU hotplug/unplug on sPAPR machines, ie.
we may try to print out info about a vCPU with a NULL presenter pointer.

Check that in order to prevent QEMU from crashing.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157192725327.3146912.12047076483178652551.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 11 ++++++++++-
 hw/intc/xive.c | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 5f746079be46..e7ac9ba618fa 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -44,7 +44,16 @@
=20
 void icp_pic_print_info(ICPState *icp, Monitor *mon)
 {
-    int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
+    int cpu_index;
+
+    /* Skip partially initialized vCPUs. This can happen on sPAPR when vCP=
Us
+     * are hot plugged or unplugged.
+     */
+    if (!icp) {
+        return;
+    }
+
+    cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
=20
     if (!icp->output) {
         return;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 952a461d5329..75dce82fb205 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -523,9 +523,18 @@ static const char * const xive_tctx_ring_names[] =3D {
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
 {
-    int cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
+    int cpu_index;
     int i;
=20
+    /* Skip partially initialized vCPUs. This can happen on sPAPR when vCP=
Us
+     * are hot plugged or unplugged.
+     */
+    if (!tctx) {
+        return;
+    }
+
+    cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
+
     if (kvm_irqchip_in_kernel()) {
         Error *local_err =3D NULL;
=20
--=20
2.23.0


