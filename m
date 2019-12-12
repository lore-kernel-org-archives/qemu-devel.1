Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC544C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 10:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7084214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 10:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+NsCeLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7084214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifLpd-0004Si-Kp
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 05:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1ifLoc-0003xk-RE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1ifLoa-0006kf-EK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:35:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32005
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1ifLoa-0006jv-9p
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576146923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4TdKNesfJudrtT6c6aoM46for0/fSf2FOHMNzPnN50Y=;
 b=F+NsCeLbUFVytafoJN57QffDHGBvCvwQ4t9e2rHcNcV5/AjlaTP3Wou5WtCoqPRjbybhDf
 zP0DoS+nmKJUZEJ3J+zglg2wJp67L/LZjACz4N7LSYXTlSAaUVCBLo+ny9IRfya4LXN5Qv
 V4ef+Vw6UXeF9u8eFY76eY16ZKSgyOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-ErX1LqpeNR6uPZqZ1uoS7g-1; Thu, 12 Dec 2019 05:35:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E3148017DF;
 Thu, 12 Dec 2019 10:35:19 +0000 (UTC)
Received: from [10.36.116.183] (ovpn-116-183.ams2.redhat.com [10.36.116.183])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E4646013D;
 Thu, 12 Dec 2019 10:35:18 +0000 (UTC)
Subject: Re: [PATCH 2/2] target/s390x: Implement LOAD/STORE TO REAL ADDRESS
 inline
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191211203614.15611-1-richard.henderson@linaro.org>
 <20191211203614.15611-3-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMFCQlmAYAGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl3pImkCGQEACgkQTd4Q
 9wD/g1o+VA//SFvIHUAvul05u6wKv/pIR6aICPdpF9EIgEU448g+7FfDgQwcEny1pbEzAmiw
 zAXIQ9H0NZh96lcq+yDLtONnXk/bEYWHHUA014A1wqcYNRY8RvY1+eVHb0uu0KYQoXkzvu+s
 Dncuguk470XPnscL27hs8PgOP6QjG4jt75K2LfZ0eAqTOUCZTJxA8A7E9+XTYuU0hs7QVrWJ
 jQdFxQbRMrYz7uP8KmTK9/Cnvqehgl4EzyRaZppshruKMeyheBgvgJd5On1wWq4ZUV5PFM4x
 II3QbD3EJfWbaJMR55jI9dMFa+vK7MFz3rhWOkEx/QR959lfdRSTXdxs8V3zDvChcmRVGN8U
 Vo93d1YNtWnA9w6oCW1dnDZ4kgQZZSBIjp6iHcA08apzh7DPi08jL7M9UQByeYGr8KuR4i6e
 RZI6xhlZerUScVzn35ONwOC91VdYiQgjemiVLq1WDDZ3B7DIzUZ4RQTOaIWdtXBWb8zWakt/
 ztGhsx0e39Gvt3391O1PgcA7ilhvqrBPemJrlb9xSPPRbaNAW39P8ws/UJnzSJqnHMVxbRZC
 Am4add/SM+OCP0w3xYss1jy9T+XdZa0lhUvJfLy7tNcjVG/sxkBXOaSC24MFPuwnoC9WvCVQ
 ZBxouph3kqc4Dt5X1EeXVLeba+466P1fe1rC8MbcwDkoUo65Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAiUEGAECAA8FAlXLn5ECGwwFCQlmAYAACgkQTd4Q
 9wD/g1qA6w/+M+ggFv+JdVsz5+ZIc6MSyGUozASX+bmIuPeIecc9UsFRatc91LuJCKMkD9Uv
 GOcWSeFpLrSGRQ1Z7EMzFVU//qVs6uzhsNk0RYMyS0B6oloW3FpyQ+zOVylFWQCzoyyf227y
 GW8HnXunJSC+4PtlL2AY4yZjAVAPLK2l6mhgClVXTQ/S7cBoTQKP+jvVJOoYkpnFxWE9pn4t
 H5QIFk7Ip8TKr5k3fXVWk4lnUi9MTF/5L/mWqdyIO1s7cjharQCstfWCzWrVeVctpVoDfJWp
 4LwTuQ5yEM2KcPeElLg5fR7WB2zH97oI6/Ko2DlovmfQqXh9xWozQt0iGy5tWzh6I0JrlcxJ
 ileZWLccC4XKD1037Hy2FLAjzfoWgwBLA6ULu0exOOdIa58H4PsXtkFPrUF980EEibUp0zFz
 GotRVekFAceUaRvAj7dh76cToeZkfsjAvBVb4COXuhgX6N4pofgNkW2AtgYu1nUsPAo+NftU
 CxrhjHtLn4QEBpkbErnXQyMjHpIatlYGutVMS91XTQXYydCh5crMPs7hYVsvnmGHIaB9ZMfB
 njnuI31KBiLUks+paRkHQlFcgS2N3gkRBzH7xSZ+t7Re3jvXdXEzKBbQ+dC3lpJB0wPnyMcX
 FOTT3aZT7IgePkt5iC/BKBk3hqKteTnJFeVIT7EC+a6YUFg=
Organization: Red Hat GmbH
Message-ID: <032873c2-9f04-2c9d-e74d-2625d5e1948d@redhat.com>
Date: Thu, 12 Dec 2019 11:35:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211203614.15611-3-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ErX1LqpeNR6uPZqZ1uoS7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> These are trivially done by performing a memory operation
> with the correct mmu_idx.  The only tricky part is using
> get_address directly in order to get the address wrapped;
> we cannot use la2 because of the format.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/helper.h      |  4 ----
>  target/s390x/mem_helper.c  | 22 ----------------------
>  target/s390x/translate.c   | 21 ++++-----------------
>  target/s390x/insn-data.def |  8 ++++----
>  4 files changed, 8 insertions(+), 47 deletions(-)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index f5b4bb6a31..b5813c2ac2 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -324,10 +324,6 @@ DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
>  DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
>  DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
>  DEF_HELPER_2(lra, i64, env, i64)
> -DEF_HELPER_FLAGS_2(lura, TCG_CALL_NO_WG, i64, env, i64)
> -DEF_HELPER_FLAGS_2(lurag, TCG_CALL_NO_WG, i64, env, i64)
> -DEF_HELPER_FLAGS_3(stura, TCG_CALL_NO_WG, void, env, i64, i64)
> -DEF_HELPER_FLAGS_3(sturg, TCG_CALL_NO_WG, void, env, i64, i64)
>  DEF_HELPER_1(per_check_exception, void, env)
>  DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
>  DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index b1b3f406c9..2921419c27 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -2329,28 +2329,6 @@ void HELPER(purge)(CPUS390XState *env)
>      tlb_flush_all_cpus_synced(env_cpu(env));
>  }
>  
> -/* load using real address */
> -uint64_t HELPER(lura)(CPUS390XState *env, uint64_t addr)
> -{
> -    return cpu_ldl_real_ra(env, wrap_address(env, addr), GETPC());
> -}
> -
> -uint64_t HELPER(lurag)(CPUS390XState *env, uint64_t addr)
> -{
> -    return cpu_ldq_real_ra(env, wrap_address(env, addr), GETPC());
> -}
> -
> -/* store using real address */
> -void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
> -{
> -    cpu_stl_real_ra(env, wrap_address(env, addr), (uint32_t)v1, GETPC());
> -}
> -
> -void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
> -{
> -    cpu_stq_real_ra(env, wrap_address(env, addr), v1, GETPC());
> -}
> -
>  /* load real address */
>  uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
>  {
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index ef751fefa4..4292bb0dd0 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3272,13 +3272,8 @@ static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
>  #ifndef CONFIG_USER_ONLY
>  static DisasJumpType op_lura(DisasContext *s, DisasOps *o)
>  {
> -    gen_helper_lura(o->out, cpu_env, o->in2);
> -    return DISAS_NEXT;
> -}
> -
> -static DisasJumpType op_lurag(DisasContext *s, DisasOps *o)
> -{
> -    gen_helper_lurag(o->out, cpu_env, o->in2);
> +    o->addr1 = get_address(s, 0, get_field(s->fields, r2), 0);
> +    tcg_gen_qemu_ld_tl(o->out, o->addr1, MMU_REAL_IDX, s->insn->data);
>      return DISAS_NEXT;
>  }
>  #endif
> @@ -4506,17 +4501,9 @@ static DisasJumpType op_stnosm(DisasContext *s, DisasOps *o)
>  
>  static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
>  {
> -    gen_helper_stura(cpu_env, o->in2, o->in1);
> -    if (s->base.tb->flags & FLAG_MASK_PER) {
> -        update_psw_addr(s);
> -        gen_helper_per_store_real(cpu_env);
> -    }
> -    return DISAS_NEXT;
> -}
> +    o->addr1 = get_address(s, 0, get_field(s->fields, r2), 0);
> +    tcg_gen_qemu_st_tl(o->in1, o->addr1, MMU_REAL_IDX, s->insn->data);
>  
> -static DisasJumpType op_sturg(DisasContext *s, DisasOps *o)
> -{
> -    gen_helper_sturg(cpu_env, o->in2, o->in1);
>      if (s->base.tb->flags & FLAG_MASK_PER) {
>          update_psw_addr(s);
>          gen_helper_per_store_real(cpu_env);
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 449eee1662..2bc77f0871 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -1275,8 +1275,8 @@
>      F(0xe313, LRAY,    RXY_a, LD,  0, a2, r1, 0, lra, 0, IF_PRIV)
>      F(0xe303, LRAG,    RXY_a, Z,   0, a2, r1, 0, lra, 0, IF_PRIV)
>  /* LOAD USING REAL ADDRESS */
> -    F(0xb24b, LURA,    RRE,   Z,   0, r2, new, r1_32, lura, 0, IF_PRIV)
> -    F(0xb905, LURAG,   RRE,   Z,   0, r2, r1, 0, lurag, 0, IF_PRIV)
> +    E(0xb24b, LURA,    RRE,   Z,   0, 0, new, r1_32, lura, 0, MO_TEUL, IF_PRIV)
> +    E(0xb905, LURAG,   RRE,   Z,   0, 0, r1, 0, lura, 0, MO_TEQ, IF_PRIV)
>  /* MOVE TO PRIMARY */
>      F(0xda00, MVCP,    SS_d,  Z,   la1, a2, 0, 0, mvcp, 0, IF_PRIV)
>  /* MOVE TO SECONDARY */
> @@ -1329,8 +1329,8 @@
>  /* STORE THEN OR SYSTEM MASK */
>      F(0xad00, STOSM,   SI,    Z,   la1, 0, 0, 0, stnosm, 0, IF_PRIV)
>  /* STORE USING REAL ADDRESS */
> -    F(0xb246, STURA,   RRE,   Z,   r1_o, r2_o, 0, 0, stura, 0, IF_PRIV)
> -    F(0xb925, STURG,   RRE,   Z,   r1_o, r2_o, 0, 0, sturg, 0, IF_PRIV)
> +    E(0xb246, STURA,   RRE,   Z,   r1_o, 0, 0, 0, stura, 0, MO_TEUL, IF_PRIV)
> +    E(0xb925, STURG,   RRE,   Z,   r1_o, 0, 0, 0, stura, 0, MO_TEQ, IF_PRIV)
>  /* TEST BLOCK */
>      F(0xb22c, TB,      RRE,   Z,   0, r2_o, 0, 0, testblock, 0, IF_PRIV)
>  /* TEST PROTECTION */
> 

So the MMU_REAL indeed does pay off in various ways ;)

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


