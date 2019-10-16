Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCF8C4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5198520872
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5198520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKf6l-0003iM-6k
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 04:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iKf4W-0001eZ-Pw
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iKf4V-00060S-EY
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:54:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iKf4R-0005xg-Ob; Wed, 16 Oct 2019 04:54:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EBA753082E0F;
 Wed, 16 Oct 2019 08:54:14 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BCEC5D9CD;
 Wed, 16 Oct 2019 08:54:10 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v6 0/9] target/arm/kvm: enable SVE in guests
Date: Wed, 16 Oct 2019 10:53:59 +0200
Message-Id: <20191016085408.24360-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 16 Oct 2019 08:54:15 +0000 (UTC)
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

v6:
  - Adding missing visit_free() to an error path in
    qmp_query_cpu_model_expansion() in patch 1/9.
  - Rebased on latest master (applied cleanly)
  - Picked up r-b's from Richard and Eric

v5:
  - Now generate an error if vector lengths have been explicitly
    enabled, but SVE is disabled
  - Fixed a bug in sve_zcr_len_for_el()
  - Fixed a bug in kvm_arch_put/get_sve() and brought back the
    put/get of FPSR/FPCR
  - A few document clarifications and added some new sentences
  - Added a couple more tests
  - Added BIT_ULL and use it in the test
  - Removed an unnecessary bitmap search
  - Moved a cpu_max_get_sve_max_vq() hunk from 4/9 to 3/9 and
    added a fix for it in 8/9
  - Picked up some more tags from Eric

v4:
  - Integrated Richard Henderson's rework for the sve property
    validation, in order to do all validating at finalize time
    and save several lines of code.
  - Fixed 'host' cpu SVE default. It was still off by default.
  - Cleaned up #ifdef's for sve_bswap64()
  - Removed redundant KVM_CAP_ARM_SVE extension check in
    kvm_arm_sve_get_vls()
  - Improved the KVM SVE qtest
  - Renamed sve<vl-bits> to sve<N> everywhere
  - Renamed power-of-2 to power-of-two everywhere
  - Picked up some more tags from Richard

Thanks!
drew


Andrew Jones (9):
  target/arm/monitor: Introduce qmp_query_cpu_model_expansion
  tests: arm: Introduce cpu feature tests
  target/arm: Allow SVE to be disabled via a CPU property
  target/arm/cpu64: max cpu: Introduce sve<N> properties
  target/arm/kvm64: Add kvm_arch_get/put_sve
  target/arm/kvm64: max cpu: Enable SVE when available
  target/arm/kvm: scratch vcpu: Preserve input kvm_vcpu_init features
  target/arm/cpu64: max cpu: Support sve properties with KVM
  target/arm/kvm: host cpu: Add support for sve<N> properties

 docs/arm-cpu-features.rst | 317 ++++++++++++++++++++++
 include/qemu/bitops.h     |   1 +
 qapi/machine-target.json  |   6 +-
 target/arm/cpu.c          |  25 +-
 target/arm/cpu.h          |  21 ++
 target/arm/cpu64.c        | 356 ++++++++++++++++++++++++-
 target/arm/helper.c       |  10 +-
 target/arm/kvm.c          |  25 +-
 target/arm/kvm32.c        |   6 +-
 target/arm/kvm64.c        | 323 ++++++++++++++++++++---
 target/arm/kvm_arm.h      |  39 +++
 target/arm/monitor.c      | 157 +++++++++++
 tests/Makefile.include    |   5 +-
 tests/arm-cpu-features.c  | 542 ++++++++++++++++++++++++++++++++++++++
 14 files changed, 1776 insertions(+), 57 deletions(-)
 create mode 100644 docs/arm-cpu-features.rst
 create mode 100644 tests/arm-cpu-features.c

--=20
2.20.1


*** BLURB HERE ***

Andrew Jones (9):
  target/arm/monitor: Introduce qmp_query_cpu_model_expansion
  tests: arm: Introduce cpu feature tests
  target/arm: Allow SVE to be disabled via a CPU property
  target/arm/cpu64: max cpu: Introduce sve<N> properties
  target/arm/kvm64: Add kvm_arch_get/put_sve
  target/arm/kvm64: max cpu: Enable SVE when available
  target/arm/kvm: scratch vcpu: Preserve input kvm_vcpu_init features
  target/arm/cpu64: max cpu: Support sve properties with KVM
  target/arm/kvm: host cpu: Add support for sve<N> properties

 docs/arm-cpu-features.rst | 317 ++++++++++++++++++++++
 include/qemu/bitops.h     |   1 +
 qapi/machine-target.json  |   6 +-
 target/arm/cpu.c          |  25 +-
 target/arm/cpu.h          |  21 ++
 target/arm/cpu64.c        | 358 ++++++++++++++++++++++++-
 target/arm/helper.c       |  10 +-
 target/arm/kvm.c          |  25 +-
 target/arm/kvm32.c        |   6 +-
 target/arm/kvm64.c        | 323 ++++++++++++++++++++---
 target/arm/kvm_arm.h      |  39 +++
 target/arm/monitor.c      | 158 +++++++++++
 tests/Makefile.include    |   5 +-
 tests/arm-cpu-features.c  | 542 ++++++++++++++++++++++++++++++++++++++
 14 files changed, 1778 insertions(+), 58 deletions(-)
 create mode 100644 docs/arm-cpu-features.rst
 create mode 100644 tests/arm-cpu-features.c

--=20
2.21.0


