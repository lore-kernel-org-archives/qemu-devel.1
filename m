Received: from eggs.gnu.org ([2001:4830:134:3::10]:43434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRzIU-0006dX-VB
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRzIQ-0006rL-FM
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:50:30 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:33936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gRzIQ-0006qy-4I
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:50:26 -0500
Received: by mail-wr1-x432.google.com with SMTP id j2so26210710wrw.1
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 04:50:26 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-39-cota@braap.org>
	<87k1kz50pb.fsf@linaro.org> <20181127021612.GF22108@flamenco>
	<87ftvm4lw4.fsf@linaro.org> <20181127190657.GB8956@flamenco>
	<20181128023020.GA25013@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181128023020.GA25013@flamenco>
Date: Wed, 28 Nov 2018 12:50:23 +0000
Message-ID: <878t1d4b8w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> On Tue, Nov 27, 2018 at 14:06:57 -0500, Emilio G. Cota wrote:
>> On Tue, Nov 27, 2018 at 14:48:11 +0000, Alex Benn=C3=A9e wrote:
>> > With a little tweaking to the TCG we could then insert
>> > our instrumentation at the end of the pass with all the knowledge we
>> > want to export to the plugin.
>>
>> After .translate_insn has returned for the last instruction, how
>> do we insert the instrumentation that the plugin wants--say, a TB
>> callback at the beginning of the TB, memory callbacks for the
>> 2nd instruction, and an insn callback before the 3rd instruction
>> executes?
>>
>> I don't see how we could achieve that with "a little tweaking"
>> instead of a 2nd pass, but I'd love to be wrong =3D)
>
> (snip)
>> > I don't quite follow. When we've done all our translation into TCG ops
>> > haven't we by definition defined the TB?
>>
>> Yes, that's precisely my point.
>>
>> The part that's missing is that once the TB is defined, we want to
>> insert instrumentation. Unfortunately, the "TCG ops" we get after
>> the 1st pass (no instrumentation), are very different from the list
>> of "TCG ops" that we get after the 2nd pass (after having injected
>> instrumentation). Could we get the same output of the 2nd pass,
>> just by using the output of the 1st and the list of injection points?
>> It's probably possible, but it seems very hard to do. (Think for
>> instance of memory callbacks, and further the complication of when
>> they use helpers).
>>
>> The only reasonable way to do this I think would be to leave behind
>> "placeholder" TCG ops, that then we could scan to add further TCG ops.
>> But you'll agree with me that the 2nd pass is simpler :P
>
> It might not be that much simpler after all!
>
> I am exploring the approach you suggested, that is IIUC to do a
> single pass and then walk the list of Ops, adding (and
> reordering) Ops based on what the plugins have requested.
>
> Contrary to what I wrote earlier today (quoted above), this
> approach seems quite promising, and certainly less ugly
> than doing the 2 passes.
>
> I just wrote some code to go over the list and add TB callbacks,
> which go right before the first insn_start Op. The code is hack-ish
> in that we first generate the TCG ops we need, which get added to
> the end of the ops list, and then we go over those and move them
> to where we want them to be (before insn_start, in this case).
> But it works and it's less of a hack than doing the whole 2nd pass.

But we should be able to insert the ops directly in the right place.
That is the whole point of being a list right ;-)

> Insn callbacks will be trivial to implement this way; memory
> callbacks should be harder because there are several qemu_ld/st
> opcodes, but it should be doable;

I was thinking about this last night. I wonder if we need to tag the
memory tcg ops so we can find them afterwards during the insertion
phase - but maybe the opcode itself provides enough information.

> last, memory instrumentation
> of helpers might actually be easier than with the 2 passes, because here
> we just have to look for a Call TCG op to know whether a guest
> instruction uses helpers, and if it does we can wrap the call
> with the helpers to generate the setting/resetting of
> CPUState.plugin_mem_cbs.

So merging the two helper calls into one from the target code?

>
> I'll try to do what's in the previous paragraph tomorrow -- I'm
> appending what I did so far.
>
> Thanks,
>
> 		Emilio
> ---
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index ee9e179e14..232f645cd4 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -18,6 +18,7 @@
>  #include "exec/gen-icount.h"
>  #include "exec/log.h"
>  #include "exec/translator.h"
> +#include "exec/plugin-gen.h"
>
>  /* Pairs with tcg_clear_temp_count.
>     To be called by #TranslatorOps.{translate_insn,tb_stop} if
> @@ -142,6 +143,11 @@ void translator_loop(const TranslatorOps *ops, Disas=
ContextBase *db,
>      gen_tb_end(db->tb, db->num_insns - bp_insn);
>
>      if (plugin_enabled) {
> +        /* collect the plugins' instrumentation */
> +        qemu_plugin_tb_trans_cb(cpu, &tcg_ctx->plugin_tb);
> +        /* inject instrumentation */
> +        qemu_plugin_gen_inject();
> +        /* done */
>          tcg_ctx->plugin_insn =3D NULL;
>      }
>
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 75f182be37..cb5dbadc3c 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -1,4 +1,5 @@
>  #include "qemu/osdep.h"
> +#include "qemu/queue.h"
>  #include "cpu.h"
>  #include "tcg/tcg.h"
>  #include "tcg/tcg-op.h"
> @@ -169,8 +170,61 @@ static void gen_vcpu_udata_cb(struct qemu_plugin_dyn=
_cb *cb)
>      tcg_temp_free_i32(cpu_index);
>  }
>
> -void qemu_plugin_gen_vcpu_udata_callbacks(struct qemu_plugin_dyn_cb_arr =
*arr)
> +/* check that @a comes before @b */
> +static inline void ops_check(const TCGOp *a, const TCGOp *b)
>  {
> +    const TCGOp *op;
> +    bool seen_a =3D false;
> +    bool seen_b =3D false;
> +
> +    tcg_debug_assert(a !=3D b);
> +    QTAILQ_FOREACH(op, &tcg_ctx->ops, link) {
> +        if (op =3D=3D a) {
> +            tcg_debug_assert(!seen_b);
> +            seen_a =3D true;
> +        } else if (op =3D=3D b) {
> +            tcg_debug_assert(seen_a);
> +            seen_b =3D true;
> +            break;
> +        }
> +    }
> +}
> +
> +/*
> + * Move ops from @from to @dest.
> + * @from must come after @dest in the list.
> + */
> +static void ops_move(TCGOp *dest, TCGOp *from)
> +{
> +    TCGOp *curr;
> +
> +#ifdef CONFIG_DEBUG_TCG
> +    ops_check(dest, from);
> +#endif
> +
> +   if (QTAILQ_NEXT(dest, link) =3D=3D from) {
> +        /* nothing to do */
> +        return;
> +    }
> +    curr =3D from;
> +    do {
> +        TCGOp *next =3D QTAILQ_NEXT(curr, link);
> +
> +        /*
> +         * This could be done more efficiently since (@from,end) will
> +         * remain linked together, but most likely we just have a few
> +         * elements, so this is simple enough.
> +         */
> +        QTAILQ_REMOVE(&tcg_ctx->ops, curr, link);
> +        QTAILQ_INSERT_AFTER(&tcg_ctx->ops, dest, curr, link);
> +        dest =3D curr;
> +        curr =3D next;
> +    } while (curr);
> +}
> +
> +static void inject_vcpu_udata_callbacks(struct qemu_plugin_dyn_cb_arr *a=
rr, TCGOp *dest)
> +{
> +    TCGOp *last_op =3D tcg_last_op();
>      size_t i;
>
>      for (i =3D 0; i < arr->n; i++) {
> @@ -187,6 +241,10 @@ void qemu_plugin_gen_vcpu_udata_callbacks(struct qem=
u_plugin_dyn_cb_arr *arr)
>              g_assert_not_reached();
>          }
>      }
> +    g_assert(tcg_last_op() !=3D last_op);
> +    last_op =3D QTAILQ_NEXT(last_op, link);
> +    g_assert(last_op);
> +    ops_move(dest, last_op);
>  }
>
>  /*
> @@ -228,3 +286,26 @@ void qemu_plugin_gen_disable_mem_helpers(void)
>                                                          plugin_mem_cbs));
>      tcg_temp_free_ptr(ptr);
>  }
> +
> +void qemu_plugin_gen_inject(void)
> +{
> +    struct qemu_plugin_tb *plugin_tb =3D &tcg_ctx->plugin_tb;
> +
> +    /* TB exec callbacks */
> +    if (plugin_tb->cbs.n) {
> +        TCGOp *op;
> +
> +        /* Insert the callbacks right before the first insn_start */
> +        QTAILQ_FOREACH(op, &tcg_ctx->ops, link) {
> +            if (op->opc =3D=3D INDEX_op_insn_start) {
> +                break;
> +            }
> +        }
> +        /* a TB without insn_start? Something went wrong */
> +        g_assert(op);
> +        op =3D QTAILQ_PREV(op, TCGOpHead, link);
> +        /* we should have called gen_tb_start before the 1st insn */
> +        g_assert(op);
> +        inject_vcpu_udata_callbacks(&plugin_tb->cbs, op);
> +    }
> +}


--
Alex Benn=C3=A9e
