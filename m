Received: from eggs.gnu.org ([209.51.188.92]:56125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1guKed-0007PH-Lm
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1guKSZ-0007zx-4U
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:06:04 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1guKSY-0007v4-Mm
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:06:03 -0500
Date: Thu, 14 Feb 2019 12:05:56 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190214170556.GA23920@flamenco>
References: <20190214040652.4811-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214040652.4811-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/4] target/arm: Reduce overhead of
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

On Wed, Feb 13, 2019 at 20:06:48 -0800, Richard Henderson wrote:
> We've talked about this before, caching state to reduce the
> amount of computation that happens looking up each TB.
> 
> I know that Peter has been concerned that we would not be able to 
> reliably maintain all of the places that need to be updates to
> keep this up-to-date.
> 
> Well, modulo dirty tricks within linux-user, it appears as if
> exception delivery and return, plus after every TB-ending write
> to a system register is sufficient.
> 
> There seems to be a noticable improvement, although wall-time
> is harder to come by -- all of my system-level measurements
> include user input, and my user-level measurements seem to be
> too small to matter.

Thanks for this!

Some SPEC06int user-mode numbers (before vs. after)

                   aarch64-linux-user speedup for SPEC06int (test set)
                      Host: Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz

                      2 +-----------------------------------------+
                        |                                         |
                    1.9 |-+.........................a+-+r.......+-|
                        |                            +-+          |
                        |                            * *          |
                    1.8 |-+..........................*.*........+-|
                        |       +-+                  * *          |
                    1.7 |-+.....+-+...............+-+*.*...+-+..+-|
                        |       * *         +-+   * ** *   +-+    |
                    1.6 |-+.....*.*..........|....*.**.*+-+*.*..+-|
                        |       * *         *|*   * ** *+-+* *    |
                    1.5 |-+.....*.*.........*|*...*.**.**.**.*..+-|
                        |       * *         +-+   * ** ** ** *    |
                        |       * *         * *   * ** ** ** *    |
                    1.4 |-+.....*.*.........*.*...*.**.**.**.*+-+-|
                        |       * *   +-+   * *   * ** ** ** ** * |
                    1.3 |-+.....*.*...+-+...*.*...*.**.**.**.**.*-|
                        | +-+   * *   * *   * *   * ** ** ** ** * |
                    1.2 |-+-+...*.*...*.*...*.*...*.**.**.**.**.*-|
                        | * *   * *   * *   * *   * ** ** ** ** * |
                        | * *   * *   * *+-+* *   * ** ** ** ** * |
                    1.1 |-*.*...*.*...*.**.**.*...*.**.**.**.**.*-|
                        | * *+-+* *+-+* ** ** *+-+* ** ** ** ** * |
                      1 +-----------------------------------------+
              400.per401.b40344454462.li464471.483.xalangeomean
 png: https://imgur.com/RjkYYJ5

That is, a 1.4x average speedup.

		Emilio
