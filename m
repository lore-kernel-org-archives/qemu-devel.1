Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AF2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88796206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFt7F7aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88796206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqf2M-0001lo-Pw
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqf15-00009A-92
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:51:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34463
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqf10-0001dS-UZ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593618674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zMxq1l3kcMV55zaM//IO3brpxivJkZaCA50hYHi9BGE=;
 b=iFt7F7aU3vdPS6dkTjRcyC3Lxzp2vviG9xwJcFkOmGQa8UUo8HMqTBRvl0HatrWwe0vXHd
 sDsfSHAuTDcyNeWDqR3/xZ/lEx13OxP5V0CsQGuYk7kSIwL1244kytnDVK5PG6CA6a6WnA
 G5hviFJO3eGufjnS0rWYbpOPf2mvGOA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-VSv3K835P_epqrhDws3nMQ-1; Wed, 01 Jul 2020 11:51:12 -0400
X-MC-Unique: VSv3K835P_epqrhDws3nMQ-1
Received: by mail-ej1-f70.google.com with SMTP id q11so16168918eja.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=zMxq1l3kcMV55zaM//IO3brpxivJkZaCA50hYHi9BGE=;
 b=OAb2fe0GUXiQ86SkCX6Nvv9E11QQzhL0P+HjCBFxbFLTKrL74VqW2jMmJ6I3uNQPe0
 nu3QnFVRRf4EPShn3/1eknX1jcDptlhCU+pAaZ2WECUGwuWhhK4WoSxc47JDLlJoMGgj
 PuZFCZ1FUvKTcr/MuPuFiVsun0uIbfgIXSQ8/S5WrLnuav1slP1NeaJCU64D43pDiQ0I
 XZlTGe4ax1nHlp6J5a9awjWX8albs4HPTE5PLde+gXc7H2gYRkCGEyiHe9B3tz6G7nWV
 m1290XAK7XIW+brntiTBuCIfrDQlo800qL8wY69CLSX762vSIYx86g4P9JtWu2RFkKw2
 HWKg==
X-Gm-Message-State: AOAM5301oAtaSLBRXYLs8JXA4M8e1841InJ/df6aDVFEXr0/uGUC1LNm
 u5cR7BQSPjrlZmUlATmY4VQoZQ7D5U6yiRjL5Oc3BGNqwodnAe2zJwCIJB3BEfSbhjgGL7Cpv93
 uZbi7dS8zLxcYsYM=
X-Received: by 2002:a17:906:1151:: with SMTP id
 i17mr24744398eja.535.1593618671183; 
 Wed, 01 Jul 2020 08:51:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcTW/3UFeBI0rnNVYpFiGeewEmD9LWUONjHS2w2nGbd1Q2oDoNOwIl3THAvUiEELiBh1YG+g==
X-Received: by 2002:a17:906:1151:: with SMTP id
 i17mr24744384eja.535.1593618670968; 
 Wed, 01 Jul 2020 08:51:10 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o17sm5025992ejb.105.2020.07.01.08.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 08:51:10 -0700 (PDT)
Subject: Re: [PATCH v4 01/40] hw/isa: check for current_cpu before generating
 IRQ
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-2-alex.bennee@linaro.org>
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
Message-ID: <85314d31-813a-8c20-7522-5186d5f31884@redhat.com>
Date: Wed, 1 Jul 2020 17:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200701135652.1366-2-alex.bennee@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Bug 1878645 <1878645@bugs.launchpad.net>, richard.henderson@linaro.org,
 cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 3:56 PM, Alex Bennée wrote:
> It's possible to trigger this function from qtest/monitor at which
> point current_cpu won't point at the right place. Check it and
> fall back to first_cpu if it's NULL.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Bug 1878645 <1878645@bugs.launchpad.net>
> ---
>  hw/isa/lpc_ich9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index cd6e169d47a..791c878eb0b 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -439,7 +439,7 @@ static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
>                  cpu_interrupt(cs, CPU_INTERRUPT_SMI);
>              }
>          } else {
> -            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
> +            cpu_interrupt(current_cpu ? current_cpu : first_cpu, CPU_INTERRUPT_SMI);

I'm not sure this change anything, as first_cpu is NULL when using
qtest accelerator or none-machine, see 508b4ecc39 ("gdbstub.c: fix
GDB connection segfault caused by empty machines").

>          }
>      }
>  }
> 


