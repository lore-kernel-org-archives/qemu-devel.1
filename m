Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020AAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF93206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="aqB91Sz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF93206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglgq-0004O1-0u
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgleN-00082f-Mo
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:54:59 -0400
Received: from shirlock.uni-paderborn.de ([2001:638:502:c003::15]:42238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgleK-0002C9-Rh
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LeOIKBmV7pJPB6ZxWMDH3kkGiWOY3hkdwYkMyjOcSb4=; b=aqB91Sz+3nmNrcxYqCbHvbX7Oa
 bsuLjUo0dSnVwAWAajmaoyPBQBc+9mbN8D5MyTlwpq22iOs3qG3nnHACLFCOWVDxto1KsZG48vaDa
 7ko7zV58bit97DodvO9s+ebtDNVYBwC4NQd9N2otMpXSDj8gih8On5kDhvkS1izKbVIo=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/15] tests/tcg: Add TriCore tests
Date: Thu,  4 Jun 2020 10:54:26 +0200
Message-Id: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6898276, da=78869957,
 mc=171, sc=3, hc=168, sp=1, fso=6898276, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.4.84518, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.6.3.5740001
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::15;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=shirlock.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

I managed to update the series to successfully run make check-tcg. This required
some changes to the makefiles. I tried running the riscv64 and arm tests and so
far I didn't break anything.

You can find the full tree here:
https://github.com/bkoppelmann/qemu/tree/tricore-tcg-tests

Cheers,
Bastian

Bastian Koppelmann (15):
  docker/tricore: Use stretch-slim as a base image
  tests/tcg: Add docker_as and docker_ld cmds
  tests/tcg: Run timeout cmds using --foreground
  hw/tricore: Add testdevice for tests in tests/tcg/
  tests/tcg/tricore: Add build infrastructure
  tests/tcg/tricore: Add macros to create tests and first test 'abs'
  tests/tcg/tricore: Add bmerge test
  tests/tcg/tricore: Add clz test
  tests/tcg/tricore: Add dvstep test
  tests/tcg/tricore: Add fadd test
  tests/tcg/tricore: Add fmul test
  tests/tcg/tricore: Add ftoi test
  tests/tcg/tricore: Add madd test
  tests/tcg/tricore: Add msub test
  tests/tcg/tricore: Add muls test

 hw/tricore/Makefile.objs                      |   2 +-
 hw/tricore/tricore_testboard.c                |   8 ++
 hw/tricore/tricore_testdevice.c               |  82 +++++++++++
 include/hw/tricore/tricore_testdevice.h       |  38 ++++++
 .../dockerfiles/debian-tricore-cross.docker   |  16 ++-
 tests/tcg/Makefile.qemu                       |  11 ++
 tests/tcg/Makefile.target                     |   5 +-
 tests/tcg/configure.sh                        |   9 +-
 tests/tcg/tricore/Makefile.softmmu-target     |  28 ++++
 tests/tcg/tricore/link.ld                     |  60 ++++++++
 tests/tcg/tricore/macros.h                    | 129 ++++++++++++++++++
 tests/tcg/tricore/test_abs.S                  |   8 ++
 tests/tcg/tricore/test_bmerge.S               |   8 ++
 tests/tcg/tricore/test_clz.S                  |   9 ++
 tests/tcg/tricore/test_dvstep.S               |  15 ++
 tests/tcg/tricore/test_fadd.S                 |  16 +++
 tests/tcg/tricore/test_fmul.S                 |   8 ++
 tests/tcg/tricore/test_ftoi.S                 |  10 ++
 tests/tcg/tricore/test_madd.S                 |  11 ++
 tests/tcg/tricore/test_msub.S                 |   9 ++
 tests/tcg/tricore/test_muls.S                 |   9 ++
 21 files changed, 485 insertions(+), 6 deletions(-)
 create mode 100644 hw/tricore/tricore_testdevice.c
 create mode 100644 include/hw/tricore/tricore_testdevice.h
 create mode 100644 tests/tcg/tricore/Makefile.softmmu-target
 create mode 100644 tests/tcg/tricore/link.ld
 create mode 100644 tests/tcg/tricore/macros.h
 create mode 100644 tests/tcg/tricore/test_abs.S
 create mode 100644 tests/tcg/tricore/test_bmerge.S
 create mode 100644 tests/tcg/tricore/test_clz.S
 create mode 100644 tests/tcg/tricore/test_dvstep.S
 create mode 100644 tests/tcg/tricore/test_fadd.S
 create mode 100644 tests/tcg/tricore/test_fmul.S
 create mode 100644 tests/tcg/tricore/test_ftoi.S
 create mode 100644 tests/tcg/tricore/test_madd.S
 create mode 100644 tests/tcg/tricore/test_msub.S
 create mode 100644 tests/tcg/tricore/test_muls.S

-- 
2.26.2


