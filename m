Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E964C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0701521721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9t4RILB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0701521721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHuaN-0000bP-6B
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 14:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHuZ1-0007z0-Br
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHuYw-00041F-P2
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:50:26 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:42013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHuYv-0003zk-Mz
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:50:22 -0400
Received: by mail-yb1-xb43.google.com with SMTP id 4so2595741ybq.9
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u2E30/JldkWIHQSVTjBMZhJ3AYuTKsBTxckBWYp7fyY=;
 b=u9t4RILB4T9CaGqfKhbD9+cTpzNx07+4ZJi3wJx1+mJ9Zqg/7LAIqg+JqCmY8qko/u
 /SVdWEa+x/gyYlCwMzlxpbk4sZTiAe0OMI13GUGBHxtZaxR44CPRZ44b2HkkBLKgtP62
 pmiFv+pf4N+u69GfxZGbhZhgc50ef1eJuRsj5EL/x0VZwTe56E+QL5ddac8V3S+unpqD
 zBxXJOnuLLHmPQelnmPPeomJbReoOenRLSh0sQfhxZtqWGZwsVipsuwTnfIr6ZxOjmdK
 KsKbCpE9ZpbCHRbyoJBdPrKoozXrwSWvJ7UuGsNzQ/1Ckh7JNUmz9Y0qs6R0dZn0LK0d
 kH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u2E30/JldkWIHQSVTjBMZhJ3AYuTKsBTxckBWYp7fyY=;
 b=WbWSz3KCO1WHh8QWkgeDQufVB9DcBfPCkdaPWF8SV6TAr+7TgFy9gVvvJAnCRhm/xm
 32D/Z8t8a0RCQimlxrmSoDQSCOfDL7AybLyWO+yLfgsRMK8cRNO+4JOogoM+qr6G77ul
 lFWhdCYPGkluUAcnDbUd9seVqgFrmPI4GnHQpoR4QDfNvjPkb8i3pLKYp1ibRhrflG8R
 v5DwmWSCthif3JKS/Ml3MSkRyjZw15lAkOlEglj8obaRYRaGfX6qPW3m2xGuUqVvH7Wx
 ySmgW/HyFmUTWQAl3KFSwqjoc00OglreDB4qupBR8fzx7Dz1Nv9BGODLxj1w837NoAqa
 6aTA==
X-Gm-Message-State: APjAAAUUdlA1aZZ131kUl1m7+IYX5hsXYZcpefgCOHOKbLuBVWH+zvmS
 3HKrMnSfOKPjgxfwadAnQ5gplw==
X-Google-Smtp-Source: APXvYqwa4urAnYRPMmOR99Fjf9W+HnqSGSrYu6P7KlKv0ugHjieSo3RzokaPGAcqetmubIDy1rbuHw==
X-Received: by 2002:a25:2313:: with SMTP id j19mr14337145ybj.366.1570560620039; 
 Tue, 08 Oct 2019 11:50:20 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id o11sm4936952ywc.42.2019.10.08.11.50.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 11:50:19 -0700 (PDT)
Subject: Re: [PATCH v9 09/13] Adding info [tb-list|tb] commands to HMP (WIP)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <57a84842-2e85-6c39-2abe-b0dd3b3750ca@linaro.org>
Date: Tue, 8 Oct 2019 14:50:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007152839.30804-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 11:28 AM, Alex Bennée wrote:
> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
> 
> These commands allow the exploration of TBs generated by the TCG.
> Understand which one hotter, with more guest/host instructions... and
> examine their guest, host and IR code.
> 
> The goal of this command is to allow the dynamic exploration of TCG
> behavior and code quality. Therefore, for now, a corresponding QMP
> command is not worthwhile.
> 
> [AJB: WIP - we still can't be safely sure a translation will succeed]
> 
> Example of output:
> 
> TB id:1 | phys:0x34d54 virt:0x0000000000034d54 flags:0x0000f0
> 	| exec:4828932/0 guest inst cov:16.38%
> 	| trans:1 ints: g:3 op:82 op_opt:34 spills:3
> 	| h/g (host bytes / guest insts): 90.666664
> 	| time to gen at 2.4GHz => code:3150.83(ns) IR:712.08(ns)
> 	| targets: 0x0000000000034d5e (id:11), 0x0000000000034d0d (id:2)
> 
> TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
> 	| exec:4825842/0 guest inst cov:21.82%
> 	| trans:1 ints: g:4 op:80 op_opt:38 spills:2
> 	| h/g (host bytes / guest insts): 84.000000
> 	| time to gen at 2.4GHz => code:3362.92(ns) IR:793.75(ns)
> 	| targets: 0x0000000000034d19 (id:12), 0x0000000000034d54 (id:1)
> 
> TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
> 	| exec:6956495/0  guest inst cov:21.82%
> 	| trans:2 ints: g:2 op:40 op_opt:19 spills:1
> 	| h/g (host bytes / guest insts): 84.000000
> 	| time to gen at 2.4GHz => code:3130.83(ns) IR:722.50(ns)
> 	| targets: 0x0000000000034d19 (id:12), 0x0000000000034d54 (id:1)
> 
> ----------------
> IN:
> 0x00034d0d:  89 de                    movl     %ebx, %esi
> 0x00034d0f:  26 8b 0e                 movl     %es:(%esi), %ecx
> 0x00034d12:  26 f6 46 08 80           testb    $0x80, %es:8(%esi)
> 0x00034d17:  75 3b                    jne      0x34d54
> 
> ------------------------------
> 
> TB id:1 | phys:0x34d54 virt:0x0000000000034d54 flags:0x0000f0
> 	| exec:5202686/0 guest inst cov:11.28%
> 	| trans:1 ints: g:3 op:82 op_opt:34 spills:3
> 	| h/g (host bytes / guest insts): 90.666664
> 	| time to gen at 2.4GHz => code:2793.75(ns) IR:614.58(ns)
> 	| targets: 0x0000000000034d5e (id:3), 0x0000000000034d0d (id:2)
> 
> TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
> 	| exec:5199468/0 guest inst cov:15.03%
> 	| trans:1 ints: g:4 op:80 op_opt:38 spills:2
> 	| h/g (host bytes / guest insts): 84.000000
> 	| time to gen at 2.4GHz => code:2958.75(ns) IR:719.58(ns)
> 	| targets: 0x0000000000034d19 (id:4), 0x0000000000034d54 (id:1)
> 
> ------------------------------
> 2 TBs to reach 25% of guest inst exec coverage
> Total of guest insts exec: 138346727
> 

Is there too much cut-and-paste in this commit message?
I certainly hope that identical information about TB id:2
is not output 3 times within the same report...

Or, alternately, that we are not generating multiple TBs
for the { phys:0x34d0d virt:0x34d0d flags:0xf0 } tuple.

Also, I think you probably need to output cs_base.  Depending
on the target, that might have been different, and so it
might make sense that you have 3 copies of the above.

> +static gint
> +inverse_sort_tbs(gconstpointer p1, gconstpointer p2, gpointer psort_by)

What about this makes the sort "inverse"?

> +    int sort_by = *((int *) psort_by);

Why is this not enum SortBy?

> +    if (likely(sort_by == SORT_BY_SPILLS)) {
...
> +    } else if (likely(sort_by == SORT_BY_HOTNESS)) {
...
> +    } else if (likely(sort_by == SORT_BY_HG)) {

Surely these options are not all "likely".

> +        float a =
> +            (float) stat_per_translation(tbs1, code.out_len) / tbs1->code.num_guest_inst;
> +        float b =
> +            (float) stat_per_translation(tbs2, code.out_len) / tbs2->code.num_guest_inst;

I don't understand why we're suddenly introducing floats, when the division
hidden within stat_per_translation is integer.

Think about what units being compared here, because I don't think that "average
host code length / sum of guest insn count" makes sense.  Certainly as time
progresses, average / sum -> ((sum / sum) / sum) -> (sum / sum**2) -> (1 / sum)
is going to approach 0.

I think you actually want "sum of host code length / sum of guest insn length",
which could be stated as "host/guest code ratio" or "jit code expansion factor".

> +        c1 = a <= b ? 0 : 1;
> +        c2 = a <= b ? 1 : 0;

Please do recall that (x < y ? 1 : 0) => (x < y).

In addition, there's no point in having these comparisons feed...

> +    return c1 < c2 ? 1 : c1 == c2 ? 0 : -1;

... these comparisions.

> +    for (i = last_search; i; i = i->next) {
> +        TBStatistics *tbs = (TBStatistics *) i->data;
> +        uint64_t tb_total_execs =
> +            (tbs->executions.atomic + tbs->executions.normal) * tbs->code.num_guest_inst;
> +        tbs->executions.coverage = (10000 * tb_total_execs) / (total_exec_count + 1);

If ever there was a time to want to use float, this is it.

I assume the total_exec_count + 1 is to avoid divide by zero?
Surely we can do better than this...

Indeed, given that we've already checked...

> +    if (!last_search) {
> +        qemu_printf("No data collected yet!\n");
> +        return;
> +    }

... surely we can either assert total_exec_count != 0, or don't and just let
the divide-by-zero signal do the same thing.  (I don't see the value of
replacing one signal with another in most cases.)

> +/*
> + * We cannot always re-generate the code even if we know there are
> + * valid translations still in the cache. The reason being the guest
> + * may have un-mapped the page code.

Um... unless I mistake what's being described here, that wouldn't be a valid
translation.  Or do you just mean that the page mapping isn't present within
the TLB?  Which is not quite the same thing as "unmapping".

> + * TODO: can we do this safely? We need to
> + *  a) somehow recover the mmu_idx for this translation

We could add an interface for this, yes.  The value *must* be able to be
derived from tb->flags, but of course in a target-dependent way.

> + *  b) probe MMU_INST_FETCH to know it will succeed

We *do* have this now, sort of: tlb_vaddr_to_host.

So far all use of this function originates from target/foo/,
and so some targets have not been updated to work with this.
I've marked these with asserts within foo_cpu_tlb_fill.

Notable targets for which it won't work: i386, sparc.


> +static GString *get_code_string(TBStatistics *tbs, int log_flags)
> +{
> +    int old_log_flags = qemu_loglevel;
> +
> +    CPUState *cpu = first_cpu;
> +    uint32_t cflags = curr_cflags() | CF_NOCACHE;
> +    TranslationBlock *tb = NULL;
> +
> +    GString *code_s = g_string_new(NULL);
> +    qemu_log_to_string(true, code_s);
> +
> +    qemu_set_log(log_flags);
> +
> +    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
> +        mmap_lock();
> +        tb = tb_gen_code(cpu, tbs->pc, tbs->cs_base, tbs->flags, cflags);
> +        tb_phys_invalidate(tb, -1);
> +        mmap_unlock();

Ew.  No.

Let us not go through tb_gen_code, just to get logging output from the
translator.  What are we really after here?  Input assembly?

> @@ -86,7 +91,6 @@ struct TBStatistics {
>  
>      struct {
>          unsigned long total;
> -        unsigned long uncached;
>          unsigned long spanning;
>      } translations;
>  

Vanishing unused variable that maybe shouldn't have existed?



r~

