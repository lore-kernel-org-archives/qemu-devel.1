Received: from eggs.gnu.org ([2001:4830:134:3::10]:51914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4ZkY-0002Cr-7k
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 17:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4ZkT-0006N5-EQ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 17:50:10 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55159)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4ZkT-0006Ma-6L
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 17:50:05 -0400
Date: Tue, 17 Oct 2017 17:50:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171017215003.GI1345@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-10-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-10-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 09/50] tcg: Use per-temp state data in
 liveness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, Oct 16, 2017 at 10:25:28 -0700, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> This avoids having to allocate external memory for each temporary.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---

Unfortunately, this patch undoes the small perf gains we made so far in
this series.

We end up running more instructions, I guess due to the loops in
setting the per-temp states (whereas earlier we just had a memset).
Same aarch64 boot benchmark, 10 runs:

Before:

       7125.400889      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.15% )
            21,654      context-switches          #    0.003 M/sec                    ( +-  0.12% )
                 1      cpu-migrations            #    0.000 K/sec                  
             8,034      page-faults               #    0.001 M/sec                    ( +-  1.22% )
    30,050,759,263      cycles                    #    4.217 GHz                      ( +-  0.15% )
   <not supported>      stalled-cycles-frontend  
   <not supported>      stalled-cycles-backend   
    53,764,201,351      instructions              #    1.79  insns per cycle          ( +-  0.09% )
     9,677,042,191      branches                  # 1358.105 M/sec                    ( +-  0.09% )
       170,903,903      branch-misses             #    1.77% of all branches          ( +-  0.16% )

       7.136617151 seconds time elapsed                                          ( +-  0.17% )

After:
       7326.945822      task-clock (msec)         #    0.999 CPUs utilized            ( +-  0.24% )
            21,997      context-switches          #    0.003 M/sec                    ( +-  0.16% )
                 1      cpu-migrations            #    0.000 K/sec                  
             8,400      page-faults               #    0.001 M/sec                    ( +-  4.63% )
    30,900,509,346      cycles                    #    4.217 GHz                      ( +-  0.23% )
   <not supported>      stalled-cycles-frontend  
   <not supported>      stalled-cycles-backend   
    55,736,672,258      instructions              #    1.80  insns per cycle          ( +-  0.16% )
     9,989,723,969      branches                  # 1363.423 M/sec                    ( +-  0.16% )
       179,662,782      branch-misses             #    1.80% of all branches          ( +-  0.16% )

       7.335805286 seconds time elapsed                                          ( +-  0.24% )

I tried merging .state into the bitfield, but that didn't help (the dcache isn't
the issue here).

Anyway we use .state_ptr later in this series, so:

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
