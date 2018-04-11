Received: from eggs.gnu.org ([2001:4830:134:3::10]:50988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1f6EGw-00047S-Lr
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1f6EGt-0006xe-Jw
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:50:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39272 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1f6EGt-0006xT-FG
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:50:39 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Wed, 11 Apr 2018 13:50:35 +0200
Message-Id: <20180411115036.31832-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/1] i386/kvm: TSC page clocksource for
 Hyper-V-on-KVM fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

Changes since v4:
- Rebase on top of Roman's patches.
- Drop PATCH2 as it is no longer needed (after adding explicit
  hv_frequencies).

Previously, Ladi was working on enabling TSC page clocksource for nested
Hyper-V-on-KVM workloads. He found out that if Hyper-V frequency MSRs are
exposed to L1 as well as INVTSC flag Hyper-V enables TSC page clocksource
to its guests. Qemu doesn't pass INVTSC by default as it is a migration
blocker.

I found out there's a different way to make Hyper-V like us: expose
Reenlightenment MSRs to it. KVM doesn't fully support the feature as
we're still unable to migrate nested environments but rudimentary support
we have there is enough.

Enable Hyper-V reenlightenment MSRs to make things work.

Vitaly Kuznetsov (1):
  i386/kvm: add support for Hyper-V reenlightenment MSRs

 target/i386/cpu.c          |  4 +++-
 target/i386/cpu.h          |  4 ++++
 target/i386/hyperv-proto.h |  9 ++++++++-
 target/i386/kvm.c          | 39 ++++++++++++++++++++++++++++++++++++++-
 target/i386/machine.c      | 24 ++++++++++++++++++++++++
 5 files changed, 77 insertions(+), 3 deletions(-)

-- 
2.14.3
