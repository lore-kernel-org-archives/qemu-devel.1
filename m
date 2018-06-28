Received: from eggs.gnu.org ([2001:4830:134:3::10]:36176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYTx6-0007zn-3h
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYTx2-0004zO-Va
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:15:00 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:32873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fYTx2-0004mL-On
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:14:56 -0400
Received: from player755.ha.ovh.net (unknown [10.109.122.11])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id A961B1BC788
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 12:14:46 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 28 Jun 2018 12:14:25 +0200
Message-ID: <153018086531.336571.17029459443980070626.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/3] spapr: fix regression with older machine
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

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

As a bonus, the last patch is a tentative to be able to detect
such misuse of *_enabled() accelerator helpers earlier.

Please comment.

[*] it also breaks PR KVM actually, but the error is different and
    I need to dig some more.

--
Greg

---

Greg Kurz (3):
      target/ppc/kvm: don't pass cpu to kvm_get_smmu_info()
      spapr: compute default value of "hpt-max-page-size" later
      accel: forbid early use of kvm_enabled() and friends


 accel/accel.c           |    7 +++++++
 hw/ppc/spapr.c          |   25 ++++++++++++++++++-------
 include/qemu-common.h   |    3 ++-
 include/sysemu/accel.h  |    1 +
 include/sysemu/kvm.h    |    3 ++-
 qom/cpu.c               |    1 +
 stubs/Makefile.objs     |    1 +
 stubs/accel.c           |   14 ++++++++++++++
 target/i386/hax-all.c   |    2 +-
 target/i386/whpx-all.c  |    2 +-
 target/ppc/kvm.c        |   37 ++++++++++++++++++-------------------
 target/ppc/mmu-hash64.h |    8 +++++++-
 12 files changed, 73 insertions(+), 31 deletions(-)
