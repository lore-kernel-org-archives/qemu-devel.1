Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FCBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDA522265
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BywORgkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDA522265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3Ys-0005nE-EF
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3W6-00041w-UD
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3W5-0007yS-3Z
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603722632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PHSViV4CrJ9nOE22U0e98lr4oVkk3f599fkGrP5C6qE=;
 b=BywORgkGzWi8AqWKuiK+LENQuVg+5d0SwXusu0lXq6YVZLEwtQgtmN3hgmtxruKxBlEzvy
 7XMnwugKghQMq78Ht9ux8jjCa+Khfc6qpKy+eJt6ur5zw3lZJkhK4lCbm+vubVrpvKIbC8
 Bet+2WguX9QZAhHXBu/QlRgslawA59Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-U57hmB7kOXy1EqaatoZyaw-1; Mon, 26 Oct 2020 10:30:30 -0400
X-MC-Unique: U57hmB7kOXy1EqaatoZyaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83BEA18C9F42
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 14:30:29 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40DCC1002391;
 Mon, 26 Oct 2020 14:30:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/15] remove bios_name variable
Date: Mon, 26 Oct 2020 10:30:13 -0400
Message-Id: <20201026143028.3034018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bios_name variable is mostly a duplicate of machine->firmware.
Only three cases need some care (i386, digic and rx), everything else
is mechanical.

Paolo Bonzini (15):
  alpha: remove bios_name
  digic: stash firmware into DigicState
  arm: remove bios_name
  hppa: remove bios_name
  i386: remove bios_name
  lm32: remove bios_name
  m68k: remove bios_name
  mips: remove bios_name
  moxie: remove bios_name
  ppc: remove bios_name
  rx: move BIOS load from MCU to board
  s390: remove bios_name
  sh4: remove bios_name
  sparc: remove bios_name
  vl: remove bios_name

 hw/alpha/dp264.c           |  2 +-
 hw/arm/cubieboard.c        |  2 +-
 hw/arm/digic_boards.c      |  5 +++--
 hw/arm/highbank.c          |  8 ++++----
 hw/arm/npcm7xx_boards.c    |  5 +----
 hw/arm/orangepi.c          |  2 +-
 hw/arm/sbsa-ref.c          |  2 ++
 hw/arm/vexpress.c          |  8 ++++----
 hw/arm/virt.c              |  2 ++
 hw/hppa/machine.c          |  3 +--
 hw/i386/microvm.c          |  7 +++----
 hw/i386/pc_sysfw.c         |  4 ++--
 hw/i386/x86.c              | 10 ++++------
 hw/lm32/milkymist.c        |  4 +---
 hw/m68k/mcf5208.c          | 10 +++++-----
 hw/m68k/next-cube.c        |  4 +---
 hw/m68k/q800.c             |  4 +---
 hw/mips/fuloong2e.c        |  6 +++---
 hw/mips/jazz.c             |  6 +++---
 hw/mips/malta.c            |  6 +++---
 hw/mips/mipssim.c          |  6 +++---
 hw/mips/r4k.c              |  4 +---
 hw/moxie/moxiesim.c        |  6 +++---
 hw/ppc/e500.c              |  4 ++--
 hw/ppc/mac_newworld.c      |  4 +---
 hw/ppc/mac_oldworld.c      |  4 +---
 hw/ppc/pnv.c               |  5 +----
 hw/ppc/ppc405_boards.c     |  6 ++----
 hw/ppc/prep.c              |  4 +---
 hw/ppc/spapr.c             |  4 +---
 hw/rx/rx-gdbsim.c          |  7 +++++++
 hw/rx/rx62n.c              |  9 ---------
 hw/s390x/ipl.c             |  8 ++------
 hw/s390x/s390-virtio-ccw.c |  3 ++-
 hw/sh4/shix.c              |  3 +--
 hw/sparc/leon3.c           |  4 +---
 hw/sparc/sun4m.c           |  2 +-
 hw/sparc64/sun4u.c         |  2 +-
 include/hw/arm/digic.h     |  1 +
 include/hw/i386/x86.h      |  3 ++-
 include/sysemu/sysemu.h    |  1 -
 softmmu/vl.c               |  2 --
 42 files changed, 80 insertions(+), 112 deletions(-)

-- 
2.26.2


