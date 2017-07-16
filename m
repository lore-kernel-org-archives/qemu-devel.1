Received: from eggs.gnu.org ([2001:4830:134:3::10]:46117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmY-0001Ad-Vb
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmU-0008GW-E2
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmU-0008FK-87
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:03:43 -0400
Message-Id: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 00/45] tcg: support for multiple TCG contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

v1:
  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02059.html

Thanks all for your comments on v1.

This v2 patchset applies on top of stefanha's tracing tree (9212a18e371):
  https://github.com/stefanha/qemu/tree/tracing
That tree has some changes (per-vcpu TCG tracing) that would conflict
with many of the patches in this series. So I based the series on that
tree.

To ease review/testing, you can pull this series from:
  https://github.com/cota/qemu/tree/multi-tcg-v2

Note: patches 1 and 2 are already on master, but not yet on stefanha's tree.
So I'm leaving them here.

Note: I cannot even compile-test _WIN32 bits, help appreciated! See
patches 40-41.

Changes from v1:
- Added R-b tags
- Added comments to the commit logs about the atomic_set/read thing.
- Renamed have_tb_lock to acquired_tb_lock in tb_find
- Merged tb->invalid into tb->cflags
  - Cleaned up the checking of the tb->invalid field
- Consolidated TB lookups into a common tb_lookup__cpu_state function
  - Removed addr argument from lookup_tb_ptr
- Defined CF_PARALLEL, and used it for hashing. Incorporated Richard's
  feedback on the previous patch, including:
  - Removed use of parallel_cpus from target/*
  - Removed use of parallel_cpus from tcg/*
  - Moved down the exclusive region in cpu_exec_step_atomic
    - Brought cpu_exec_step into cpu_exec_step_atomic
- Defined and used DEBUG_*_GATE in translate-all
  - Introduced TB_PAGE_ADDR_FMT
- Defined struct tb_tc to bring together tb->tc_{ptr,search,size}
  - Used the struct for g_tree comparisons
  - The struct has now a 4-byte hole, but really given the added
    tb->trace_vcpu_dstate field (a u32) we probably can just live
    with it.
- renamed tb_free to tb_remove
- Use size_t everywhere when counting TB's and code size
- Moved tci_regs to tcg_qemu_tb_exec's stack
- Defined tcg_init_ctx and made tcg_ctx a pointer
- Switched to dynamic allocation of TCG optimizer globals
  - Folded them into TCGContext
- Introduced an array of *tcg_ctx's (instead of a list) to keep track
  of TCGContexts.
- Wrapped a macro with do..while(0) in the TCGProf patch to please checkpatch
- Moved qemu_real_host_page_size/mask to osdep
  - Introduced qemu_mprotect_rwx/none in osdep
    - Used these helpers instead of local inlines in translate-all.c
- TCG regions:
  - tcg_region_init takes a desired number of regions, not a desired
    region size.
      - TCG region sizes are a multiple of the host's page size
  - Add a guard page at the end of each region
    - Do not allocate a guard page when allocating code_gen_buffer
  - switched tcg_region_alloc to positive logic (return true on error)
  - Document non-trivial functions (N.B. some doc added in the region
    patch, but quite a bit more is added in the "multiple TCG context"
    patch)
  - Simplified initialization: child TCG threads just have to call
    tcg_register_thread(). All other initialization is done by the
    parent thread.
  - Changed the place at which we call tcg_region_init in softmmu,
    so that we can check whether mttcg is enabled when deciding
    how many regions to have.
    - Use 1 region when !mttcg.
- Dropped the "do not hold tb_lock" patch for now; the patchset is
  already too long, and to do a good job there takes more than just
  one patch. I have already started working on that though, based
  on the feedback from v1.

Thanks,

		Emilio
