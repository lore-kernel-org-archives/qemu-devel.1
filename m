Received: from eggs.gnu.org ([2001:4830:134:3::10]:38328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g79tn-0003X8-6x
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 21:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g79tj-0006Yu-Ur
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 21:54:55 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g79tj-0006Yk-Nt
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 21:54:51 -0400
Date: Mon, 1 Oct 2018 21:54:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181002015449.GA19082@flamenco>
References: <20180919175423.GA25553@flamenco> <87va71uijc.fsf@linaro.org>
	<20181001183423.GA27555@flamenco>
	<4d2fbab5-13c8-1c19-5e58-02968cdcfef0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d2fbab5-13c8-1c19-5e58-02968cdcfef0@linaro.org>
Subject: Re: [Qemu-devel] ideas for improving TLB performance (help with TCG
 backend wanted)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Pranith Kumar <bobby.prani@gmail.com>

On Mon, Oct 01, 2018 at 15:40:37 -0500, Richard Henderson wrote:
> On 10/1/18 1:34 PM, Emilio G. Cota wrote:
> > On Thu, Sep 20, 2018 at 01:19:51 +0100, Alex Bennée wrote:
> >> If we are going to have an indirection then we can also drop the
> >> requirement to scale the TLB according to the number of MMU indexes we
> >> have to support. It's fairly wasteful when a bunch of them are almost
> >> never used unless you are running stuff that uses them.
> > 
> > So with dynamic TLB sizing, what you're suggesting here is to resize
> > each MMU array independently (depending on their use rate) instead
> > of using a single "TLB size" for all MMU indexes. Am I understanding
> > your point correctly?
> 
> You cannot do that without flushing the TBs (and with out-of-line memory ops,
> the prologue as well) and regenerating.  The TLB size is baked into the code.
> And we really don't have any extra registers free to vary that.

Can you please elaborate on this? I can't see where this is
baked into the generated code, other than the TLB lookup.
Grepping for CPU_TLB_SIZE and CPU_TLB_BITS only shows a few
places.

I have written today a prototype of dynamic TLB flushing. It
uses no extra registers because mmu_idx is known at generation time.
I haven't done any extensive testing yet, but at least it boots
aarch64 and x86_64 guests on an x86_64 host.

The code (some messy WIP commits in there, sorry) is at:
  https://github.com/cota/qemu/tree/tlb2

Please take a look -- am I doing anything horribly wrong there?

Thanks,

		Emilio
