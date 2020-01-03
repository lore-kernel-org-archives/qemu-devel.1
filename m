Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EA8C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE752084D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nBm929Bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE752084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inGeJ-0006s3-TI
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 01:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1inGcH-00056s-DG
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1inGcF-0000Jl-Fa
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:39:24 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:40321 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1inGcE-00007j-9m; Fri, 03 Jan 2020 01:39:22 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47pwH82DYFz9sR0; Fri,  3 Jan 2020 17:39:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578033556;
 bh=KnDd/bGGexvHpiw+9M2GlBohx9YVWH4iDq7+dtggNVo=;
 h=From:To:Cc:Subject:Date:From;
 b=nBm929Bi//7maq2qo/6aMcKbdOeGZZEeRfyMBfsp+y4w4WtKtxX1jigFUOxztwkJ0
 R18XakqBI4la3f6VriHY3h/rf2Dm9DIIkWPK4bT2Zs76w0/FtVhlcyxpBz7ttVFWqW
 fLwR+DXASkk7fTAoA5Nlu1U8Hwv2FpRv8b4zhHSk=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org,
	philmd@redhat.com,
	clg@kaod.org,
	groug@kaod.org
Subject: [RFC 0/4] target/ppc: Correct some errors with real mode handling
Date: Fri,  3 Jan 2020 17:39:07 +1100
Message-Id: <20200103063911.180977-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
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
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, paulus@samba.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

POWER "book S" (server class) cpus have a concept of "real mode" where
MMU translation is disabled... sort of.  In fact this can mean a bunch
of slightly different things when hypervisor mode and other
considerations are present.

We had some errors in edge cases here, so clean some things up and
correct them.

David Gibson (4):
  ppc: Drop PPC_EMULATE_32BITS_HYPV stub
  ppc: Remove stub of PPC970 HID4 implementation
  target/ppc: Correct handling of real mode accesses with vhyp on hash
    MMU
  target/ppc: Introduce ppc_hash64_use_vrma() helper

 target/ppc/cpu.h                |   7 --
 target/ppc/mmu-hash64.c         | 125 ++++++++++++++------------------
 target/ppc/translate_init.inc.c |  17 ++---
 3 files changed, 59 insertions(+), 90 deletions(-)

--=20
2.24.1


