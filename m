Received: from eggs.gnu.org ([2001:4830:134:3::10]:47594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYq0q-00016R-0P
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYq0l-00042E-42
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:48:20 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:60982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fYq0k-0003xD-S7
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:48:15 -0400
Received: from player734.ha.ovh.net (unknown [10.109.120.107])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 020CF1C6BC8
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 11:48:12 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 29 Jun 2018 11:48:01 +0200
Message-ID: <153026568125.394407.16374811229961951138.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 0/3] spapr: fix regression with older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

Since the recent cleanups to hide host configuration details from guests,
it isn't possible to start an older machine type with HV KVM [*]:

qemu-system-ppc64: KVM doesn't support for base page shift 34

This basically boils down to the fact that it isn't safe to call
the kvmppc_hpt_needs_host_contiguous_pages() helper from a class
init function because:
- KVM isn't initialized yet, and kvm_enabled() always return false
  in this case. This causes kvmppc_hpt_needs_host_contiguous_pages()
  to do nothing and we end up choosing a 16G default page size
  which is not supported by KVM.
- even if we drop kvm_enabled() we then have the issue that
  kvmppc_hpt_needs_host_contiguous_pages() assumes CPUs are
  created, which isn't the case either.

The choice was made to initialize capabilities during machine
init before creating the CPUs, and I don't think we should
revert to the previous behavior. Let's go forward instead and
ensure we can retrieve the MMU information from KVM before
CPUs are created.

To fix this, we first change kvm_get_smmu_info() so that it
doesn't need a CPU object. This allows to stop using first_cpu
in kvmppc_hpt_needs_host_contiguous_pages(). Then we delay
the setting of the default value to machine init time, so
that we're sure that KVM is fully initialized.

Please comment.

[*] it also breaks PR KVM actually, but the error is different and
    I need to dig some more.

Changes in v2:
- added patch "target/ppc/kvm: get rid of kvm_get_fallback_smmu_info()"
- dropped patch "accel: forbid early use of kvm_enabled() and friends" to
  be sent separately

--
Greg

---

Greg Kurz (3):
      target/ppc/kvm: get rid of kvm_get_fallback_smmu_info()
      target/ppc/kvm: don't pass cpu to kvm_get_smmu_info()
      spapr: compute default value of "hpt-max-page-size" later


 hw/ppc/spapr.c      |   13 +++---
 hw/ppc/spapr_caps.c |   20 +++++++++
 target/ppc/kvm.c    |  118 +++++++++------------------------------------------
 3 files changed, 46 insertions(+), 105 deletions(-)
