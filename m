Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC669C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836562072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlRgdg4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836562072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZfB-00007k-4u
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipZdD-00067h-BG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipZdB-0001X3-4O
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:21:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipZdA-0001RR-Mh
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578583311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=P5RGdQrGsYtgUOKj0M4myzDzBUaBMtcy1aS0kbUYf64=;
 b=HlRgdg4L1OFxKuK1oL71gdPD2nLs5sEInQxTz/meMDlxcrBIgjIpGc5/87km2Q6QcKMaX6
 8tNR0boKB1PbNvm/vL7rZqs6Bquv9gU6Dn07jOadxA4vMJPb5hB5mO99TQrft2gxW9jXA5
 z7GY2FgOBhmKjwdp4kaglMzZYpyw1LA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-Z6-I5PgHMWWbDGkeCQozUg-1; Thu, 09 Jan 2020 10:21:48 -0500
X-MC-Unique: Z6-I5PgHMWWbDGkeCQozUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACD758C2BE1;
 Thu,  9 Jan 2020 15:21:45 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-180.brq.redhat.com [10.40.204.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F14D27FB5C;
 Thu,  9 Jan 2020 15:21:36 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/15] Replace current_machine by qdev_get_machine()
Date: Thu,  9 Jan 2020 16:21:18 +0100
Message-Id: <20200109152133.23649-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, qemu-ppc@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Blurb from previous question [1]:

  "hw/boards.h" declare current_machine, and vl.c defines it:

    current_machine =3D MACHINE(object_new_with_class(OBJECT_CLASS(machin=
e_class)));
    object_property_add_child(object_get_root(), "machine",
                              OBJECT(current_machine), &error_abort);

  The bigger user of 'current_machine' is the accel/KVM code.

  Recently in a0628599f..cc7d44c2e0 "Replace global smp variables
  with machine smp properties" we started to use MACHINE(qdev_get_machine=
()).
  Following a0628599f..cc7d44c2e0, a5e0b33119 use 'current_machine' again=
.

  qdev_get_machine() resolves the machine in the QOM composition tree.

Paolo answered [2]:

> I would always use MACHINE(qdev_get_machine()), espeecially outside
> vl.c.  Ideally, current_machine would be static within vl.c or even
> unused outside the object_property_add_child() that you quote above.

Let's remove the global current_machine.

I am still confused by this comment:

  /* qdev_get_machine() can return something that's not TYPE_MACHINE
   * if this is one of the user-only emulators; in that case there's
   * no need to check the ignore_memory_transaction_failures board flag.
   */

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg669475.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg669493.html

Philippe Mathieu-Daud=C3=A9 (15):
  target/arm/kvm: Use CPUState::kvm_state in kvm_arm_pmu_supported()
  hw/ppc/spapr_rtas: Use local MachineState variable
  hw/ppc/spapr_rtas: Access MachineState via SpaprMachineState argument
  hw/ppc/spapr_rtas: Restrict variables scope to single switch case
  device-hotplug: Replace current_machine by qdev_get_machine()
  migration/savevm: Replace current_machine by qdev_get_machine()
  hw/core/machine-qmp-cmds: Replace current_machine by
    qdev_get_machine()
  target/arm/monitor: Replace current_machine by qdev_get_machine()
  device_tree: Replace current_machine by qdev_get_machine()
  memory: Replace current_machine by qdev_get_machine()
  exec: Replace current_machine by qdev_get_machine()
  accel: Introduce the current_accel() method
  accel: Replace current_machine->accelerator by current_accel() method
  accel/accel: Replace current_machine by qdev_get_machine()
  vl: Make current_machine a local variable

 include/hw/boards.h        |  2 --
 include/sysemu/accel.h     |  2 ++
 accel/accel.c              |  7 +++++++
 accel/kvm/kvm-all.c        |  4 ++--
 accel/tcg/tcg-all.c        |  2 +-
 device-hotplug.c           |  2 +-
 device_tree.c              |  4 +++-
 exec.c                     | 10 ++++++----
 hw/core/machine-qmp-cmds.c |  4 ++--
 hw/ppc/spapr_rtas.c        |  6 +++---
 memory.c                   |  6 ++++--
 migration/savevm.c         | 10 +++++-----
 target/arm/kvm.c           |  4 +---
 target/arm/kvm64.c         |  4 ++--
 target/arm/monitor.c       |  3 ++-
 target/i386/kvm.c          |  2 +-
 target/ppc/kvm.c           |  2 +-
 vl.c                       |  6 +++---
 18 files changed, 46 insertions(+), 34 deletions(-)

--=20
2.21.1


