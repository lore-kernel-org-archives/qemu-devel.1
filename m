Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD54C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCBE2078E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZapKKCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCBE2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFiCX-0002g5-Sl
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFiBu-0002GZ-5D
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFiBr-0006vx-MB
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599589076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P177te2wPfEIWbihp7Czpt5ngguFjLIm44UV8gIr4BU=;
 b=MZapKKCO0sVC54VSPYpynAy+j0OByj73MWyAJYdmIO+vXiOIwqYKHH6qgt41dK4z0DHqdO
 KF5XGh2h13EtRn5v229hbhamuWVQIkBEXZl6XlAm5/2cZCVFtiGlOpzvfw/vN/S+LDbjPG
 9RwqcwA+hrwfRqYAZ1YrceZnMZ8nYX4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-B1JKm7iNOxSaRnyK_Swp7g-1; Tue, 08 Sep 2020 14:17:54 -0400
X-MC-Unique: B1JKm7iNOxSaRnyK_Swp7g-1
Received: by mail-wr1-f70.google.com with SMTP id b7so7256841wrn.6
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 11:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=P177te2wPfEIWbihp7Czpt5ngguFjLIm44UV8gIr4BU=;
 b=HH6NfhEpgW9CPpRLBWEU+vP4o9HPPqzlBSSyQA42x6Tuh9t2Kzwcsx5XA9DOydB6cI
 v9OIr79hFRpKT7iouroUjR5U8EJgoCTq/8QjrppVpMlbvu3WB0htBR0ibLexDmSAKsqc
 hClTP4esWmauKRJCEPFOYxGgRKzqgyLnSZfNa7E7MBsxdkFayxIy+7WiNtNW48ee6xjD
 QLtRXTu3Z2JD9bdTScQnV5hHiQtcxHWsWGyNk+YFMDAwcywYb/5v8cAIGXqr8xKX6I3o
 ySkJ7cfnmk5EDMeaiQPTKHwizJohGOpnQ3Yx7GBHfToa+Swr1XKn0m6hkTpngdDGftma
 onGg==
X-Gm-Message-State: AOAM533002xo/I/1jKGtA83m3xybm8Ul+R1u+S7KwJ+43m6gQUn+md4n
 d3kn3+k1owPSmmdEf9DSmn7xGKrvQ3hhEWJ4+o0nSdJZC1iseA6OFjSTgmSK0s7T3x9lQlqEEh5
 FD64TiYPLo3A+5l8=
X-Received: by 2002:a1c:2e17:: with SMTP id u23mr370332wmu.73.1599589073098;
 Tue, 08 Sep 2020 11:17:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAY/REexjxgFd70UsFCe6RLaoc3O6BalUJsiRwU3qSgxKl8uJues7eulhw+wxnvl4WnJXP1A==
X-Received: by 2002:a1c:2e17:: with SMTP id u23mr370319wmu.73.1599589072933;
 Tue, 08 Sep 2020 11:17:52 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k24sm279054wmj.19.2020.09.08.11.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 11:17:51 -0700 (PDT)
Subject: Re: [PATCH] memory: Remove kernel-doc comment marker
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200908173650.3293057-1-ehabkost@redhat.com>
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
Message-ID: <3cecb899-a6d0-ab48-484c-34c0bfb9a942@redhat.com>
Date: Tue, 8 Sep 2020 20:17:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908173650.3293057-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 7:36 PM, Eduardo Habkost wrote:
> The IOMMUMemoryRegionClass struct documentation was never in the
> kernel-doc format.  Stop pretending it is, by removing the "/**"
> comment marker.
> 
> This fixes a documentation build error introduced when we split
> the IOMMUMemoryRegionClass typedef from the struct declaration.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> I will submit a separate patch to convert the documentation to
> kernel-doc format later.  This is just a build fix that restores
> the previous behavior (IOMMUMemoryRegionClass was never included
> in the generated documentation).
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  include/exec/memory.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index dc908738c6..f1bb2a7df5 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -211,7 +211,7 @@ enum IOMMUMemoryRegionAttr {
>      IOMMU_ATTR_SPAPR_TCE_FD
>  };
>  
> -/**
> +/*
>   * IOMMUMemoryRegionClass:
>   *
>   * All IOMMU implementations need to subclass TYPE_IOMMU_MEMORY_REGION
> 


