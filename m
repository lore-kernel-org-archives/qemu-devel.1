Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AF0C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D922064B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doxL06aH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D922064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imMLB-0000DT-5m
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 13:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imMJw-0007Cc-GP
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imMJt-0006la-Vt
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:32:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52340
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imMJt-0006kT-Rs
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577817160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wkybI7Yl9dLUqqnBz74H1ituHpgJBQmgKqjimiE6qWg=;
 b=doxL06aHWM3swbRinFDTdFAKuOZr+m9xFmP/NV1zh54lvR6QKXKNIZhH2SsrSeTkhqNdAJ
 L2MAHPqRwwSOXec+jh8ccTcWZ1T2JotQAQDh2btEYLMAXEfUsHwazbPht/Kyh5KfAgtY7x
 YtXuFgJKD4gWLhCJzsPgLL/cHDisPC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-bEOZr3E8Pf2tDMo1wQihlw-1; Tue, 31 Dec 2019 13:32:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88B3710054E3;
 Tue, 31 Dec 2019 18:32:32 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA55A67673;
 Tue, 31 Dec 2019 18:32:18 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 00/14] hw: Fix various --without-default-devices issues
Date: Tue, 31 Dec 2019 19:32:02 +0100
Message-Id: <20191231183216.6781-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: bEOZr3E8Pf2tDMo1wQihlw-1
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Various fixes when configured with --without-default-devices
and building each machine individually.
Adding the corresponding CI tests is out of the scope of this
series.

This series is pushed on top of "hw/i386: Allow building
machines without IOMMU" [*] here:
https://gitlab.com/philmd/qemu/commits/kconfig_misc_fixes

Happy new year!

[*] https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg05230.html

Philippe Mathieu-Daud=C3=A9 (14):
  hw/usb/redirect: Do not link 'usb-redir' device when USB not enabled
  hw/intc/i8259: Fix Kconfig dependency on ISA bus
  hw/i386/Kconfig: Let the MicroVM machine select the SERIAL_ISA config
  hw/i386: Restrict fw_cfg to the PC machines
  hw/i2c/Kconfig: Add an entry for the SMBus
  hw/ppc/Kconfig: Restrict the MPC I2C controller to e500-based
    platforms
  hw/ppc/Kconfig: Let the Sam460ex board use the PowerPC 405 devices
  hw/ppc/Kconfig: Let the Xilinx Virtex5 ML507 use the PPC-440 devices
  hw/ppc/Makefile: Simplify the sPAPR PCI objects rule
  hw/ppc/Kconfig: Only select fw_cfg with machines using OpenBIOS
  hw/ppc/Kconfig: Only select FDT helper for machines using it
  hw/nvram/Kconfig: Add an entry for the NMC93xx EEPROM
  hw/nvram/Kconfig: Restrict CHRP NVRAM to machines using OpenBIOS or
    SLOF
  hw/intc/Kconfig: Let APIC select IOAPIC

 default-configs/mips-softmmu-common.mak |  1 +
 default-configs/ppc-softmmu.mak         |  1 -
 hw/i2c/Kconfig                          |  8 ++++++--
 hw/i2c/Makefile.objs                    |  3 ++-
 hw/i386/Kconfig                         |  2 +-
 hw/i386/Makefile.objs                   |  2 +-
 hw/intc/Kconfig                         |  2 ++
 hw/net/Kconfig                          |  2 ++
 hw/nvram/Kconfig                        |  8 ++++++++
 hw/nvram/Makefile.objs                  |  4 ++--
 hw/ppc/Kconfig                          | 20 ++++++++++++++++++++
 hw/ppc/Makefile.objs                    |  9 ++++-----
 hw/scsi/Kconfig                         |  1 +
 hw/sparc/Kconfig                        |  1 +
 hw/sparc64/Kconfig                      |  1 +
 hw/usb/Makefile.objs                    |  2 ++
 16 files changed, 54 insertions(+), 13 deletions(-)

--=20
2.21.0


