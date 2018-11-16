Received: from eggs.gnu.org ([2001:4830:134:3::10]:47459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gNWP7-0003Kn-30
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 00:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gNWP3-0006a0-Gw
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 00:10:53 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59973)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gNWP0-0006Xj-P6
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 00:10:47 -0500
Date: Fri, 16 Nov 2018 00:10:40 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181116051040.GA25165@flamenco>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
	<20181114010014.GA19024@flamenco>
	<d15fa143-ab52-3de9-29f0-ff794cec6ac3@linaro.org>
	<20181115184827.GA12024@flamenco>
	<06e66024-1abb-e5b7-591c-3633b5cb3e31@linaro.org>
	<20181116011338.GB17566@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116011338.GB17566@flamenco>
Subject: Re: [Qemu-devel] [PATCH for-4.0 00/17] tcg: Move softmmu out-of-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Thu, Nov 15, 2018 at 20:13:38 -0500, Emilio G. Cota wrote:
> I'll generate now some more perf numbers that we could include in the
> commit logs.

SPEC numbers are a net perf decrease, unfortunately:

                     Softmmu speedup for SPEC06int (test set)
   1.1 +-+--+----+----+----+----+----+----+---+----+----+----+----+----+--+-+
       |                                                                    |
       |                                                      aft+++        |
  1.05 +-+........................................................|.......+-+
       |                                               +++        |         |
       |                       +++                      |         |         |
       |   +++                  |                       |         |         |
     1 +-++++++++++++++++****++++++++++++++++++++++++++++++++++++***+++++++-+
       |    |         |  *  * ****                     ****      *|*        |
       |   ***  +++   |  *  * * |*       +++           *| *      *|*        |
  0.95 +-+.*|*..***...|..*..*.*.|*..+++...|............*|.*.+++..*|*..+++.+-+
       |   *|*  *+*  *** *  * * |*   |    |  +++       *| * ***  *|*  ***   |
       |   *+*  * *  *|* *  * *++*   |  ****  |        *| * *+*  *|*  *+*   |
       |   * *  * *  *|* *  * *  * **** * |* ****      *++* * *  *+*  * *   |
   0.9 +-+.*.*..*.*..*+*.*..*.*..*.*.|*.*.|*.*|.*......*..*.*.*..*.*..*.*.+-+
       |   * *  * *  * * *  * *  * *++* *++* *++* +++  *  * * *  * *  * *   |
       |   * *  * *  * * *  * *  * *  * *  * *  *  |   *  * * *  * *  * *   |
  0.85 +-+.*.*..*.*..*.*.*..*.*..*.*..*.*..*.*..*..|...*..*.*.*..*.*..*.*.+-+
       |   * *  * *  * * *  * *  * *  * *  * *  *  |   *  * * *  * *  * *   |
       |   * *  * *  * * *  * *  * *  * *  * *  * **** *  * * *  * *  * *   |
       |   * *  * *  * * *  * *  * *  * *  * *  * *| * *  * * *  * *  * *   |
   0.8 +-+.*.*..*.*..*.*.*..*.*..*.*..*.*..*.*..*.*|.*.*..*.*.*..*.*..*.*.+-+
       |   * *  * *  * * *  * *  * *  * *  * *  * *| * *  * * *  * *  * *   |
       |   * *  * *  * * *  * *  * *  * *  * *  * *++* *  * * *  * *  * *   |
  0.75 +-+-***--***--***-****-****-****-****-****-****-****-***--***--***-+-+
        401.bzi403.g429445.g456.462.libq464.h471.omn4483.xalancbgeomean
  png: https://imgur.com/aO39gyP

Turns out that the additional instructions are the problem,
despite the much lower icache miss rate. For instance, here
are some numbers for h264ref running on the not-so-recent
Xeon E5-2643 (i.e. Sandy Bridge):

- Before:
 1,137,737,512,668      instructions              #    2.02  insns per cycle
   563,574,505,040      cycles
     5,663,616,681      L1-icache-load-misses
     164.091239774 seconds time elapsed

- After:
 1,216,600,582,476      instructions              #    2.06  insns per cycle        
   591,888,969,223      cycles                                                      
     3,082,426,508      L1-icache-load-misses                                       

     172.232292897 seconds time elapsed

It's possible that newer machines with larger reorder buffers
will be able to take better advantage of the higher instruction
locality, hiding the latency of having to execute more instructions.
I'll test on Skylake tomorrow.

Thanks,

		E.
