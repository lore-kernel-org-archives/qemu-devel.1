Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC24C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE20F206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTskfckU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE20F206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJfa-0004Dm-7d
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiJes-0003lI-Gh
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:25:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37018
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiJep-0000NV-0Z
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591629949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wPfZncxHOTuK+nKf3J5dIhfYeZIqqA9qb/QuF11/mLo=;
 b=iTskfckU2EcQpZmeauUtT2VACmlEWPdeUImnkCPTkCssWNu9VXFkqhtMx4ZXkS2d8tTnHz
 V9aUsNfhTD9+mYlIarcUaXTgpAVDmxphKzh0rfmAhbfPXKRUY2fXhSL0EZGfXDJ7ih2FOc
 lCwMH7AM24HB5fyHRzD/Vd9cKqLL6Ds=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-6gEf0FuDOhqai_ZKzroH2w-1; Mon, 08 Jun 2020 11:25:38 -0400
X-MC-Unique: 6gEf0FuDOhqai_ZKzroH2w-1
Received: by mail-wr1-f72.google.com with SMTP id o1so7256023wrm.17
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 08:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=wPfZncxHOTuK+nKf3J5dIhfYeZIqqA9qb/QuF11/mLo=;
 b=LFxIc3ijlAXV0wWwqxR5VMCD56Wx2ZFePArPQOccrqCIERgLW/fBl198zBBZm0xl/O
 g8+1YixN03vaBGNk8dPEQJtDBMxQzXPHmVscHUvlIUPiVORH5z2rziL/rzPZ/0hZBj7p
 Z+aEwUblOCSIkCdQtQtFaR38x4yLt//jE3AS/wYxJIRF48iSo0muy1BUN9AN5ZaZLuQe
 u3GfwN1WFYf0CsX6Fvv5TdZWMTdYhJkav757LhVqZeECCQ0qoNk51RfVZNRCNw//44yg
 L85tyYQsIRYtrNKfadHDHhbV+9P5wYroFdqA9L8OU7FI6CFF0/Tfz/dBRvZdzDvxHCDt
 tO6A==
X-Gm-Message-State: AOAM53267fdxxUMN8+GMDvF9lpCO/ZS8wk9wiG0npUU88P3L4+aD98zw
 Ma9uz0EfyDxU4Xgd1+sYlA0cBgfgRY+a35aj15+MxgT5jknRt3EG6fMEMHsGVod5JbgP8+DpD20
 BkdEgS2kL1GbmDxs=
X-Received: by 2002:a1c:24c6:: with SMTP id k189mr17896639wmk.9.1591629937483; 
 Mon, 08 Jun 2020 08:25:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+qQtWBoL60IMkHStOceZAwOwXLITJB6e3n4Y64wf862oPCj0lnm5O0sf5XeAN4wl1kTumag==
X-Received: by 2002:a1c:24c6:: with SMTP id k189mr17896623wmk.9.1591629937264; 
 Mon, 08 Jun 2020 08:25:37 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id l17sm21594711wmi.3.2020.06.08.08.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 08:25:36 -0700 (PDT)
Subject: Re: [PATCH v6 03/11] MAINTAINERS: Add an entry for the HAX accelerator
To: "Wang, Wenchao" <wenchao.wang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20200605093256.30351-1-philmd@redhat.com>
 <20200605093256.30351-4-philmd@redhat.com>
 <CY4PR11MB1317B912A7D53409235EE3C187850@CY4PR11MB1317.namprd11.prod.outlook.com>
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
Message-ID: <05edfe63-79b6-a395-4a4f-3990d66d0ad0@redhat.com>
Date: Mon, 8 Jun 2020 17:25:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CY4PR11MB1317B912A7D53409235EE3C187850@CY4PR11MB1317.namprd11.prod.outlook.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vincent Palatin <vpalatin@chromium.org>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 haxm-team <haxm-team@intel.com>, "Xu, Colin" <colin.xu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Tao Wu <lepton@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/8/20 11:27 AM, Wang, Wenchao wrote:
> Hi, Philippe,
> 
> Sorry for missing your mail.
> 
> We are still maintaining HAX accelerator in QEMU. The status had been added as below in MAINTAINERS line 458. I noticed that the only difference with your commit is the last third line. The file accel/stubs/hax-stub.c is missed in the current files, while others are listed. Do you want to add this one only? And I will avoid missing emails in future and reply as soon as possible. Thanks.
> 
> 
> Guest CPU Cores (HAXM)
> ---------------------
> X86 HAXM CPUs
> M: Wenchao Wang <wenchao.wang@intel.com>
> M: Colin Xu <colin.xu@intel.com>
> L: haxm-team@intel.com
> W: https://github.com/intel/haxm/issues
> S: Maintained
> +F: accel/stubs/hax-stub.c
> F: include/sysemu/hax.h
> F: target/i386/hax-*

I missed it, sorry.

> 
> 
> Best Regards,
> Wenchao
> 
> -----Original Message-----
> From: Philippe Mathieu-Daudé <philmd@redhat.com> 
> Sent: Friday, June 5, 2020 17:33
> To: qemu-devel@nongnu.org
> Cc: Richard Henderson <rth@twiddle.net>; Paolo Bonzini <pbonzini@redhat.com>; Philippe Mathieu-Daudé <philmd@redhat.com>; haxm-team <haxm-team@intel.com>; Tao Wu <lepton@google.com>; Xu, Colin <colin.xu@intel.com>; Wang, Wenchao <wenchao.wang@intel.com>; Vincent Palatin <vpalatin@chromium.org>; Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
> Subject: [PATCH v6 03/11] MAINTAINERS: Add an entry for the HAX accelerator
> 
> Nobody replied since the first time [*] that patch was posted, so mark HAX as orphan.
> 
> [*] https://mid.mail-archive.com/20200316120049.11225-4-philmd@redhat.com
> 
> Cc: haxm-team@intel.com
> Cc: Tao Wu <lepton@google.com>
> Cc: Colin Xu <colin.xu@intel.com>
> Cc: Wenchao Wang <wenchao.wang@intel.com>
> Cc: Vincent Palatin <vpalatin@chromium.org>
> Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f725c12161..05d7210204 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -426,6 +426,12 @@ F: accel/accel.c
>  F: accel/Makefile.objs
>  F: accel/stubs/Makefile.objs
>  
> +HAX Accelerator
> +S: Orphan
> +F: accel/stubs/hax-stub.c
> +F: target/i386/hax-all.c
> +F: include/sysemu/hax.h
> +
>  X86 HVF CPUs
>  M: Roman Bolshakov <r.bolshakov@yadro.com>
>  S: Maintained
> --
> 2.21.3
> 


