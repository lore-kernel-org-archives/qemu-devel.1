Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24F4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25BB2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUg3rymK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25BB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSh0f-000376-Gy
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 09:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSgzv-0002G4-2I
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSgzq-0006w9-QL
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602682752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Rt5m5/U+8F+4Tn/0qiT96ylMF3jPVuuKx/vD4wBTc4=;
 b=FUg3rymKIaGVZZdvn7+P0BizozEYEi/YUwghAARe64hQx+d8v2QDL3pSGM1U/f5+sTr+jy
 a034lLnov8lCrUDvIysQACI3DGf3TCLcUEwldeHzUW3Cq/DyRYZCSm/bI93lzn1zTHwNSe
 IsqWIwJolpFyaC+qntT2prPA6oCVUv0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-9fR3b5YCMvCvNXk87-yWZA-1; Wed, 14 Oct 2020 09:39:11 -0400
X-MC-Unique: 9fR3b5YCMvCvNXk87-yWZA-1
Received: by mail-wr1-f71.google.com with SMTP id i6so1284723wrx.11
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 06:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Rt5m5/U+8F+4Tn/0qiT96ylMF3jPVuuKx/vD4wBTc4=;
 b=H7Bjwd05f5HVaSWlceG4i8rg5z5ztJrRoDYKWsuMeeseLhsxUj/+U41eh07K2cruy4
 QkOpOIP4Y6A1vMoeyOXS0KTBw9lm2SuuPK3JAvqTyQ794BgFP8pdHdIaIQG6xgJsT5pK
 /tKNjHyBjCFoBtfggi1fihvRqK7q5WUdqN/+C/nbJzjVHJVLQhbP9CiX4y2ZNpIXolXJ
 EzxjrcWVcS70vAInuv58Wj1XDeA4GRa2A5IYP/FYnurXwdu/72aWeRv7BSWnWTjbCqwE
 sQ/A3ABG7nigdliRJiMkfAEiLg7EyzHVi1WIXppYYgcybeuVXFZyu9rTmyNWQA5rlx3m
 AGvg==
X-Gm-Message-State: AOAM531bV/pQddbOrDVGICkYP6de+lizMknJrdpBux27AT20Hf/WEg6V
 3k+ipTuO29OdSDpvtyvIcTOHKbqXfLG/wEkvUkwX3zOMlmHT1wEVHCXddZdtJtfE5tX3BGkx7Xu
 PX+4ChQF7hWTGHsE=
X-Received: by 2002:a5d:550d:: with SMTP id b13mr5520655wrv.125.1602682750052; 
 Wed, 14 Oct 2020 06:39:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5E1yOiBfJaqiK4GCHZspUsgZaeqS5TUt0bK1te3P4W90ZNmC78zoySpzSCrb5Y82FGr2SBA==
X-Received: by 2002:a5d:550d:: with SMTP id b13mr5520638wrv.125.1602682749875; 
 Wed, 14 Oct 2020 06:39:09 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c1sm5162928wru.49.2020.10.14.06.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 06:39:09 -0700 (PDT)
Subject: Re: [PATCH v5 6/7] meson: add spice dependency to core spice source
 files.
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20201014121120.13482-1-kraxel@redhat.com>
 <20201014121120.13482-7-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7377acf7-b6a8-a037-54c0-ec66cc1f0f1e@redhat.com>
Date: Wed, 14 Oct 2020 15:39:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014121120.13482-7-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 2:11 PM, Gerd Hoffmann wrote:
> Right now it happens to work by pure luck because the spice chardevs
> add the spice dependency to the softmmu source set.  That'll change
> though once we start building spice chardevs as module, so lets fix
> it properly.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   ui/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


