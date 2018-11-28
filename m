Received: from eggs.gnu.org ([2001:4830:134:3::10]:59765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gS1N7-0007am-JT
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gS1N1-0000Jo-BA
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:03:25 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gS1N1-0000II-1V
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:03:19 -0500
Date: Wed, 28 Nov 2018 10:03:14 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181128150314.GC1763@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-39-cota@braap.org>
	<87k1kz50pb.fsf@linaro.org> <20181127021612.GF22108@flamenco>
	<87ftvm4lw4.fsf@linaro.org> <20181127190657.GB8956@flamenco>
	<20181128023020.GA25013@flamenco> <878t1d4b8w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t1d4b8w.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 38/48] translator: implement 2-pass
 translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Richard Henderson <richard.henderson@linaro.org>

On Wed, Nov 28, 2018 at 12:50:23 +0000, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > I just wrote some code to go over the list and add TB callbacks,
> > which go right before the first insn_start Op. The code is hack-ish
> > in that we first generate the TCG ops we need, which get added to
> > the end of the ops list, and then we go over those and move them
> > to where we want them to be (before insn_start, in this case).
> > But it works and it's less of a hack than doing the whole 2nd pass.
> 
> But we should be able to insert the ops directly in the right place.
> That is the whole point of being a list right ;-)

Right, it's just hard sometimes to know exactly where to insert.

> > Insn callbacks will be trivial to implement this way; memory
> > callbacks should be harder because there are several qemu_ld/st
> > opcodes, but it should be doable;
> 
> I was thinking about this last night. I wonder if we need to tag the
> memory tcg ops so we can find them afterwards during the insertion
> phase - but maybe the opcode itself provides enough information.

We should be able to extract the info from the memop argument,
I think.

> > last, memory instrumentation
> > of helpers might actually be easier than with the 2 passes, because here
> > we just have to look for a Call TCG op to know whether a guest
> > instruction uses helpers, and if it does we can wrap the call
> > with the helpers to generate the setting/resetting of
> > CPUState.plugin_mem_cbs.
> 
> So merging the two helper calls into one from the target code?

Actually we don't need helpers to set/reset CPUState.plugin_mem_cbs;
we do that in TCG directly. So here we could just add the "set"
code right after "insn_start", and the "reset" code at the very
end of the translation (right before tb_exit/goto_tb etc).
The "reset" might still be dead code, but that is unavoidable
because the helper might do a longjmp. But we can fix that by
resetting the variable when returning from the jump.

Thanks,

		E.
