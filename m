Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3098AC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 18:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083282075B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 18:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083282075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv4fi-00014Z-AZ
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 14:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41048)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sean.j.christopherson@intel.com>) id 1hv4dx-0004OC-1b
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 14:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sean.j.christopherson@intel.com>) id 1hv4dv-000722-Ev
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 14:57:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:31802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sean.j.christopherson@intel.com>)
 id 1hv4dv-0006yc-6O
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 14:57:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Aug 2019 11:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; d="scan'208";a="176715062"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
 by orsmga003.jf.intel.com with ESMTP; 06 Aug 2019 11:56:59 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Date: Tue,  6 Aug 2019 11:56:29 -0700
Message-Id: <20190806185649.2476-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [RFC PATCH 00/20] i386: Add support for Intel SGX
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series enables exposing Intel Software Guard Extensions (SGX) to KVM
guests.  This series is firmly RFC due to SGX support not yet being
accepted into the Linux kernel, let alone KVM.

The primary goal of this RFC is to get feedback on the overall approach,
especially with respect to Enclave Page Cache (EPC) handling, but any
feedback whatsoever would be greatly appreciated.  Please don't hesitate
to ask for more details and/or clarification.

The code is based on 'https://github.com/ehabkost/qemu.git x86-next',
which currently points at commit:

  ff656fcd33 ("i386: Fix Snowridge CPU model name and features")


Brief arch blurb (providing useful documentation in a cover letter is
impractical due to scope of SGX):

  SGX is a set of instructions and mechanisms that enable ring 3
  applications to set aside private regions of code and data for the
  purpose of establishing and running enclaves.  An enclave is a secure
  entity whose private memory can only be accessed by code running within
  the enclave.  Accesses from outside the enclave, including software
  running at a higher privilege level and other enclaves, are disallowed
  by hardware.

Overviews and details:

  SGX arch kernel doc - https://patchwork.kernel.org/patch/11043125/

  SGX arch overview   - https://www.youtube.com/watch?v=mPT_vJrlHlg

Gory details on SGX are also available in all recent versions of Intel's
SDM, e.g. chapters 37-42 in Vol. 3 of the May 2019 version of the SDM.


Linux kernel and KVM enabling:

  SGX kernel enabling - https://lkml.kernel.org/r/20190713170804.2340-1-jarkko.sakkinen@linux.intel.com

  SGX KVM enabling    - https://lkml.kernel.org/r/20190727055214.9282-1-sean.j.christopherson@intel.com


QEMU points of interest:

Basics - SGX is exposed the guest if and only if KVM is enabled and
         supports virtualization of SGX, and the kernel provides access
         to "raw" EPC.  Because SGX uses a hardware-based root of trust,
         the attestation aspects of SGX cannot be emulated in software,
         i.e. ultimately emulation will fail as software cannot generate
         a valid quote/report.  The complexity of partially emulating SGX
         in Qemu far outweighs the value added, e.g. an SGX specific
         simulator for userspace applications can emulate SGX for
         development and testing purposes.

EPC - Because of its unique requirements, the kernel manages EPC separately
      from normal memory.  Similar to memfd, the device /dev/sgx/virt_epc
      can be opened to obtain a file descriptor which can in turn be used
      to mmap() EPC memory.

      The notable quirk with EPC from QEMU's perspective is that EPC is
      enumerated via CPUID, which complicates realizing EPC as a normal
      device due to vCPU creation depending on the location/size of EPC
      sections.

Migration - Physical EPC is encrypted with an ephemeral key that is
            (re)generated at CPU reset, i.e. is platform specific.  Thus,
            migrating EPC contents between physical platforms is
            infeasible.  However, live migration is not blocked by SGX as
            kernels and applications are conditioned to gracefully handle
            EPC invalidation due to the EPC being zapped on power state
            transitions that power down the CPU, e.g. S3.  I.e. from the
            guest's perspective, live migration appears and is handled
            like an unannounced suspend/resume cycle.

NUMA - How EPC NUMA affinity will be enumerated to the kernel is not yet
       defined (initial hardware support for SGX was limited to single
       socket systems).

Sean Christopherson (20):
  hostmem: Add hostmem-epc as a backend for SGX EPC
  i386: Add 'sgx-epc' device to expose EPC sections to guest
  vl: Add "sgx-epc" option to expose SGX EPC sections to guest
  i386: Add primary SGX CPUID and MSR defines
  i386: Add SGX CPUID leaf FEAT_SGX_12_0_EAX
  i386: Add SGX CPUID leaf FEAT_SGX_12_1_EAX
  i386: Add SGX CPUID leaf FEAT_SGX_12_1_EBX
  i386: Add get/set/migrate support for SGX LE public key hash MSRs
  i386: Add feature control MSR dependency when SGX is enabled
  i386: Update SGX CPUID info according to hardware/KVM/user input
  linux-headers: Add temporary placeholder for KVM_CAP_SGX_ATTRIBUTE
  i386: kvm: Add support for exposing PROVISIONKEY to guest
  i386: Propagate SGX CPUID sub-leafs to KVM
  i386: Adjust min CPUID level to 0x12 when SGX is enabled
  hw/i386/pc: Set SGX bits in feature control fw_cfg accordingly
  hw/i386/pc: Account for SGX EPC sections when calculating device
    memory
  i386/pc: Add e820 entry for SGX EPC section(s)
  i386: acpi: Add SGX EPC entry to ACPI tables
  q35: Add support for SGX EPC
  i440fx: Add support for SGX EPC

 backends/Makefile.objs    |   1 +
 backends/hostmem-epc.c    |  91 ++++++++++++
 hw/i386/Makefile.objs     |   1 +
 hw/i386/acpi-build.c      |  22 +++
 hw/i386/pc.c              |  23 ++-
 hw/i386/pc_piix.c         |   3 +
 hw/i386/pc_q35.c          |   2 +
 hw/i386/sgx-epc.c         | 291 ++++++++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h      |   3 +
 include/hw/i386/sgx-epc.h |  75 ++++++++++
 linux-headers/linux/kvm.h |   1 +
 qapi/misc.json            |  32 ++++-
 qemu-options.hx           |  12 ++
 target/i386/cpu.c         | 148 ++++++++++++++++++-
 target/i386/cpu.h         |  14 ++
 target/i386/kvm-stub.c    |   5 +
 target/i386/kvm.c         |  70 +++++++++
 target/i386/kvm_i386.h    |   3 +
 target/i386/machine.c     |  20 +++
 vl.c                      |   9 ++
 20 files changed, 820 insertions(+), 6 deletions(-)
 create mode 100644 backends/hostmem-epc.c
 create mode 100644 hw/i386/sgx-epc.c
 create mode 100644 include/hw/i386/sgx-epc.h

-- 
2.22.0


