Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A92C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B922078A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+VPsumN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B922078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFmi-0000GS-W1
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFlF-0007fl-Pb
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFlC-0004bI-Oh
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602578057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7waybJVBI9uSsjKZ2aTqAy3MPMStO7qPJG9cYHM54M=;
 b=i+VPsumNYv1To3HYmLFKfdw6la6vkXdj3RMYTwuewuyrPCDB6Hgd7BbJC16GvZD38YZT3v
 +qW1wE08HHkJr9rjNvfz2PUyFFNqhrmVpuHzp+WeF1mwocDup3clYye3tuyIeq43mE5/mo
 NnL/WxQY5TOrRzvpF37Wsqq7yDC7DFM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-HTQcEQ0MN12Vs5G3bRjFlQ-1; Tue, 13 Oct 2020 04:34:15 -0400
X-MC-Unique: HTQcEQ0MN12Vs5G3bRjFlQ-1
Received: by mail-wr1-f69.google.com with SMTP id 33so10459581wrf.22
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 01:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C7waybJVBI9uSsjKZ2aTqAy3MPMStO7qPJG9cYHM54M=;
 b=IkL0J8QZv7/k2k+7bxkAozBJLX73yBB/cVpyQrupUWG414oWxr4QwTdszjIYtaM34I
 JD0BLblgbG0hhveX6Z0VeqjHpTOBduW7LifmeONgY2OUofFh1uwFp+6jtkCNrejaXAUz
 N/plP+arXLUGsBu2UReBjCCpAz+Gc+E5ZCOWshGkUUTadNXh1E+PqMGpRO6Jnow0z5Z/
 qouJLjEDZ1ZY2kPJT6E3hvFxvEuKydZ80Ul9ImTyDmEXwq6Jv0cxQxw4gMWETf3KHpbA
 8JNn6pa8PnQGxRuNTGndWlM86LuWfs8aSMZZmErGR1v21XyYDos0pF/xIFd+tnndPrny
 HfMQ==
X-Gm-Message-State: AOAM530pg6RqYfTR86fBHCCXe/tCAyEwBeFKntuz8LSYTD58bcUtB3aV
 +kFXWcqUVMCBeTdaLl9oTxS0svDD2VYqQohq6tpyVXEHPJWN8/zdFF0LSK/ndhOHCYyMNH3o//Y
 sZGZJwjzFkrxkV7o=
X-Received: by 2002:a1c:3b8a:: with SMTP id
 i132mr15259060wma.189.1602578051401; 
 Tue, 13 Oct 2020 01:34:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxqWxzU32F98Fi3/XTnB3kUK/ah6aMhWDCZ7WXayd06UtrcqtzvhMeNIcY/MYzIZLGJP+J8w==
X-Received: by 2002:a1c:3b8a:: with SMTP id
 i132mr15259037wma.189.1602578051199; 
 Tue, 13 Oct 2020 01:34:11 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 64sm7273207wmd.3.2020.10.13.01.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:34:10 -0700 (PDT)
Subject: Re: [PATCH] hw/core/qdev-properties: Fix pci bus range in
 set_pci_host_devaddr()
To: Klaus Herman <kherman@inbox.lv>, qemu-devel@nongnu.org
References: <20201012225831.72920-1-kherman@inbox.lv>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6b392d9f-37b8-0cfc-7227-5cebcb1524b3@redhat.com>
Date: Tue, 13 Oct 2020 10:34:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012225831.72920-1-kherman@inbox.lv>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus,

On 10/13/20 12:58 AM, Klaus Herman wrote:

Please include:

Fixes: bccb20c49df ("hw/core/qdev-properties: Use qemu_strtoul() in 
set_pci_host_devaddr()")

You forgot to sign your patch, see:
https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line

> ---
>   hw/core/qdev-properties-system.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 49bdd12..e3dca56 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -903,7 +903,7 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
>       bus = val;
>   
>       p = (char *)e + 1;
> -    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
> +    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xff || e == p) {
>           goto inval;
>       }
>       if (*e == ':') {
> 


