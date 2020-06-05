Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AECC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFAE20663
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJQNf8p5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFAE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh7pb-0005bT-F0
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 04:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh7o3-0003Sf-Ek
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:34:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26643
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh7o1-0000Ju-FD
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591346064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q60riLID+wY/l1Z/OGnNB5ceO4KU0O1zMDfx+lOfH58=;
 b=jJQNf8p5IT0l3fRGX1GW28/GtV1rhPpWa1cCvPL1YMyyqRJBFNX1j00zenZTJSCyBYwgus
 7eT79LvoxdKnfQfGSnlTTEiw7qzxQcO/sRxI/anmngIve2+AElxBkemESADGAbtpdzPTul
 e5DJgSM86Hzpwho9kIbjjUMefNzDZfI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-wLuCcs83MC6gjUogUC16ew-1; Fri, 05 Jun 2020 04:34:20 -0400
X-MC-Unique: wLuCcs83MC6gjUogUC16ew-1
Received: by mail-wm1-f70.google.com with SMTP id x6so2745683wmj.9
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 01:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Q60riLID+wY/l1Z/OGnNB5ceO4KU0O1zMDfx+lOfH58=;
 b=iuCmfW7C6KZ6xekRdGCDLxw02l2sZT1FmRoLoPTk9sP7bzcRdAFae0RU5q+5dfebaO
 Tr7BS39EhrUmd+oEcm0ryPRMk0nEMJQgvlYgO/dAhItulZWmwzgi2+Pzo/LsKjn1ymSm
 6w2n1CdpfuV84X+yo+dG2DoFjQc3s+bUWhMIaNpR++5/cDXYckvl8MRJdpZPcjxdYmWl
 fiscRpBF+KglmicQled7Hkmsir+l5dOh6Y/cGb7XEm+oN6HV3P17SWB3g91GYB2pYyH1
 1eaoallMdFjAbrNLWAvyZG3+j3OgBqyXnp/PyXMbA27uksC78AA8rducoSMibhX8LjT9
 AxRA==
X-Gm-Message-State: AOAM532sVSgFzqd+T8BgyBx1oA4cANDXiYGi1J1TkLTTaqMBi3Qzc2iQ
 X+gh1bysJoePwFiXaEFbF+TNxHoj7plnmaXyyd6lu9Ou5jsc9UzhLF98OkNK0PRc1FMsAnEh/kY
 qGCmSjXjfD0OZ0gs=
X-Received: by 2002:adf:bb02:: with SMTP id r2mr8832501wrg.143.1591346059305; 
 Fri, 05 Jun 2020 01:34:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwji2ms4LMHP775QjSVWT6ASARpyRziH0ya9FhTibkTx6mlvc/8sVbhfgUTca/kfOXsYKgZLg==
X-Received: by 2002:adf:bb02:: with SMTP id r2mr8832486wrg.143.1591346059051; 
 Fri, 05 Jun 2020 01:34:19 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm295811wmc.0.2020.06.05.01.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 01:34:18 -0700 (PDT)
Subject: Re: [PATCH v2] hw/sd/sdcard: Verify CMD24 (Block Write) address is
 valid
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200604182502.24228-1-f4bug@amsat.org>
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
Message-ID: <057b7d37-204f-32e1-3548-5e51def423a2@redhat.com>
Date: Fri, 5 Jun 2020 10:34:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200604182502.24228-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 1880822@bugs.launchpad.net, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 8:25 PM, Philippe Mathieu-Daudé wrote:
> Avoid OOB access by verifying the requested address belong to
> the actual card size. Return ADDRESS_ERROR when not in range.
> Only move the state machine to ReceivingData if there is no
> pending error.
> 
>   "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"
> 
>   4.3.4 Data Write
> 
>   * Block Write
> 
>   Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>   occurred and no data transfer is performed.
> 
> Fixes: CVE-2020-13253
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880822

While the reproducer triggers the OOB via CMD24, other commands have the
same problem, so I'll post a v3.

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Cc: Prasad J Pandit <pjp@fedoraproject.org>
> 
> v2: check for blksz in range, only go to sd_receivingdata_state
>     if no error.
> ---
>  hw/sd/sd.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 3c06a0ac6d..2254dc7acc 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1211,17 +1211,18 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>              /* Writing in SPI mode not implemented.  */
>              if (sd->spi)
>                  break;
> -            sd->state = sd_receivingdata_state;
> -            sd->data_start = addr;
> -            sd->data_offset = 0;
> -            sd->blk_written = 0;
> -
> -            if (sd->data_start + sd->blk_len > sd->size)
> +            if (addr + sd->blk_len >= sd->size) {
>                  sd->card_status |= ADDRESS_ERROR;
> -            if (sd_wp_addr(sd, sd->data_start))
> +            } else if (sd_wp_addr(sd, sd->data_start)) {
>                  sd->card_status |= WP_VIOLATION;
> -            if (sd->csd[14] & 0x30)
> +            } else if (sd->csd[14] & 0x30) {
>                  sd->card_status |= WP_VIOLATION;
> +            } else {
> +                sd->state = sd_receivingdata_state;
> +                sd->data_start = addr;
> +                sd->data_offset = 0;
> +                sd->blk_written = 0;
> +            }
>              return sd_r1;
>  
>          default:
> 


