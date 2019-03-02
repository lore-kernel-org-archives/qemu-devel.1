Received: from eggs.gnu.org ([209.51.188.92]:33312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gztr2-0001ou-DI
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 20:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gztmI-0008GF-Nj
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 20:49:27 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gztmI-0008CE-5M
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 20:49:26 -0500
Date: Fri, 1 Mar 2019 20:49:21 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190302014921.GA5081@flamenco>
References: <20190222024106.9167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222024106.9167-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org

On Thu, Feb 21, 2019 at 18:41:03 -0800, Richard Henderson wrote:
> Changes since v2:
>   * Do not cache VECLEN, VECSTRIDE, VFPEN.
>     These variables come from VFP_FPSCR and VFP_FPEXC, not from
>     system control registers.
>   * Move HANDLER and STACKCHECK to rebuild_hflags_a32,
>     instead of building them in rebuild_hflags_common.

Tested-by: Emilio G. Cota <cota@braap.org>

You might want to add these numbers (I re-ran the benchmarks for v3)
to patch 3's commit log:

                        aarch64-linux-user SPEC06int (train set)
                     Host: Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz
         2.2 +--------------------------------------------------------------+
             |                                                              |
             |                                                after         |
           2 |-+.........................................+-+..............+-|
             |                                            |                 |
             |                                           *|*                |
             |                                           *|*      +-+       |
         1.8 |-+..........+-+............................+-+.......|......+-|
             |             |                             * *       |        |
             |           **|*               +-+     *+-+ * *      *|*       |
         1.6 |-+.........*+-+..............**|*.....*..*.*.*.*+-+.*|*.....+-|
             |           *  *              *+-+     *  * * * *+-+ *|*       |
             |           *  *              *  *     *  * * * *  * +-+       |
         1.4 |-+.........*..*......+-+.....*..*.....*..*.*.*.*..*.*.*.*+-++-|
             |           *  *     **|*     *  *     *  * * * *  * * * *+-+  |
             |  *+-+     *  *     *+-+     *  *     *  * * * *  * * * *  *  |
         1.2 |-+*+-+.....*..*.....*..*.....*..*.....*..*.*.*.*..*.*.*.*..*+-|
             |  *  * +-+ *  *     *  * +-+ *  *     *  * * * *  * * * *  *  |
             |  *  *  |  *  * +-+ *  * +-+ *  * +-+ *  * * * *  * * * *  *  |
             |  *  * *|* *  * *|* *  * * * *  * +-+ *  * * * *  * * * *  *  |
           1 |++*++*++-++*++*++-++*++*+*+*+*++*+*+*+*++*+*+*+*++*+*+*+*++*++|
             |  *  * * * *  * * * *  * * * *  * * * *  * * * *  * * * *  *  |
             |  *  * * * *  * * * *  * * * *  * * * *  * * * *  * * * *  *  |
         0.8 +--------------------------------------------------------------+
     400.perl401.bzi403.429445.456.462.libq464.471.omn483.xalancbgeomean
  png: https://imgur.com/wr4ODMw

Thanks,

		Emilio
