Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2B8C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30CA20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cVdESdZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30CA20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Cr-0006E0-4u
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95l-00016e-AL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95h-0002nU-Va
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:57 -0400
Received: from ozlabs.org ([203.11.71.1]:50711)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95h-0001uL-Fi; Tue, 17 Mar 2020 06:04:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKw3gKlz9sSl; Tue, 17 Mar 2020 21:04:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439476;
 bh=SsCee0AU6qi7MD8E+l9wYYZMteadeXr2Ro4UYhkZybg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cVdESdZiVhMaOex1W6+cWmVUxiuqvRJDIProzIK7sV7kH8WvvdmknSStKKfnB3TYH
 p3iynBeJ6riX50Zt0+XM2MbIILL92jICv0qtNRpR5An8uU0z7fYGHeIKoziKpSkvXJ
 lQYFcMzs4jYFN5C73HNmqHt2EPRQM/CZYeirozzM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 14/45] target/ppc: Correct RMLS table
Date: Tue, 17 Mar 2020 21:03:52 +1100
Message-Id: <20200317100423.622643-15-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The table of RMA limits based on the LPCR[RMLS] field is slightly wrong.
We're missing the RMLS =3D=3D 0 =3D> 256 GiB RMA option, which is availab=
le on
POWER8, so add that.

The comment that goes with the table is much more wrong.  We *don't* filt=
er
invalid RMLS values when writing the LPCR, and there's not really a
sensible way to do so.  Furthermore, while in theory the set of RMLS valu=
es
is implementation dependent, it seems in practice the same set has been
available since around POWER4+ up until POWER8, the last model which
supports RMLS at all.  So, correct that as well.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mmu-hash64.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 934989e6d9..fcccaabb88 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -762,15 +762,16 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
 {
     CPUPPCState *env =3D &cpu->env;
     /*
-     * This is the full 4 bits encoding of POWER8. Previous
-     * CPUs only support a subset of these but the filtering
-     * is done when writing LPCR.
+     * In theory the meanings of RMLS values are implementation
+     * dependent.  In practice, this seems to have been the set from
+     * POWER4+..POWER8, and RMLS is no longer supported in POWER9.
      *
      * Unsupported values mean the OS has shot itself in the
      * foot. Return a 0-sized RMA in this case, which we expect
      * to trigger an immediate DSI or ISI
      */
     static const target_ulong rma_sizes[16] =3D {
+        [0] =3D 256 * GiB,
         [1] =3D 16 * GiB,
         [2] =3D 1 * GiB,
         [3] =3D 64 * MiB,
--=20
2.24.1


