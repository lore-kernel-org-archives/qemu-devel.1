Received: from eggs.gnu.org ([2001:4830:134:3::10]:50155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1evP7w-0004P9-Gr
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1evP7s-00040o-GJ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:12:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52726 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1evP7s-0003zq-Bw
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:12:36 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Mon, 12 Mar 2018 16:12:31 +0100
Message-Id: <20180312151233.16565-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] i386/kvm: TSC page clocksource for
 Hyper-V-on-KVM fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org

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

[My first patches for Qemu, please be nice :-) ]

Vitaly Kuznetsov (2):
  i386/kvm: add support for Hyper-V reenlightenment MSRs
  i386/kvm: lower requirements for Hyper-V frequency MSRs exposure

 target/i386/cpu.h          |  3 +++
 target/i386/hyperv-proto.h |  9 ++++++++-
 target/i386/kvm.c          | 35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 2 deletions(-)

-- 
2.14.3
