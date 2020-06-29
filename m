Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61974C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2598223139
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgtIEdzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2598223139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpphJ-0002M4-BL
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jppfN-0001BX-Qw
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:01:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55669
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jppfL-0002Up-8U
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593421285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mUE8aci4sTKmJp1XWkkNp+havphEVYf8+XamSJws19k=;
 b=OgtIEdzVVkcGgjQ7Z2OyGgrL8KhPtZ27+cjzH7YLoS/eOAunXImOd8WKxafyZBB2e2ZuL5
 LfniiVMlcCLufa7cxpY49FLUP4MnrCgg+bndpPcFQAChP74xgQ23vuDxJE4PdNMZIivVCR
 K/qU5ethsJpkcyy5dzT7sF/4XRdI7Lo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-TP5zb1drOiKO3pwVUJs28Q-1; Mon, 29 Jun 2020 05:01:23 -0400
X-MC-Unique: TP5zb1drOiKO3pwVUJs28Q-1
Received: by mail-wr1-f70.google.com with SMTP id j5so16301348wro.6
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 02:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mUE8aci4sTKmJp1XWkkNp+havphEVYf8+XamSJws19k=;
 b=Jj5doHjYd0V/iT7YVyThhrdUgeLHSSwfQLuLx96hiBWmGgeP6u0bDmMqkhoz2ixnw2
 BoKWz1QV4boGhRGH+zzwyi+tvCKiIQuiuxCY+ovzpnZK9QlHkFZYt0ZP1I4JKJF0Gyl3
 go0Z6HpwUzP+iSVuAZl9v7+wdog0UPB0fNeBl8SLFYHTFaqoHWIq4thO8lihfu1sqzft
 xitPcDHEFXRQi8qWM0Q736YtNSHOtmIVqeEjlZAsNAIPv7z7rrKpOPfL2yDawQhUH6Yl
 BHWBlFfNwKps3JTTmLNHI7M+OB5Qhn/9Tyb7Oyk67BsamUP3JR2Yjbx6WAyhf0XAR7sT
 wXig==
X-Gm-Message-State: AOAM532F9lmERm4mY8OnP7jWa9Dk5hQavDOpg02Dzg2v1P+M8eG8PbYT
 T6M9Ebay0obHKSPhSFYEUNDZl+8shTGWf+yeWeIzOgp1OAmdHND0j0+mdkakot+5ruAjuRKETkx
 8uN/OJ7JHj70oz2o=
X-Received: by 2002:adf:ab4a:: with SMTP id r10mr17307374wrc.103.1593421282824; 
 Mon, 29 Jun 2020 02:01:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDm8d5RwEJxBaak/qyhhpXypKZhNnPsitdBzgrXVcTH43vlZvzk5ziOaBBrPfycfg197I/pA==
X-Received: by 2002:adf:ab4a:: with SMTP id r10mr17307341wrc.103.1593421282622; 
 Mon, 29 Jun 2020 02:01:22 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h29sm50731973wrc.78.2020.06.29.02.01.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 02:01:21 -0700 (PDT)
Subject: Re: [PATCH 06/17] hw/misc/max111x: provide QOM properties for setting
 initial values
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-7-peter.maydell@linaro.org>
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
Message-ID: <ff3227d3-2648-3a4b-824a-74f8c41bdd78@redhat.com>
Date: Mon, 29 Jun 2020 11:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628142429.17111-7-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
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
Cc: Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/20 4:24 PM, Peter Maydell wrote:
> Add some QOM properties to the max111x ADC device to allow the
> initial values to be configured. Currently this is done by
> board code calling max111x_set_input() after it creates the
> device, which doesn't work on system reset.
> 
> This requires us to implement a reset method for this device,
> so while we're doing that make sure we reset the other parts
> of the device state.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/max111x.c | 57 ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
> index 2b87bdee5b7..d0e5534e4f5 100644
> --- a/hw/misc/max111x.c
> +++ b/hw/misc/max111x.c
> @@ -15,11 +15,15 @@
>  #include "hw/ssi/ssi.h"
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
> +#include "hw/qdev-properties.h"
>  
>  typedef struct {
>      SSISlave parent_obj;
>  
>      qemu_irq interrupt;
> +    /* Values of inputs at system reset (settable by QOM property) */
> +    uint8_t reset_input[8];
> +
>      uint8_t tb1, rb2, rb3;
>      int cycle;
>  

An eventual improvement is to make 'inputs' a class property:

  MAX111xClass {
      SSISlaveClass parent_obj;

      unsigned input_count;
  }

"eventual" because from a QOM point it is cleaner, but we'd have
to add more boiler-plate casts, so code less clear.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


