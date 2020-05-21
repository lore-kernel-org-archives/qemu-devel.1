Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A8EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBEE206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmSiuJU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBEE206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblpO-00058u-Ho
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jblok-0004Nw-Oa
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:05:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59155
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbloj-00038e-2L
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590069899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WCKNTUWRbqUPeiRPnkUyLzHXmhdj+cZ4YQYD3xxRsOE=;
 b=gmSiuJU7VD9DZRb8njgVs5bfwWBy5h9kTWKHuMrsqlEBtnerQQcHbQpyAp2XKfeK7Laws1
 mvVm/M/1yoRz2lpIddGZotvbXHMRBoSI0ehIYM/TIeZp3b632AUyzOoAm6iaIXJprrUrlf
 vvpBtvLwmlZ6NtwDiY1G1DX6EXTlCDI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-cuhsqQxBMVOd9gmeLZ5YrQ-1; Thu, 21 May 2020 10:04:55 -0400
X-MC-Unique: cuhsqQxBMVOd9gmeLZ5YrQ-1
Received: by mail-wr1-f70.google.com with SMTP id z5so2944111wrt.17
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WCKNTUWRbqUPeiRPnkUyLzHXmhdj+cZ4YQYD3xxRsOE=;
 b=c9gZW5beqydlUE2GVTF4/2ZgofWC6Yp9Lx4n2U5WJ0ib6t9Bsha2dNLudlWzVziuC6
 BsAu4P5CO9MMshn5NxQu2qeNR+ymz3sYnfp8vBFSN2LSwUplr/jKdOq08Jrru2oNeaBH
 M7sXohJVE5p9HXP/NOQeMSSUzla86rGgiM6dZvoVla4vIIt660Dv09fjMd0cdAkMlrxv
 LgW1pzN2+QpaXKfoQZX1+RFdEG5VQkYwtThiBSqu+buuoxX8lFYc5jdwUwP4xKUBx+Fg
 YQ+SvW/vbWd1M020RM58cSVX+QWgrJlr+1R5QF24aQURRlfphKACd7N0LezWX8CoaZYe
 aSug==
X-Gm-Message-State: AOAM533ZKNhkSpiIrFTPLW82ry/lp+GUcQFigghzdqdcsJOMTpfKrJqj
 0eY6bXdT4PAD6l2xIuXMWFH+PqSnluZuec2OEUgb6zIj5UDmkVHJfEHEkJGTjRF/pVSSFU37QNX
 4bp1/Kghal65OTwo=
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr8559341wrw.314.1590069893850; 
 Thu, 21 May 2020 07:04:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOpYeJVwaEgtbBzfd9h0DfJYdljrF2sF0DuwZs7IF3TEcu9bE0bedK5jQrYZP8arwYKiRfrg==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr8559321wrw.314.1590069893555; 
 Thu, 21 May 2020 07:04:53 -0700 (PDT)
Received: from [192.168.1.40] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v131sm7131542wmb.27.2020.05.21.07.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:04:52 -0700 (PDT)
Subject: Re: [PATCH v1 10/10] translate-all: include guest address in out_asm
 output
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200513175134.19619-1-alex.bennee@linaro.org>
 <20200513175134.19619-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f4862b01-8a96-7c8c-c62e-ccb9fa5cffbb@redhat.com>
Date: Thu, 21 May 2020 16:04:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200513175134.19619-11-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 5/13/20 7:51 PM, Alex Bennée wrote:
> We already have information about where each guest instructions
> representation starts stored in the tcg_ctx->gen_insn_data so we can
> rectify the PC for faults. We can re-use this information to annotate
> the out_asm output with guest instruction address which makes it a bit
> easier to work out where you are especially with longer blocks. A
> minor wrinkle is that some instructions get optimised away so we have
> to scan forward until we find some actual generated code.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v1
>    - better logic for doing chunk at a time
>    - use new "note" facility to tag address
>    - rewrite the commit log
> v2
>    - don't terminate gen_insn_end_off, trust your termination
>      conditions ;-)
> ---
>   accel/tcg/translate-all.c | 39 +++++++++++++++++++++++++++++++++------
>   1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index cdf58bb420e..42ce1dfcff7 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1794,14 +1794,43 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
>           qemu_log_in_addr_range(tb->pc)) {
>           FILE *logfile = qemu_log_lock();
> +        int code_size, data_size = 0;
> +        g_autoptr(GString) note = g_string_new("[tb header & initial instruction]");
> +        size_t chunk_start = 0;
> +        int insn = 0;
>           qemu_log("OUT: [size=%d]\n", gen_code_size);
>           if (tcg_ctx->data_gen_ptr) {
> -            size_t code_size = tcg_ctx->data_gen_ptr - tb->tc.ptr;
> -            size_t data_size = gen_code_size - code_size;
> -            size_t i;
> +            code_size = tcg_ctx->data_gen_ptr - tb->tc.ptr;
> +            data_size = gen_code_size - code_size;
> +        } else {
> +            code_size = gen_code_size;
> +        }
>   
> -            log_disas(tb->tc.ptr, code_size, NULL);
> +        /* Dump header and the first instruction */
> +        chunk_start = tcg_ctx->gen_insn_end_off[insn];
> +        log_disas(tb->tc.ptr, chunk_start, note->str);
>   
> +        /*
> +         * Dump each instruction chunk, wrapping up empty chunks into
> +         * the next instruction. The whole array is offset so the
> +         * first entry is the beginning of the 2nd instruction.
> +         */
> +        while (insn <= tb->icount && chunk_start < code_size) {
> +            size_t chunk_end = tcg_ctx->gen_insn_end_off[insn];
> +            if (chunk_end > chunk_start) {
> +                g_string_printf(note, "[guest addr: " TARGET_FMT_lx "]",
> +                                tcg_ctx->gen_insn_data[insn][0]);
> +                log_disas(tb->tc.ptr + chunk_start, chunk_end - chunk_start,
> +                          note->str);
> +                chunk_start = chunk_end;
> +            }
> +            insn++;
> +        }
> +
> +        /* Finally dump any data we may have after the block */
> +        if (data_size) {

It seems we can simplify checking tcg_ctx->data_gen_ptr here, and 
declaring data_size in this reduced scope. Doing so as a preliminary 
patch makes the rest of this patch easier to review. What do you think?

> +            int i;
> +            qemu_log("  data: [size=%d]\n", data_size);
>               for (i = 0; i < data_size; i += sizeof(tcg_target_ulong)) {
>                   if (sizeof(tcg_target_ulong) == 8) {
>                       qemu_log("0x%08" PRIxPTR ":  .quad  0x%016" PRIx64 "\n",
> @@ -1813,8 +1842,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>                                *(uint32_t *)(tcg_ctx->data_gen_ptr + i));
>                   }
>               }
> -        } else {
> -            log_disas(tb->tc.ptr, gen_code_size, NULL);
>           }
>           qemu_log("\n");
>           qemu_log_flush();
> 


