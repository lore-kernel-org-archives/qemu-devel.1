Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF611C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F20720684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOorKeb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F20720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itU4a-0001jp-G2
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1itU0y-0005My-5E
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1itU0u-0002yd-3I
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42383
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1itU0t-0002yL-VE
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579515031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gpiTY7C+FUDsh6siZn/Ci7Goc6W669jxLLLakhq1bzo=;
 b=hOorKeb8wMKpChLjnFcQ5PBwMMjDL81F1xV8Go8/m51VBv6xTpffaN0gdiP5P2JyYp8MoJ
 QEm1/2HH7iGPPQNdRvhA3uJHovWZEjZhOvcuZnv9KQuglzi9CwyuojeCGP7VcRide/Et5d
 5rqgSHjBY2Msc4itxnn+nCcX9d3exgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-AZmSxa_qPwaqrX_99jvASw-1; Mon, 20 Jan 2020 05:10:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D31BC107ACC9;
 Mon, 20 Jan 2020 10:10:26 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D418F87EDF;
 Mon, 20 Jan 2020 10:10:24 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [RFC PATCH v3 0/6] target/arm/kvm: Adjust virtual time
Date: Mon, 20 Jan 2020 11:10:17 +0100
Message-Id: <20200120101023.16030-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: AZmSxa_qPwaqrX_99jvASw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org,
 richard.henderson@linaro.org, guoheyi@huawei.com, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3:
 - Added a target/arm/kvm_arm.h comment cleanup patch (1/6)
 - Minor refactoring of assert_has_feature_enabled/disabled in 4/6,
   kept Richard's r-b.
 - Rewrote kvm-no-adjvtime documentation in 6/6.
 - Reworked approach in 5/6 to properly deal with migration and to
   track running vs. !running, rather than running vs. paused states.

v2:
 - Reworked it enough that I brought back the RFC tag and retitled the
   series. Also had to drop r-b's from a couple of patches, and even
   drop patches.
 - Changed approach from writing the QEMU virtual time to the guest
   vtime counter to saving and restoring the guest vtime counter.
 - Changed the kvm-adjvtime property, which was off by default, to a
   kvm-no-adjvtime property, which is also off by default, meaning the
   effective "adjust vtime" property is now on by default (but only
   for 5.0 virt machine types and later)

v1:
 - move from RFC status to v1
 - put kvm_arm_vm_state_change() in kvm.c to share among kvm32.c and kvm64.=
c
 - add r-b's from Richard


This series is inspired by a series[1] posted by Bijan Mottahedeh over
a year ago and by the patch[2] posted by Heyi Guo almost a year ago.
The problem described in the cover letter of [1] is easily reproducible
and some users would like to have the option to avoid it. However the
solution, which is to adjust the virtual counter each time the VM
transitions to the running state, introduces a different problem, which
is that the virtual and physical counters diverge. As described in the
cover letter of [1] this divergence is easily observed when comparing
the output of `date` and `hwclock` after suspending the guest, waiting
a while, and then resuming it. Because this different problem may actually
be worse for some users, unlike [1], the series posted here makes the
virtual counter adjustment optional. Besides the adjustment being
optional, this series approaches the needed changes differently to apply
them in more appropriate locations.

Additional notes
----------------

Note 1
------

As described above, when running a guest with kvm-no-adjtime disabled
it will be less likely the guest OS and guest applications get surprise
time jumps when they use the virtual counter.  However the counter will
no longer reflect real time.  It will lag behind.  If this is a problem
then the guest can resynchronize its time from an external source or
even from its physical counter.  If the suspend/resume is done with
libvirt's virsh, and the guest is running the guest agent, then it's
also possible to use a sequence like this

 $ virsh suspend $GUEST
 $ virsh resume $GUEST
 $ virsh domtime --sync $GUEST

in order to resynchronize a guest right after the resume.  Of course
there will still be time when the clock is not right, possibly creating
confusing timestamps in logs, for example, and the guest must still be
tolerant to the time synchronizations.

Note 2
------

Userspace that wants to set KVM_REG_ARM_TIMER_CNT should beware that
the KVM register ID is not correct.  This cannot be fixed because it's
UAPI and if the UAPI headers are used then it can't be a problem.
However, if a userspace attempts to create the ID themselves from the
register's specification, then they will get KVM_REG_ARM_TIMER_CVAL
instead, as the _CNT and _CVAL definitions have their register
parameters swapped.

Note 3
------

I didn't test this with a 32-bit KVM host, but the changes to kvm32.c
are the same as kvm64.c. So what could go wrong? Test results would be
appreciated.
=20

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05713.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg03695.html

Thanks,
drew


Andrew Jones (6):
  target/arm/kvm: trivial: Clean up header documentation
  hw/arm/virt: Add missing 5.0 options call to 4.2 options
  target/arm/kvm64: kvm64 cpus have timer registers
  tests/arm-cpu-features: Check feature default values
  target/arm/kvm: Implement virtual time adjustment
  target/arm/cpu: Add the kvm-no-adjvtime CPU property

 docs/arm-cpu-features.rst      |  37 +++++++++-
 hw/arm/virt.c                  |   9 +++
 include/hw/arm/virt.h          |   1 +
 target/arm/cpu.c               |   2 +
 target/arm/cpu.h               |   7 ++
 target/arm/cpu64.c             |   1 +
 target/arm/kvm.c               | 120 +++++++++++++++++++++++++++++++++
 target/arm/kvm32.c             |   3 +
 target/arm/kvm64.c             |   4 ++
 target/arm/kvm_arm.h           |  95 ++++++++++++++++++++------
 target/arm/machine.c           |   7 ++
 target/arm/monitor.c           |   1 +
 tests/qtest/arm-cpu-features.c |  41 ++++++++---
 13 files changed, 299 insertions(+), 29 deletions(-)

--=20
2.21.1


