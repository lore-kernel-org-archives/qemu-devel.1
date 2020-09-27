Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14602C4727E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5948B23998
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTngfJY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5948B23998
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMSKZ-0007ws-D3
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 04:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMSJe-0007Ip-Ox
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:45:54 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMSJd-00082B-47
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:45:54 -0400
Received: by mail-wr1-x441.google.com with SMTP id o5so8301420wrn.13
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3EtFQBMECjCKrhn6/NkSXLlQafAj/Ic4atOtScZxR38=;
 b=CTngfJY3hILrLZNSUzUQ6uG1TpVISULF+OkPXmOiLdO7z6fQl4JL1MvhLX3NHr0ZPY
 wSpOGkeG/le9xPzQWm6sbfEPxD9IFvJLfo4pIfQImixuFteqtyyX+cvFNY8gHHJqSE4g
 HcEQ1OVcf+Yrzdq2YXOuobZttXsB7tqZ7DeZx0AE2nZS864ilkX79zDDbxNRXSGmwDTN
 5feU1Ltelhr7JipiuGqAumpBi2T7rNKIp1eF1yFzB+PONfU7CLWNgLuPwjxcOoKSJJ5v
 ORrRFwcbpZjoGbX+N+JagR/7nTR0GX1HK8e+SmLtC+8GDoVft0u2dGPN+AuwIM1qbWiY
 SMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3EtFQBMECjCKrhn6/NkSXLlQafAj/Ic4atOtScZxR38=;
 b=jDU/fRVDFJKKrJhID2YJQ3t2kFQmfujit1GDjHqTyKobSEJWquPDa+ewfqSvSgMJ62
 Q/7I6q+lpCZ+74NaLbYczTh8/ECVLujtVoVL3zOatm58+8lJl590Tm39Goy3xGQWvuZj
 nhoFB1oakQd7V2p6PTFqUmQ60Pl8wo1VB2XcZPEkV25vT5OASrJrMKWDQ6ydqqjlH/fq
 rMlqH7rC/JiTv36bLeDY1eb6CE4XHeWUg8ycG9v5rndXV/UqTYb+ja/WLsPWQ5RsV+Oi
 NYjruIZImIQbAtWuKzyz6w6NwDUUydANg21nEy8tvJtxJPEZVQuacskmZPHW9UB1/COj
 9l/g==
X-Gm-Message-State: AOAM5338gDwCtsgD47C3Uu+c/vDSzYj2DKPF+diZm929wEKGvxHjpyBB
 y41028zqz7Z2nGpcFpwk0kc=
X-Google-Smtp-Source: ABdhPJzSkLG0i3es6FghIFnYPZnWzXW5iZK6akGQiB3gUyIC+UJiUKq9RKGV449zEL4HPuMkjxnA5g==
X-Received: by 2002:adf:e449:: with SMTP id t9mr13244131wrm.154.1601196351727; 
 Sun, 27 Sep 2020 01:45:51 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id l126sm4913326wmf.39.2020.09.27.01.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2020 01:45:50 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] plugin: Fixes compiling errors on msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200927081901.771-1-luoyonggang@gmail.com>
 <20200927081901.771-3-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dd4e8591-c6cc-b86b-5103-c6f313d69f00@amsat.org>
Date: Sun, 27 Sep 2020 10:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200927081901.771-3-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.213,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=e8=8c=85e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/20 10:18 AM, Yonggang Luo wrote:
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  contrib/plugins/hotblocks.c | 2 +-
>  tests/plugin/bb.c           | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> index 3942a2ca54..37435a3fc7 100644
> --- a/contrib/plugins/hotblocks.c
> +++ b/contrib/plugins/hotblocks.c
> @@ -102,7 +102,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>  {
>      ExecCount *cnt;
>      uint64_t pc = qemu_plugin_tb_vaddr(tb);
> -    unsigned long insns = qemu_plugin_tb_n_insns(tb);
> +    size_t insns = qemu_plugin_tb_n_insns(tb);
>      uint64_t hash = pc ^ insns;
>  
>      g_mutex_lock(&lock);
> diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
> index e4cc7fdd6e..de09bdde4e 100644
> --- a/tests/plugin/bb.c
> +++ b/tests/plugin/bb.c
> @@ -72,7 +72,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>      CPUCount *count = max_cpus ?
>          g_ptr_array_index(counts, cpu_index) : &inline_count;
>  
> -    unsigned long n_insns = (unsigned long)udata;
> +    uintptr_t n_insns = (uintptr_t)udata;

Shouldn't this be:

       uint64_t n_insns = (uint64_t)(uintptr_t)udata;

?

>      g_mutex_lock(&count->lock);
>      count->insn_count += n_insns;
>      count->bb_count++;
> @@ -81,7 +81,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>  
>  static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>  {
> -    unsigned long n_insns = qemu_plugin_tb_n_insns(tb);
> +    size_t n_insns = qemu_plugin_tb_n_insns(tb);
>  
>      if (do_inline) {
>          qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
> 

