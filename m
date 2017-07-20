Received: from eggs.gnu.org ([2001:4830:134:3::10]:60140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qM-00016N-At
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qJ-0005on-0U
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dY1qI-0005ng-S3
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:34 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 19 Jul 2017 23:08:46 -0400
Message-Id: <1500520169-23367-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 00/43] tcg: support for multiple TCG contexts
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

v2:
  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04749.html

v3 applies on top of the current master (d4e59218a).

To ease review/testing, you can pull this series from:
  https://github.com/cota/qemu/tree/multi-tcg-v3

Note: I cannot even compile-test _WIN32 bits, help appreciated! See
patches 39/40.

Changes from v2:
- Rebase on top of current master (therefore dropping the first 2 patches,
  which are already on master)
  - Add sh4 bits, touching:
    - Removal of argument to tb_lookup_ptr (merged into otherwise same v2 patch)
    - tb_cflags() inline (new patch in v3 for sh4 and all other arches)
    - CF_PARALLEL instead of parallel_cpus (sh4-only patch in v3)
- Add R-b tags
- Drop the patch removing the tb->invalid check.
- Introduce the patch implementing tb_lookup__cpu_state before the patches
  that fiddle with tb->cflags, so that we have a single place where to
  do that fiddling
  - Update commit log of the tb_lookup__cpu_state patch explaining
    why tb->invalid must be checked when obtaining the *tb from tb_jmp_cache
- Improve comment next to CF_INVALID
- CF_PARALLEL:
  - Introduce tb_cflags inline to hide the atomic_read
    - Add an extra patch to convert tb->cflags readers to tb_cflags
  - Rename curr_cf_mask() to curr_cflags()
    - Remove many superfluous if (parallel_cpus) checks; just call curr_cflags()
  - Drop tb_cf_mask(); use CF_HASH_MASK instead
  - m68k: use gen_helper_exit_atomic instead of implementing cas2w_parallel
  - s390x: Richard: I dropped your R-b tag because v3 also includes csst.
  - sh4: add sh4 patch, as mentioned above
  - tcg_ctx.cf_parallel: use a bool instead of a u8
  - Do if (foo && (tb_cflags(tb) & BAR)) instead of (foo && tb_cflags() & BAR)
- Use a size_t for struct tb_tc.size, plugging the 4-byte hole
- Dynamically allocate TCG optimizer globals
  - Use directly a bitmap, instead of TCGTempSet for temps_used, which
    saves some space
  - Add perf numbers for the change: ~2% slowdown
- **tcg_ctxs: get rid of tcg_ctxs_init
- TCGProfile: s/PROF_ADD_MAX/PROF_MAX/
- real_host_page_size: move to its own file with an init constructor,
  as suggested by Richard (Richard: I kept your R-b tag).
- qemu_mprotect helpers: g_assert on page-aligned address and size
  - Adapt callers in translate-all.c to pass page-aligned address and size
- TCG regions:
  - Hide the computation of n_regions from tcg_region_init's callers. The
    function now takes no arguments. Add a comment about
    qemu_tcg_mttcg_enabled().
  - if (!inited) { inited = true; do_init(); } in cpus.c
  - Use assert instead of if (err) tcg_abort();
  - Use QEMU_ALIGN_DOWN instead of &= mask
  - Inline set_guard_pages() into tcg_region_init
  - Merge patch that removes code_gen_buffer's guard page into the TCG
    regions' patch
- TCG __thread:
  - Inline tcg_ctxs_init into tcg_context_init
  - Move the code that determines the number of regions from the previous
    patch to this patch.

To be done after this series:
- Get rid of tb_lock, or at least push it down so that we take advantage of
  multiple TCG contexts in MTTCG. (I'm doing this in my testing, but doing
  it well will require another patch series.)

Improvements that were suggested during this series' development:
- Order tb->[*] comparisons by likelihood of mismatch.
- Get rid of parallel_cpus from from cpu_exec_step_atomic -- I'm not sure
  whether just removing it is safe, since we call curr_cflags from several
  places.
- Perhaps parse -accel=tcg command-line arguments before TCG is initialized,
  so that those arguments can be used during TCG initialization.

Thanks,

		Emilio
