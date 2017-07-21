Received: from eggs.gnu.org ([2001:4830:134:3::10]:55926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYQyM-0002RL-AR
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYQyJ-0001pm-4L
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:59:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYQyI-0001p7-S9
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 01:59:31 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 21 Jul 2017 01:59:18 -0400
Message-Id: <1500616763-26560-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 00/43] tcg: support for multiple TCG contexts
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

v3:
  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06353.html

To ease review/testing, you can pull this series from:
  https://github.com/cota/qemu/tree/multi-tcg-v4
  [ head commit: 1d50a9f24e ]

In this iteration I'm sending only the few patches that contain changes
from v3; they are highlighted in the change list below.

Changes from v3:
- Add R-b tags
- Rebase on top of current master (25d0233c1)
- [PATCH 11] tb->cflags hashing: add CF_COUNT_MASK to CF_HASH_MASK
  - [PATCH 20] tcg_ctx.cf_parallel: convert to tcg_ctx.tb_cflags (Richard:
    kept your R-b)
- [PATCH 35] TCG optimizer: allocate using tcg_malloc (Richard: dropped
  your R-b)
- [PATCH 42] TCG regions:
  - expand first and last regions to fully use the buffer
    - use tcg_region_bounds as suggested by Richard
    - substitute regions.n_full with region.agg_full_size since now
      not all regions are of the same size
  - add region.stride and .start_aligned fields
    - Only use qemu_real_host_page_size once in the file; guard size
      is derived as 'region.stride - region.size'
- [PATCH 43] TCG __thread: (Richard: kept your R-b)
  - do not assume CONFIG_SOFTMMU == !CONFIG_USER_ONLY
  - use atomic_read/set on tcg_ctxs[] as well
  - Remove unnecessary clearing of tcg_ctx->prof in tcg_register_thread()

To be done after this series:
- Get rid of tb_lock, or at least push it down so that we take advantage of
  multiple TCG contexts in MTTCG. (I'm doing this in my testing, but doing
  it well will require another patch series.)

Improvements that were suggested during this series' development:
- Perhaps look at arranging fields such that all the fields that are
  "shared" between the contexts are up front, and use the qemu standard
  'memcpy(new, old, offsetof(TCGContext, end_common_fields));' trick, and
  zero the rest.
- Order tb->[*] comparisons by likelihood of mismatch.
- Get rid of parallel_cpus from from cpu_exec_step_atomic -- I'm not sure
  whether just removing it is safe, since we call curr_cflags from several
  places.
- Add CF_NOCHAIN flag, that tcg-op can check via tcg_ctx->tb_cflags.
- Expand CF_HASH_MASK to compare all bits in cflags. Would require cleaning
  CF_IGNORE_ICOUNT up.
- Perhaps parse -accel=tcg command-line arguments before TCG is initialized,
  so that those arguments can be used during TCG initialization.

Thanks,

		Emilio
