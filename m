Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3177AC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC3D20658
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMVdpA4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC3D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEq8g-00033W-2D
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jEq7Q-0001T3-6L
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jEq7O-0004jJ-Lt
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21677)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jEq7O-0004hG-HD
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584604890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qj3ejEU/gg4P+5ykUB0xuJBRDxEeKLVjS9+jxbSd/RI=;
 b=IMVdpA4jP2aBBKfU/LFhuW/HTrYobPxLF2Orz4ukjqVCtoqrgKdvDeYAL0T5r5REw49iWv
 k3Pbenvl+LFjjl1qqumYZb3b/9qu8n3y48hZhSjtlk+aMPtlOCRLf5t1beZexZk0mrhpAR
 Q0qVAHYIdAf0gZopV+9aTHY0l6BMFWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-5NAKUms_Oaal70I_alPGAg-1; Thu, 19 Mar 2020 04:01:27 -0400
X-MC-Unique: 5NAKUms_Oaal70I_alPGAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A85C800D4E;
 Thu, 19 Mar 2020 08:01:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60F0E5D9E2;
 Thu, 19 Mar 2020 08:01:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9E6823BD; Thu, 19 Mar 2020 09:01:17 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/13] microvm: add acpi support
Date: Thu, 19 Mar 2020 09:01:04 +0100
Message-Id: <20200319080117.7725-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I know that not supporting ACPI in microvm is intentional.  If you still
don't want ACPI this is perfectly fine, you can use the usual -no-acpi
switch to toggle ACPI support.

These are the advantages you are going to loose then:

  (1) virtio-mmio device discovery without command line hacks (tweaking
      the command line is a problem when not using direct kernel boot).
  (2) Better IO-APIC support, we can use IRQ lines 16-23.
  (3) ACPI power button (aka powerdown request) works.
  (4) machine poweroff (aka S5 state) works.

Together with seabios patches for virtio-mmio support this allows to
boot standard fedora images (cloud, coreos, workstation live) with the
microvm machine type.

cheers,
  Gerd

Gerd Hoffmann (13):
  acpi: make build_madt() more generic.
  acpi: factor out acpi_dsdt_add_fw_cfg()
  microvm: add isa-acpi device
  microvm: add minimal acpi support.
  microvm: add acpi_dsdt_add_virtio() for x86
  microvm: disable virtio-mmio cmdline hack
  [testing] seabios: update submodule to experimental microvm branch
  [testing] seabios: update config & build rules
  [testing] seabios: update binaries to experimental microvm branch
  microvm/acpi: add rtc
  microvm/acpi: add serial
  microvm: make virtio irq base runtime configurable
  microvm/acpi: use GSI 16-23 for virtio

 include/hw/i386/microvm.h   |   8 +-
 hw/acpi/isa-acpi.c          | 114 +++++++++++++++
 hw/i386/acpi-build.c        | 278 +++++++++++++++++++++++++++++-------
 hw/i386/microvm.c           |  32 +++--
 hw/acpi/Makefile.objs       |   1 +
 pc-bios/bios-256k.bin       | Bin 262144 -> 262144 bytes
 pc-bios/bios-microvm.bin    | Bin 65536 -> 131072 bytes
 pc-bios/bios.bin            | Bin 131072 -> 131072 bytes
 roms/Makefile               |   5 +-
 roms/config.seabios-128k    |   2 +
 roms/config.seabios-microvm |  25 ++++
 roms/seabios                |   2 +-
 12 files changed, 403 insertions(+), 64 deletions(-)
 create mode 100644 hw/acpi/isa-acpi.c
 create mode 100644 roms/config.seabios-microvm

--=20
2.18.2


