Received: from eggs.gnu.org ([2001:4830:134:3::10]:35345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gR4n5-00026p-6W
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gR4n1-0005ad-VD
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:30:19 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44659)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gR4n1-0005a6-Lv
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:30:15 -0500
Date: Sun, 25 Nov 2018 19:30:11 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181126003011.GA12936@flamenco>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 00/37] tcg: Assorted cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com

On Fri, Nov 23, 2018 at 15:45:21 +0100, Richard Henderson wrote:
> This includes everything queued so far -- softmmu out-of-line
> patches

Reviewed-by: Emilio G. Cota <cota@braap.org>
for patches 1-9.

I am sad to report that on a Skylake host, this series gives
a ~10% average slowdown for x86_64-softmmu SPEC06int
(I'm reporting speedup, so <1 means slowdown):
  https://imgur.com/a/25iu8Yl

Turns out that despite the higher icache hit, the IPC
ends up being lower. For instance, here are perf counts when
running hmmer x3 right after booting up (bootup is included
in the counts, but hmmer is run 3 times in a row):

- Before:
   249,392,070,159      cycles
   781,327,593,681      instructions              #    3.13  insn per cycle
    85,914,418,873      branches
       242,572,820      branch-misses             #    0.28% of all branches
     1,567,954,032      L1-icache-load-misses

      70.559864567 seconds time elapsed

- After:
   277,806,651,701      cycles
   813,619,725,225      instructions              #    2.93  insn per cycle
   132,453,633,831      branches
       306,969,989      branch-misses             #    0.23% of all branches
     1,250,619,057      L1-icache-load-misses

      78.420517079 seconds time elapsed

On the bright side, in an older system (Sandy Bridge), I get
a fairly neutral average perf impact, with some workloads
speeding up and others slowing down:
  https://imgur.com/a/AokDbkm
(Note that v1 of this series gave an overall slowdown, so that's
progress.)

Given the above, perhaps the best way forward is to add a
configure flag to disable OOL thunks, unless you have any
further optimizations coming up.

Thanks,

		Emilio
