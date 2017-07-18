Received: from eggs.gnu.org ([2001:4830:134:3::10]:48440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXWY7-0003zV-AB
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXWY4-0006Pd-5v
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:44:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dXWY3-0006P6-Rg
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:44:40 -0400
Date: Tue, 18 Jul 2017 13:44:38 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718174438.GA31298@flamenco>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-44-git-send-email-cota@braap.org>
	<0424e774-a832-5172-11a6-b36b412055e3@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0424e774-a832-5172-11a6-b36b412055e3@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 43/45] tcg: introduce regions to split
 code_gen_buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Mon, Jul 17, 2017 at 19:09:28 -1000, Richard Henderson wrote:
> On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> >+#ifdef CONFIG_SOFTMMU
> >+/*
> >+ * It is likely that some vCPUs will translate more code than others, so we
> >+ * first try to set more regions than smp_cpus, with those regions being
> >+ * larger than the minimum code_gen_buffer size. If that's not possible we
> >+ * make do by evenly dividing the code_gen_buffer among the vCPUs.
> >+ */
> >+void softmmu_tcg_region_init(void)
> >+{
> >+    size_t i;
> >+
> >+    /* Use a single region if all we have is one vCPU thread */
> >+    if (smp_cpus == 1 || !qemu_tcg_mttcg_enabled()) {
> >+        tcg_region_init(0);
> >+        return;
> >+    }
> >+
> >+    for (i = 8; i > 0; i--) {
> >+        size_t regions_per_thread = i;
> >+        size_t region_size;
> >+
> >+        region_size = tcg_init_ctx.code_gen_buffer_size;
> >+        region_size /= smp_cpus * regions_per_thread;
> >+
> >+        if (region_size >= 2 * MIN_CODE_GEN_BUFFER_SIZE) {
> >+            tcg_region_init(smp_cpus * regions_per_thread);
> >+            return;
> >+        }
> >+    }
> >+    tcg_region_init(smp_cpus);
> >+}
> >+#endif
> 
> Any reason this code wouldn't just live in tcg_region_init?
> It would certainly simplify the interface.

Good point. Will move it there, adding a comment to make sure the
function is called once qemu_tcg_mttcg_enabled() has been set up.

		E.
