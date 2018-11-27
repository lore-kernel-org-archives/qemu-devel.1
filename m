Received: from eggs.gnu.org ([2001:4830:134:3::10]:58887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRihM-0005pN-K6
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRihH-00073n-Lm
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:07:04 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46527)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRihH-00073d-Cf
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:06:59 -0500
Date: Tue, 27 Nov 2018 14:06:57 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181127190657.GB8956@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-39-cota@braap.org>
	<87k1kz50pb.fsf@linaro.org> <20181127021612.GF22108@flamenco>
	<87ftvm4lw4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftvm4lw4.fsf@linaro.org>
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

On Tue, Nov 27, 2018 at 14:48:11 +0000, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > On Mon, Nov 26, 2018 at 15:16:00 +0000, Alex Bennée wrote:
> >> Emilio G. Cota <cota@braap.org> writes:
> > (snip)
> >> > +    if (tb_trans_cb && first_pass) {
> >> > +        qemu_plugin_tb_trans_cb(cpu, plugin_tb);
> >> > +        first_pass = false;
> >> > +        goto translate;
> >> > +    }
> >>
> >> So the only reason we are doing this two pass tango is to ensure the
> >> plugin can insert TCG ops before the actual translation has occurred?
> >
> > Not only. The idea is to provide plugins with well-defined TBs,
> > i.e. the instruction sizes and contents can be queried by the plugin
> > before the plugin decides how/where to instrument the TB.
> 
> Hmmm, this seems a little to close to internal knowledge of the TCG.

As far as plugins are concerned, a "TB" is a sequence of instructions
that will (unless there are exceptions) execute in sequence. That is,
single-entry and single-exit.
QEMU is free to cut those in any way it wants, and there's no need
for a 1:1 mapping between the "TBs" exported to plugins and
the "TranslationBlock"s we manage internally in QEMU.

I thought about calling them "basic blocks", but then that could
confuse users because not all TB's meet the definition of basic blocks,
that is TBs might end in a non-branch instruction, whereas basic
blocks don't.

So I kept the TB name, but note that all that plugins can assume
about TBs, is that they are single-entry and single-exit, that's it.
Different QEMU releases will cut TB's differently, and plugins
will cope with that perfectly fine. IOW, this imposes no
restrictions on TCG's implementation.

> Is the idea that a plugin might make a different decision based on the
> number of a particular type of instruction in the translation block?

Plugins will make their decisions based on the TB's contents.
For that, they need to know what instructions form the TB,
and be able to disassemble them.

> This seems like it would get broken if we wanted to implement other
> types of TranslationBlock (e.g. hot-blocks with multiple exits for the
> non-hot case).

Again, let's dissociate struct TranslationBlock vs. what we export;
let's call the latter "plugin TB's" for discussion's sake.

If we implemented single-entry, multiple-exit traces, we could implement
that in any way we wanted (e.g. expanding TranslationBlock, or grouping
them into TranslationTraces or whatever we called them). Plugins
would them be exposed to an interface similar to what Pin/DynamoRIO
offer, that is, plugins can subscribe to "Trace" translation events,
where Traces are lists of "plugin TB's".

Besides, I'm OK with having an API that we can break in the future.
(Pin/DynamoRIO do it all the time.)

> That said looking at the examples using it so far it doesn't seem to be
> doing more than looking at the total number of instructions for a given
> translation block.

OK, so I'm appending a more complicated example, where we use capstone
to look at the instructions in a TB at translation time. (Just
for illustration purposes, we then register an empty callback)

> > Since in the targets we generate TCG code and also generate
> > host code in a single shot (TranslatorOps.translate_insn),
> > the 2-pass approach is a workaround to first get the
> > well-defined TB, and in the second pass inject the instrumentation
> > in the appropriate places.
> 
> Richard's suggestion of providing a central translator_ldl_code could
> keep the book keeping of each instruction location and contents in the
> core translator.

Yes, at least for most targets I think that will work.

> With a little tweaking to the TCG we could then insert
> our instrumentation at the end of the pass with all the knowledge we
> want to export to the plugin.

After .translate_insn has returned for the last instruction, how
do we insert the instrumentation that the plugin wants--say, a TB
callback at the beginning of the TB, memory callbacks for the
2nd instruction, and an insn callback before the 3rd instruction
executes?

I don't see how we could achieve that with "a little tweaking"
instead of a 2nd pass, but I'd love to be wrong =)

> Inserting instrumentation after instructions have executed will be
> trickier though due to reasons Peter mentioned on IRC.

Particularly the last instruction in a TB; by the time we return
from .translate_insn, all code we insert will most likely be dead.

> > This is a bit of a waste but given that it only happens at
> > translate time, it can have negligible performance impact --
> > I measured a 0.13% gmean slowdown for SPEC06int.
> 
> I'm less concerned about efficiency as complicating the code, especially
> if we are baking in concepts that restrict our freedom to change code
> generation around going forward.

Agreed. I don't think exposing for now "plugin TB"s, i.e. single-entry,
single-exit blocks of insns restricts our future designs. And if all
else fails, we should reserve the right to break the API (e.g. via
new version numbers).

> >> I think we can do better, especially as the internal structures of
> >> TCGops are implemented as a list so ops and be inserted before and after
> >> other ops. This is currently only done by the optimiser at the moment,
> >> see:
> >>
> >>   TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
> >>   TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
> >>
> >> and all the base tcg ops end up going to tcg_emit_op which just appends
> >> to the tail. But if we can come up with a neater way to track the op
> >> used before the current translated expression we could do away with two
> >> phases translation completely.
> >
> > This list of ops is generated via TranslatorOps.translate_insn.
> > Unfortunately, this function also defines the guest insns that form the TB.
> > Decoupling the two actions ("define the TB" and "translate to TCG ops")
> > would be ideal, but I didn't want to rewrite all the target translators
> > in QEMU, and opted instead for the 2-pass approach as a compromise.
> 
> I don't quite follow. When we've done all our translation into TCG ops
> haven't we by definition defined the TB?

Yes, that's precisely my point.

The part that's missing is that once the TB is defined, we want to
insert instrumentation. Unfortunately, the "TCG ops" we get after
the 1st pass (no instrumentation), are very different from the list
of "TCG ops" that we get after the 2nd pass (after having injected
instrumentation). Could we get the same output of the 2nd pass,
just by using the output of the 1st and the list of injection points?
It's probably possible, but it seems very hard to do. (Think for
instance of memory callbacks, and further the complication of when
they use helpers).

The only reasonable way to do this I think would be to leave behind
"placeholder" TCG ops, that then we could scan to add further TCG ops.
But you'll agree with me that the 2nd pass is simpler :P

> Maybe the interface shouldn't be per-insn and per-TB but just an
> arbitrary chunk of instructions. We could call the plugin with a list of
> instructions with some opaque data that can be passed back to the plugin
> APIs to allow insertion of instrumentation at the appropriate points.

This is what this series implements. It just happens that these
chunks match our internal translation blocks, but there's no need for
that (and for now, no good reason for them not to match.)

> The initial implementation would be a single-pass and called after the
> TCG op generation. An instruction counter plugin would then be free to
> insert counter instrumentation as frequently or infrequently as it
> wants. These chunks wouldn't have to be tied to the internals of TCG and
> in the worst case we could just inform the plugin in 1 insn chunks
> without having to change the API?
> 
> What do you think?

With a single pass, all you can do is to add a callback with a descriptor
of what just executed. So the "instruction counter" example would work OK.

But what about a plugin that needed only memory accesses performed
by, say, xchg instructions? It'd have to subscribe to *all* memory
accesses, because after a TB is generated we cannot go back to
instrument something (due to the single pass), and then somehow figure
out a way to discard non-xchg-generated memory accesses at run-time.

So having instruction-grained injection is very valuable, and it's
not surprising that Pin/DynamoRIO provide that in their API.
With this series I'm trying to provide something similar.

Thanks,

		Emilio

---
#include <inttypes.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>

#include <capstone/capstone.h>
#include <qemu-plugin.h>

struct tb {
	size_t n_insns;
};

static csh cap_handle;
static cs_insn *cap_insn;

static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
{ }

static void vcpu_tb_trans(qemu_plugin_id_t id, unsigned int cpu_index, struct qemu_plugin_tb *tb)
{
	struct tb *desc;
	size_t n = qemu_plugin_tb_n_insns(tb);
	size_t i;

	for (i = 0; i < n; i++) {
		struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
		size_t size = qemu_plugin_insn_size(insn);
		const uint8_t *code = qemu_plugin_insn_data(insn);
		uint64_t offset = 0;
		bool success;

		success = cs_disasm_iter(cap_handle, &code, &size, &offset, cap_insn);
		assert(success);
	}
	desc = malloc(sizeof(*desc));
	assert(desc);
	desc->n_insns = n;

	qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
					     QEMU_PLUGIN_CB_NO_REGS, desc);
}

QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc, char **argv)
{
	if (cs_open(CS_ARCH_X86, CS_MODE_64, &cap_handle) != CS_ERR_OK) {
		return -1;
	}
	cap_insn = cs_malloc(cap_handle);
	if (cap_insn == NULL) {
		return -1;
	}
	qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
	return 0;
}
