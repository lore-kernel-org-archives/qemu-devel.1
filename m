Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D281C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE4A206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="huCZKcX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE4A206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39885 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJu2Z-00077P-4z
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:08:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0T-0005Mv-8W
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0S-0004G3-8K
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:45 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:58051 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0R-00045S-6M; Fri, 26 Apr 2019 02:06:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tj5SW7z9s9G; Fri, 26 Apr 2019 16:06:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258793;
	bh=fVSArwuHjDtfx9MjMlmUyGKpSfM86wL2ccdo3lroxmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huCZKcX5NvggzgCXgs6d8MW8n3fpWRfj/tuctVDRI3Kwwogrc7GkjocRWDxddzx35
	hmSTxf5NxFDA8k3r4TeyjrmAR2XdAsbgu9he+sM56krGbfp3hB6ACfDcvMIY77O4dW
	eeqzf0Ds6e/GnhOY43073oLaNw6bEumDRbWeyIf8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:05:54 +1000
Message-Id: <20190426060627.18153-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 03/36] spapr/rtas: modify spapr_rtas_register()
 to remove RTAS handlers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: gkurz@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
	qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060554.MdoqBjX-cuZRFCan6aHf2QW-UgbSK0iIy_rLzI3DAlU@z>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Removing RTAS handlers will become necessary when the new pseries
machine supporting multiple interrupt mode is introduced.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190321144914.19934-9-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_rtas.c    | 2 +-
 include/hw/ppc/spapr.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 24c45b12d4..ee24212765 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -404,7 +404,7 @@ void spapr_rtas_register(int token, const char *name,=
 spapr_rtas_fn fn)
=20
     token -=3D RTAS_TOKEN_BASE;
=20
-    assert(!rtas_table[token].name);
+    assert(!name || !rtas_table[token].name);
=20
     rtas_table[token].name =3D name;
     rtas_table[token].fn =3D fn;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 02b5ce7e40..9331f5e0b9 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -675,6 +675,10 @@ typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, Spapr=
MachineState *sm,
                               uint32_t nargs, target_ulong args,
                               uint32_t nret, target_ulong rets);
 void spapr_rtas_register(int token, const char *name, spapr_rtas_fn fn);
+static inline void spapr_rtas_unregister(int token)
+{
+    spapr_rtas_register(token, NULL, NULL);
+}
 target_ulong spapr_rtas_call(PowerPCCPU *cpu, SpaprMachineState *sm,
                              uint32_t token, uint32_t nargs, target_ulon=
g args,
                              uint32_t nret, target_ulong rets);
--=20
2.20.1


