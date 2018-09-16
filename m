Received: from eggs.gnu.org ([2001:4830:134:3::10]:54521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g1WS4-00067Y-2V
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 08:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1g1WS0-0006Ov-UZ
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 08:47:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1g1WS0-0006Nx-Kz
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 08:46:56 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Sun, 16 Sep 2018 15:46:29 +0300
Message-Id: <20180916124631.39016-1-liran.alon@oracle.com>
Subject: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for save
 and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, jmattson@google.com

Hi,

This series aims to add support for QEMU to be able to migrate VMs that
are running nested hypervisors. In order to do so, it utilizes the new
IOCTLs introduced in KVM commit 8fcc4b5923af ("kvm: nVMX: Introduce
KVM_CAP_NESTED_STATE") which were created for this purpose.

1st patch is not really related to the goal of the patch series. It just
makes CPUX86State->xsave_buf to be compiled only when needed (When
compiling with KVM or HVF CPU accelerator).

2nd patch adds the support to migrate VMs that are running nested
hypervisors.

Regards,
-Liran

v1->v2 Changes:
* Renamed kvm_nested_state_length() to kvm_max_nested_state_length()
to better indicate it represents the max nested state size that can
be returned from kernel.
* Added error_report() calls to nested_state_post_load() to make
failures in migration easier to diagnose.
* Fixed support of migrating with various nested_state buffer sizes.
The following scenarios were tested:
(a) src and dest have same nested state size.
	==> Migration succeeds.
(b) src don't have nested state while dest do.
	==> Migration succeed and src don't send it's nested state.
(c) src have nested state while dest don't.
	==> Migration fails as it cannot restore nested state.
(d) dest have bigger max nested state size than src
	==> Migration succeeds.
(e) dest have smaller max nested state size than src but enough to store it's saved nested state
	==> Migration succeeds
(f) dest have smaller max nested state size than src but not enough to store it's saved nested state
	==> Migration fails
