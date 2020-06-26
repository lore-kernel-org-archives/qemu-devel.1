Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FFBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D039207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0F81QZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D039207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jop1G-0002oq-H5
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joozL-0008AU-3l
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:05:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28140
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joozI-0005YL-HN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593180351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hH7PfO6pRUl8tjEBFB8BsE6lvyY8nG/Oeh5ah5l91q4=;
 b=O0F81QZQX8lFcMas/F2AvEcqBMejpcgv5z/lqs48NtXXuKaFWmImWFxpWduOz9k2t0A1f3
 fHZtp4n2jMdoroKQ1jrViCll3LkC0QX9+amiIjytWX75V/sVnTN8EajKicR4XOKwS7yimC
 Dz7aQwHXkM+V2H+CEoNImITG48liqg4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-x6jLlHVEPg2SMcjHW4MLIA-1; Fri, 26 Jun 2020 10:05:49 -0400
X-MC-Unique: x6jLlHVEPg2SMcjHW4MLIA-1
Received: by mail-wr1-f70.google.com with SMTP id b14so10995415wrp.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 07:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hH7PfO6pRUl8tjEBFB8BsE6lvyY8nG/Oeh5ah5l91q4=;
 b=KglFZdCWkNyr7OsR8CRtDNYBh3CCWkNYvNNMcehFZiLY751YalSSEG8dtBGH6wdOGX
 6zeamGDXan+gtJH7tRDvZztVgbztWGu4hApt92ob0vkHNWK9JlI6Nw9VrPbh338/860q
 QDT0EI8FSQiCp5NoMVTxgBfNl4SSU6H6x3m0Pgf30QKcR8hmhKHMLFWnDiptOeB79BsZ
 TkeQWrMnNjBd+6wLw2IZ9O1ehvuDbKFBRYudOG/J32aDpjwWM91b7FqnVrhlq+DFbB2s
 9L0+gxjCx0H0zfMBEbK+ZU7Kr1EqmYjrW7CGdpM1NsMh9nxJHZomHr7QVErDOx9Wcwvc
 KMaQ==
X-Gm-Message-State: AOAM530IzGfqmOK+4BfzUYCUftCwuZ7drG1DBgMp+Ogd0mJpVH8V5SLA
 CGiTQSaIyOrheaSialQFi0gKvKFt72+2ue6iG30SIOXl9LMu1PAPpBwRVc/s9N7l8lB6AEk8MRG
 5JS9oy/Yp+1liO7g=
X-Received: by 2002:adf:f54b:: with SMTP id j11mr4045662wrp.206.1593180348110; 
 Fri, 26 Jun 2020 07:05:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrQE3WMVpBgFNQxuY8Oe5dQm6jK4IYCkFkcD4WMihRQr3RfKc1Drjyw1c+NWnj+IF9YkbZ9A==
X-Received: by 2002:adf:f54b:: with SMTP id j11mr4045636wrp.206.1593180347931; 
 Fri, 26 Jun 2020 07:05:47 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u10sm17287795wml.29.2020.06.26.07.05.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 07:05:47 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add an entry for OpenSBI firmware
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, qemu-devel@nongnu.org
References: <1593177220-28143-1-git-send-email-bmeng.cn@gmail.com>
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
Message-ID: <385afacc-f544-f595-ce8b-eed56fb7d017@redhat.com>
Date: Fri, 26 Jun 2020 16:05:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1593177220-28143-1-git-send-email-bmeng.cn@gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 3:13 PM, Bin Meng wrote:
> List me as the maintainer for OpenSBI firmware related files.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b40446..b0e2dd2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2609,6 +2609,13 @@ F: tests/uefi-test-tools/
>  F: .gitlab-ci.d/edk2.yml
>  F: .gitlab-ci.d/edk2/
>  
> +OpenSBI Firmware
> +M: Bin Meng <bmeng.cn@gmail.com>
> +S: Supported
> +F: pc-bios/opensbi-*
> +F: .gitlab-ci.d/opensbi.yml
> +F: .gitlab-ci.d/opensbi/

Or simply:

   F: .gitlab-ci.d/opensbi*

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>  Usermode Emulation
>  ------------------
>  Overall usermode emulation
> 


