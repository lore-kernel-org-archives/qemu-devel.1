Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E48C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64968207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cw8SUG0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64968207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7QC-0006Mr-Km
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY7O0-0004MD-HI
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:18:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22782
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY7Nz-0001TL-Nd
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589199499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VpKvH+OX/HhyE0FSafJf0hC/3SfjvlbQ/zKk26ZY5do=;
 b=Cw8SUG0Smvhjlr+8Fz3z/2fqYpGlIkwdS5L8+zLMLKM3q/1ubExR3ODUApnxYiih4mByqP
 b0DjNAriIqbB94mlZZtozJ843xupU4DMz8J+1YBLGwjhENK9R9lqyK0veABiw7Ta3E9wfY
 FR0aiSRCHn10nnBT/vAQ2iVcwgR0pFQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-RQgGNmOGM0q4UrsOkSwP2g-1; Mon, 11 May 2020 08:18:16 -0400
X-MC-Unique: RQgGNmOGM0q4UrsOkSwP2g-1
Received: by mail-wm1-f69.google.com with SMTP id a206so2909886wmh.6
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 05:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VpKvH+OX/HhyE0FSafJf0hC/3SfjvlbQ/zKk26ZY5do=;
 b=RLCQJVKQ9jc2K9fHyOiPI+0RjetZlWFwY4tf7MJIWs9or3qo4V/Cm+11/CpOr8ssaV
 /uRGC/JX0DCBuwz6gjE0MGV7q6IdIRaqbijOWLnmFFKMGSBWfkChGJ3ZW9kUgnqhRP2T
 mJ90beQ5LLBzS4qFD1uxCBg8vUEJRDDVxLcGgu5JgHcK14ooFiWRekS8RbC/gkC09ByM
 BSdCjA3uFMDsXGvYF7u89MWwXRM3I8BLxOVOboeAMdBILzNmtdhhSh+Jzq2GwPlAv7e0
 nD5/uFHwaSQUCnU29LG4vO9jTc6fNrCNXVqhdSQH68nS+xDkpdh8agB9Df8QVJGWZJEf
 jM3w==
X-Gm-Message-State: AGi0PuaUCQ/jwepSBYbMDfLlXWfYgyh8Z9yI6Sa/e1MU75/+UgtcVQ3Y
 4c1duWBmSfXf8ZEKenwu2aWqlWMzXmrlq45gtPN8vV7c0Y5ISWoCAwqHzP74atJ8vXRpTjqeg3E
 7rvGukfQgHoij0Ws=
X-Received: by 2002:a1c:5f08:: with SMTP id t8mr17003466wmb.67.1589199495143; 
 Mon, 11 May 2020 05:18:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypJlembs7C7OEviYyEx02qrq9XV8dulsk2Y22GR1Cjw2vrkvyIQ9ypBT2TzfGcEJd0QLFkfnqw==
X-Received: by 2002:a1c:5f08:: with SMTP id t8mr17003443wmb.67.1589199494920; 
 Mon, 11 May 2020 05:18:14 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d126sm6927791wmd.32.2020.05.11.05.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 05:18:14 -0700 (PDT)
Subject: Re: [PATCH v1 6/7] disas: add optional note support to cap_disas
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200501145713.19822-1-alex.bennee@linaro.org>
 <20200501145713.19822-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cd4891c2-e3c1-8c97-1935-e89674205aad@redhat.com>
Date: Mon, 11 May 2020 14:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200501145713.19822-7-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 4:57 PM, Alex Bennée wrote:
> Include support for outputting a note at the top of a chunk of
> disassembly to capstone as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   disas.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/disas.c b/disas.c
> index bb74650633..5e7eb65326 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -260,7 +260,8 @@ static void cap_dump_insn_units(disassemble_info *info, cs_insn *insn,
>       }
>   }
>   
> -static void cap_dump_insn(disassemble_info *info, cs_insn *insn)
> +static void cap_dump_insn(disassemble_info *info, cs_insn *insn,
> +                          const char *note)
>   {
>       fprintf_function print = info->fprintf_func;
>       int i, n, split;
> @@ -281,7 +282,8 @@ static void cap_dump_insn(disassemble_info *info, cs_insn *insn)
>       }
>   
>       /* Print the actual instruction.  */
> -    print(info->stream, "  %-8s %s\n", insn->mnemonic, insn->op_str);
> +    print(info->stream, "  %-8s %s\t\t%s\n", insn->mnemonic, insn->op_str,
> +          note ? note : "");
>   
>       /* Dump any remaining part of the insn on subsequent lines.  */
>       for (i = split; i < n; i += split) {
> @@ -313,7 +315,7 @@ static bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
>           size -= tsize;
>   
>           while (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
> -           cap_dump_insn(info, insn);
> +            cap_dump_insn(info, insn, NULL);
>           }
>   
>           /* If the target memory is not consumed, go back for more... */
> @@ -342,7 +344,8 @@ static bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
>   }
>   
>   /* Disassemble SIZE bytes at CODE for the host.  */
> -static bool cap_disas_host(disassemble_info *info, void *code, size_t size)
> +static bool cap_disas_host(disassemble_info *info, void *code, size_t size,
> +                           const char *note)
>   {
>       csh handle;
>       const uint8_t *cbuf;
> @@ -358,7 +361,8 @@ static bool cap_disas_host(disassemble_info *info, void *code, size_t size)
>       pc = (uintptr_t)code;
>   
>       while (cs_disasm_iter(handle, &cbuf, &size, &pc, insn)) {
> -       cap_dump_insn(info, insn);
> +        cap_dump_insn(info, insn, note ? note : NULL);

'note' directly?

Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        note = NULL;
>       }
>       if (size != 0) {
>           (*info->fprintf_func)(info->stream,
> @@ -402,7 +406,7 @@ static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
>           csize += tsize;
>   
>           if (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
> -            cap_dump_insn(info, insn);
> +            cap_dump_insn(info, insn, NULL);
>               if (--count <= 0) {
>                   break;
>               }
> @@ -416,7 +420,7 @@ static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
>   #endif /* !CONFIG_USER_ONLY */
>   #else
>   # define cap_disas_target(i, p, s)  false
> -# define cap_disas_host(i, p, s)  false
> +# define cap_disas_host(i, p, s, n)  false
>   # define cap_disas_monitor(i, p, c)  false
>   # define cap_disas_plugin(i, p, c) false
>   #endif /* CONFIG_CAPSTONE */
> @@ -664,7 +668,7 @@ void disas(FILE *out, void *code, unsigned long size, const char *note)
>       print_insn = print_insn_hppa;
>   #endif
>   
> -    if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size)) {
> +    if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size, note)) {
>           return;
>       }
>   
> 


