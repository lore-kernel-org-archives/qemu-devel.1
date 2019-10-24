Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2883C47E49
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFF02166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ONI4c/XU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFF02166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYV4-0000xu-5r
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKW-0004qU-1O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKU-0005Dm-Dq
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:47 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50725 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKU-00056l-0L; Thu, 24 Oct 2019 04:18:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrZ59Qbz9sRp; Thu, 24 Oct 2019 19:18:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905118;
 bh=zjFNkfEC2lqwHnFh4a9YRFMi7iKEynZsNvxFNHQaBOs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ONI4c/XUmavxAY3xRrSDWq2rDSawT1GWPe/scy1UrIFGLdpna+XZDZ1aTd3zBxMit
 fMVKmKoOHlobjkarh17I83ZN1nihyw3S1vdmOpaSftd0JONAt9pfgRbBUozg/6rWXB
 UQDJaD0sGMiKnX0dGN/vWumKGpUA9mvP0/8BFYmU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 21/28] spapr: Don't request to unplug the same core twice
Date: Thu, 24 Oct 2019 19:18:06 +1100
Message-Id: <20191024081813.2115-22-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024081813.2115-1-david@gibson.dropbear.id.au>
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

We must not call spapr_drc_detach() on a detached DRC otherwise bad thing=
s
can happen, ie. QEMU hangs or crashes. This is easily demonstrated with
a CPU hotplug/unplug loop using QMP.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157185826035.3073024.1664101000438499392.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f9410d390a..94f9d27096 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3741,9 +3741,10 @@ void spapr_core_unplug_request(HotplugHandler *hot=
plug_dev, DeviceState *dev,
                           spapr_vcpu_id(spapr, cc->core_id));
     g_assert(drc);
=20
-    spapr_drc_detach(drc);
-
-    spapr_hotplug_req_remove_by_index(drc);
+    if (!spapr_drc_unplug_requested(drc)) {
+        spapr_drc_detach(drc);
+        spapr_hotplug_req_remove_by_index(drc);
+    }
 }
=20
 int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
--=20
2.21.0


