Received: from eggs.gnu.org ([2001:4830:134:3::10]:55412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dR5tX-0004v4-IS
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 20:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dR5tT-00047g-AH
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 20:04:15 -0400
Date: Fri, 30 Jun 2017 20:04:08 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170701000408.GA16320@flamenco>
References: <20170630183736.13222-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170630183736.13222-1-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Use tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Fri, Jun 30, 2017 at 11:37:36 -0700, Richard Henderson wrote:
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/ppc/translate.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)

Tested-by: Emilio G. Cota <cota@braap.org>

Just measured the speedup for linux-user:

                                     SPECint06 (test set), ppc64le-linux-user. Host: IBM POWER8 @ 3.42 GHz                                  
                                                                                                                                            
  1.6 +-+------+---------+--------+--------+--------+---------+--------+--------+---------+--------+--------+--------+---------+------+-+   
      |                                                                                   |                                             |   
      |                                                                                   |                               after         |   
  1.5 +-+.................................................................................|...........................................+-+   
      |                                                                                   |                                             |   
      |                                                                                ******                                           |   
  1.4 +-+.....+++.....................................................+++..............*..|.*.....+++.................................+-+   
      |        |                                   +++                 |               *  | *      |                                    |   
      |        |                                    |                  |               *  | *    *****                                  |   
  1.3 +-+......|....................................|..................|...............*..|.*....*.|.*................................+-+   
      |        |                 +++              ******             *****             * +++*    * | *             ******               |   
      |      ******               |               * |  *             * | *             *    *    *+++*             *+++ *               |   
  1.2 +-+....*.|..*...............|...............*.|..*.....+++.....*.|.*.............*....*....*...*.............*....*.............+-+   
      |      * |  *               |               * |  *      |      *+++*             *    *    *   *             *    *   ******      |   
      |      * |  *             *****             *+++ *   ******    *   *             *    *    *   *             *    *   * +++*      |   
  1.1 +-+....*+++.*.............*.|.*.............*....*...*.+++*....*...*.............*....*....*...*.....+++.....*....*...*....*....+-+   
      |      *    *             * | *             *    *   *    *    *   *             *    *    *   *      |      *    *   *    *      |   
      |      *    *             * | *             *    *   *    *    *   *    ******   *    *    *   *      |      *    *   *    *      |   
    1 +-+....*....*.....+++.....*+++*.....+++.....*....*...*....*....*...*....*....*...*....*....*...*....*****....*....*...*....*....+-+   
      |      *    *      |      *   *      |      *    *   *    *    *   *    *    *   *    *    *   *    * | *    *    *   *    *      |   
      |      *    *      |      *   *    *****    *    *   *    *    *   *    *    *   *    *    *   *    * | *    *    *   *    *      |   
  0.9 +-+....*....*...******....*...*....*.|.*....*....*...*....*....*...*....*....*...*....*....*...*....*.|.*....*....*...*....*....+-+   
      |      *    *   *  | *    *   *    * | *    *    *   *    *    *   *    *    *   *    *    *   *    *+++*    *    *   *    *      |   
      |      *    *   * +++*    *   *    *+++*    *    *   *    *    *   *    *    *   *    *    *   *    *   *    *    *   *    *      |   
  0.8 +-+----******---******----*****----*****----******---******----*****----******---******----*****----*****----******---******----+-+   
  400.perlbench 401.bzip2  403.gcc  429.mcf445.gobmk 456.hmmer458.462.libquantu464.h264r471.omnetpp473.a483.xalancbmk     gmean             
png: http://imgur.com/a/twj6V

Thanks,

		Emilio

PS. If you have spec06, you can very easily generate these plots. See
  https://github.com/cota/runspec-simple/commit/14211b927
