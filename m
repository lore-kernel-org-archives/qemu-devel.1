Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03DDC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB31520772
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB31520772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEELq-00045I-Jk
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.price@arm.com>)
 id 1kEE8f-0002cy-Vn
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:00:35 -0400
Received: from foss.arm.com ([217.140.110.172]:45922)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steven.price@arm.com>) id 1kEE8c-0001dk-VM
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:00:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2935E11B3;
 Fri,  4 Sep 2020 09:00:27 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD76B3F66F;
 Fri,  4 Sep 2020 09:00:24 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v2 0/2] MTE support for KVM guest
Date: Fri,  4 Sep 2020 17:00:16 +0100
Message-Id: <20200904160018.29481-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=steven.price@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 12:00:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Maydell <Peter.Maydell@arm.com>, Haibo Xu <Haibo.Xu@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, qemu-devel@nongnu.org,
 Dave Martin <Dave.Martin@arm.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Steven Price <steven.price@arm.com>, James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Arm's Memory Tagging Extension (MTE) adds 4 bits of tag data to every 16
bytes of memory in the system. This along with stashing a tag within the
high bit of virtual addresses allows runtime checking of memory
accesses.

These patches add support to KVM to enable MTE within a guest. They are
based on Catalin's v9 MTE user-space support series[1].

I'd welcome feedback on the proposed user-kernel ABI. Specifically this
series currently:

 1. Requires the VMM to enable MTE per-VCPU.
 2. Automatically promotes (normal host) memory given to the guest to be
    tag enabled (sets PG_mte_tagged), if any VCPU has MTE enabled. The
    tags are cleared if the memory wasn't previously MTE enabled.
 3. Doesn't provide any new methods for the VMM to access the tags on
    memory.

(2) and (3) are particularly interesting from the aspect of VM migration.
The guest is able to store/retrieve data in the tags (presumably for the
purpose of tag checking, but architecturally it could be used as just
storage). This means that when migrating a guest the data needs to be
transferred (or saved/restored).

MTE tags are controlled by the same permission model as normal pages
(i.e. a read-only page has read-only tags), so the normal methods of
detecting guest changes to pages can be used. But this would also
require the tags within a page to be migrated at the same time as the
data (since the access control for tags is the same as the normal data
within a page).

(3) may be problematic and I'd welcome input from those familiar with
VMMs. User space cannot access tags unless the memory is mapped with the
PROT_MTE flag. However enabling PROT_MTE will also enable tag checking
for the user space process (assuming the VMM enables tag checking for
the process) and since the tags in memory are controlled by the guest
it's unlikely the VMM would have an appropriately tagged pointer for its
access. This means the VMM would either need to maintain two mappings of
memory (one to access tags, the other to access data) or disable tag
checking during the accesses to data.

If it's not practical to either disable tag checking in the VMM or
maintain multiple mappings then the alternatives I'm aware of are:

 * Provide a KVM-specific method to extract the tags from guest memory.
   This might also have benefits in terms of providing an easy way to
   read bulk tag data from guest memory (since the LDGM instruction
   isn't available at EL0).
 * Provide support for user space setting the TCMA0 or TCMA1 bits in
   TCR_EL1. These would allow the VMM to generate pointers which are not
   tag checked.

Feedback is welcome, and feel free to ask questions if anything in the
above doesn't make sense.

Changes since the previous v1 posting[2]:

 * Rebasing clean-ups
 * sysreg visibility is now controlled based on whether the VCPU has MTE
   enabled or not

[1] https://lore.kernel.org/r/20200904103029.32083-1-catalin.marinas@arm.com
[2] https://lore.kernel.org/r/20200713100102.53664-1-steven.price%40arm.com

Steven Price (2):
  arm64: kvm: Save/restore MTE registers
  arm64: kvm: Introduce MTE VCPU feature

 arch/arm64/include/asm/kvm_emulate.h       |  3 +++
 arch/arm64/include/asm/kvm_host.h          |  9 ++++++++-
 arch/arm64/include/asm/sysreg.h            |  3 ++-
 arch/arm64/include/uapi/asm/kvm.h          |  1 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
 arch/arm64/kvm/mmu.c                       | 15 +++++++++++++++
 arch/arm64/kvm/reset.c                     |  8 ++++++++
 arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
 8 files changed, 66 insertions(+), 7 deletions(-)

-- 
2.20.1


