Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA67C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401E72073D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgtC4VrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401E72073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTFB-0002u8-Pv
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ifSLH-0002Ds-Bk
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ifSLE-0002fK-4a
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34234
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ifSLD-0002aW-R1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576172009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2EL/bGHWUdBeUlnl5qW+9PCRIIH7sgKnghtEX7B2zvU=;
 b=hgtC4VrAgyegygxbMgiq/u7L+qvcVIa/UMD0fStmZAG3cxynJznFoCVUltacpQJiuRyrIp
 QsHlidasPYoA1FwOLtYX9FodhBmYB83lFq6cxbqtYJanMYFBIMjn1qA7bQSl4xKOL+pP7m
 ioU/frM2UXrDAM9OEVYavjAk1zxZxOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-ATM9rdhPN16XJQ892c8U_g-1; Thu, 12 Dec 2019 12:33:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92E02800D41;
 Thu, 12 Dec 2019 17:33:24 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA78319C4F;
 Thu, 12 Dec 2019 17:33:21 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [RFC PATCH v2 0/5] target/arm/kvm: Adjust virtual time
Date: Thu, 12 Dec 2019 18:33:15 +0100
Message-Id: <20191212173320.11610-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ATM9rdhPN16XJQ892c8U_g-1
X-Mimecast-Spam-Score: 0
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org,
 richard.henderson@linaro.org, guoheyi@huawei.com, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
them in more appropriate locations and also integrates some of the
approach posted in [2].

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


Andrew Jones (5):
  hw: add compat machines for 5.0
  target/arm/kvm64: kvm64 cpus have timer registers
  target/arm/kvm: Implement virtual time adjustment
  tests/arm-cpu-features: Check feature default values
  target/arm/cpu: Add the kvm-no-adjvtime CPU property

 docs/arm-cpu-features.rst  | 31 +++++++++++++++-
 hw/arm/virt.c              | 17 ++++++++-
 hw/core/machine.c          |  3 ++
 hw/i386/pc.c               |  3 ++
 hw/i386/pc_piix.c          | 14 ++++++-
 hw/i386/pc_q35.c           | 13 ++++++-
 hw/ppc/spapr.c             | 15 +++++++-
 hw/s390x/s390-virtio-ccw.c | 15 +++++++-
 include/hw/arm/virt.h      |  1 +
 include/hw/boards.h        |  3 ++
 include/hw/i386/pc.h       |  3 ++
 target/arm/cpu.c           |  2 +
 target/arm/cpu.h           |  9 +++++
 target/arm/cpu64.c         |  1 +
 target/arm/kvm.c           | 76 ++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c         |  3 ++
 target/arm/kvm64.c         |  4 ++
 target/arm/kvm_arm.h       | 34 +++++++++++++++++
 target/arm/monitor.c       |  1 +
 tests/arm-cpu-features.c   | 48 +++++++++++++++++++-----
 20 files changed, 280 insertions(+), 16 deletions(-)

--=20
2.21.0


