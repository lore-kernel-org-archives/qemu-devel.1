Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BECCA9EAD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 22:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA64A21928
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 22:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMwH+yYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA64A21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMKAW-0008JK-D5
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 18:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMK8d-0006iu-GW
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMK8a-0000H6-NX
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:57:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMK8a-0000GA-CY
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 18:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571612243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Llb/8OALtJXI9mwJaYEIRinlAzAxVy4qKKagrFZsSKA=;
 b=ZMwH+yYJK9txjBS4rvSgxW6FUYM3YDIpGlkSwJLca7/08eg5wrdkgepiaeHxXUVe9F3XL1
 L+5t38RgiYc1XneEe7kx5/e0xtDZNzgsNGMt6wNgmHnlsq8CafXKu+PULAupb561c79N2u
 si+PZybUV/BXgHKQzS6tFuGxoDbgeao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-Xgkgy1oBMsa9BZnuFG_tHA-1; Sun, 20 Oct 2019 18:57:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E710C80183E;
 Sun, 20 Oct 2019 22:57:14 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-40.brq.redhat.com [10.40.204.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4214D60C18;
 Sun, 20 Oct 2019 22:56:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 00/21] hw: Let the machine be the owner of the system memory
Date: Mon, 21 Oct 2019 00:56:29 +0200
Message-Id: <20191020225650.3671-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Xgkgy1oBMsa9BZnuFG_tHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series is based on Igor's "eliminate remaining places that
abuse memory_region_allocate_system_memory()":
https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01601.html

It is quite simple, we enforce all machines to be the QOM owner
of the system memory.

This changes the memory tree from:

  (qemu) info mtree -o
  memory-region: pc.ram
    0000000000000000-0000000007ffffff (prio 0, ram): pc.ram parent:{obj pat=
h=3D/machine/unattached}

to:

  (qemu) info mtree -o
  memory-region: pc.ram
    0000000000000000-0000000007ffffff (prio 0, ram): pc.ram owner:{obj path=
=3D/machine}

Few patches are required to clean the codebase first, to unify the
creation of the system memory in the board/machine code. Mostly some
old ARM machines (pre-QOM) were affected.

Please review (as a generic codebase cleanup).

Regards,

Phil.

Based-on: <20191008113318.7012-1-imammedo@redhat.com>

Philippe Mathieu-Daud=C3=A9 (21):
  hw/arm/xilinx_zynq: Use the IEC binary prefix definitions
  hw/arm/mps2: Use the IEC binary prefix definitions
  hw/arm/collie: Create the RAM in the board
  hw/arm/omap2: Create the RAM in the board
  hw/arm/omap1: Create the RAM in the board
  hw/arm/digic4: Inline digic4_board_setup_ram() function
  hw: Drop QOM ownership on memory_region_allocate_system_memory() calls
  hw/alpha/dp264: Create the RAM in the board
  hw: Let memory_region_allocate_system_memory take MachineState
    argument
  hw/core: Let the machine be the owner of the system memory
  hw/alpha: Let the machine be the owner of the system memory
  hw/arm: Let the machine be the owner of the system memory
  hw/cris: Let the machine be the owner of the system memory
  hw/hppa: Let the machine be the owner of the system memory
  hw/i386: Let the machine be the owner of the system memory
  hw/lm32: Let the machine be the owner of the system memory
  hw/m68k: Let the machine be the owner of the system memory
  hw/mips: Let the machine be the owner of the system memory
  hw/ppc: Let the machine be the owner of the system memory
  hw/sparc: Let the machine be the owner of the system memory
  hw/core: Assert memory_region_allocate_system_memory has machine owner

 hw/alpha/alpha_sys.h      |  2 +-
 hw/alpha/dp264.c          | 11 ++++++++++-
 hw/alpha/typhoon.c        |  9 +--------
 hw/arm/aspeed.c           |  2 +-
 hw/arm/collie.c           |  8 ++++++--
 hw/arm/cubieboard.c       |  2 +-
 hw/arm/digic_boards.c     | 14 +++++---------
 hw/arm/highbank.c         |  3 ++-
 hw/arm/imx25_pdk.c        |  2 +-
 hw/arm/integratorcp.c     |  2 +-
 hw/arm/kzm.c              |  2 +-
 hw/arm/mcimx6ul-evk.c     |  2 +-
 hw/arm/mcimx7d-sabre.c    |  2 +-
 hw/arm/mps2-tz.c          |  5 +++--
 hw/arm/mps2.c             |  5 +++--
 hw/arm/musicpal.c         |  2 +-
 hw/arm/nseries.c          | 10 +++++++---
 hw/arm/omap1.c            | 12 +++++-------
 hw/arm/omap2.c            | 13 +++++--------
 hw/arm/omap_sx1.c         |  8 ++++++--
 hw/arm/palm.c             |  8 ++++++--
 hw/arm/raspi.c            |  2 +-
 hw/arm/sabrelite.c        |  2 +-
 hw/arm/sbsa-ref.c         |  2 +-
 hw/arm/strongarm.c        |  7 +------
 hw/arm/strongarm.h        |  4 +---
 hw/arm/versatilepb.c      |  2 +-
 hw/arm/vexpress.c         |  4 ++--
 hw/arm/virt.c             |  2 +-
 hw/arm/xilinx_zynq.c      |  5 +++--
 hw/arm/xlnx-versal-virt.c |  2 +-
 hw/arm/xlnx-zcu102.c      |  2 +-
 hw/core/null-machine.c    |  2 +-
 hw/core/numa.c            |  9 +++++----
 hw/cris/axis_dev88.c      |  2 +-
 hw/hppa/machine.c         |  2 +-
 hw/i386/pc.c              |  2 +-
 hw/lm32/lm32_boards.c     |  4 ++--
 hw/lm32/milkymist.c       |  2 +-
 hw/m68k/an5206.c          |  2 +-
 hw/m68k/mcf5208.c         |  2 +-
 hw/m68k/next-cube.c       |  2 +-
 hw/mips/boston.c          |  2 +-
 hw/mips/mips_fulong2e.c   |  3 ++-
 hw/mips/mips_jazz.c       |  2 +-
 hw/mips/mips_malta.c      |  2 +-
 hw/mips/mips_mipssim.c    |  2 +-
 hw/mips/mips_r4k.c        |  3 ++-
 hw/ppc/e500.c             |  3 ++-
 hw/ppc/mac_newworld.c     |  3 ++-
 hw/ppc/mac_oldworld.c     |  2 +-
 hw/ppc/pnv.c              |  2 +-
 hw/ppc/ppc405_boards.c    |  6 +++---
 hw/ppc/prep.c             |  3 ++-
 hw/ppc/spapr.c            |  2 +-
 hw/ppc/virtex_ml507.c     |  2 +-
 hw/sparc/leon3.c          |  2 +-
 hw/sparc/sun4m.c          |  2 +-
 include/hw/arm/omap.h     | 10 +++-------
 include/hw/boards.h       |  6 ++++--
 60 files changed, 127 insertions(+), 117 deletions(-)

--=20
2.21.0


