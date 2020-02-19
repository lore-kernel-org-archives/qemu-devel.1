Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57330C34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 02:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216B9207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 02:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hBNG/2+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216B9207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4EzR-00069T-CW
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 21:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4Esc-0004A3-Me
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 21:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4Esa-00017z-S6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 21:14:26 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:53813)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4EsZ-00012U-1R; Tue, 18 Feb 2020 21:14:24 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48Mh9g0HfZz9sSV; Wed, 19 Feb 2020 13:14:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582078455;
 bh=+8n08mVffDMTcd5vOcig56fSB0Fl8e0bs0SvTi5PJhE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hBNG/2+AlGhaou+S6I5EV2Z+ItmMlFllMSvIC/hyrr6d24xtUItvRhoKiGnob3efe
 Uku8t/Jxl4MYFm5f/am0ruJV11vwTakP1qmU4gQ2IgdkgmyFi5oYGIE77XwJQeK/Ud
 I+a4kPxZVyuBNA07DFRyNRtAWcQidy4vV5rto6ew=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	clg@kaod.org,
	philmd@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v4 06/12] target/ppc: Remove RMOR register from POWER9 &
 POWER10
Date: Wed, 19 Feb 2020 13:14:03 +1100
Message-Id: <20200219021409.21332-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219021409.21332-1-david@gibson.dropbear.id.au>
References: <20200219021409.21332-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, paulus@samba.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently we create the Real Mode Offset Register (RMOR) on all Book3S cp=
us
from POWER7 onwards.  However the translation mode which the RMOR control=
s
is no longer supported in POWER9, and so the register has been removed fr=
om
the architecture.

Remove it from our model on POWER9 and POWER10.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/translate_init.inc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index ab79975fec..925bc31ca5 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8015,12 +8015,16 @@ static void gen_spr_book3s_ids(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
-    spr_register_hv(env, SPR_RMOR, "RMOR",
+    spr_register_hv(env, SPR_HRMOR, "HRMOR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
-    spr_register_hv(env, SPR_HRMOR, "HRMOR",
+}
+
+static void gen_spr_rmor(CPUPPCState *env)
+{
+    spr_register_hv(env, SPR_RMOR, "RMOR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
@@ -8535,6 +8539,7 @@ static void init_proc_POWER7(CPUPPCState *env)
=20
     /* POWER7 Specific Registers */
     gen_spr_book3s_ids(env);
+    gen_spr_rmor(env);
     gen_spr_amr(env);
     gen_spr_book3s_purr(env);
     gen_spr_power5p_common(env);
@@ -8676,6 +8681,7 @@ static void init_proc_POWER8(CPUPPCState *env)
=20
     /* POWER8 Specific Registers */
     gen_spr_book3s_ids(env);
+    gen_spr_rmor(env);
     gen_spr_amr(env);
     gen_spr_iamr(env);
     gen_spr_book3s_purr(env);
--=20
2.24.1


