Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAC7C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F73205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F73205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHn9o-0003j5-Dd
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 06:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iHn7P-0001re-A7
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iHn7M-0003k2-Qv
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:53:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17157)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iHn7M-0003hm-Lf
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:53:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A1CAF9AE9C;
 Tue,  8 Oct 2019 10:53:22 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-109.rdu2.redhat.com
 [10.10.120.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2C455D9C9;
 Tue,  8 Oct 2019 10:53:01 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH 0/4] hw/i386: pass "MachineState.smp.max_cpus" to OVMF
Date: Tue,  8 Oct 2019 12:52:55 +0200
Message-Id: <20191008105259.5378-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 08 Oct 2019 10:53:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://bugzilla.tianocore.org/show_bug.cgi?id=3D1515

For enabling VCPU hotplug with OVMF, OVMF needs to know the value of
"max_cpus". This quantity is not passed to the firmware currently --
SeaBIOS receives the (exclusive) maximum APICID, which is not useful to
OVMF --, so introduce a new fw_cfg file for this purpose.

Note: when OVMF is built with -D SMM_REQUIRE, this patch series is just
a small building block, towards the full VCPU hotplug feature. However,
when OVMF is built without -D SMM_REQUIRE, this series (together with
the counterpart patch set for OVMF) completes the VCPU hotplug feature:
it allows S3 resume to work with VCPUs hot-plugged previously (at OS
runtime, of course).

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>

Thanks
Laszlo

Laszlo Ersek (4):
  fw_cfg: bump file slots to 40
  target/i386: remove useless enable_compat_apic_id_mode() prototype
  hw/i386: add facility to expose CPU topology over fw-cfg
  hw/i386/pc: expose CPU topology over fw-cfg

 hw/core/machine.c    |  2 ++
 hw/i386/fw_cfg.c     | 26 ++++++++++++++++++++++++--
 hw/i386/fw_cfg.h     | 30 +++++++++++++++++++++++++++++-
 hw/i386/pc.c         |  5 +++--
 hw/i386/pc_piix.c    |  2 ++
 hw/i386/pc_q35.c     |  2 ++
 hw/nvram/fw_cfg.c    |  2 +-
 include/hw/i386/pc.h |  3 +++
 target/i386/cpu.h    |  2 --
 9 files changed, 66 insertions(+), 8 deletions(-)

--=20
2.19.1.3.g30247aa5d201


