Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A23C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18CB2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la6hbxS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18CB2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQQRi-0004fE-1d
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 03:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41438 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQQQ-000497-90
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 03:01:02 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQQP-0004SY-Bj
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 03:01:01 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:38586)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQQO-0004FX-Tl
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 03:01:00 -0400
Received: by mail-ed1-x541.google.com with SMTP id e5so6520598edq.5
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y716F6QUFyNYTSj/qAxyLKRDJknKpyJAI0JwpbVAEdI=;
 b=la6hbxS7UfIrfmKQMDxG1QAY0jckdJLg2vux+pGM0owfnLRUQEbBXEpAdfOwLEIWx0
 PNS9C/lm8IALeibtTf3Hmxe6jAunNuosPfs+3krkAxLe5loVj08xdcYlD+zlx6EmO5RD
 7LudBVfsAITCxZuagp4p9Po51xm+hSOOKhC76RofJmiXVcDwxNwpP7/unk10p/gnwVfJ
 GRIxX8wjquYs6YE3Q0yfg/QoycG1t29RiXXuJi8cxDUtN9hiQWrn8kWKVQV+uDJZcaku
 ltyu3Z376u9UqCh2rScFCDvoxwN4S7hfoVnRVBK7wpKzWo3tsZodyhUaZTzdiW0Sb+5k
 sDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=y716F6QUFyNYTSj/qAxyLKRDJknKpyJAI0JwpbVAEdI=;
 b=gMDRnKtZ0u9fwA44vMOLZaz9IxkAQithoa9txVx2PhsK8Ftp0HkbbP8QTQJtKR2O5H
 e99a6Zp7MU22AT+X3VWo2FXsPLIFBKA37GCJPdeFrwRuz0YJ+SLASp874DnZVjqS+AQP
 gr0v25sZArlbcFzdDXvTMmBoIrRpuZahXD/2ge2PoSq9fuerdJTPPrQj7oT+2x0Lzlw9
 pxygsDkuybKZDnFCcDYDZS5v/19aFPVVlYvVdpmmLzsOTv6gSV6Yi1VS7V9zlYKNOVo0
 rhIw/Rjk6qdkESaYRKwuv2dW1zKe3JEil81ZiP0CFTLVVBRG35skqrY1W1JcNilrxdFE
 yWsQ==
X-Gm-Message-State: AGi0PuYK425tMEOUsZdM9Rt1vcegtB1E+UNrhO4Pa/S1MFQc1xdwyvln
 Lhd0KNIoTO8JG787b0/IITw2K20jToo=
X-Google-Smtp-Source: APiQypLgjAwzjb3k7nNOvxaetjYuN0MgEihHW6FjyKewssT4aNmqUkrV+qbJzD3gbrkv6EpSOHx3zg==
X-Received: by 2002:a05:6402:75a:: with SMTP id
 p26mr5838169edy.311.1587366058240; 
 Mon, 20 Apr 2020 00:00:58 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f21sm2942588edy.96.2020.04.20.00.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 00:00:57 -0700 (PDT)
Subject: Re: [PATCH 07/16] tcg: Rename struct tcg_temp_info to TempOptInfo
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200418161914.4387-1-richard.henderson@linaro.org>
 <20200418161914.4387-8-richard.henderson@linaro.org>
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
Message-ID: <398bc2f2-6d9d-0664-329c-d456e35bfcc5@amsat.org>
Date: Mon, 20 Apr 2020 09:00:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200418161914.4387-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::541
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/18/20 6:19 PM, Richard Henderson wrote:
> Fix this name vs our coding style.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/optimize.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index effb47eefd..b86bf3d707 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -35,20 +35,20 @@
>          glue(glue(case INDEX_op_, x), _i64):    \
>          glue(glue(case INDEX_op_, x), _vec)
>  
> -struct tcg_temp_info {
> +typedef struct TempOptInfo {
>      bool is_const;
>      TCGTemp *prev_copy;
>      TCGTemp *next_copy;
>      tcg_target_ulong val;
>      tcg_target_ulong mask;
> -};
> +} TempOptInfo;
>  
> -static inline struct tcg_temp_info *ts_info(TCGTemp *ts)
> +static inline TempOptInfo *ts_info(TCGTemp *ts)
>  {
>      return ts->state_ptr;
>  }
>  
> -static inline struct tcg_temp_info *arg_info(TCGArg arg)
> +static inline TempOptInfo *arg_info(TCGArg arg)
>  {
>      return ts_info(arg_temp(arg));
>  }
> @@ -71,9 +71,9 @@ static inline bool ts_is_copy(TCGTemp *ts)
>  /* Reset TEMP's state, possibly removing the temp for the list of copies.  */
>  static void reset_ts(TCGTemp *ts)
>  {
> -    struct tcg_temp_info *ti = ts_info(ts);
> -    struct tcg_temp_info *pi = ts_info(ti->prev_copy);
> -    struct tcg_temp_info *ni = ts_info(ti->next_copy);
> +    TempOptInfo *ti = ts_info(ts);
> +    TempOptInfo *pi = ts_info(ti->prev_copy);
> +    TempOptInfo *ni = ts_info(ti->next_copy);
>  
>      ni->prev_copy = ti->prev_copy;
>      pi->next_copy = ti->next_copy;
> @@ -89,12 +89,12 @@ static void reset_temp(TCGArg arg)
>  }
>  
>  /* Initialize and activate a temporary.  */
> -static void init_ts_info(struct tcg_temp_info *infos,
> +static void init_ts_info(TempOptInfo *infos,
>                           TCGTempSet *temps_used, TCGTemp *ts)
>  {
>      size_t idx = temp_idx(ts);
>      if (!test_bit(idx, temps_used->l)) {
> -        struct tcg_temp_info *ti = &infos[idx];
> +        TempOptInfo *ti = &infos[idx];
>  
>          ts->state_ptr = ti;
>          ti->next_copy = ts;
> @@ -114,7 +114,7 @@ static void init_ts_info(struct tcg_temp_info *infos,
>      }
>  }
>  
> -static void init_arg_info(struct tcg_temp_info *infos,
> +static void init_arg_info(TempOptInfo *infos,
>                            TCGTempSet *temps_used, TCGArg arg)
>  {
>      init_ts_info(infos, temps_used, arg_temp(arg));
> @@ -177,7 +177,7 @@ static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg val)
>      const TCGOpDef *def;
>      TCGOpcode new_op;
>      tcg_target_ulong mask;
> -    struct tcg_temp_info *di = arg_info(dst);
> +    TempOptInfo *di = arg_info(dst);
>  
>      def = &tcg_op_defs[op->opc];
>      if (def->flags & TCG_OPF_VECTOR) {
> @@ -208,8 +208,8 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg src)
>      TCGTemp *dst_ts = arg_temp(dst);
>      TCGTemp *src_ts = arg_temp(src);
>      const TCGOpDef *def;
> -    struct tcg_temp_info *di;
> -    struct tcg_temp_info *si;
> +    TempOptInfo *di;
> +    TempOptInfo *si;
>      tcg_target_ulong mask;
>      TCGOpcode new_op;
>  
> @@ -242,7 +242,7 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg src)
>      di->mask = mask;
>  
>      if (src_ts->type == dst_ts->type) {
> -        struct tcg_temp_info *ni = ts_info(si->next_copy);
> +        TempOptInfo *ni = ts_info(si->next_copy);
>  
>          di->next_copy = si->next_copy;
>          di->prev_copy = src_ts;
> @@ -605,7 +605,7 @@ void tcg_optimize(TCGContext *s)
>  {
>      int nb_temps, nb_globals;
>      TCGOp *op, *op_next, *prev_mb = NULL;
> -    struct tcg_temp_info *infos;
> +    TempOptInfo *infos;
>      TCGTempSet temps_used;
>  
>      /* Array VALS has an element for each temp.
> @@ -616,7 +616,7 @@ void tcg_optimize(TCGContext *s)
>      nb_temps = s->nb_temps;
>      nb_globals = s->nb_globals;
>      bitmap_zero(temps_used.l, nb_temps);
> -    infos = tcg_malloc(sizeof(struct tcg_temp_info) * nb_temps);
> +    infos = tcg_malloc(sizeof(TempOptInfo) * nb_temps);
>  
>      QTAILQ_FOREACH_SAFE(op, &s->ops, link, op_next) {
>          tcg_target_ulong mask, partmask, affected;
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

