Received: from eggs.gnu.org ([2001:4830:134:3::10]:48168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gS87S-0003fl-83
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 17:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gS87N-0000dp-Hf
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 17:15:41 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41229)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gS87J-0000W6-Od
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 17:15:35 -0500
Date: Wed, 28 Nov 2018 17:15:30 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181128221530.GA32160@flamenco>
References: <20181128053834.10861-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128053834.10861-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 00/12] tcg: Improve register allocation for
 calls
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

On Tue, Nov 27, 2018 at 21:38:22 -0800, Richard Henderson wrote:
> The intent here is to remove several move insns putting the
> function arguments into the proper place.  I'm hoping that
> this will solve the skylake regression with spec2006, as
> seen with the ool softmmu patch set.
> 
> Emilio, all of this is present on my tcg-next-for-4.0 branch.

Thanks for this.

Unfortunately, it doesn't seem to help, performance-wise.

I've benchmarked this on three different machines: Sandy
Bridge, Haswell and Skylake. The average slowdown vs.
the baseline is ~0%, ~5%, and ~10%, respectively.

So it seems the more modern the microarchitecture, the more
severe the slowdown (this is consistent with the assumption
that processors are getting better at caching over time).

Here are all the bar charts:

  https://imgur.com/a/k7vmjVd

- baseline: tcg-next-for-4.0's parent from master, i.e.
  4822f1e ("Merge remote-tracking branch
  'remotes/kraxel/tags/fixes-31-20181127-pull-request'
  into staging", 2018-11-27)

- ool: dc93c4a ("tcg/ppc: Use TCG_TARGET_NEED_LDST_OOL_LABELS",
  2018-11-27)

- ool-regs: a9bac58 ("tcg: Record register preferences during
  liveness", 2018-11-27)

I've also looked at hardware event counts on Skylake for
the above three commits. It seems that the indirection of
the (very) frequent ool calls/rets are what cause the large
reduction in IPC (results for bootup + hmmer):

- baseline:
   291,451,142,426      instructions              #    2.94  insn per cycle           (71.45%)
    99,050,829,190      cycles                                                        (71.49%)
     2,678,751,743      br_inst_retired.near_call                                     (71.43%)
     2,674,367,278      br_inst_retired.near_return                                   (71.42%)
    34,065,079,963      branches                                                      (57.09%)
       161,441,496      branch-misses             #    0.47% of all branches          (57.17%)
      29.916874137 seconds time elapsed

- ool:
   312,368,465,806      instructions              #    2.79  insn per cycle           (71.45%)
   111,863,014,212      cycles                                                        (71.31%)
    11,751,151,140      br_inst_retired.near_call                                     (71.30%)
    11,736,770,191      br_inst_retired.near_return                                   (71.41%)
        24,660,597      br_misp_retired.near_call                                     (71.49%)
    52,096,512,558      branches                                                      (57.28%)
       176,951,727      branch-misses             #    0.34% of all branches          (57.20%)
      33.285149773 seconds time elapsed

- ool-regs:
   309,253,149,588      instructions              #    2.71  insn per cycle           (71.47%)
   113,938,069,597      cycles                                                        (71.50%)
    11,735,199,530      br_inst_retired.near_call                                     (71.51%)
    11,725,686,909      br_inst_retired.near_return                                   (71.54%)
        24,885,204      br_misp_retired.near_call                                     (71.46%)
    52,768,150,694      branches                                                      (56.97%)
       184,421,824      branch-misses             #    0.35% of all branches          (57.03%)
      33.867122498 seconds time elapsed 

The additional branches are all from call/ret. I double-checked the generated
code and these are all well-matched (no jmp's instead of ret's), so
I don't think we can optimize anything there; it seems to me that this
is just a code size vs. speed trade-off.

ool-regs has even lower IPC, but it also uses less instructions, which
mitigates the slowdown due to lower IPC. The bottleneck in the ool
calls/rets remains, which explains why there isn't much to
be gained from the lower number of insns.

Let me know if you want me to do any other data collection.

Thanks,

		Emilio
