Received: from eggs.gnu.org ([2001:4830:134:3::10]:51879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cF2Nh-0002cj-Bc
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cF2Ne-0001iu-3W
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:21:17 -0500
Received: from mail-wj0-f176.google.com ([209.85.210.176]:33487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cF2Nd-0001YM-S0
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:21:14 -0500
Received: by mail-wj0-f176.google.com with SMTP id xy5so393624641wjc.0
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 09:20:52 -0800 (PST)
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-24-git-send-email-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1479906121-12211-24-git-send-email-rth@twiddle.net>
Date: Thu, 08 Dec 2016 17:19:49 +0000
Message-ID: <8760muz6bu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 23/64] tcg: Allow an operand to be
 matching or a constant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> This allows an output operand to match an input operand
> only when the input operand needs a register.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

It's hard to offer anything more than a mechanical review for this as
the constraints aren't intuitive to me (I guess not as a gcc hacker!).

Could we either expand the documentation of constraints in tcg/README
with a summary of the global ones?

Should there be a one to one mapping of textual constraint descriptions
to the TCG_CT_FOO defines? I'm finding it hard to figure out why the
text->bitfield step is needed. Is it something to do with the merging of
generic TCG op constraints with their backend counterparts?

Anyway:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>


> ---
>  tcg/tcg.c | 63 ++++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 8b4dce7..cb898f1 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1256,37 +1256,37 @@ static void process_op_defs(TCGContext *s)
>
>              tcg_regset_clear(def->args_ct[i].u.regs);
>              def->args_ct[i].ct = 0;
> -            if (ct_str[0] >= '0' && ct_str[0] <= '9') {
> -                int oarg;
> -                oarg = ct_str[0] - '0';
> -                tcg_debug_assert(oarg < def->nb_oargs);
> -                tcg_debug_assert(def->args_ct[oarg].ct & TCG_CT_REG);
> -                /* TCG_CT_ALIAS is for the output arguments. The input
> -                   argument is tagged with TCG_CT_IALIAS. */
> -                def->args_ct[i] = def->args_ct[oarg];
> -                def->args_ct[oarg].ct = TCG_CT_ALIAS;
> -                def->args_ct[oarg].alias_index = i;
> -                def->args_ct[i].ct |= TCG_CT_IALIAS;
> -                def->args_ct[i].alias_index = oarg;
> -            } else {
> -                for(;;) {
> -                    if (*ct_str == '\0')
> -                        break;
> -                    switch(*ct_str) {
> -                    case '&':
> -                        def->args_ct[i].ct |= TCG_CT_NEWREG;
> -                        ct_str++;
> -                        break;
> -                    case 'i':
> -                        def->args_ct[i].ct |= TCG_CT_CONST;
> -                        ct_str++;
> -                        break;
> -                    default:
> -                        ct_str = target_parse_constraint(&def->args_ct[i],
> -                                                         ct_str, type);
> -                        /* Typo in TCGTargetOpDef constraint. */
> -                        tcg_debug_assert(ct_str != NULL);
> +            while (*ct_str != '\0') {
> +                switch(*ct_str) {
> +                case '0' ... '9':
> +                    {
> +                        int oarg = *ct_str - '0';
> +                        tcg_debug_assert(ct_str == tdefs->args_ct_str[i]);
> +                        tcg_debug_assert(oarg < def->nb_oargs);
> +                        tcg_debug_assert(def->args_ct[oarg].ct & TCG_CT_REG);
> +                        /* TCG_CT_ALIAS is for the output arguments.
> +                           The input is tagged with TCG_CT_IALIAS. */
> +                        def->args_ct[i] = def->args_ct[oarg];
> +                        def->args_ct[oarg].ct |= TCG_CT_ALIAS;
> +                        def->args_ct[oarg].alias_index = i;
> +                        def->args_ct[i].ct |= TCG_CT_IALIAS;
> +                        def->args_ct[i].alias_index = oarg;
>                      }
> +                    ct_str++;
> +                    break;
> +                case '&':
> +                    def->args_ct[i].ct |= TCG_CT_NEWREG;
> +                    ct_str++;
> +                    break;
> +                case 'i':
> +                    def->args_ct[i].ct |= TCG_CT_CONST;
> +                    ct_str++;
> +                    break;
> +                default:
> +                    ct_str = target_parse_constraint(&def->args_ct[i],
> +                                                     ct_str, type);
> +                    /* Typo in TCGTargetOpDef constraint. */
> +                    tcg_debug_assert(ct_str != NULL);
>                  }
>              }
>          }
> @@ -2296,7 +2296,8 @@ static void tcg_reg_alloc_op(TCGContext *s,
>              arg = args[i];
>              arg_ct = &def->args_ct[i];
>              ts = &s->temps[arg];
> -            if (arg_ct->ct & TCG_CT_ALIAS) {
> +            if ((arg_ct->ct & TCG_CT_ALIAS)
> +                && !const_args[arg_ct->alias_index]) {
>                  reg = new_args[arg_ct->alias_index];
>              } else if (arg_ct->ct & TCG_CT_NEWREG) {
>                  reg = tcg_reg_alloc(s, arg_ct->u.regs,


--
Alex Bennée
