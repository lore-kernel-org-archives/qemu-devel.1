Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B10C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4B5216C8
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4B5216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htWeD-0006Fs-L1
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 08:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37546)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1htWdA-0004Gt-8n
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1htWd9-0001et-1g
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1htWd6-0001co-EK; Fri, 02 Aug 2019 08:25:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E2309307D88D;
 Fri,  2 Aug 2019 12:25:50 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3D455C205;
 Fri,  2 Aug 2019 12:25:41 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Fri,  2 Aug 2019 14:25:25 +0200
Message-Id: <20190802122540.26385-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 02 Aug 2019 12:25:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 00/15] target/arm/kvm: enable SVE in guests
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 eric.auger@redhat.com, imammedo@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since Linux kernel v5.2-rc1 KVM has support for enabling SVE in guests.
This series provides the QEMU bits for that enablement. First, we
select existing CPU properties representing features we want to
advertise in addition to the SVE vector lengths and prepare
them for a qmp query. Then we introduce the qmp query, applying
it immediately to those selected features. We also document ARM CPU
features at this time. We next add a qtest for the selected CPU
features that uses the qmp query for its tests - and we continue to
add tests as we add CPU features with the following patches. So then,
once we have the support we need for CPU feature querying and testing,
we add our first SVE CPU feature property, 'sve', which just allows
SVE to be completely enabled/disabled. Following that feature property,
we add all 16 vector length properties along with the input validation
they need and tests to prove the validation works. At this point the
SVE features are still only for TCG, so we provide some patches to
prepare for KVM and then a patch that allows the 'max' CPU type to
enable SVE with KVM, but at first without vector length properties.
After a bit more preparation we add the SVE vector length properties
to the KVM-enabled 'max' CPU type along with the additional input
validation and tests that that needs.  Finally we allow the 'host'
CPU type to also enjoy these properties by simply sharing them with it.

v3:
  - Added documentation (docs/arm-cpu-features.rst)
  - Fixed TCG emulation of ZCR
  - Fixed KVM put/get_sve registers to not forget to bswap FFR
  - Now ensure we never end up with no vector lengths selected and sve=3D=
on
  - Now also auto-disable uninitialized larger vector lengths that are
    no longer possible due to disabling a dependent smaller length
  - Now only use cpu_isar_feature(aa64_sve, cpu) to track SVE enablement
  - Now sve-max-vq can come wherever it wants in an sve* property sequenc=
e
  - No longer abuse sve_max_vq for additional states; instead use a coupl=
e
    new helper functions to determine the same states
  - Changed some error messages
  - Dropped some asserts
  - Added more code comments
  - Churned a good amount of code for refactoring and cleanups
  - Picked up some tags from Eric and Richard


Thanks!
drew

Andrew Jones (15):
  target/arm/cpu64: Ensure kvm really supports aarch64=3Doff
  target/arm/cpu: Ensure we can use the pmu with kvm
  target/arm/monitor: Introduce qmp_query_cpu_model_expansion
  tests: arm: Introduce cpu feature tests
  target/arm/helper: zcr: Add build bug next to value range assumption
  target/arm/cpu: Use div-round-up to determine predicate register array
    size
  target/arm: Allow SVE to be disabled via a CPU property
  target/arm/cpu64: max cpu: Introduce sve<vl-bits> properties
  target/arm/kvm64: Fix error returns
  target/arm/kvm64: Move the get/put of fpsimd registers out
  target/arm/kvm64: Add kvm_arch_get/put_sve
  target/arm/kvm64: max cpu: Enable SVE when available
  target/arm/kvm: scratch vcpu: Preserve input kvm_vcpu_init features
  target/arm/cpu64: max cpu: Support sve properties with KVM
  target/arm/kvm: host cpu: Add support for sve<vl-bits> properties

 docs/arm-cpu-features.rst | 301 ++++++++++++++++++++++
 qapi/machine-target.json  |   6 +-
 target/arm/cpu.c          |  38 ++-
 target/arm/cpu.h          |  19 +-
 target/arm/cpu64.c        | 499 +++++++++++++++++++++++++++++++++--
 target/arm/helper.c       |  14 +-
 target/arm/kvm.c          |  32 ++-
 target/arm/kvm32.c        |   6 +-
 target/arm/kvm64.c        | 439 ++++++++++++++++++++++++++-----
 target/arm/kvm_arm.h      |  67 +++++
 target/arm/monitor.c      | 154 +++++++++++
 tests/Makefile.include    |   5 +-
 tests/arm-cpu-features.c  | 529 ++++++++++++++++++++++++++++++++++++++
 13 files changed, 2005 insertions(+), 104 deletions(-)
 create mode 100644 docs/arm-cpu-features.rst
 create mode 100644 tests/arm-cpu-features.c

--=20
2.20.1


