Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A636EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F1A207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVj8jfDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F1A207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOwX-0005jA-Lz
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbOrk-0006Rz-DM
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:34:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41875
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbOrj-0003Im-0j
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589981674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgWD20Dwrfzi0M+n4zA1V+F+krFEkXE7HFGsucmCRek=;
 b=SVj8jfDPD8mKpeCOSj6oyjIWN/hFEfOc+mbNDhHFKtdvqy4zF4XC5cYY7uujjBlskkHltX
 2iQCLINY6x8GHyme2OIckFCi9PLE7eaMAp/NDVxH+wZ7Oc6s6Z77wImW2YnBEX2uJd0EBx
 fda4L8ckrgFcj873fyk04E+z+2N24+k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-te6L4mk6Pr6X5SVoRSGBNg-1; Wed, 20 May 2020 09:34:32 -0400
X-MC-Unique: te6L4mk6Pr6X5SVoRSGBNg-1
Received: by mail-wr1-f72.google.com with SMTP id z5so1403138wrt.17
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 06:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lgWD20Dwrfzi0M+n4zA1V+F+krFEkXE7HFGsucmCRek=;
 b=RqRtU7QJhOpc99fTAf2t+AT9TZqG/9yzq2LVHg+3NzXT0Mr0VxfawmWpYJw/VU52YO
 m5kO5WQCTbL48Qn71yqwYnXN7bBzB9jFlSPPVAmSpuMlkpJzDI4JaUQkof0r5X9wacDp
 dM3LuLiBEFv55v+Kp8PeZpoFSzeOASkD4PyYT3uu5u7pX+ramYFZ2jZaHM8LxeZaTOdV
 avWFI2aJNdvZySHMbekyCQVo4zTEKLAgNMhZb/vuLLoaAg4XlmzEcZda4YJYKbReiHyY
 AGiQNMCNkptYrZZKAq571snM4MGrP9qXKPFbmEBpBZCJSLuPowRVDsafBFz+N4TieOa3
 jx6g==
X-Gm-Message-State: AOAM532Rn7+w4ioXetcgL25EX7Ervdc3mARGx7A+ePmYx5qYjIqEBTYj
 YMCbl66iq7wpps3F5DJiBeVRi1DBqVz5E3xbq/XAc/nVBgGbEuS5jRYeaTlP0wx+wdvh0dacpfY
 vZMIZsfIKIzRsda4=
X-Received: by 2002:a1c:5502:: with SMTP id j2mr5007040wmb.56.1589981671182;
 Wed, 20 May 2020 06:34:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHx4zwfAcPIS2gov5ofeTf698nybT3Q+DzdRYtGiD9+aBlA2Vy963G84IjJmfijiHQ8/eekA==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr5007022wmb.56.1589981670946;
 Wed, 20 May 2020 06:34:30 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q5sm3043277wra.36.2020.05.20.06.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 06:34:30 -0700 (PDT)
Subject: Re: [PATCH v3 14/22] microvm: use 2G split unconditionally
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-15-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <83ebdc64-f049-9c0d-7d7b-243233705cda@redhat.com>
Date: Wed, 20 May 2020 15:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200520132003.9492-15-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 3:19 PM, Gerd Hoffmann wrote:
> Looks like the logiv was copied over from q35.

Typo 'logiv' -> 'logic'.

> 
> q35 does this for backward compatibility, there is no reason to do this
> on microvm though.  So split @ 2G unconditionally.

Yes please!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/i386/microvm.c | 16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 867d3d652145..b8f0d3283758 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -170,23 +170,9 @@ static void microvm_memory_init(MicrovmMachineState *mms)
>       MemoryRegion *ram_below_4g, *ram_above_4g;
>       MemoryRegion *system_memory = get_system_memory();
>       FWCfgState *fw_cfg;
> -    ram_addr_t lowmem;
> +    ram_addr_t lowmem = 0x80000000; /* 2G */
>       int i;
>   
> -    /*
> -     * Check whether RAM fits below 4G (leaving 1/2 GByte for IO memory
> -     * and 256 Mbytes for PCI Express Enhanced Configuration Access Mapping
> -     * also known as MMCFG).
> -     * If it doesn't, we need to split it in chunks below and above 4G.
> -     * In any case, try to make sure that guest addresses aligned at
> -     * 1G boundaries get mapped to host addresses aligned at 1G boundaries.
> -     */
> -    if (machine->ram_size >= 0xb0000000) {
> -        lowmem = 0x80000000;
> -    } else {
> -        lowmem = 0xb0000000;
> -    }
> -
>       /*
>        * Handle the machine opt max-ram-below-4g.  It is basically doing
>        * min(qemu limit, user limit).
> 


