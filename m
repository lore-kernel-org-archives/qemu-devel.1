Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7928DC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF4C20781
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLKg71aK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF4C20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRXjo-0000dF-8B
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRXia-00083L-Ot
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRXiY-0000iS-Re
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:00:24 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRXiY-0000hH-Ad
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:00:22 -0400
Received: by mail-wm1-x341.google.com with SMTP id x4so5572663wmj.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5PpqfdKpIbMLPxAjCeb+vrZvIKNs8Q55nHtP1+sJn2E=;
 b=cLKg71aKXVKZPhuCiaXiIQdx6WjRYfl7aGLI1j4j6qDR4ZWgt/AWLodbT9dS1DVjiZ
 fx8GWDXYFnLsX5bYFtq1qiRqU9+dDYEX1PVW7jdNuRKJvoAriWQDParve21lJGACqDAq
 Dp9KQvjtqlrq7tcnB+B6XErGCGGODHvrFYl0lBsjMNyo0qoA1F824isY/X2PDpKqr3Fv
 Gjt7SVsuY0YdxS7Vvu3D/TXDRqchOeoNtYBh/ev8u6xWs3ZcEZV2ejY+ZT4eJrRT45Hu
 HbOP/Qj9PzxDu+kwimdX5cyHAbQ8wlhXK6CjjuY+T9+YRf9raMX4SkxQQQKiuBaDDtMj
 H5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5PpqfdKpIbMLPxAjCeb+vrZvIKNs8Q55nHtP1+sJn2E=;
 b=JRemB3Ar1zmiEKl7Yu3BH1i1a+CmrFiSFdXAdpcYP+DkwvhmpIOcOZjrngCtu7KeMz
 XUNz2O+D+nrboGHiJgmRUKtuBcDT+cOlvljDgQmgFRJXidv5jXruwjcpYyWkc42P9PlA
 Ce8DJtctq0bC0KUk7ezAOW50imIBEUDo0920VjibM1Kwo7TXEYqxG2YXmT0VS/M3Qr+E
 WbjEeDfa9RWF9UtSHV55EbA7BqEp/6bYr0XRbUUjhE1c33aQc9t6mvoYxlAz8uM4x5lM
 Ezr07CMc+h9FFRM2Sxh8hF5CYK8tj9IX4eAY2DjdUJOv+/7pLGwctLnZq3y/5NoFhvpj
 zzCA==
X-Gm-Message-State: AGi0PubFPCbgEk51LCfKPtW1wZhpwbOg848azYHj5IvI7pJ3Bra8YbJv
 Nt5gL5D4k9JOewxmk1fpzLAHldzv
X-Google-Smtp-Source: APiQypL+9mxOra1pI/pBKH21Eoc3DCktblMoocByQ9Ze5XGktnu7ANO7Ff52Vo3rRQeNBZWnGLREFQ==
X-Received: by 2002:a05:600c:2c47:: with SMTP id
 r7mr2960186wmg.50.1587632419684; 
 Thu, 23 Apr 2020 02:00:19 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id u30sm2783944wru.13.2020.04.23.02.00.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 02:00:18 -0700 (PDT)
Subject: Re: [PATCH v2 09/36] tcg: Consolidate 3 bits into enum TCGTempKind
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-10-richard.henderson@linaro.org>
 <CAHiYmc7eFG5FSa8z1gEv0Cdi+eBvOx-Y4_2qFCM-EYNZBPqd6A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <a3133ba4-9146-bd1a-98be-c41077a18eca@amsat.org>
Date: Thu, 23 Apr 2020 11:00:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc7eFG5FSa8z1gEv0Cdi+eBvOx-Y4_2qFCM-EYNZBPqd6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 9:58 PM, Aleksandar Markovic wrote:
> сре, 22. апр 2020. у 03:27 Richard Henderson
> <richard.henderson@linaro.org> је написао/ла:
>>
>> The temp_fixed, temp_global, temp_local bits are all related.
>> Combine them into a single enumeration.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/tcg/tcg.h |  20 +++++---
>>  tcg/optimize.c    |   8 +--
>>  tcg/tcg.c         | 122 ++++++++++++++++++++++++++++------------------
>>  3 files changed, 90 insertions(+), 60 deletions(-)
>>
>> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
>> index c48bd76b0a..3534dce77f 100644
>> --- a/include/tcg/tcg.h
>> +++ b/include/tcg/tcg.h
>> @@ -480,23 +480,27 @@ typedef enum TCGTempVal {
>>      TEMP_VAL_CONST,
>>  } TCGTempVal;
>>
>> +typedef enum TCGTempKind {
>> +    /* Temp is dead at the end of all basic blocks. */
>> +    TEMP_NORMAL,
>> +    /* Temp is saved across basic blocks but dead at the end of TBs. */
>> +    TEMP_LOCAL,
>> +    /* Temp is saved across both basic blocks and translation blocks. */
>> +    TEMP_GLOBAL,
>> +    /* Temp is in a fixed register. */
>> +    TEMP_FIXED,

4 cases, so currently 2 bits are enough.

>> +} TCGTempKind;
>> +
>>  typedef struct TCGTemp {
>>      TCGReg reg:8;
>>      TCGTempVal val_type:8;
>>      TCGType base_type:8;
>>      TCGType type:8;
>> -    unsigned int fixed_reg:1;
>> +    TCGTempKind kind:3;

But in case you plan to support more cases...

>>      unsigned int indirect_reg:1;
>>      unsigned int indirect_base:1;
>>      unsigned int mem_coherent:1;
>>      unsigned int mem_allocated:1;
>> -    /* If true, the temp is saved across both basic blocks and
>> -       translation blocks.  */
>> -    unsigned int temp_global:1;
>> -    /* If true, the temp is saved across basic blocks but dead
>> -       at the end of translation blocks.  If false, the temp is
>> -       dead at the end of basic blocks.  */
>> -    unsigned int temp_local:1;
>>      unsigned int temp_allocated:1;
>>
>>      tcg_target_long val;
>> diff --git a/tcg/optimize.c b/tcg/optimize.c
>> index 53aa8e5329..afb4a9a5a9 100644
>> --- a/tcg/optimize.c
>> +++ b/tcg/optimize.c
>> @@ -116,21 +116,21 @@ static TCGTemp *find_better_copy(TCGContext *s, TCGTemp *ts)
>>      TCGTemp *i;
>>
>>      /* If this is already a global, we can't do better. */
>> -    if (ts->temp_global) {
>> +    if (ts->kind >= TEMP_GLOBAL) {
>>          return ts;
>>      }
>>
>>      /* Search for a global first. */
>>      for (i = ts_info(ts)->next_copy; i != ts; i = ts_info(i)->next_copy) {
>> -        if (i->temp_global) {
>> +        if (i->kind >= TEMP_GLOBAL) {
>>              return i;
>>          }
>>      }
>>
>>      /* If it is a temp, search for a temp local. */
>> -    if (!ts->temp_local) {
>> +    if (ts->kind == TEMP_NORMAL) {
>>          for (i = ts_info(ts)->next_copy; i != ts; i = ts_info(i)->next_copy) {
>> -            if (ts->temp_local) {
>> +            if (i->kind >= TEMP_LOCAL) {
>>                  return i;
>>              }
>>          }
>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>> index dd4b3d7684..eaf81397a3 100644
>> --- a/tcg/tcg.c
>> +++ b/tcg/tcg.c
>> @@ -1155,7 +1155,7 @@ static inline TCGTemp *tcg_global_alloc(TCGContext *s)
>>      tcg_debug_assert(s->nb_globals == s->nb_temps);
>>      s->nb_globals++;
>>      ts = tcg_temp_alloc(s);
>> -    ts->temp_global = 1;
>> +    ts->kind = TEMP_GLOBAL;
>>
>>      return ts;
>>  }
>> @@ -1172,7 +1172,7 @@ static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
>>      ts = tcg_global_alloc(s);
>>      ts->base_type = type;
>>      ts->type = type;
>> -    ts->fixed_reg = 1;
>> +    ts->kind = TEMP_FIXED;
>>      ts->reg = reg;
>>      ts->name = name;
>>      tcg_regset_set_reg(s->reserved_regs, reg);
>> @@ -1199,7 +1199,7 @@ TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
>>      bigendian = 1;
>>  #endif
>>
>> -    if (!base_ts->fixed_reg) {
>> +    if (base_ts->kind != TEMP_FIXED) {
>>          /* We do not support double-indirect registers.  */
>>          tcg_debug_assert(!base_ts->indirect_reg);
>>          base_ts->indirect_base = 1;
>> @@ -1247,6 +1247,7 @@ TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
>>  TCGTemp *tcg_temp_new_internal(TCGType type, bool temp_local)
>>  {
>>      TCGContext *s = tcg_ctx;
>> +    TCGTempKind kind = temp_local ? TEMP_LOCAL : TEMP_NORMAL;
>>      TCGTemp *ts;
>>      int idx, k;
>>
>> @@ -1259,7 +1260,7 @@ TCGTemp *tcg_temp_new_internal(TCGType type, bool temp_local)
>>          ts = &s->temps[idx];
>>          ts->temp_allocated = 1;
>>          tcg_debug_assert(ts->base_type == type);
>> -        tcg_debug_assert(ts->temp_local == temp_local);
>> +        tcg_debug_assert(ts->kind == kind);
>>      } else {
>>          ts = tcg_temp_alloc(s);
>>          if (TCG_TARGET_REG_BITS == 32 && type == TCG_TYPE_I64) {
>> @@ -1268,18 +1269,18 @@ TCGTemp *tcg_temp_new_internal(TCGType type, bool temp_local)
>>              ts->base_type = type;
>>              ts->type = TCG_TYPE_I32;
>>              ts->temp_allocated = 1;
>> -            ts->temp_local = temp_local;
>> +            ts->kind = kind;
>>
>>              tcg_debug_assert(ts2 == ts + 1);
>>              ts2->base_type = TCG_TYPE_I64;
>>              ts2->type = TCG_TYPE_I32;
>>              ts2->temp_allocated = 1;
>> -            ts2->temp_local = temp_local;
>> +            ts2->kind = kind;
>>          } else {
>>              ts->base_type = type;
>>              ts->type = type;
>>              ts->temp_allocated = 1;
>> -            ts->temp_local = temp_local;
>> +            ts->kind = kind;
>>          }
>>      }
>>
>> @@ -1336,12 +1337,12 @@ void tcg_temp_free_internal(TCGTemp *ts)
>>      }
>>  #endif
>>
>> -    tcg_debug_assert(ts->temp_global == 0);
>> +    tcg_debug_assert(ts->kind < TEMP_GLOBAL);
>>      tcg_debug_assert(ts->temp_allocated != 0);
>>      ts->temp_allocated = 0;
>>
>>      idx = temp_idx(ts);
>> -    k = ts->base_type + (ts->temp_local ? TCG_TYPE_COUNT : 0);
>> +    k = ts->base_type + (ts->kind == TEMP_NORMAL ? 0 : TCG_TYPE_COUNT);
>>      set_bit(idx, s->free_temps[k].l);
>>  }
>>
>> @@ -1864,17 +1865,27 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
>>  static void tcg_reg_alloc_start(TCGContext *s)
>>  {
>>      int i, n;
>> -    TCGTemp *ts;
>>
>> -    for (i = 0, n = s->nb_globals; i < n; i++) {
>> -        ts = &s->temps[i];
>> -        ts->val_type = (ts->fixed_reg ? TEMP_VAL_REG : TEMP_VAL_MEM);
>> -    }
>> -    for (n = s->nb_temps; i < n; i++) {
>> -        ts = &s->temps[i];
>> -        ts->val_type = (ts->temp_local ? TEMP_VAL_MEM : TEMP_VAL_DEAD);
>> -        ts->mem_allocated = 0;
>> -        ts->fixed_reg = 0;
>> +    for (i = 0, n = s->nb_temps; i < n; i++) {
>> +        TCGTemp *ts = &s->temps[i];
>> +        TCGTempVal val = TEMP_VAL_MEM;
>> +
>> +        switch (ts->kind) {
>> +        case TEMP_FIXED:
>> +            val = TEMP_VAL_REG;
>> +            break;
>> +        case TEMP_GLOBAL:
>> +            break;
>> +        case TEMP_NORMAL:
>> +            val = TEMP_VAL_DEAD;
>> +            /* fall through */
>> +        case TEMP_LOCAL:
>> +            ts->mem_allocated = 0;
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>> +        ts->val_type = val;
>>      }
>>
>>      memset(s->reg_to_temp, 0, sizeof(s->reg_to_temp));
>> @@ -1885,12 +1896,17 @@ static char *tcg_get_arg_str_ptr(TCGContext *s, char *buf, int buf_size,
>>  {
>>      int idx = temp_idx(ts);
>>
>> -    if (ts->temp_global) {
>> +    switch (ts->kind) {
>> +    case TEMP_FIXED:
>> +    case TEMP_GLOBAL:
>>          pstrcpy(buf, buf_size, ts->name);
>> -    } else if (ts->temp_local) {
>> +        break;
>> +    case TEMP_LOCAL:
>>          snprintf(buf, buf_size, "loc%d", idx - s->nb_globals);
>> -    } else {
>> +        break;
>> +    case TEMP_NORMAL:
>>          snprintf(buf, buf_size, "tmp%d", idx - s->nb_globals);
>> +        break;
>>      }
> 
> Hmm, why this switch doesn't have:
> 
>         default:
>             g_assert_not_reached();
> 
> like the other ones?

... then all switch should have a default case, as noticed Aleksandar.

With the default case fixed:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Aleksandar
> 
>>      return buf;
>>  }
>> @@ -2486,15 +2502,24 @@ static void la_bb_end(TCGContext *s, int ng, int nt)
>>  {
>>      int i;
>>
>> -    for (i = 0; i < ng; ++i) {
>> -        s->temps[i].state = TS_DEAD | TS_MEM;
>> -        la_reset_pref(&s->temps[i]);
>> -    }
>> -    for (i = ng; i < nt; ++i) {
>> -        s->temps[i].state = (s->temps[i].temp_local
>> -                             ? TS_DEAD | TS_MEM
>> -                             : TS_DEAD);
>> -        la_reset_pref(&s->temps[i]);
>> +    for (i = 0; i < nt; ++i) {
>> +        TCGTemp *ts = &s->temps[i];
>> +        int state;
>> +
>> +        switch (ts->kind) {
>> +        case TEMP_FIXED:
>> +        case TEMP_GLOBAL:
>> +        case TEMP_LOCAL:
>> +            state = TS_DEAD | TS_MEM;
>> +            break;
>> +        case TEMP_NORMAL:
>> +            state = TS_DEAD;
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>> +        ts->state = state;
>> +        la_reset_pref(ts);
>>      }
>>  }
>>
>> @@ -3069,7 +3094,8 @@ static void check_regs(TCGContext *s)
>>      }
>>      for (k = 0; k < s->nb_temps; k++) {
>>          ts = &s->temps[k];
>> -        if (ts->val_type == TEMP_VAL_REG && !ts->fixed_reg
>> +        if (ts->val_type == TEMP_VAL_REG
>> +            && ts->kind != TEMP_FIXED
>>              && s->reg_to_temp[ts->reg] != ts) {
>>              printf("Inconsistency for temp %s:\n",
>>                     tcg_get_arg_str_ptr(s, buf, sizeof(buf), ts));
>> @@ -3106,15 +3132,14 @@ static void temp_load(TCGContext *, TCGTemp *, TCGRegSet, TCGRegSet, TCGRegSet);
>>     mark it free; otherwise mark it dead.  */
>>  static void temp_free_or_dead(TCGContext *s, TCGTemp *ts, int free_or_dead)
>>  {
>> -    if (ts->fixed_reg) {
>> +    if (ts->kind == TEMP_FIXED) {
>>          return;
>>      }
>>      if (ts->val_type == TEMP_VAL_REG) {
>>          s->reg_to_temp[ts->reg] = NULL;
>>      }
>>      ts->val_type = (free_or_dead < 0
>> -                    || ts->temp_local
>> -                    || ts->temp_global
>> +                    || ts->kind != TEMP_NORMAL
>>                      ? TEMP_VAL_MEM : TEMP_VAL_DEAD);
>>  }
>>
>> @@ -3131,7 +3156,7 @@ static inline void temp_dead(TCGContext *s, TCGTemp *ts)
>>  static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
>>                        TCGRegSet preferred_regs, int free_or_dead)
>>  {
>> -    if (ts->fixed_reg) {
>> +    if (ts->kind == TEMP_FIXED) {
>>          return;
>>      }
>>      if (!ts->mem_coherent) {
>> @@ -3289,7 +3314,8 @@ static void temp_save(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs)
>>  {
>>      /* The liveness analysis already ensures that globals are back
>>         in memory. Keep an tcg_debug_assert for safety. */
>> -    tcg_debug_assert(ts->val_type == TEMP_VAL_MEM || ts->fixed_reg);
>> +    tcg_debug_assert(ts->val_type == TEMP_VAL_MEM
>> +                     || ts->kind == TEMP_FIXED);
>>  }
>>
>>  /* save globals to their canonical location and assume they can be
>> @@ -3314,7 +3340,7 @@ static void sync_globals(TCGContext *s, TCGRegSet allocated_regs)
>>      for (i = 0, n = s->nb_globals; i < n; i++) {
>>          TCGTemp *ts = &s->temps[i];
>>          tcg_debug_assert(ts->val_type != TEMP_VAL_REG
>> -                         || ts->fixed_reg
>> +                         || ts->kind == TEMP_FIXED
>>                           || ts->mem_coherent);
>>      }
>>  }
>> @@ -3327,7 +3353,7 @@ static void tcg_reg_alloc_bb_end(TCGContext *s, TCGRegSet allocated_regs)
>>
>>      for (i = s->nb_globals; i < s->nb_temps; i++) {
>>          TCGTemp *ts = &s->temps[i];
>> -        if (ts->temp_local) {
>> +        if (ts->kind == TEMP_LOCAL) {
>>              temp_save(s, ts, allocated_regs);
>>          } else {
>>              /* The liveness analysis already ensures that temps are dead.
>> @@ -3347,7 +3373,7 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
>>                                    TCGRegSet preferred_regs)
>>  {
>>      /* ENV should not be modified.  */
>> -    tcg_debug_assert(!ots->fixed_reg);
>> +    tcg_debug_assert(ots->kind != TEMP_FIXED);
>>
>>      /* The movi is not explicitly generated here.  */
>>      if (ots->val_type == TEMP_VAL_REG) {
>> @@ -3387,7 +3413,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>>      ts = arg_temp(op->args[1]);
>>
>>      /* ENV should not be modified.  */
>> -    tcg_debug_assert(!ots->fixed_reg);
>> +    tcg_debug_assert(ots->kind != TEMP_FIXED);
>>
>>      /* Note that otype != itype for no-op truncation.  */
>>      otype = ots->type;
>> @@ -3426,7 +3452,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>>          }
>>          temp_dead(s, ots);
>>      } else {
>> -        if (IS_DEAD_ARG(1) && !ts->fixed_reg) {
>> +        if (IS_DEAD_ARG(1) && ts->kind != TEMP_FIXED) {
>>              /* the mov can be suppressed */
>>              if (ots->val_type == TEMP_VAL_REG) {
>>                  s->reg_to_temp[ots->reg] = NULL;
>> @@ -3448,7 +3474,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
>>                   * Store the source register into the destination slot
>>                   * and leave the destination temp as TEMP_VAL_MEM.
>>                   */
>> -                assert(!ots->fixed_reg);
>> +                assert(ots->kind != TEMP_FIXED);
>>                  if (!ts->mem_allocated) {
>>                      temp_allocate_frame(s, ots);
>>                  }
>> @@ -3485,7 +3511,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
>>      its = arg_temp(op->args[1]);
>>
>>      /* ENV should not be modified.  */
>> -    tcg_debug_assert(!ots->fixed_reg);
>> +    tcg_debug_assert(ots->kind != TEMP_FIXED);
>>
>>      itype = its->type;
>>      vece = TCGOP_VECE(op);
>> @@ -3625,7 +3651,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>>          i_preferred_regs = o_preferred_regs = 0;
>>          if (arg_ct->ct & TCG_CT_IALIAS) {
>>              o_preferred_regs = op->output_pref[arg_ct->alias_index];
>> -            if (ts->fixed_reg) {
>> +            if (ts->kind == TEMP_FIXED) {
>>                  /* if fixed register, we must allocate a new register
>>                     if the alias is not the same register */
>>                  if (arg != op->args[arg_ct->alias_index]) {
>> @@ -3716,7 +3742,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>>              ts = arg_temp(arg);
>>
>>              /* ENV should not be modified.  */
>> -            tcg_debug_assert(!ts->fixed_reg);
>> +            tcg_debug_assert(ts->kind != TEMP_FIXED);
>>
>>              if ((arg_ct->ct & TCG_CT_ALIAS)
>>                  && !const_args[arg_ct->alias_index]) {
>> @@ -3758,7 +3784,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>>          ts = arg_temp(op->args[i]);
>>
>>          /* ENV should not be modified.  */
>> -        tcg_debug_assert(!ts->fixed_reg);
>> +        tcg_debug_assert(ts->kind != TEMP_FIXED);
>>
>>          if (NEED_SYNC_ARG(i)) {
>>              temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i));
>> @@ -3890,7 +3916,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
>>          ts = arg_temp(arg);
>>
>>          /* ENV should not be modified.  */
>> -        tcg_debug_assert(!ts->fixed_reg);
>> +        tcg_debug_assert(ts->kind != TEMP_FIXED);
>>
>>          reg = tcg_target_call_oarg_regs[i];
>>          tcg_debug_assert(s->reg_to_temp[reg] == NULL);
>> --
>> 2.20.1
>>
>>
> 

