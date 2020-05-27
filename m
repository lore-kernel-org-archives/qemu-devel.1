Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D7CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DC820E65
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K72FWLPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DC820E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdqV9-0001X3-E3
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 03:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdqTr-0008OR-7r
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:28:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39303
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdqTq-0003TM-5m
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590564480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z2/c0Aqc+jPAz37cBdOdNxUgJnmWJgrosIaFchyc4EY=;
 b=K72FWLPpnV4Ox92ZulRldGzDuuacZvIrrjdaNxKu7OoJwDQLN0frWNrA3lJw54t5j/kB7M
 p2SzmloTDCfJkF3l/OPAtpAb0QhaADeckCilOJMFeuf9jri9uPqY3z9dLXfbmF5+7hGo8W
 4xRNWmCx7YiSUwGthZeTVt8ShvXZsWE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-ztIALLTOO46jQ5CVqwqcnA-1; Wed, 27 May 2020 03:27:56 -0400
X-MC-Unique: ztIALLTOO46jQ5CVqwqcnA-1
Received: by mail-wr1-f70.google.com with SMTP id a4so1660092wrp.5
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 00:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Z2/c0Aqc+jPAz37cBdOdNxUgJnmWJgrosIaFchyc4EY=;
 b=uYRnEu8fQKl9FqfleoAddzOPqVGRl7fdj+BA+ABqmZkfeBSSHZQedNr3SEEYWZt/Fa
 eQMUT4paHuX9kUDYHU7fsScgZk1VyBafu8FFGqa+n/FP/amv4FgOqYI9U4IYwPFeXbFQ
 gfm4V3gYpYIJcmaKH6a3M4dcDir8AMOEvg2HnM6x17QIV4KaOE3nbiWxdQzb4YTH5RTq
 JwmmbT7B4Q55tKbNzCV7f+o+rAVF2XG1hXCZgr8xOlmgVLYog8KqVf4yBk1hT4WuLbqS
 O7BCfY5WoVpt2XxGYQa1/KWgOePDuPZf3db+ro7XejUfoUnwiMBG4VHJLYUrpKpuA7WI
 0a5g==
X-Gm-Message-State: AOAM530X0LdkFjm/gbRcoDy37Am5EHjrEnh09gPPYQAFthR163X2zjPS
 YOIrohiTrXSgUTyL98k8vt3GZKPBni3xQtKQU60JY2f4Y8BwPQospmy2mKNKo2fLPlU9YtiLEUr
 0w6Ms6NV21Vpog58=
X-Received: by 2002:adf:f512:: with SMTP id q18mr25332599wro.38.1590564475071; 
 Wed, 27 May 2020 00:27:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv00IBPjCoazyPRwkEKCJmHmxHEMZNtLkSzuQlakVZMDfuy4O0kWegqGxIfTNEJwjObNwZRg==
X-Received: by 2002:adf:f512:: with SMTP id q18mr25332581wro.38.1590564474749; 
 Wed, 27 May 2020 00:27:54 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id o10sm1950572wrq.40.2020.05.27.00.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 00:27:54 -0700 (PDT)
Subject: Re: [PATCH] or1k: Fix compilation hiccup
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200526185132.1652355-1-eblake@redhat.com>
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
Message-ID: <e6f9b1b0-2c57-4089-4907-053a553e4180@redhat.com>
Date: Wed, 27 May 2020 09:27:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200526185132.1652355-1-eblake@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 22:58:18
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jia Liu <proljc@gmail.com>,
 qemu-trivial@nongnu.org, Bug 1874073 <1874073@bugs.launchpad.net>,
 Stafford Horne <shorne@gmail.com>, Martin Liska <mliska@suse.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 8:51 PM, Eric Blake wrote:
> On my Fedora 32 machine, gcc 10.1.1 at -O2 (the default for a bare
> './configure') has a false-positive complaint:
> 
>   CC      or1k-softmmu/hw/openrisc/openrisc_sim.o
> /home/eblake/qemu/hw/openrisc/openrisc_sim.c: In function ‘openrisc_sim_init’:
> /home/eblake/qemu/hw/openrisc/openrisc_sim.c:87:42: error: ‘cpu_irqs[0]’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    87 |         sysbus_connect_irq(s, i, cpu_irqs[i][irq_pin]);
>       |                                  ~~~~~~~~^~~
> 
> Initializing both pointers of cpu_irqs[] to NULL is sufficient to shut
> up the compiler, even though they are definitely assigned in
> openrisc_sim_init() prior to the inlined call to
> openrisc_sim_ompic_init() containing the line in question.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  hw/openrisc/openrisc_sim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index d08ce6181199..95011a8015b4 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -129,7 +129,7 @@ static void openrisc_sim_init(MachineState *machine)
>      const char *kernel_filename = machine->kernel_filename;
>      OpenRISCCPU *cpu = NULL;
>      MemoryRegion *ram;
> -    qemu_irq *cpu_irqs[2];
> +    qemu_irq *cpu_irqs[2] = {};

Ah I now remembered why this warning sound familiar:
https://bugs.launchpad.net/qemu/+bug/1874073

Peter suggested a different fix, I tested it, and was expecting Martin
Liska to post an updated patch.

>      qemu_irq serial_irq;
>      int n;
>      unsigned int smp_cpus = machine->smp.cpus;
> 


