Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0118C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 05:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0BD20659
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 05:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0BD20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfdbu-0007vD-Tv
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 01:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hfdZA-0006kR-SY
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 01:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hfdZ9-0002Qe-GK
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 01:00:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hfdZ9-0002Pm-8U
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 01:00:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6B34130832DA;
 Tue, 25 Jun 2019 05:00:12 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14BA310018F9;
 Tue, 25 Jun 2019 05:00:09 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 02:00:02 -0300
Message-Id: <20190625050008.12789-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 25 Jun 2019 05:00:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/6] x86 CPU model versioning
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
Cc: Pavel Hrdina <phrdina@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Tao Xu <tao3.xu@intel.com>, "Hu,
 Robert" <robert.hu@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series implements basic infrastructure for CPU model
versioning, as discussed before[1][2][3].  This will finally
allow us to update CPU models in ways that introduce new software
or hardware requirements.

My original plan was to use "query-cpu-model-expansion
mode=static" to resolve aliases, but I dropped that plan because
it would increase complexity for management software a lot.
static CPU models are documented as not being affected by the
machine type and accelerator at all, which would make the
versioned CPU models very inconvenient to use in the command
line.  e.g.: users would be forced to replace:

  -cpu Haswell

with:

  -cpu Haswell-4.1,+2apic,+monitor,+kvmclock,+kvm-nopiodelay,+kvm-asyncpf,+kvm-steal-time,+kvm-pv-eoi,+kvmclock-stable-bit,+x2apic,-acpi,-monitor,-svm

In the end, making the versioned CPU models static is not a
requirement at all: what we really need is to drop the
runnability guarantees from unversioned CPU model names, and
require management software to resolve the unversioned alias
before saving the VM configuration.

Guest ABI compatibility and live migration guarantees are going
to be kept: unversioned CPU models will still be usable with live
migration.  Only runnability guarantees when updating the machine
type will be dropped.  This means unversioned CPU models are
still reported as migration-safe in query-cpu-definitions.

The last patch in the series demonstrates how the new feature can
be used to update a CPU model: it adds a Cascadelake-Server-4.1.1
CPU model, including "arch-capabilities=on" and "stepping=5".
Unfortunately we can't enable arch-capabilities in the -4.1
version of Cascadelake-Server because it would break our existing
runnability guarantees.

[1] https://www.mail-archive.com/libvir-list@redhat.com/msg167342.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg590034.html
[3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg611244.html

---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Hrdina <phrdina@redhat.com>
Cc: Jiri Denemark <jdenemar@redhat.com>
Cc: "Hu, Robert" <robert.hu@intel.com>
Cc: Tao Xu <tao3.xu@intel.com>
Cc: Richard Henderson <rth@twiddle.net>

Eduardo Habkost (6):
  i386: Add x-force-features option for testing
  i386: Remove unused host_cpudef variable
  qmp: Add "alias-of" field to query-cpu-definitions
  i386: Infrastructure for versioned CPU models
  docs: Deprecate CPU model runnability guarantees
  i386: Add Cascadelake-Server-4.1.1 CPU model

 qapi/target.json                           |   9 +-
 include/hw/i386/pc.h                       |   3 +
 target/i386/cpu-qom.h                      |  10 +-
 target/i386/cpu.h                          |  16 ++
 hw/i386/pc.c                               |   3 +
 hw/i386/pc_piix.c                          |   4 +
 hw/i386/pc_q35.c                           |   4 +
 target/i386/cpu.c                          | 188 +++++++++++++++++----
 qemu-deprecated.texi                       |  19 +++
 tests/acceptance/x86_cpu_model_versions.py | 173 +++++++++++++++++++
 10 files changed, 388 insertions(+), 41 deletions(-)
 create mode 100644 tests/acceptance/x86_cpu_model_versions.py

-- 
2.18.0.rc1.1.g3f1ff2140


