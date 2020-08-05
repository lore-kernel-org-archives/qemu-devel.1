Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72426C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E4522D00
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0KPMD/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E4522D00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3FYr-0000LH-GL
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 05:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k3FXX-0007Da-B2
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:16:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22426
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k3FXT-0003ie-Cc
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596619006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EmJZVmdebOHatacpSeSNz+jVmDzT3ZPy43FzP5Jq9pg=;
 b=V0KPMD/+dJ11oSyBZ007/kVqDuqNBPMYmk7IQsKBfwzg3J+ZddFPv5CPkFlrHEprRWUDku
 PmL7zSl+vbxV/f+9E7/AUURE0JtIybZxqvfye3PUJLyf44S0DMExoNd9dG7S0PYZ/cHrxL
 MHxOO3KLxzVEfIrGqI1r5tkq+Uge+iY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-4JWeeRc-MOCHK-M7iMNS1A-1; Wed, 05 Aug 2020 05:16:43 -0400
X-MC-Unique: 4JWeeRc-MOCHK-M7iMNS1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E43C9100AA21;
 Wed,  5 Aug 2020 09:16:42 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A630D2DE73;
 Wed,  5 Aug 2020 09:16:41 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v2 0/5] hw/arm/virt: Introduce kvm-steal-time
Date: Wed,  5 Aug 2020 11:16:35 +0200
Message-Id: <20200805091640.11134-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
  - Changed the introduction of the feature to 5.2 from 5.1
    (The 5.2 machine type patch posted by Cornelia was thrown
     in for completeness, but I suppose that'll get picked up
     separately.)
  - Added a patch adding g_assert_not_reached() to many KVM
    stubs. (This isn't exactly related to the series, but the
    series does add two more stubs that can now be added in
    the same way.)
  - Fixed a patch that wasn't suppose to have a functional
    change, but did (fdt_add_gic_node() shouldn't generate
    the node without the PMU) [Peter]
  - Pass sysmem to virt_cpu_post_init() [Peter]
  - Introduced a define for the pvtime struct size
  - Calculate the pvtime memory region size based on max-cpus
    and host-page-size [Beata]
  - Renamed kvm_no_steal_time to no_kvm_steal_time [Peter]
  - Fixed a parameter misordering with object_property_set_bool()
  - Added a comment explaining why the feature isn't supported
    for AArch32 guests
  - Changed a !kvm_steal_time to a kvm_steal_time == ON_OFF_AUTO_OFF
    as it should be
  - Picked up one r-b from Peter


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
ioctl interface. This feature is only available for 64-bit hosts
running 64-bit guests.

This series provides the QEMU support of this feature. It will
be enabled by default for 5.2 machine types and later, but may
be disabled with a new CPU property "kvm-steal-time".

While testing migration it was observed that the amount of
steal time as viewed by the guest was getting reset on each
migration. Patch 4/6 of a pvtime fix series posted[*] for KVM
should fix that. Also, we may still want to change the way we
probe KVM for the feature in this QEMU series to the new KVM
cap proposed in that KVM series.

Migration testing:

* virt-5.1 can migrate as usual, no steal-time enabled

* virt-5.2 can migrate between hosts with steal-time enabled
  (the default) and disabled when both hosts support steal-time

* virt-5.2 with steal-time disabled can migrate to a host that
  does not support steal-time

* virt-5.2 with steal-time enabled will cleanly fail when migrating
  to a host that does not support steal-time

* virt-5.2 without the kvm-steal-time property specified can
  boot on a host that does not support the feature - the feature
  will be disabled. However, if the guest is migrated to a host
  that does support the feature, then after the guest has reboot
  the feature will become available with the guest kernel supports
  it (this is the nature of migrating guests that use '-cpu host').
  Additionally, once this guest has been migrated to a host that
  does have the feature, then it will fail (cleanly) to migrate to
  a host that does not have the feature. If this behavior isn't
  desired, then the user should explicitly disable steal-time with
  the kvm-steal-time property if they want to boot a 5.2 guest on
  a host that doesn't support steal-time.

[*] https://lists.cs.columbia.edu/pipermail/kvmarm/2020-August/041823.html

Thanks,
drew


Andrew Jones (4):
  target/arm/kvm: Make uncalled stubs explicitly unreachable
  hw/arm/virt: Move post cpu realize check into its own function
  hw/arm/virt: Move kvm pmu setup to virt_cpu_post_init
  hw/arm/virt: Implement kvm-steal-time

Cornelia Huck (1):
  hw: add compat machines for 5.2

 docs/system/arm/cpu-features.rst |  11 +++
 hw/arm/virt.c                    | 119 +++++++++++++++++++++++--------
 hw/core/machine.c                |   3 +
 hw/i386/pc.c                     |   6 +-
 hw/i386/pc_piix.c                |  14 +++-
 hw/i386/pc_q35.c                 |  13 +++-
 hw/ppc/spapr.c                   |  15 +++-
 hw/s390x/s390-virtio-ccw.c       |  14 +++-
 include/hw/arm/virt.h            |   5 ++
 include/hw/boards.h              |   3 +
 include/hw/i386/pc.h             |   3 +
 target/arm/cpu.c                 |  10 +++
 target/arm/cpu.h                 |   4 ++
 target/arm/kvm.c                 |  20 ++++++
 target/arm/kvm32.c               |   5 ++
 target/arm/kvm64.c               |  77 ++++++++++++++++++--
 target/arm/kvm_arm.h             |  74 ++++++++++++++-----
 target/arm/monitor.c             |   2 +-
 tests/qtest/arm-cpu-features.c   |  25 +++++--
 19 files changed, 358 insertions(+), 65 deletions(-)

-- 
2.25.4


