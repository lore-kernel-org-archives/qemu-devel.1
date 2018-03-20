Received: from eggs.gnu.org ([2001:4830:134:3::10]:50812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1eyLAD-00075C-Mc
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1eyLAC-0007wx-UM
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:35:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1eyLAC-0007sa-Qr
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:35:08 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Tue, 20 Mar 2018 18:34:58 +0100
Message-Id: <20180320173500.32065-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] i386/kvm: TSC page clocksource for
 Hyper-V-on-KVM fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, Roman Kagan <rkagan@virtuozzo.com>

Changes since v2:
- add hv-reenlightenment CPU property [Roman Kagan, Paolo Bonzini]
- add a comment to feature_word_info [Roman Kagan]

Previously, Ladi was working on enabling TSC page clocksource for nested
Hyper-V-on-KVM workloads. He found out that if Hyper-V frequency MSRs are
exposed to L1 as well as INVTSC flag Hyper-V enables TSC page clocksource
to its guests. Qemu doesn't pass INVTSC by default as it is a migration
blocker.

I found out there's a different way to make Hyper-V like us: expose
Reenlightenment MSRs to it. KVM doesn't fully support the feature as
we're still unable to migrate nested environments but rudimentary support
we have there (kvm/queue only currently) is enough.

Enable Hyper-V reenlightenment MSRs and expose frequency MSRs even without
INVTSC to make things work.

Vitaly Kuznetsov (2):
  i386/kvm: add support for Hyper-V reenlightenment MSRs
  i386/kvm: lower requirements for Hyper-V frequency MSRs exposure

 target/i386/cpu.c          |  4 +++-
 target/i386/cpu.h          |  4 ++++
 target/i386/hyperv-proto.h |  9 ++++++++-
 target/i386/kvm.c          | 41 +++++++++++++++++++++++++++++++++++++++--
 target/i386/machine.c      | 24 ++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 4 deletions(-)

-- 
2.14.3
