Received: from eggs.gnu.org ([2001:4830:134:3::10]:50857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1eyLAG-0007Gg-Oa
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1eyLAF-00082o-GV
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:35:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36988 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1eyLAF-0007tE-DA
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:35:11 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Tue, 20 Mar 2018 18:35:00 +0100
Message-Id: <20180320173500.32065-3-vkuznets@redhat.com>
In-Reply-To: <20180320173500.32065-1-vkuznets@redhat.com>
References: <20180320173500.32065-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/2] i386/kvm: lower requirements for
 Hyper-V frequency MSRs exposure
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

Requiring tsc_is_stable_and_known() is too restrictive: even without INVTCS
nested Hyper-V-on-KVM enables TSC pages for its guests e.g. when
Reenlightenment MSRs are present. Presence of frequency MSRs doesn't mean
these frequencies are stable, it just means they're available for reading.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 7d9f9ca0b1..74fc3d3b2c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -651,7 +651,7 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
         env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
 
-        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
+        if (has_msr_hv_frequencies && env->tsc_khz) {
             env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
             env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
         }
-- 
2.14.3
