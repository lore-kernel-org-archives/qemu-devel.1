Received: from eggs.gnu.org ([2001:4830:134:3::10]:48707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dv3uK-0007ZU-Bt
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dv3uG-000591-3q
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:00:56 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:34890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dv3uF-00058Z-UT
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:00:52 -0400
Received: from player687.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 2932573769
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 18:00:49 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 21 Sep 2017 18:00:41 +0200
Message-ID: <150600964184.30533.472565821627831467.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 0/2] kvm: use kvm_vm_check_extension() with
 VM capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Some VM capabilities are currently checked with kvm_check_extension(). This
doesn't have any impact for most host architectures because they don't depend
on the KVM type. However, this is a problem for server-class ppc hosts that
can support the PR and HV KVM types. Both implementations can co-exist in the
kernel at the same time and we decide which one will be used with the "type"
argument of the KVM_CREATE_VM ioctl.

Each KVM type has a different set of capabilities, and checking them with
kvm_check_extension() will always cause KVM to assume we're in HV mode,
even if they are VM specific and we have explicitely requested to run in
PR mode. This may produce unexpected results.

Similar issues were recently fixed in the ppc code:

https://github.com/qemu/qemu/commit/70a0c19e83aa4c71c879d51e426e89e4b3d4e014
https://github.com/dgibson/qemu/commit/b152d74ebaed61f89fa1ab2c9b1526d9e9dabae5

This series focuses on capabilities that are checked by the common code.

--
Greg

---

Greg Kurz (2):
      kvm: check KVM_CAP_SYNC_MMU with kvm_vm_check_extension()
      kvm: check KVM_CAP_NR_VCPUS with kvm_vm_check_extension()


 accel/kvm/kvm-all.c    |   51 +++++++++++++++++++++++++-----------------------
 accel/stubs/kvm-stub.c |    4 ++--
 include/sysemu/kvm.h   |    2 +-
 3 files changed, 30 insertions(+), 27 deletions(-)
