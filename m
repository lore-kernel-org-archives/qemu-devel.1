Received: from eggs.gnu.org ([2001:4830:134:3::10]:44068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7SEo-0007fs-Sh
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7SEj-0001My-RH
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:29:50 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49719)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g7SEj-0001LQ-Kw
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:29:45 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue,  2 Oct 2018 17:29:18 -0400
Message-Id: <20181002212921.30982-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/3] per-TLB lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This series introduces a per-TLB lock. This removes existing UB
(e.g. memset racing with cmpxchg on another thread while flushing),
and in my opinion makes the TLB code simpler to understand.

I had a bit of trouble finding the best place to initialize the
mutex, since it has to be called before tlb_flush, and tlb_flush
is called quite early during cpu initialization. I settled on
cpu_exec_realizefn, since then cpu->env_ptr has been set
but tlb_flush hasn't yet been called.

Perf-wise this change does have a small impact (~2% slowdown for
the aarch64 bootup+shutdown test; 1.2% comes from using atomic_read
consistently), but I think this is a fair price for avoiding UB.
Numbers below.

Initially I tried using atomics instead of memset for flushing (i.e.
no mutex), and the slowdown is close to 2X due to the repeated
(full) memory barriers. That's when I turned to using a lock.

Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz

- Before this series:
 Performance counter stats for 'taskset -c 0 ../img/aarch64/die.sh' (10 runs):

       7464.797838      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.14% )
    31,473,652,436      cycles                    #    4.216 GHz                      ( +-  0.14% )
    57,032,288,549      instructions              #    1.81  insns per cycle          ( +-  0.08% )
    10,239,975,873      branches                  # 1371.769 M/sec                    ( +-  0.07% )
       172,150,358      branch-misses             #    1.68% of all branches          ( +-  0.12% )

       7.482009203 seconds time elapsed                                          ( +-  0.18% )

- After:
 Performance counter stats for 'taskset -c 0 ../img/aarch64/die.sh' (10 runs):
       7621.625434      task-clock (msec)         #    0.999 CPUs utilized            ( +-  0.10% )
    32,149,898,976      cycles                    #    4.218 GHz                      ( +-  0.10% )
    58,168,454,452      instructions              #    1.81  insns per cycle          ( +-  0.10% )
    10,486,183,612      branches                  # 1375.846 M/sec                    ( +-  0.10% )
       173,900,633      branch-misses             #    1.66% of all branches          ( +-  0.11% )

       7.632067213 seconds time elapsed                                          ( +-  0.10% )

This series is checkpatch-clean. You can fetch the code from:
  https://github.com/cota/qemu/tree/tlb-lock

Thanks,

		Emilio
