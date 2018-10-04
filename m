Received: from eggs.gnu.org ([2001:4830:134:3::10]:60721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7uq0-0004r0-Jp
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 00:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7upl-0006OL-AP
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 00:02:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49951)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g7upk-0006L3-VW
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 00:01:53 -0400
Date: Thu, 4 Oct 2018 00:01:47 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181004040147.GA22844@flamenco>
References: <20181003200454.18384-1-cota@braap.org>
	<20181003200454.18384-5-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003200454.18384-5-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] cputlb: read CPUTLBEntry.addr_write
 atomically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Wed, Oct 03, 2018 at 16:04:54 -0400, Emilio G. Cota wrote:
> Updates can come from other threads, so readers that do not
> take tlb_lock must use atomic_read to avoid undefined
> behaviour (UB).
> 
> This and the previous commit result in a small performance decrease,
> but this is a fair price for removing UB.
(snip)
> That is, a ~2% slowdown for the aarch64 bootup+shutdown test.

I've run more tests. This slowdown is much more pronounced on
memory-heavy workloads. These are the numbers for SPEC06int:

                                Speedup over master

  1.05 +-+--+----+----+----+----+----+----+---+----+----+----+----+----+--+-+
       |                                 +++  ||      +++                   |
       |tlb-lock-noatomic      +++        |  **|       |+++                 |
       |          +atomic       |  ++++   |  **##      | |                  |
     1 +-+..+++...............++##.***#...|..**|#......**|................+-+
       |    ###     ***++     ***# *+*# +++  **+#  +++ **##                 |
       |    # #     *+*#      *|*# *+*#  ||  ** # **## **|#                 |
       |    # #     * *#+     *+*# * *#  ||  ** # **+#+**|#     +**  ++###  |
  0.95 +-+..#.#.....*.*#......*.*#.*.*#.***#.**.#.**.#.**|#......**##***+#+-+
       |    # #     * *#      * *# * *# *|*# ** # ** # **+#      **+#* * #  |
       |    # #     * *#      * *# * *# *|*# ** # ** # ** #+++++ ** #* * #  |
   0.9 +-+***.#..+++*.*#......*.*#.*.*#.*+*#.**.#.**.#.**.#+**|..**.#*.*.#+-+
       |  * * #***##* *#      * *# * *# * *# ** # ** # ** # **## ** #* * #  |
       |  * * #* *+#* *#   +++* *# * *# * *# ** # ** # ** # **|# ** #* * #  |
       |  * * #* * #* *# ***# * *# * *# *+*# ** # ** # ** # **+# ** #* * #  |
  0.85 +-+*.*.#*.*.#*.*#.*.*#+*.*#.*.*#.*.*#.**.#.**.#.**.#.**.#.**.#*.*.#+-+
       |  * * #* * #* *# * *# * *# * *# * *# ** # ** # ** # ** # ** #* * #  |
       |  * * #* * #* *# * *# * *# * *# * *# ** # ** # ** # ** # ** #* * #  |
       |  * * #* * #* *# * *# * *# * *# * *# ** # ** # ** # ** # ** #* * #  |
   0.8 +-+***##***##***#-***#-***#-***#-***#-**##-**##-**##-**##-**##***##+-+
        401.bzi403.g429445.g456.462.libq464.h471.omn4483.xalancbgeomean

That is, a 5% average slowdown, with a max slowdown of ~14% for
mcf :-(

I'll profile tomorrow and see where the slowdown comes from.
If the lock is the issue, we might be better off shifting
all the work to the cross-vCPU call (e.g. doing a round of
synchronous cross-vCPU calls via run_on_cpu), if the assumption
that those calls are very rare is correct.

		Emilio
