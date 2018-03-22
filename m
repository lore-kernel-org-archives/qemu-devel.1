Received: from eggs.gnu.org ([2001:4830:134:3::10]:37847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1ez02p-00057F-2C
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1ez02l-0000bb-SU
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:14:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1ez02l-0000aF-N4
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:14:11 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Thu, 22 Mar 2018 14:13:56 +0100
Message-Id: <20180322131358.15096-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/2] i386/kvm: TSC page clocksource for
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

Changes since v3:
- check cpu->hyperv_reenlightenment instead of has_msr_reenlightenment
  [Eduardo Habkost, Roman Kagan]
- expose frequency MSRs only when either INVTSC or Reenlightenment is
  provided [Paolo Bonzini] (I'm not doing 'hv_frequency' property for now
  as the discussion around it seems to be inconclusive.)

Previously, Ladi was working on enabling TSC page clocksource for nested
Hyper-V-on-KVM workloads. He found out that if Hyper-V frequency MSRs are
exposed to L1 as well as INVTSC flag Hyper-V enables TSC page clocksource
to its guests. Qemu doesn't pass INVTSC by default as it is a migration
blocker.

I found out there's a different way to make Hyper-V like us: expose
Reenlightenment MSRs to it. KVM doesn't fully support the feature as
we're still unable to migrate nested environments but rudimentary support
we have there (kvm/queue currently) is enough.

Enable Hyper-V reenlightenment MSRs and expose frequency MSRs even without
INVTSC to make things work.

Vitaly Kuznetsov (2):
  i386/kvm: add support for Hyper-V reenlightenment MSRs
  i386/kvm: expose Hyper-V frequency MSRs with reenlightenment

 target/i386/cpu.c          |  4 +++-
 target/i386/cpu.h          |  4 ++++
 target/i386/hyperv-proto.h |  9 ++++++++-
 target/i386/kvm.c          | 41 +++++++++++++++++++++++++++++++++++++++--
 target/i386/machine.c      | 24 ++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 4 deletions(-)

-- 
2.14.3
