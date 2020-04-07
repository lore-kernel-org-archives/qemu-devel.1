Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B99C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCD320748
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cmFL7lc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCD320748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLfzP-0001D7-Au
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 00:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyK-0007xs-DF
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyJ-0004Aq-EG
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:24 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:48261)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jLfyH-00045Q-QU; Tue, 07 Apr 2020 00:36:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xF3K0Dqfz9sR4; Tue,  7 Apr 2020 14:36:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586234173;
 bh=hHIGRjoFYCwEG4FYc0AkcpQkI4ODTreh/O1iHm8vwyg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cmFL7lc1mD/Ev/HAAS8Te0JtMPNiB4gyeL05NMdvX8DMYMmLXQwtfFmpCKXqaUXJ7
 Q7rS24JdyHnETg3XLJxYIm8bEotBhCU+CDo8eiPnDPegp1QTkQvrrJzoVXDoSzh/zR
 SvS/yuqOPfBCD7rWs0F+4zfcxdmxF6tYFqQPAH+A=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 01/10] hw/ppc/e500.c: Handle qemu_find_file() failure
Date: Tue,  7 Apr 2020 14:35:57 +1000
Message-Id: <20200407043606.291546-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200407043606.291546-1-david@gibson.dropbear.id.au>
References: <20200407043606.291546-1-david@gibson.dropbear.id.au>
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

If qemu_find_file() doesn't find the BIOS it returns NULL; we were
passing that unchecked through to load_elf(), which assumes a non-NULL
pointer and may misbehave. In practice it fails with a weird message:

  $ qemu-system-ppc -M ppce500 -display none -kernel nonesuch
  Bad address
  qemu-system-ppc: could not load firmware '(null)'

Handle the failure case better:

  $ qemu-system-ppc -M ppce500 -display none -kernel nonesuch
  qemu-system-ppc: could not find firmware/kernel file 'nonesuch'

Spotted by Coverity (CID 1238954).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200324121216.23899-1-peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/e500.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 854cd3ac46..0d1f41197c 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1047,6 +1047,10 @@ void ppce500_init(MachineState *machine)
     }
=20
     filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
+    if (!filename) {
+        error_report("could not find firmware/kernel file '%s'", payload=
_name);
+        exit(1);
+    }
=20
     payload_size =3D load_elf(filename, NULL, NULL, NULL,
                             &bios_entry, &loadaddr, NULL, NULL,
--=20
2.25.2


