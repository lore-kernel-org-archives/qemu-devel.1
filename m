Received: from eggs.gnu.org ([2001:4830:134:3::10]:46084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e0WuM-0004Ny-4g
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e0WuJ-0003Gn-3w
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:59:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36437)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e0WuI-0003GV-UF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:59:31 -0400
Date: Fri, 6 Oct 2017 13:59:29 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171006175929.GA28281@flamenco>
References: <87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	<87o9pywt8k.fsf@frigg.lan> <87shf5zlty.fsf@frigg.lan>
	<20170929175943.GA25038@flamenco> <87vak1w53a.fsf@frigg.lan>
	<20170930180941.GA22048@flamenco> <8760bu333n.fsf@frigg.lan>
	<20171005005043.GA20425@flamenco> <87vajsl3h7.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87vajsl3h7.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Oct 06, 2017 at 18:07:16 +0300, Lluís Vilanova wrote:
> Emilio G Cota writes:
> > On Thu, Oct 05, 2017 at 02:28:12 +0300, Lluís Vilanova wrote:
> >> The API takes care of telling you if the access could be performed
> >> successfully. If you access the instruction's memory representation at
> >> translation time, it should be able to perform the access, since QEMU's
> >> translation loop just had to do so in order to access that instruction (I should
> >> check what happens in the corner case where another guest CPU changes the page
> >> table, since I'm not sure if the address translation functions I'm using in QEMU
> >> will use the per-vCPU TLB cache or always traverse the page table).
> 
> > That was my concern, I'd rather just perform the read once, that is, the read(s)
> > done by ops->insn_translate.
> 
> If your concern is on performance, that should not be an issue, since you'd be
> using the memory peek functions at translation-time. Furthermore, since others
> suggested having memory peek anyway, that's a nicer way (to me) to compose APIs
> (and is less complex to implement).

My concern was the same as yours, correctness -- what happens if something
changes between the two reads? Because the two reads should always return
the same thing.

> > I see. I implemented what I suggested above, i.e. tb_trans_cb
> > (i.e. post_trans) passes an opaque descriptor of the TB (which can
> > be iterated over insn by insn) and the return value (void *) of this
> > cb will be passed by tb_exec_cb (i.e. pre_exec).  Perf-wise this
> > is pretty OK, turns out even if we don't end up caring about the
> > TB, the additional per-TB helper (which might not end up calling
> > a callback) does not introduce significant overhead at execution time.
> 
> So you build this structure after translating the whole TB, and the user can
> iterate it to check the translated instructions. This is closer to other
> existing tools: you iterate the structure and then decide which/how to
> instrument instructions, memory accesses, etc within it.

Correct. I suspect they went with this design because it makes sense to
do this preprocessing once, instead of having each plugin do it
themselves. I'm not sure how much we should care about supporting multiple
plugins, but the impression I get from DynamoRIO is that it seems important
to users.

> My only concern is that this is much more complex than the simpler API I propose
> (you must build the informational structures, generate calls to every possible
> instrumentation call, which will be optimized-out by TCG if the user decides not
> to use them, and overall pay in performance for any unused functionality),
> whereas your approach can be implemented on top of it.

It's pretty simple; tr_ops->translate_insn has to copy each insn.
For instance, on aarch64 (disas_a64 is called from tr_translate_insn):

-static void disas_a64_insn(CPUARMState *env, DisasContext *s)
+static void disas_a64_insn(CPUARMState *env, DisasContext *s, struct qemu_plugin_insn *q_insn)
 {
     uint32_t insn;

     insn = arm_ldl_code(env, s->pc, s->sctlr_b);
+    if (q_insn) {
+        qemu_plugin_insn_append(q_insn, &insn, sizeof(insn));
+    }

It takes some memory though (we duplicate the guest code), but perf-wise this
isn't a big deal (an empty callback on every TB execution incurs only a 10-15%
perf slowdown).

I don't understand the part where you say that the instrumentation call can
be optimized out. Is there a special value of a "TCG promise" (at tb_trans_post
time) that removes the previously generated callback (at tb_trans_pre time)?
Otherwise I don't see how selective TB instrumentation can work at tb_trans_pre
time.

Thanks,

		E.
