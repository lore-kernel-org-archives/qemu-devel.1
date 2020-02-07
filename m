Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30624C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E014B20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNgLY+Wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E014B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j03LE-0000E6-24
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j03KC-0007bo-E2
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j03KA-0007g4-Uk
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:05:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58590
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j03KA-0007fA-Qs
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581080734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TPyeTQVoGVIo9b5LzSFXtIt3DMMWp2dN58foGtQj7MM=;
 b=hNgLY+Wz1ZidLN17/46ylzN352WCsX8qSzBONk87ZQXUTsGLzYcWdbRYPVfcgCFm5ueodN
 Ht3tYybQQJ7UphTBXQjSCFIYHIzP5+E/br2TBatgkDAbnfVIQ66GC5aotO4I6tDKsCX/ed
 cmQS8Tna+viJjVhV00bPvgzQhaRGqKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-Ts1dBpymMnmmxVhRcHqH5g-1; Fri, 07 Feb 2020 08:05:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2EB01081FA5;
 Fri,  7 Feb 2020 13:05:22 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54FF25C554;
 Fri,  7 Feb 2020 13:04:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] Make MachineClass::is_default boolean,
 refuse  multiple default machines
Date: Fri,  7 Feb 2020 14:04:50 +0100
Message-Id: <20200207130453.16666-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Ts1dBpymMnmmxVhRcHqH5g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup after reviewing "ppc: function to setup latest class options":
https://www.mail-archive.com/qemu-devel@nongnu.org/msg677709.html

Philippe Mathieu-Daud=C3=A9 (3):
  hw: Do not initialize MachineClass::is_default to 0
  hw: Make MachineClass::is_default a boolean type
  vl: Abort if multiple machines are registered as default

 include/hw/boards.h                      |  2 +-
 hw/alpha/dp264.c                         |  2 +-
 hw/cris/axis_dev88.c                     |  2 +-
 hw/hppa/machine.c                        |  2 +-
 hw/i386/pc_piix.c                        | 10 +++++-----
 hw/lm32/lm32_boards.c                    |  3 +--
 hw/lm32/milkymist.c                      |  1 -
 hw/m68k/mcf5208.c                        |  2 +-
 hw/m68k/q800.c                           |  1 -
 hw/microblaze/petalogix_ml605_mmu.c      |  1 -
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
 hw/mips/mips_malta.c                     |  2 +-
 hw/moxie/moxiesim.c                      |  2 +-
 hw/nios2/10m50_devboard.c                |  2 +-
 hw/openrisc/openrisc_sim.c               |  2 +-
 hw/ppc/mac_oldworld.c                    |  2 +-
 hw/ppc/spapr.c                           |  2 +-
 hw/riscv/spike.c                         |  2 +-
 hw/s390x/s390-virtio-ccw.c               |  2 +-
 hw/sh4/shix.c                            |  2 +-
 hw/sparc/sun4m.c                         |  2 +-
 hw/sparc64/niagara.c                     |  2 +-
 hw/sparc64/sun4u.c                       |  4 ++--
 hw/tricore/tricore_testboard.c           |  1 -
 hw/unicore32/puv3.c                      |  2 +-
 vl.c                                     |  4 ++++
 26 files changed, 30 insertions(+), 31 deletions(-)

--=20
2.21.1


