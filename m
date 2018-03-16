Received: from eggs.gnu.org ([2001:4830:134:3::10]:57117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1ewsid-0005dS-0t
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1ewsiX-0005Xc-J0
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:00:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1ewsiX-0005X9-Fg
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:00:33 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 16 Mar 2018 18:00:20 +0100
Message-Id: <20180316170020.8212-3-vkuznets@redhat.com>
In-Reply-To: <20180316170020.8212-1-vkuznets@redhat.com>
References: <20180316170020.8212-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] i386/kvm: lower requirements for
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
index accf50eac3..a6d1210f46 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -650,7 +650,7 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
         env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
 
-        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
+        if (has_msr_hv_frequencies && env->tsc_khz) {
             env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
             env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
         }
-- 
2.14.3
