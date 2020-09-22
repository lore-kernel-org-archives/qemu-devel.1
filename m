Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6C6C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693FD2395C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjUoSbUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693FD2395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfTH-0007xZ-5p
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKfSU-0007Js-7X
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKfSS-00054m-Iz
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600770215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NBaFfHAUhTdvgrpirg82c54WHYzYiWaCGBwkVdXpYyI=;
 b=NjUoSbUGZNe/+2CNR56zWk8mZjTyUHm+6z7ZSKemMe9jPKo25+rzsyWtDujYKTMvIzs5bN
 uoFEunij5ELnE9q3e5uZbYWj2Z6qIZ95ugK69j32hu/5w0v6Xs7b2IYGAbx+94CrktkubQ
 OYIqiXceQ7W0lqs0+YcFwfP2eg5yUGo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-XSG0hHlQP0Wj07Rqr4DanQ-1; Tue, 22 Sep 2020 06:23:34 -0400
X-MC-Unique: XSG0hHlQP0Wj07Rqr4DanQ-1
Received: by mail-wr1-f70.google.com with SMTP id r16so7184980wrm.18
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=NBaFfHAUhTdvgrpirg82c54WHYzYiWaCGBwkVdXpYyI=;
 b=S/KyjYuNPvmlN2uU3UMPb41xthdsnkyz8oaIZkOP6UDtKlYnEYhCK6zARUX/FSxm9c
 FyRwm8HFDOZiRXTBmZBh7TX5I9InxF9PAJXiFEmOVWQNFKLqCVmBUpzlmdTF06gEPq75
 PAbu2jmaKTti0I2vUWzdeKRXhPu6oJsSlU8FcMCQofBD8bTvG+oC+65qoh3H4QR2aZrM
 EqSeLxGRvNk5HqotCv/W5MQ+9MDzw8TtynMlkVzI6A1aXNNLY61XcMdRaTH09/yBbS+i
 k00Bgle1GdOwJ2JSYsTK1ew/WjgXYUZJTjKumx7i1e5nQdSQpvRai9dre67tVOO5sMMr
 rzog==
X-Gm-Message-State: AOAM530+BT1xGGzPAswysfm1/A9V5TsvVJmxh6p4seGMoT/WN2z9nFr6
 7Ch80Vt17OaK463zbRJ4airspIbseSblChcnqWLA+NEQaGYletVic8yHokNS6cRAG7ihWqveyQ7
 vteU6rW+BmQOURsc=
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr4369442wrw.425.1600770212707; 
 Tue, 22 Sep 2020 03:23:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnwM5j8cd6wl9yxWfl5EEUyoDfPQ4nCReAusl0+Wj+oDytOm2j3WxkcTHZ9IvaGa73CD3A5g==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr4369428wrw.425.1600770212498; 
 Tue, 22 Sep 2020 03:23:32 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t1sm3705292wmi.16.2020.09.22.03.23.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 03:23:31 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] target-i386: seperate MCIP & MCE_MASK error reason
To: zhenwei pi <pizhenwei@bytedance.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org
References: <20200922095630.394893-1-pizhenwei@bytedance.com>
 <20200922095630.394893-2-pizhenwei@bytedance.com>
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
Message-ID: <dd556664-4419-28d6-e975-6e67724e9c2c@redhat.com>
Date: Tue, 22 Sep 2020 12:23:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922095630.394893-2-pizhenwei@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: mtosatti@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 11:56 AM, zhenwei pi wrote:
> Previously we can only get a simple string "Triple fault" in qemu
> log. Add detailed message for the two reasons to describe why qemu
> has to reset the guest.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  target/i386/helper.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 70be53e2c3..0c7fd32491 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -857,6 +857,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>      X86CPU *cpu = X86_CPU(cs);
>      CPUX86State *cenv = &cpu->env;
>      uint64_t *banks = cenv->mce_banks + 4 * params->bank;
> +    char msg[64];

The preferred for is now to use 'g_autofree char *msg = NULL'
here and g_strdup_printf() instead of snprintf().

> +    bool need_reset = false;
>  
>      cpu_synchronize_state(cs);
>  
> @@ -894,16 +896,25 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>              return;
>          }
>  
> -        if ((cenv->mcg_status & MCG_STATUS_MCIP) ||
> -            !(cenv->cr[4] & CR4_MCE_MASK)) {
> -            monitor_printf(params->mon,
> -                           "CPU %d: Previous MCE still in progress, raising"
> -                           " triple fault\n",
> -                           cs->cpu_index);
> -            qemu_log_mask(CPU_LOG_RESET, "Triple fault\n");
> +        if (cenv->mcg_status & MCG_STATUS_MCIP) {
> +            need_reset = true;
> +            snprintf(msg, sizeof(msg), "CPU %d: Previous MCE still in progress,"
> +                     " raising triple fault", cs->cpu_index);
> +        }
> +
> +        if (!(cenv->cr[4] & CR4_MCE_MASK)) {
> +            need_reset = true;
> +            snprintf(msg, sizeof(msg), "CPU %d: MCE capability is not enabled,"
> +                     " raising triple fault", cs->cpu_index);
> +        }
> +
> +        if (need_reset) {
> +            monitor_printf(params->mon, "%s", msg);
> +            qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
>              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>              return;
>          }
> +
>          if (banks[1] & MCI_STATUS_VAL) {
>              params->status |= MCI_STATUS_OVER;
>          }
> 


