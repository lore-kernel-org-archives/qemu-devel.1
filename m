Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DFDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4B720678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcuB35mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4B720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgSnk-0006Qx-Bu
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 08:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgSn0-0005gs-7b
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 08:46:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27390
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgSmz-0008OE-7L
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 08:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591188395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vcjQZ1BPsnWStgGfL6JglFpZEEgYsoXIRVPER7jk1WI=;
 b=gcuB35mzTSfmasarsMo75QMGVUtkMaPUcWUNJ/yHMfCPx4FoSgy0Y8WDduXuEZQZgswtdH
 okmo8awKvgCq1YyUsW7xCevsd37uuV6mc2QJY6b/jf28GyVRbSJUlv8Zjxz1bq8NWhkJ2i
 Gt4tG5jXjgTb1wraJ4CQ0x7vUIvqvbU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-zvTwV5DQMV6KWLrzBMVHYg-1; Wed, 03 Jun 2020 08:46:34 -0400
X-MC-Unique: zvTwV5DQMV6KWLrzBMVHYg-1
Received: by mail-wr1-f72.google.com with SMTP id d6so1062512wrn.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 05:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=vcjQZ1BPsnWStgGfL6JglFpZEEgYsoXIRVPER7jk1WI=;
 b=EvmUc3Ilty/zdq++FWyTB8GUM2GLgzhFpvxSyqp+yHYH6lLGQX8MCFWTEwSGkrJ7sR
 p8kFnmfL69DpXqpzxEgcRiH0oHNsXFEygrFW2e3FNDI1ToiEpRBlPLhpwxdnfUb3XYL6
 heDxcNPWvHCQHJRiwcSRsjEJlQrfF5NhhO/MSLLNR1HO4dxcfmdZYAqVNJNoWdlp/rnu
 00qKSmxY8dmPSii55dnqObRi8IoBrKp1m4VfzfkZRmIpwwKqX6Hsk1dBwFpRFP8T9AbM
 ww4AcjXpNlvXA56evtQJIPREH8HUnTWXCeMdSKD0le7mBSDX/ZUjYvIwIsHZXTXDBZVK
 DtDQ==
X-Gm-Message-State: AOAM530Ep/oZWExCLqnt0mMGeQxGcnEdiVyKiXLizpgYrtXonZnImrhz
 FEGCDtI5R7RamUbduXLINMK5CU2ytrv88Z5Y3mPnkAixHFcn1mlJlno6H7l63ghp+bUGDevP+jV
 tHI/F0TxkwfQuLGI=
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr8592110wma.160.1591188393102; 
 Wed, 03 Jun 2020 05:46:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBbyUSlwmlQs0y9/i29SIejxgTFbP+N7vHMhRwUyjTlQCAwN9PY1b8/44juv+0f9v27zUkJw==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr8592085wma.160.1591188392871; 
 Wed, 03 Jun 2020 05:46:32 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 23sm2891624wmo.18.2020.06.03.05.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 05:46:32 -0700 (PDT)
Subject: Re: [PATCH v2] exec: flush the whole TLB if a watchpoint crosses a
 page boundary
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200603112442.22833-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <dc06ca1f-4327-7511-eadf-cc5ad905c94c@redhat.com>
Date: Wed, 3 Jun 2020 14:46:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200603112442.22833-1-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 1:24 PM, Alex Bennée wrote:
> There is no particular reason why you can't have a watchpoint in TCG
> that covers a large chunk of the address space. We could be clever
> about it but these cases are pretty rare and we can assume the user
> will expect a little performance degradation.
> 
> NB: In my testing gdb will silently squash a watchpoint like:
> 
>   watch (char[0x7fffffffff]) *0x0
> 
> to a 4 byte watchpoint. Practically it will limit the maximum size
> based on max-value-size. However given enough of a tweak the sky is
> the limit.
> 
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - use cleaner in_page = -(addr | TARGET_PAGE_MASK) logic per rth

Can we have a macro for this?
Maybe QEMU_IN_PAGE_OFFSET(addr, TARGET_PAGE_MASK)?
or QEMU_OFFSET_IN_PAGE()...

> ---
>  exec.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/exec.c b/exec.c
> index 5162f0d12f9..65a4376df37 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1036,6 +1036,7 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
>                            int flags, CPUWatchpoint **watchpoint)
>  {
>      CPUWatchpoint *wp;
> +    vaddr in_page;
>  
>      /* forbid ranges which are empty or run off the end of the address space */
>      if (len == 0 || (addr + len - 1) < addr) {
> @@ -1056,7 +1057,12 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
>          QTAILQ_INSERT_TAIL(&cpu->watchpoints, wp, entry);
>      }
>  
> -    tlb_flush_page(cpu, addr);
> +    in_page = -(addr | TARGET_PAGE_MASK);
> +    if (len <= in_page) {
> +        tlb_flush_page(cpu, addr);
> +    } else {
> +        tlb_flush(cpu);
> +    }
>  
>      if (watchpoint)
>          *watchpoint = wp;
> 


