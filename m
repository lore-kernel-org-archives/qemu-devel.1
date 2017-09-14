Received: from eggs.gnu.org ([2001:4830:134:3::10]:53537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsZlO-0001J3-0e
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsZlK-0005tE-0v
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:25:25 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:51912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsZlJ-0005rO-RT
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:25:21 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 35DCAABC46
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 21:25:18 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Sep 2017 21:25:11 +0200
Message-ID: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/3] kvm: use kvm_vm_check_extension() with VM
 capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

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

A similar issue was recently fix in the ppc code:

https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg03751.html

This series goes a bit further, and turns more kvm_check_extension() into
kvm_vm_check_extension() where appropriate.

--
Greg

---

Greg Kurz (3):
      kvm: check KVM_CAP_SYNC_MMU with kvm_vm_check_extension()
      kvm: check KVM_CAP_NR_VCPUS with kvm_vm_check_extension()
      ppc/kvm: check some capabilities with kvm_vm_check_extension()


 accel/kvm/kvm-all.c |   47 ++++++++++++++++++++++++-----------------------
 target/ppc/kvm.c    |    6 +++---
 2 files changed, 27 insertions(+), 26 deletions(-)
