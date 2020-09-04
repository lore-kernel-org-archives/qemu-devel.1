Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAECC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307ED20658
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hALrWg9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307ED20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAml-0005fB-Bu
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEAly-00058a-BS
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEAlv-0002g4-Dl
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599222288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0P+1BBhRg8wznt3NT6U0B23heHcJauvTqNmCPJlp1Gc=;
 b=hALrWg9vmKA6kz6rhtwqOEn/seueQ3JNJQmeFZ6iZIYSMiNhoCOQR2HCoy+ApKRlVB1R8+
 PopIY1Oj29/p5B6nP5OE2Q+SMztzgT6U1JZ39fl1SUTm1TJ4CbzSTY20fkcQlUeuIx4mW3
 XuOhVJjlXcwHZZfRx4uG9U9/klzHd8o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-NU_V0iTfNai2ESiErpgXLA-1; Fri, 04 Sep 2020 08:24:47 -0400
X-MC-Unique: NU_V0iTfNai2ESiErpgXLA-1
Received: by mail-ed1-f71.google.com with SMTP id r9so2258492edi.9
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 05:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0P+1BBhRg8wznt3NT6U0B23heHcJauvTqNmCPJlp1Gc=;
 b=s6yW6Ur4fTzTjHZZjDSv9Gc5ED2b0upnUTEHaFuULXKJpDuF4CT8wU41QlYQ0GEhn0
 78kEXHRInQy1gbGBMuqyXmdS0cfX46TelaRFK3NJMLdI+At0Y4LOCAFEMaMtL9GwPuhv
 3oMtoNICLKTwEkc/d4mpO+sPS7KcnyO+iRsRPn/VxKXWfbqFNqDjC0yp/DBcrDO0BlCN
 sxMvMzurXxCmMz9TmdhGtlrZS7AitMkkSfgDls8+1+xRTtSYhe3ZdxTNoG42XJX8660e
 aBF20cn7aRAveoKS5o7yiIyyRRUwEFbsv3BThy+6OptI8zdI5h32bE3ooj7l/veiBojC
 z7NQ==
X-Gm-Message-State: AOAM533ijRdIjRpphfG6jVeKHYfepfu2uR/KLfj1uIUJSIzeu1sRC3P1
 e5/ts33MuknbRoIY45bzOKXgxeFNshRV6PPQ+jiub14Bja0qqNBcjjaB1FIF4JHOGvqwEbQCOua
 vAvWxGVK7ozCJDi0=
X-Received: by 2002:a17:907:72c5:: with SMTP id
 du5mr7414005ejc.469.1599222286328; 
 Fri, 04 Sep 2020 05:24:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCz/L+a2Tx56RhPG+9SjhBVZebH1LwkA5uyiZAs2OAqxLMQKQDnBgQiZKPPx4nT82udceAdw==
X-Received: by 2002:a17:907:72c5:: with SMTP id
 du5mr7413990ejc.469.1599222286099; 
 Fri, 04 Sep 2020 05:24:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6276:52ed:96d5:c094?
 ([2001:b07:6468:f312:6276:52ed:96d5:c094])
 by smtp.gmail.com with ESMTPSA id bn14sm5921555ejb.115.2020.09.04.05.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 05:24:45 -0700 (PDT)
Subject: Re: [PATCH] meson: fix qxl module build
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200827064629.23080-1-kraxel@redhat.com>
 <20200904081240.afvjaek5o2owlyeh@sirius.home.kraxel.org>
 <2706f51d-381f-929e-7c8c-7df83f8491ff@redhat.com>
 <20200904121412.lgrm7mlri664jz4n@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9de758ed-ae9d-40e6-8ad5-aaf102bc5013@redhat.com>
Date: Fri, 4 Sep 2020 14:24:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904121412.lgrm7mlri664jz4n@sirius.home.kraxel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 06:46:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/09/20 14:14, Gerd Hoffmann wrote:
>   Hi,
> 
>>>> -  qxl_ss.add(when: 'CONFIG_QXL', if_true: files('qxl.c', 'qxl-logger.c', 'qxl-render.c'))
>>>> +  qxl_ss.add(files('qxl.c', 'qxl-logger.c', 'qxl-render.c'))
> 
>> You have found why it's got that "when:". :)
> 
>> -      module_ss = module_ss.apply(config_host, strict: false)
>> +      module_ss = module_ss.apply(config_all, strict: false)
> 
> Ah.  That nicely explains why the "when:" didn't work in the
> first place.
> 
>> etc.  This would work also for the CONFIG_VIRTIO_GPU changes.
> 
> Yes, virtio-gpu modules are next on the list ;)

Great, feel free to pick the patch up, no need for attribution or anything.

Paolo


