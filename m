Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945FDC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFCB20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pp3QAFPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFCB20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5cN-0006li-CQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4k9-0002MD-G8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4k6-00082c-1m
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:55 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52743 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4k2-0007V9-3s; Mon, 16 Dec 2019 23:45:53 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWg2mZKz9sTS; Tue, 17 Dec 2019 15:43:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557823;
 bh=5/a5TMrvK4EzeFh6JE4d9uQG/td8uvROAlRqOMDCQng=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pp3QAFPf4XCm3gCh3bHQR27GX9dZJPZt/k2mZ5ohGxI6JSZYnkOxB7SyrTZQSddI8
 aJm4p2oXplpdp4uNxYXWvxSBOe27bCJkqdtdxqqyKa5pfTkLdWSrdhn8/c8mZYPX8y
 GXri7XvK9GU4oQtxelFbqcn8KCcY+2Tc0hPgd6fk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 68/88] target/ppc: Add SPR ASDR
Date: Tue, 17 Dec 2019 15:43:02 +1100
Message-Id: <20191217044322.351838-69-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The Access Segment Descriptor Register (ASDR) provides information about
the storage element when taking a hypervisor storage interrupt. When
performing nested radix address translation, this is normally the guest
real address. This register is present on POWER9 processors and later.

Implement the ADSR, note read and write access is limited to the
hypervisor.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191128134700.16091-4-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h                | 1 +
 target/ppc/translate_init.inc.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index da44cc8809..e99850c3ae 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1778,6 +1778,7 @@ typedef PowerPCCPU ArchCPU;
 #define SPR_MPC_MD_DBRAM1     (0x32A)
 #define SPR_RCPU_L2U_RA3      (0x32B)
 #define SPR_TAR               (0x32F)
+#define SPR_ASDR              (0x330)
 #define SPR_IC                (0x350)
 #define SPR_VTB               (0x351)
 #define SPR_MMCRC             (0x353)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index c5e4d45569..c850a9d065 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8295,6 +8295,12 @@ static void gen_spr_power9_mmu(CPUPPCState *env)
                         SPR_NOACCESS, SPR_NOACCESS,
                         &spr_read_generic, &spr_write_ptcr,
                         KVM_REG_PPC_PTCR, 0x00000000);
+    /* Address Segment Descriptor Register */
+    spr_register_hv(env, SPR_ASDR, "ASDR",
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    &spr_read_generic, &spr_write_generic,
+                    0x0000000000000000);
 #endif
 }
=20
--=20
2.23.0


