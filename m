Received: from eggs.gnu.org ([2001:4830:134:3::10]:50152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1evP7w-0004P5-G3
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1evP7u-00044D-I5
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:12:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1evP7u-00043h-EG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:12:38 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Mon, 12 Mar 2018 16:12:33 +0100
Message-Id: <20180312151233.16565-3-vkuznets@redhat.com>
In-Reply-To: <20180312151233.16565-1-vkuznets@redhat.com>
References: <20180312151233.16565-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] i386/kvm: lower requirements for Hyper-V
 frequency MSRs exposure
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

Requiring tsc_is_stable_and_known() is too restrictive: even without INVTCS
nested Hyper-V-on-KVM enables TSC pages for its guests e.g. when
Reenlightenment MSRs are present. Presence of frequency MSRs doesn't mean
these frequencies are stable, it just means they're available for reading.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 21e06deaf1..43c521f61a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -646,7 +646,7 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
         env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
 
-        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
+        if (has_msr_hv_frequencies && env->tsc_khz) {
             env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
             env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
         }
-- 
2.14.3
