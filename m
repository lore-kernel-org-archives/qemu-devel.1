Received: from eggs.gnu.org ([2001:4830:134:3::10]:44511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mallachiev@ispras.ru>) id 1eK59O-0004Vp-6B
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mallachiev@ispras.ru>) id 1eK59K-0003nP-Vw
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:23:54 -0500
From: Kurban Mallachiev <mallachiev@ispras.ru>
Date: Wed, 29 Nov 2017 19:22:18 +0300
Message-Id: <20171129162219.16288-1-mallachiev@ispras.ru>
Subject: [Qemu-devel] [RFC PATCH 0/1] ppc: loadvm corrupts excp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Kurban Mallachiev <mallachiev@ispras.ru>

On processors which don't support MSR_EP bit, loadvm command set exception prefix to an incorrect value and so guest OS freezes.

In cpu_post_load() there is:
	/* Invalidate all msr bits except MSR_TGPR/MSR_HVB before restoring */
	msr = env->msr;
	env->msr ^= ~((1ULL << MSR_TGPR) | MSR_HVB);
	ppc_store_msr(env, msr);

While hreg_store_msr() (called by ppc_store_msr) contains:
	value &= env->msr_mask;
	...
	if (unlikely((value >> MSR_EP) & 1) != msr_ep) {
	/* Change the exception prefix on PowerPC 601 */
	...

where msr_ep is ((env->msr >> MSR_EP) & 1).

If MSR_EP bit in msr_mask is zero, then MSR_EP in 'value' bit is zero, and MSR_EP bit in env->msr is 1. Condition '(value >> MSR_EP) & 1) != msr_ep' is true and so qemu changes exception prefix.

AFAIU we should multiply env->msr by msr_mask, but I am not sure where we should do it: inside hreg_store_msr or outside. This is why this patch is RFC.

Current version of the patch adds msr_mask multiplication before the hreg_store_msr call.

Kurban

Kurban Mallachiev (1):
  target-ppc: Don't invalidate non-supported msr bits

 target/ppc/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.15.0
