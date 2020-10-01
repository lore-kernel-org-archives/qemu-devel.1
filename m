Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8F2C47420
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 06:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114E3221E8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 06:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6kPRmo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114E3221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNrvZ-0005xN-7P
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 02:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kNruI-00049w-DY
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 02:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kNruD-0003r4-UL
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 02:17:34 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601533049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8eBQ4xArbNe0H4b51EnwvK//0iqdyYTLDLzz0NqmkOk=;
 b=g6kPRmo7pQnWntj1NzBAxqqw4fD8z5vzaLAKXPvovIBCK9kRyVF0zGUhkZJiehE9gkjybB
 WPlv0R8u/RjhZnJs01VDvv0haHBEt/CboT4phH8rZwdqsoagK+w53RzeMFmi9NYzpU4WyC
 hYOryPeudz4h6P8Pwd7BXY/GezN0VX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-0t21fm0lNFevAFt8wBbkrA-1; Thu, 01 Oct 2020 02:17:26 -0400
X-MC-Unique: 0t21fm0lNFevAFt8wBbkrA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D304E185A0E1;
 Thu,  1 Oct 2020 06:17:24 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 063275578D;
 Thu,  1 Oct 2020 06:17:19 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 0/6] hw/arm/virt: Introduce kvm-steal-time
Date: Thu,  1 Oct 2020 08:17:12 +0200
Message-Id: <20201001061718.101915-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 00:27:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v4:
  - Rebased to latest master
  - Added an official linux header synch patch, replacing the
    hack patch used in v3
  - Added a patch to restore the arm-cpu-features test for AArch64
    that got lost in the meson shuffle
  - Added Eric's R-b's

v3:
  - Rebased: 5.2 machine type and kvm32 drop now included
  - Switched to using new KVM cap that has been merged upstream
  - Picked up some r-b's and some of Eric's comments from v2

v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg727588.html

KVM supports the ability to publish the amount of time that VCPUs
were runnable, but not running due to other host threads running
instead, to the guest. The guest scheduler may use that information
when making decisions and the guest may expose it to its userspace
(Linux publishes this information in /proc/stat). This feature is
called "steal time" as it represents the amount of time stolen from
a guest by scheduling out its VCPUs. To enable this feature KVM
userspace must provide a memory region that will be used to publish
the information to the guest. The memory region is typical migratable
region. The GPA of the region is given to KVM through a VCPU device
ioctl interface. This feature is only available for 64-bit guests
per the Arm PVTIME specification (DEN0057A).

This series provides the QEMU support of this feature. It will
be enabled by default for 5.2 machine types and later, but may
be disabled with a new CPU property "kvm-steal-time".

Thanks,
drew


Andrew Jones (6):
  linux headers: sync to 5.9-rc7
  target/arm/kvm: Make uncalled stubs explicitly unreachable
  hw/arm/virt: Move post cpu realize check into its own function
  hw/arm/virt: Move kvm pmu setup to virt_cpu_post_init
  tests/qtest: Restore aarch64 arm-cpu-features test
  hw/arm/virt: Implement kvm-steal-time

 docs/system/arm/cpu-features.rst |  11 ++++
 hw/arm/virt.c                    | 110 ++++++++++++++++++++++---------
 include/hw/arm/virt.h            |   5 ++
 linux-headers/linux/kvm.h        |   6 +-
 target/arm/cpu.c                 |   8 +++
 target/arm/cpu.h                 |   4 ++
 target/arm/kvm.c                 |  16 +++++
 target/arm/kvm64.c               |  64 ++++++++++++++++--
 target/arm/kvm_arm.h             |  94 ++++++++++++++++++++------
 target/arm/monitor.c             |   2 +-
 tests/qtest/arm-cpu-features.c   |  25 +++++--
 tests/qtest/meson.build          |   3 +-
 12 files changed, 286 insertions(+), 62 deletions(-)

-- 
2.26.2


