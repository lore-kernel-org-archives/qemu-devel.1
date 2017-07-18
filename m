Received: from eggs.gnu.org ([2001:4830:134:3::10]:51978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXaZf-0007iM-D0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXaZb-0002E4-0t
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:02:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dXaZa-0002Cy-LI
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:02:30 -0400
Date: Tue, 18 Jul 2017 18:02:29 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718220229.GA2200@flamenco>
References: <20170714001819.1660-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714001819.1660-1-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 0/8] target/alpha cleanups
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

On Thu, Jul 13, 2017 at 14:18:11 -1000, Richard Henderson wrote:
> The new title holder for perf top is helper_lookup_tb_ptr.
> Those targets that have a complicated cpu_get_tb_cpu_state
> function are going to regret that.
> 
> 
> This cleans up the Alpha version of that function such that it is
> just two loads and one mask.  Which is one practically-free mask
> away from being as minimal as one can get.

Tested-by: Emilio G. Cota <cota@braap.org>
for the series.

I tried to get some perf numbers but really booting linux
doesn't spend much time in lookup_tb_ptr, nor does dbt-bench; so
I get very similar before/after numbers (slight perf decrease for
booting, tiny perf increase for dbt-bench). Numbers are below, FWIW.

		Emilio

* I modified the gentoo-alpha image I'm using [1] to shut down once
it has fully booted. Results before/after this patchset:

 Performance counter stats for 'taskset -c 0 alpha-softmmu/qemu-system-alpha \
	-m 512 -drive \
	file=../img/alpha/die-on-boot.img,media=disk,format=raw,index=0 \
	-kernel ../img/alpha/vmlinux -append root=/dev/sda2 \
	-accel accel=tcg,thread=single -smp 1 -nographic' (10 runs):

Before:

      30586.631281      task-clock (msec)         #    0.883 CPUs utilized            ( +-  0.56% )
            16,373      context-switches          #    0.535 K/sec                    ( +-  1.16% )
                 1      cpu-migrations            #    0.000 K/sec
            10,269      page-faults               #    0.336 K/sec                    ( +-  1.39% )
   128,287,167,139      cycles                    #    4.194 GHz                      ( +-  0.55% )
   <not supported>      stalled-cycles-frontend
   <not supported>      stalled-cycles-backend
   244,179,137,606      instructions              #    1.90  insns per cycle          ( +-  0.66% )
    45,088,775,217      branches                  # 1474.133 M/sec                    ( +-  0.61% )
       267,065,722      branch-misses             #    0.59% of all branches          ( +-  0.84% )

      34.639115913 seconds time elapsed                                          ( +-  0.50% )

After:
      31358.851235      task-clock (msec)         #    0.892 CPUs utilized            ( +-  1.07% )
            16,352      context-switches          #    0.521 K/sec                    ( +-  1.59% )
                 1      cpu-migrations            #    0.000 K/sec
            10,643      page-faults               #    0.339 K/sec                    ( +-  1.18% )
   131,620,007,449      cycles                    #    4.197 GHz                      ( +-  1.07% )
   <not supported>      stalled-cycles-frontend
   <not supported>      stalled-cycles-backend
   249,714,336,126      instructions              #    1.90  insns per cycle          ( +-  1.35% )
    46,259,663,064      branches                  # 1475.171 M/sec                    ( +-  1.27% )
       269,500,888      branch-misses             #    0.58% of all branches          ( +-  0.71% )

      35.136529309 seconds time elapsed                                          ( +-  0.99% )

perf diff doesn't show anything interesting (all differences, <1%, are due to kernel code)

* DBT-bench before/after:
			  NBench score, higher is better
  100 +-+---+-----+-----+----+-----+-----+-----+-----+-----+----+-----+---+-+
      |                    ***##       ***##                                |
   90 +-+..................*+*.#.......*.*.#.................before       +-+
      |                    * * #       * * #                  after         |
      |               ***# * * # +++++ * * #                                |
   80 +-+.......***##.*.*#.*.*.#.***##.*.*.#..............................+-+
      |         * * # * *# * * # * * # * * #                                |
   70 +-+.......*.*.#.*.*#.*.*.#.*.*.#.*.*.#..............................+-+
      |         * * # * *# * * # * * # * * #                                |
      |         * * # * *# * * # * * # * * #                                |
   60 +-+.......*.*.#.*.*#.*.*.#.*.*.#.*.*.#..............................+-+
      |         * * # * *# * * # * * # * * # ***##                          |
   50 +-+.......*.*.#.*.*#.*.*.#.*.*.#.*.*.#.*.*.#........................+-+
      |         * * # * *# * * # * * # * * # * * #                          |
      |         * * # * *# * * # * * # * * # * * #                          |
   40 +-+.......*.*.#.*.*#.*.*.#.*.*.#.*.*.#.*.*.#........................+-+
      |   ***## * * # * *# * * # * * # * * # * * #                          |
   30 +-+.*.*.#.*.*.#.*.*#.*.*.#.*.*.#.*.*.#.*.*.#........................+-+
      |   * * # * * # * *# * * # * * # * * # * * #                  ***##   |
      |   * * # * * # * *# * * # * * # * * # * * #                  * * #   |
   20 +-+.*.*.#.*.*.#.*.*#.*.*.#.*.*.#.*.*.#.*.*.#..................*.*.#.+-+
      |   * * # * * # * *# * * # * * # * * # * * #                  * * #   |
   10 +-+.*.*.#.*.*.#.*.*#.*.*.#.*.*.#.*.*.#.*.*.#..................*.*.#.+-+
      |   * * # * * # * *# * * # * * # * * # * * #                  * * #   |
      |   * * # * * # * *# * * # * * # * * # * * #       ***# ***## * * #   |
    0 +-+-***##-***##-***#-***##-***##-***##-***##-***##-***#-***##-***##-+-+
       STRING SOBFP EMULAASSIGNMENT  IDEHUFFMAFOLU DECOMPOSITION gmean
  png: http://imgur.com/oFFYSKd

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00630.html
