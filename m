Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EE5C34022
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 02:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F4E20836
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 02:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5sAe4Tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F4E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3sGM-00059d-2Z
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 21:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j3sFY-00043Y-Oh
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 21:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j3sFW-0007Pw-To
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 21:04:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53329
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j3sFW-0007PR-Pq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 21:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581991473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yCHoUPvzYBVp9PdCimEQIUn/yQd6c7EaoL443PlojAI=;
 b=i5sAe4TfxQO6QJzoP59e9YSWUi6vlMckMgA+5KmMz2bk1+LPjtvks6BSwszny4vjyXy2MD
 fakESI7hPhe02rxbNhi6D82v8AnTz0RBzAp6WRyo4GZdRH2oAjxD2OULP7XWooPNxu4ZqL
 /TY3PlBsh0zOX0RW2bJSNpcalBBv0y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-WQZxT-XiOJ2wV86sunPeDQ-1; Mon, 17 Feb 2020 21:04:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66D8E13E4;
 Tue, 18 Feb 2020 02:04:29 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-110.bne.redhat.com
 [10.64.54.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3535A1BC6D;
 Tue, 18 Feb 2020 02:04:21 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 0/3] hw/arm/virt: Simulate NMI Injection
Date: Tue, 18 Feb 2020 13:04:13 +1100
Message-Id: <20200218020416.50244-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WQZxT-XiOJ2wV86sunPeDQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 aik@ozlabs.ru, maz@kernel.org, richard.henderson@linaro.org,
 eric.auger@redhat.com, shan.gavin@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series simulates the behavior of receiving NMI interrupt for "virt"
board. First of all, a new interrupt (SError) is supported for each CPU.
The backend is either sending error events through kvm module or emulating
the bahavior when TCG is enabled. The outcome is SError or data abort is
raised to crash guest. In the mean while, the virtual SError interrupt is
also supported, but there is no users yet.

For GICv2 or GICv3, a new IRQ line is added for each CPU and it's connected
to the (above) introduced SError interrupt. The IRQ line of CPU#0 is raised
when HMP/QMP "nmi" is issued, to crash the guest.

Testing
=3D=3D=3D=3D=3D=3D=3D

After the HMP/QMP "nmi" is issued in the following 4 environment, the guest=
 is
crashed as expected.

   Accel     Mode                  Crashed    Parameter
   ------------------------------------------------------------------------
   kvm       aarch64               yes        -machine virt -cpu host
   kvm       aarch32(cortex-a15)   yes        -machine virt -cpu host,aarch=
64=3Doff
   tcg       aarch64               yes        -machine virt -cpu max
   tcg       aarch32(cortex-a15)   yes        -machine virt -cpu cortex-a15

Changelog
=3D=3D=3D=3D=3D=3D=3D=3D=3D
v4:
   * Correct the flag in arm_cpu_has_work()               (Richard Henderso=
n)
   * Check CPU_INTERRUPT_SERROR in arm_cpu_exec_interrupt()
     and arm_v7m_cpu_exec_interrupt()                     (Richard Henderso=
n)
   * Introduce ARM_CPU_NUM_IRQ to make the code of initializing
     the CPU's inbound IRQ lines atomic                   (Richard Henderso=
n)
   * Correct comments about ARM_CPU_IRQ                   (Richard Henderso=
n)
   * Update ISR.EL1 with SError state                     (Gavin Shan)
   * Include SError state during migration                (Gavin Shan)
   * Added PATCH[2/3] to support VSError injection        (Marc Zyngier)
v3:
   * Support SError injection for aarch32                 (Richard Henderso=
n)
   * Export the SError injection through IRQ line         (Peter Maydell)
   * Removed RFC tag as it seems in correct track         (Gavin Shan)
v2:
   * Redesigned to fully exploit SError interrupt

Gavin Shan (3):
  target/arm: Support SError injection
  target/arm: Support VSError injection
  hw/arm/virt: Simulate NMI injection

 hw/arm/virt.c                      |  34 ++++++++-
 hw/intc/arm_gic_common.c           |   3 +
 hw/intc/arm_gicv3_common.c         |   3 +
 include/hw/intc/arm_gic_common.h   |   1 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 target/arm/cpu.c                   | 113 ++++++++++++++++++++++++++---
 target/arm/cpu.h                   |  23 ++++--
 target/arm/helper.c                |  30 ++++++++
 target/arm/internals.h             |  10 +++
 target/arm/m_helper.c              |   8 ++
 target/arm/machine.c               |   3 +-
 11 files changed, 208 insertions(+), 21 deletions(-)

--=20
2.23.0


