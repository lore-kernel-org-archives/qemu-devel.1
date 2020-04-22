Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E61C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 20:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188F52075A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 20:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyGpCwvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188F52075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRLXU-0002dM-9O
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 16:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jRLVp-0001Rd-VR
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jRLVn-0001Y8-Ly
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:58:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33908)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jRLVn-0001Uf-77
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:58:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id j1so4043851wrt.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 12:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jPuAsAUo9LNxtFZpMH2pz5laPLWGeQvxh2VzZEqx11I=;
 b=UyGpCwvnqrYcngq10qjKcBXWrwvuoi6UzIp61qNYEZEluZxK0BIU79Kx/9ziVFoLgk
 t+9gBE63GTRZpzMeQCGA4bDJgPkXuHJ/Gw9spwdIWHcdGeO9zW6k90ok3susXINTXB84
 OM1sLEYymw6QPfVByCa3uYr3AlWEp8ojAPEIovYlv/IfUjCQkZaO+ByYdYrP90IXQ9vJ
 HYSrw5TSefmPpdGgWoc7kJDEWcm4/QFeFzqtbemqCAp0GineBh0sLnJi4JSyJsjkf7dq
 dyfiJgpJ+iQT2Nz3+S1pBOIbICkahLCWTM/fEIw3/NBSlvbghGKeTgCvFbTtxTLR3iYm
 kBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jPuAsAUo9LNxtFZpMH2pz5laPLWGeQvxh2VzZEqx11I=;
 b=sQeGCz03v18HV/sjhV/fy9B7Wjial1woo0d0u+5swHDGQlJzpUrPyX+R5rAOfl/4wJ
 8BXnhJggH3HIAYH1i9MojKEgcEEnQBTlAp7j/HTFjqUjYdi5/Aa9fNMGbZucA7pdUSWG
 xxThz6qHOhf69xB8VLEfvcMMuxgSjCYjs7+GTARn+ghIvZdHA5U+pwuzIvKgIz3c4+8k
 OfvZeCHlE+K7+Afkg8PT4wLAquo9jRuV+eKbDqKQ/Px8Oq18SzNlfCz7FNr9JjVLwsJ6
 yp0c9pMXXyrf3sRMHwKbTVozWJ4xuDUoaraUGkjkp9MraIoQ2DcN/T8EM3HElyb26c7l
 M38w==
X-Gm-Message-State: AGi0PuZtVlaeIG9e0Kf5jIY7asgssqLTw3pwRMIa036WfrCU431OrBic
 SYDUSXHr+ptiKmYuhEFkfIUxUsQVT4qGFwumchk=
X-Google-Smtp-Source: APiQypL5Gtlce7784Dj0w4JXGX1vdOYxQHJah5LkPCQlPfsWolL4RKTghUmPa8igpnUquyOeTvf2onQSkG3vYaaSzuw=
X-Received: by 2002:adf:94a6:: with SMTP id 35mr757881wrr.420.1587585500995;
 Wed, 22 Apr 2020 12:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-10-richard.henderson@linaro.org>
In-Reply-To: <20200422011722.13287-10-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 22 Apr 2020 21:58:06 +0200
Message-ID: <CAHiYmc7eFG5FSa8z1gEv0Cdi+eBvOx-Y4_2qFCM-EYNZBPqd6A@mail.gmail.com>
Subject: Re: [PATCH v2 09/36] tcg: Consolidate 3 bits into enum TCGTempKind
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 22. =D0=B0=D0=BF=D1=80 2020. =D1=83 03:27 Richard Hende=
rson
<richard.henderson@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> The temp_fixed, temp_global, temp_local bits are all related.
> Combine them into a single enumeration.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg.h |  20 +++++---
>  tcg/optimize.c    |   8 +--
>  tcg/tcg.c         | 122 ++++++++++++++++++++++++++++------------------
>  3 files changed, 90 insertions(+), 60 deletions(-)
>
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index c48bd76b0a..3534dce77f 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -480,23 +480,27 @@ typedef enum TCGTempVal {
>      TEMP_VAL_CONST,
>  } TCGTempVal;
>
> +typedef enum TCGTempKind {
> +    /* Temp is dead at the end of all basic blocks. */
> +    TEMP_NORMAL,
> +    /* Temp is saved across basic blocks but dead at the end of TBs. */
> +    TEMP_LOCAL,
> +    /* Temp is saved across both basic blocks and translation blocks. */
> +    TEMP_GLOBAL,
> +    /* Temp is in a fixed register. */
> +    TEMP_FIXED,
> +} TCGTempKind;
> +
>  typedef struct TCGTemp {
>      TCGReg reg:8;
>      TCGTempVal val_type:8;
>      TCGType base_type:8;
>      TCGType type:8;
> -    unsigned int fixed_reg:1;
> +    TCGTempKind kind:3;
>      unsigned int indirect_reg:1;
>      unsigned int indirect_base:1;
>      unsigned int mem_coherent:1;
>      unsigned int mem_allocated:1;
> -    /* If true, the temp is saved across both basic blocks and
> -       translation blocks.  */
> -    unsigned int temp_global:1;
> -    /* If true, the temp is saved across basic blocks but dead
> -       at the end of translation blocks.  If false, the temp is
> -       dead at the end of basic blocks.  */
> -    unsigned int temp_local:1;
>      unsigned int temp_allocated:1;
>
>      tcg_target_long val;
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 53aa8e5329..afb4a9a5a9 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -116,21 +116,21 @@ static TCGTemp *find_better_copy(TCGContext *s, TCG=
Temp *ts)
>      TCGTemp *i;
>
>      /* If this is already a global, we can't do better. */
> -    if (ts->temp_global) {
> +    if (ts->kind >=3D TEMP_GLOBAL) {
>          return ts;
>      }
>
>      /* Search for a global first. */
>      for (i =3D ts_info(ts)->next_copy; i !=3D ts; i =3D ts_info(i)->next=
_copy) {
> -        if (i->temp_global) {
> +        if (i->kind >=3D TEMP_GLOBAL) {
>              return i;
>          }
>      }
>
>      /* If it is a temp, search for a temp local. */
> -    if (!ts->temp_local) {
> +    if (ts->kind =3D=3D TEMP_NORMAL) {
>          for (i =3D ts_info(ts)->next_copy; i !=3D ts; i =3D ts_info(i)->=
next_copy) {
> -            if (ts->temp_local) {
> +            if (i->kind >=3D TEMP_LOCAL) {
>                  return i;
>              }
>          }
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index dd4b3d7684..eaf81397a3 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1155,7 +1155,7 @@ static inline TCGTemp *tcg_global_alloc(TCGContext =
*s)
>      tcg_debug_assert(s->nb_globals =3D=3D s->nb_temps);
>      s->nb_globals++;
>      ts =3D tcg_temp_alloc(s);
> -    ts->temp_global =3D 1;
> +    ts->kind =3D TEMP_GLOBAL;
>
>      return ts;
>  }
> @@ -1172,7 +1172,7 @@ static TCGTemp *tcg_global_reg_new_internal(TCGCont=
ext *s, TCGType type,
>      ts =3D tcg_global_alloc(s);
>      ts->base_type =3D type;
>      ts->type =3D type;
> -    ts->fixed_reg =3D 1;
> +    ts->kind =3D TEMP_FIXED;
>      ts->reg =3D reg;
>      ts->name =3D name;
>      tcg_regset_set_reg(s->reserved_regs, reg);
> @@ -1199,7 +1199,7 @@ TCGTemp *tcg_global_mem_new_internal(TCGType type, =
TCGv_ptr base,
>      bigendian =3D 1;
>  #endif
>
> -    if (!base_ts->fixed_reg) {
> +    if (base_ts->kind !=3D TEMP_FIXED) {
>          /* We do not support double-indirect registers.  */
>          tcg_debug_assert(!base_ts->indirect_reg);
>          base_ts->indirect_base =3D 1;
> @@ -1247,6 +1247,7 @@ TCGTemp *tcg_global_mem_new_internal(TCGType type, =
TCGv_ptr base,
>  TCGTemp *tcg_temp_new_internal(TCGType type, bool temp_local)
>  {
>      TCGContext *s =3D tcg_ctx;
> +    TCGTempKind kind =3D temp_local ? TEMP_LOCAL : TEMP_NORMAL;
>      TCGTemp *ts;
>      int idx, k;
>
> @@ -1259,7 +1260,7 @@ TCGTemp *tcg_temp_new_internal(TCGType type, bool t=
emp_local)
>          ts =3D &s->temps[idx];
>          ts->temp_allocated =3D 1;
>          tcg_debug_assert(ts->base_type =3D=3D type);
> -        tcg_debug_assert(ts->temp_local =3D=3D temp_local);
> +        tcg_debug_assert(ts->kind =3D=3D kind);
>      } else {
>          ts =3D tcg_temp_alloc(s);
>          if (TCG_TARGET_REG_BITS =3D=3D 32 && type =3D=3D TCG_TYPE_I64) {
> @@ -1268,18 +1269,18 @@ TCGTemp *tcg_temp_new_internal(TCGType type, bool=
 temp_local)
>              ts->base_type =3D type;
>              ts->type =3D TCG_TYPE_I32;
>              ts->temp_allocated =3D 1;
> -            ts->temp_local =3D temp_local;
> +            ts->kind =3D kind;
>
>              tcg_debug_assert(ts2 =3D=3D ts + 1);
>              ts2->base_type =3D TCG_TYPE_I64;
>              ts2->type =3D TCG_TYPE_I32;
>              ts2->temp_allocated =3D 1;
> -            ts2->temp_local =3D temp_local;
> +            ts2->kind =3D kind;
>          } else {
>              ts->base_type =3D type;
>              ts->type =3D type;
>              ts->temp_allocated =3D 1;
> -            ts->temp_local =3D temp_local;
> +            ts->kind =3D kind;
>          }
>      }
>
> @@ -1336,12 +1337,12 @@ void tcg_temp_free_internal(TCGTemp *ts)
>      }
>  #endif
>
> -    tcg_debug_assert(ts->temp_global =3D=3D 0);
> +    tcg_debug_assert(ts->kind < TEMP_GLOBAL);
>      tcg_debug_assert(ts->temp_allocated !=3D 0);
>      ts->temp_allocated =3D 0;
>
>      idx =3D temp_idx(ts);
> -    k =3D ts->base_type + (ts->temp_local ? TCG_TYPE_COUNT : 0);
> +    k =3D ts->base_type + (ts->kind =3D=3D TEMP_NORMAL ? 0 : TCG_TYPE_CO=
UNT);
>      set_bit(idx, s->free_temps[k].l);
>  }
>
> @@ -1864,17 +1865,27 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int =
nargs, TCGTemp **args)
>  static void tcg_reg_alloc_start(TCGContext *s)
>  {
>      int i, n;
> -    TCGTemp *ts;
>
> -    for (i =3D 0, n =3D s->nb_globals; i < n; i++) {
> -        ts =3D &s->temps[i];
> -        ts->val_type =3D (ts->fixed_reg ? TEMP_VAL_REG : TEMP_VAL_MEM);
> -    }
> -    for (n =3D s->nb_temps; i < n; i++) {
> -        ts =3D &s->temps[i];
> -        ts->val_type =3D (ts->temp_local ? TEMP_VAL_MEM : TEMP_VAL_DEAD)=
;
> -        ts->mem_allocated =3D 0;
> -        ts->fixed_reg =3D 0;
> +    for (i =3D 0, n =3D s->nb_temps; i < n; i++) {
> +        TCGTemp *ts =3D &s->temps[i];
> +        TCGTempVal val =3D TEMP_VAL_MEM;
> +
> +        switch (ts->kind) {
> +        case TEMP_FIXED:
> +            val =3D TEMP_VAL_REG;
> +            break;
> +        case TEMP_GLOBAL:
> +            break;
> +        case TEMP_NORMAL:
> +            val =3D TEMP_VAL_DEAD;
> +            /* fall through */
> +        case TEMP_LOCAL:
> +            ts->mem_allocated =3D 0;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        ts->val_type =3D val;
>      }
>
>      memset(s->reg_to_temp, 0, sizeof(s->reg_to_temp));
> @@ -1885,12 +1896,17 @@ static char *tcg_get_arg_str_ptr(TCGContext *s, c=
har *buf, int buf_size,
>  {
>      int idx =3D temp_idx(ts);
>
> -    if (ts->temp_global) {
> +    switch (ts->kind) {
> +    case TEMP_FIXED:
> +    case TEMP_GLOBAL:
>          pstrcpy(buf, buf_size, ts->name);
> -    } else if (ts->temp_local) {
> +        break;
> +    case TEMP_LOCAL:
>          snprintf(buf, buf_size, "loc%d", idx - s->nb_globals);
> -    } else {
> +        break;
> +    case TEMP_NORMAL:
>          snprintf(buf, buf_size, "tmp%d", idx - s->nb_globals);
> +        break;
>      }

Hmm, why this switch doesn't have:

        default:
            g_assert_not_reached();

like the other ones?

Aleksandar

>      return buf;
>  }
> @@ -2486,15 +2502,24 @@ static void la_bb_end(TCGContext *s, int ng, int =
nt)
>  {
>      int i;
>
> -    for (i =3D 0; i < ng; ++i) {
> -        s->temps[i].state =3D TS_DEAD | TS_MEM;
> -        la_reset_pref(&s->temps[i]);
> -    }
> -    for (i =3D ng; i < nt; ++i) {
> -        s->temps[i].state =3D (s->temps[i].temp_local
> -                             ? TS_DEAD | TS_MEM
> -                             : TS_DEAD);
> -        la_reset_pref(&s->temps[i]);
> +    for (i =3D 0; i < nt; ++i) {
> +        TCGTemp *ts =3D &s->temps[i];
> +        int state;
> +
> +        switch (ts->kind) {
> +        case TEMP_FIXED:
> +        case TEMP_GLOBAL:
> +        case TEMP_LOCAL:
> +            state =3D TS_DEAD | TS_MEM;
> +            break;
> +        case TEMP_NORMAL:
> +            state =3D TS_DEAD;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        ts->state =3D state;
> +        la_reset_pref(ts);
>      }
>  }
>
> @@ -3069,7 +3094,8 @@ static void check_regs(TCGContext *s)
>      }
>      for (k =3D 0; k < s->nb_temps; k++) {
>          ts =3D &s->temps[k];
> -        if (ts->val_type =3D=3D TEMP_VAL_REG && !ts->fixed_reg
> +        if (ts->val_type =3D=3D TEMP_VAL_REG
> +            && ts->kind !=3D TEMP_FIXED
>              && s->reg_to_temp[ts->reg] !=3D ts) {
>              printf("Inconsistency for temp %s:\n",
>                     tcg_get_arg_str_ptr(s, buf, sizeof(buf), ts));
> @@ -3106,15 +3132,14 @@ static void temp_load(TCGContext *, TCGTemp *, TC=
GRegSet, TCGRegSet, TCGRegSet);
>     mark it free; otherwise mark it dead.  */
>  static void temp_free_or_dead(TCGContext *s, TCGTemp *ts, int free_or_de=
ad)
>  {
> -    if (ts->fixed_reg) {
> +    if (ts->kind =3D=3D TEMP_FIXED) {
>          return;
>      }
>      if (ts->val_type =3D=3D TEMP_VAL_REG) {
>          s->reg_to_temp[ts->reg] =3D NULL;
>      }
>      ts->val_type =3D (free_or_dead < 0
> -                    || ts->temp_local
> -                    || ts->temp_global
> +                    || ts->kind !=3D TEMP_NORMAL
>                      ? TEMP_VAL_MEM : TEMP_VAL_DEAD);
>  }
>
> @@ -3131,7 +3156,7 @@ static inline void temp_dead(TCGContext *s, TCGTemp=
 *ts)
>  static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_re=
gs,
>                        TCGRegSet preferred_regs, int free_or_dead)
>  {
> -    if (ts->fixed_reg) {
> +    if (ts->kind =3D=3D TEMP_FIXED) {
>          return;
>      }
>      if (!ts->mem_coherent) {
> @@ -3289,7 +3314,8 @@ static void temp_save(TCGContext *s, TCGTemp *ts, T=
CGRegSet allocated_regs)
>  {
>      /* The liveness analysis already ensures that globals are back
>         in memory. Keep an tcg_debug_assert for safety. */
> -    tcg_debug_assert(ts->val_type =3D=3D TEMP_VAL_MEM || ts->fixed_reg);
> +    tcg_debug_assert(ts->val_type =3D=3D TEMP_VAL_MEM
> +                     || ts->kind =3D=3D TEMP_FIXED);
>  }
>
>  /* save globals to their canonical location and assume they can be
> @@ -3314,7 +3340,7 @@ static void sync_globals(TCGContext *s, TCGRegSet a=
llocated_regs)
>      for (i =3D 0, n =3D s->nb_globals; i < n; i++) {
>          TCGTemp *ts =3D &s->temps[i];
>          tcg_debug_assert(ts->val_type !=3D TEMP_VAL_REG
> -                         || ts->fixed_reg
> +                         || ts->kind =3D=3D TEMP_FIXED
>                           || ts->mem_coherent);
>      }
>  }
> @@ -3327,7 +3353,7 @@ static void tcg_reg_alloc_bb_end(TCGContext *s, TCG=
RegSet allocated_regs)
>
>      for (i =3D s->nb_globals; i < s->nb_temps; i++) {
>          TCGTemp *ts =3D &s->temps[i];
> -        if (ts->temp_local) {
> +        if (ts->kind =3D=3D TEMP_LOCAL) {
>              temp_save(s, ts, allocated_regs);
>          } else {
>              /* The liveness analysis already ensures that temps are dead=
.
> @@ -3347,7 +3373,7 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TC=
GTemp *ots,
>                                    TCGRegSet preferred_regs)
>  {
>      /* ENV should not be modified.  */
> -    tcg_debug_assert(!ots->fixed_reg);
> +    tcg_debug_assert(ots->kind !=3D TEMP_FIXED);
>
>      /* The movi is not explicitly generated here.  */
>      if (ots->val_type =3D=3D TEMP_VAL_REG) {
> @@ -3387,7 +3413,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const =
TCGOp *op)
>      ts =3D arg_temp(op->args[1]);
>
>      /* ENV should not be modified.  */
> -    tcg_debug_assert(!ots->fixed_reg);
> +    tcg_debug_assert(ots->kind !=3D TEMP_FIXED);
>
>      /* Note that otype !=3D itype for no-op truncation.  */
>      otype =3D ots->type;
> @@ -3426,7 +3452,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const =
TCGOp *op)
>          }
>          temp_dead(s, ots);
>      } else {
> -        if (IS_DEAD_ARG(1) && !ts->fixed_reg) {
> +        if (IS_DEAD_ARG(1) && ts->kind !=3D TEMP_FIXED) {
>              /* the mov can be suppressed */
>              if (ots->val_type =3D=3D TEMP_VAL_REG) {
>                  s->reg_to_temp[ots->reg] =3D NULL;
> @@ -3448,7 +3474,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const =
TCGOp *op)
>                   * Store the source register into the destination slot
>                   * and leave the destination temp as TEMP_VAL_MEM.
>                   */
> -                assert(!ots->fixed_reg);
> +                assert(ots->kind !=3D TEMP_FIXED);
>                  if (!ts->mem_allocated) {
>                      temp_allocate_frame(s, ots);
>                  }
> @@ -3485,7 +3511,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const =
TCGOp *op)
>      its =3D arg_temp(op->args[1]);
>
>      /* ENV should not be modified.  */
> -    tcg_debug_assert(!ots->fixed_reg);
> +    tcg_debug_assert(ots->kind !=3D TEMP_FIXED);
>
>      itype =3D its->type;
>      vece =3D TCGOP_VECE(op);
> @@ -3625,7 +3651,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const T=
CGOp *op)
>          i_preferred_regs =3D o_preferred_regs =3D 0;
>          if (arg_ct->ct & TCG_CT_IALIAS) {
>              o_preferred_regs =3D op->output_pref[arg_ct->alias_index];
> -            if (ts->fixed_reg) {
> +            if (ts->kind =3D=3D TEMP_FIXED) {
>                  /* if fixed register, we must allocate a new register
>                     if the alias is not the same register */
>                  if (arg !=3D op->args[arg_ct->alias_index]) {
> @@ -3716,7 +3742,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const T=
CGOp *op)
>              ts =3D arg_temp(arg);
>
>              /* ENV should not be modified.  */
> -            tcg_debug_assert(!ts->fixed_reg);
> +            tcg_debug_assert(ts->kind !=3D TEMP_FIXED);
>
>              if ((arg_ct->ct & TCG_CT_ALIAS)
>                  && !const_args[arg_ct->alias_index]) {
> @@ -3758,7 +3784,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const T=
CGOp *op)
>          ts =3D arg_temp(op->args[i]);
>
>          /* ENV should not be modified.  */
> -        tcg_debug_assert(!ts->fixed_reg);
> +        tcg_debug_assert(ts->kind !=3D TEMP_FIXED);
>
>          if (NEED_SYNC_ARG(i)) {
>              temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i));
> @@ -3890,7 +3916,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp=
 *op)
>          ts =3D arg_temp(arg);
>
>          /* ENV should not be modified.  */
> -        tcg_debug_assert(!ts->fixed_reg);
> +        tcg_debug_assert(ts->kind !=3D TEMP_FIXED);
>
>          reg =3D tcg_target_call_oarg_regs[i];
>          tcg_debug_assert(s->reg_to_temp[reg] =3D=3D NULL);
> --
> 2.20.1
>
>

