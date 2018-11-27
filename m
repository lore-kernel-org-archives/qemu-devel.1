Received: from eggs.gnu.org ([2001:4830:134:3::10]:47880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRSvE-0002Vo-Au
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 21:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRSv9-0001aH-ED
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 21:16:20 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37949)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRSv9-0001Zu-5F
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 21:16:15 -0500
Date: Mon, 26 Nov 2018 21:16:12 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181127021612.GF22108@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-39-cota@braap.org>
	<87k1kz50pb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1kz50pb.fsf@linaro.org>
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

On Mon, Nov 26, 2018 at 15:16:00 +0000, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
(snip)
> > +    if (tb_trans_cb && first_pass) {
> > +        qemu_plugin_tb_trans_cb(cpu, plugin_tb);
> > +        first_pass = false;
> > +        goto translate;
> > +    }
> 
> So the only reason we are doing this two pass tango is to ensure the
> plugin can insert TCG ops before the actual translation has occurred?

Not only. The idea is to provide plugins with well-defined TBs,
i.e. the instruction sizes and contents can be queried by the plugin
before the plugin decides how/where to instrument the TB.

Since in the targets we generate TCG code and also generate
host code in a single shot (TranslatorOps.translate_insn),
the 2-pass approach is a workaround to first get the
well-defined TB, and in the second pass inject the instrumentation
in the appropriate places.

This is a bit of a waste but given that it only happens at
translate time, it can have negligible performance impact --
I measured a 0.13% gmean slowdown for SPEC06int.

> I think we can do better, especially as the internal structures of
> TCGops are implemented as a list so ops and be inserted before and after
> other ops. This is currently only done by the optimiser at the moment,
> see:
> 
>   TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
>   TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
> 
> and all the base tcg ops end up going to tcg_emit_op which just appends
> to the tail. But if we can come up with a neater way to track the op
> used before the current translated expression we could do away with two
> phases translation completely.

This list of ops is generated via TranslatorOps.translate_insn.
Unfortunately, this function also defines the guest insns that form the TB.
Decoupling the two actions ("define the TB" and "translate to TCG ops")
would be ideal, but I didn't want to rewrite all the target translators
in QEMU, and opted instead for the 2-pass approach as a compromise.

Thanks,

		Emilio
