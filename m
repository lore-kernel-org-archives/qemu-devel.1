Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C990C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 10:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 272A6206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 10:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GU0GnmLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272A6206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifLk3-0002Xx-5y
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 05:30:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1ifLjC-00021k-I7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1ifLj9-0003wo-B2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:29:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20822
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1ifLj8-0003tH-R0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576146585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E5FuNg/ZPjLHPtY185sC2JSc75Zn3HMbn7ubr3mQKog=;
 b=GU0GnmLN2+iDtSrvHh6m09NLrUjJgI5YDroeXsZjWx3BhU677ATWY3wMc8ZYsVjRet6Vs4
 2IMj/P19ScUswgY6GK5eghAWdsUH5FuLbroqoLQ8gOV1+VM5zPx3a7ze3dFaF9TebowMeA
 trR8fTS7zuo7JeHxYVhCxp8h+bDemZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-RGFqC8L4MI2nax3oxslUiQ-1; Thu, 12 Dec 2019 05:29:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4A97800D41;
 Thu, 12 Dec 2019 10:29:40 +0000 (UTC)
Received: from [10.36.116.183] (ovpn-116-183.ams2.redhat.com [10.36.116.183])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3E4377013;
 Thu, 12 Dec 2019 10:29:39 +0000 (UTC)
Subject: Re: [PATCH 1/2] target/s390x: Split out helper_per_store_real
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191211203614.15611-1-richard.henderson@linaro.org>
 <20191211203614.15611-2-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <eed8bb1c-1da0-9bb8-6711-bc5cc55ce4f6@redhat.com>
Date: Thu, 12 Dec 2019 11:29:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211203614.15611-2-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: RGFqC8L4MI2nax3oxslUiQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11.12.19 21:36, Richard Henderson wrote:
> Split the PER handling for store-to-real-address into its
> own helper function, conditionally called when PER is
> enabled, just as we do for per_branch and per_ifetch.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/helper.h      |  1 +
>  target/s390x/mem_helper.c  | 16 ----------------
>  target/s390x/misc_helper.c | 10 ++++++++++
>  target/s390x/translate.c   |  8 ++++++++
>  4 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 56e8149866..f5b4bb6a31 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -331,6 +331,7 @@ DEF_HELPER_FLAGS_3(sturg, TCG_CALL_NO_WG, void, env, i64, i64)
>  DEF_HELPER_1(per_check_exception, void, env)
>  DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
>  DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
> +DEF_HELPER_FLAGS_1(per_store_real, TCG_CALL_NO_RWG, void, env)
>  DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
>  
>  DEF_HELPER_2(xsch, void, env, i64)
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 2325767f17..b1b3f406c9 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -2344,27 +2344,11 @@ uint64_t HELPER(lurag)(CPUS390XState *env, uint64_t addr)
>  void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
>  {
>      cpu_stl_real_ra(env, wrap_address(env, addr), (uint32_t)v1, GETPC());
> -
> -    if ((env->psw.mask & PSW_MASK_PER) &&
> -        (env->cregs[9] & PER_CR9_EVENT_STORE) &&
> -        (env->cregs[9] & PER_CR9_EVENT_STORE_REAL)) {
> -        /* PSW is saved just before calling the helper.  */
> -        env->per_address = env->psw.addr;
> -        env->per_perc_atmid = PER_CODE_EVENT_STORE_REAL | get_per_atmid(env);
> -    }
>  }
>  
>  void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
>  {
>      cpu_stq_real_ra(env, wrap_address(env, addr), v1, GETPC());
> -
> -    if ((env->psw.mask & PSW_MASK_PER) &&
> -        (env->cregs[9] & PER_CR9_EVENT_STORE) &&
> -        (env->cregs[9] & PER_CR9_EVENT_STORE_REAL)) {
> -        /* PSW is saved just before calling the helper.  */
> -        env->per_address = env->psw.addr;
> -        env->per_perc_atmid = PER_CODE_EVENT_STORE_REAL | get_per_atmid(env);
> -    }
>  }
>  
>  /* load real address */
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index bfb457fb63..58dbc023eb 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -620,6 +620,16 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
>          }
>      }
>  }
> +
> +void HELPER(per_store_real)(CPUS390XState *env)
> +{
> +    if ((env->cregs[9] & PER_CR9_EVENT_STORE) &&
> +        (env->cregs[9] & PER_CR9_EVENT_STORE_REAL)) {
> +        /* PSW is saved just before calling the helper.  */
> +        env->per_address = env->psw.addr;
> +        env->per_perc_atmid = PER_CODE_EVENT_STORE_REAL | get_per_atmid(env);
> +    }
> +}
>  #endif
>  
>  static uint8_t stfl_bytes[2048];
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 151dfa91fb..ef751fefa4 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -4507,12 +4507,20 @@ static DisasJumpType op_stnosm(DisasContext *s, DisasOps *o)
>  static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
>  {
>      gen_helper_stura(cpu_env, o->in2, o->in1);
> +    if (s->base.tb->flags & FLAG_MASK_PER) {
> +        update_psw_addr(s);
> +        gen_helper_per_store_real(cpu_env);
> +    }
>      return DISAS_NEXT;
>  }
>  
>  static DisasJumpType op_sturg(DisasContext *s, DisasOps *o)
>  {
>      gen_helper_sturg(cpu_env, o->in2, o->in1);
> +    if (s->base.tb->flags & FLAG_MASK_PER) {
> +        update_psw_addr(s);
> +        gen_helper_per_store_real(cpu_env);
> +    }
>      return DISAS_NEXT;
>  }
>  #endif
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


