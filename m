Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DBCC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763C820658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Szs+mtCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763C820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9L7-00056e-G2
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96c-0002an-BW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96a-0000k0-MR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:50 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:49853 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE96a-0006UO-7O; Tue, 17 Mar 2020 06:05:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTL26Nbsz9sTZ; Tue, 17 Mar 2020 21:04:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439482;
 bh=bQQmdDvTIGTYx9hToVqDanlWHhCaBUAPPuQxwhbV9d4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Szs+mtCHEuG7pJhOWVtyNcVeUiRz0W20aviFU8F21j9s/3iP6aPIMGNAaouPtlhIQ
 SccB+wE18iry5mn4V9a+UlrVXfm/lxWQJuwNK2FDzEBD9x8QJ8S3HlAtL6fJcohpj3
 u3cxIPnQdZ3T+akLA0ZDFZx112csMId2cn1188w0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 41/45] ppc/spapr: Allow FWNMI on TCG
Date: Tue, 17 Mar 2020 21:04:19 +1100
Message-Id: <20200317100423.622643-42-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

There should no longer be a reason to prevent TCG providing FWNMI.
System Reset interrupts are generated to the guest with nmi monitor
command and H_SIGNAL_SYS_RESET. Machine Checks can not be injected
currently, but this could be implemented with the mce monitor cmd
similarly to i386.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200316142613.121089-6-npiggin@gmail.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
[dwg: Re-enable FWNMI in qtests, since that now works]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c               | 5 +----
 tests/qtest/libqos/libqos-spapr.h | 3 +--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index f626d769a0..679ae7959f 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -516,10 +516,7 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr=
, uint8_t val,
         return; /* Disabled by default */
     }
=20
-    if (tcg_enabled()) {
-        warn_report("Firmware Assisted Non-Maskable Interrupts(FWNMI) no=
t "
-                    "supported in TCG");
-    } else if (kvm_enabled()) {
+    if (kvm_enabled()) {
         if (kvmppc_set_fwnmi() < 0) {
             error_setg(errp, "Firmware Assisted Non-Maskable Interrupts(=
FWNMI) "
                              "not supported by KVM");
diff --git a/tests/qtest/libqos/libqos-spapr.h b/tests/qtest/libqos/libqo=
s-spapr.h
index 16174dbada..49bd72d20b 100644
--- a/tests/qtest/libqos/libqos-spapr.h
+++ b/tests/qtest/libqos/libqos-spapr.h
@@ -12,7 +12,6 @@ void qtest_spapr_shutdown(QOSState *qs);
     "cap-cfpc=3Dbroken,"                           \
     "cap-sbbc=3Dbroken,"                           \
     "cap-ibs=3Dbroken,"                            \
-    "cap-ccf-assist=3Doff,"                        \
-    "cap-fwnmi=3Doff"
+    "cap-ccf-assist=3Doff,"
=20
 #endif
--=20
2.24.1


