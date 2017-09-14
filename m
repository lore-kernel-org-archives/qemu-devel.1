Received: from eggs.gnu.org ([2001:4830:134:3::10]:53619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsZlV-0001Ps-B9
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsZlR-0005xF-CI
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:25:33 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:54058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsZlR-0005wK-5h
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:25:29 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id D3172ABC7F
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 21:25:27 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Sep 2017 21:25:22 +0200
Message-ID: <150541712226.1616.17581342887936984948.stgit@bahia.lan>
In-Reply-To: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
References: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/3] kvm: check KVM_CAP_SYNC_MMU with
 kvm_vm_check_extension()
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

On a server-class ppc host, this capability depends on the KVM type,
ie, HV or PR. If both KVM are present in the kernel, we will always
get the HV specific value, even if we explicitely requested PR on
the command line.

This can have an impact if we're using hugepages or a balloon device.

Since we've already created the VM at the time any user calls
kvm_has_sync_mmu(), switching to kvm_vm_check_extension() is
enough to fix any potential issue.

It is okay for the other archs that also implement KVM_CAP_SYNC_MMU,
ie, mips, s390, x86 and arm, because they don't depend on the VM being
created or not.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 accel/kvm/kvm-all.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f85553a85194..323c567cfb68 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2234,7 +2234,7 @@ int kvm_device_access(int fd, int group, uint64_t attr,
 /* Return 1 on success, 0 on failure */
 int kvm_has_sync_mmu(void)
 {
-    return kvm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
+    return kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
 }
 
 int kvm_has_vcpu_events(void)
