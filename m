Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DECC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D0F223EA
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gq9eOrWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D0F223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0Cy-0002t9-Uu
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVzOR-0006UO-6H
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:54:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVzOP-0004xo-Hy
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603468452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IOZhoJ29FH7QTkuusUR0+0yDW05xUF/iF0ZddsU6y3U=;
 b=gq9eOrWSRxkjdV2udEMz2lfz6JbCNRqVARO84f/Kin3534jS0o5Wwjzyr7Pc3Sznw24G5j
 wjXoYpHikptV6ywt9viOSk6EWKsjV/gSzATRexNmVyQViUZczPbao0/FTDZBOjanLh/L8l
 DogkfeaxsYotklERdOUSdOjvZE8XKyw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-MtcQrpgVMgy7UEfyd6p2bw-1; Fri, 23 Oct 2020 11:54:10 -0400
X-MC-Unique: MtcQrpgVMgy7UEfyd6p2bw-1
Received: by mail-wm1-f69.google.com with SMTP id s25so610006wmj.7
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IOZhoJ29FH7QTkuusUR0+0yDW05xUF/iF0ZddsU6y3U=;
 b=RWP39oAfpBovcIFKj++2qumjurv1KF2yVMCfrLLojsnDw6G8V01FgSE+nwVFV7s38g
 U51YP4SSkLRFK60wRdwd07OL8tLuVsHo5a3Zs3HX3607pytwcQOjIjkmtZWgyUf2qqrB
 acFn1tU3KS6YKDh3IHiwKbs82Z1osJgfFjeYAZohWPi6t8QoZMsgBKjJ/Lq1COb9e6wM
 6E59IYnopJMTl2oUv7xn0861qAG0UpVlg+rWqc4GMAinY5EZ4O3tIiEdubrzJFLv+IEk
 EEmTLaOuxvoZ0H4YJYfq+WS1EJuami+dsPGv5ZaidMRx+qW3GvdMD4SZExVt4V+iaKR7
 o2VA==
X-Gm-Message-State: AOAM5316nchH83vEznTHuTND9AuxFRLMK2noSnEbJGkJiep33d4oIpAN
 T8IXhoeqsGStyxpLkRedCxJrP03U9eDnC8Aa5tdigQfuqux+GJq4ORrnr3OHx0Fb5T9lP3EogAU
 ZyU2bCKxALxUUjhc=
X-Received: by 2002:adf:9361:: with SMTP id 88mr3190431wro.37.1603468449068;
 Fri, 23 Oct 2020 08:54:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuD07Cv/pqX8QEkIAcYv8SioYO6kaxRHGhJhxMfVQVSYgSyaK8NS7pUG9bnpeFxEBubT626g==
X-Received: by 2002:adf:9361:: with SMTP id 88mr3190421wro.37.1603468448882;
 Fri, 23 Oct 2020 08:54:08 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id i10sm4647150wrq.27.2020.10.23.08.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 08:54:08 -0700 (PDT)
Subject: Re: [PATCH] hw/vfio: Use lock guard macros
To: Amey Narkhede <ameynarkhede03@gmail.com>, alex.williamson@redhat.com
References: <20201023124342.17793-1-ameynarkhede03@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9ec4834c-18bf-ad84-a117-228f8c3d06a6@redhat.com>
Date: Fri, 23 Oct 2020 17:54:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023124342.17793-1-ameynarkhede03@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 2:43 PM, Amey Narkhede wrote:
> Use qemu LOCK_GUARD macros in hw/vfio.
> Saves manual unlock calls
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>   hw/vfio/platform.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


