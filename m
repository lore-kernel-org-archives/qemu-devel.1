Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8ACC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D338221FC
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrTEFQ5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D338221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUSWS-0000a8-2k
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 06:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUSVT-0008As-DI
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUSVR-0007zH-UO
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603103709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=auHnQuL3FOrEDMH2QjEI/Yo3nXp1WUImC/u2fKGbNjY=;
 b=LrTEFQ5jUHuNAJP+fEa4UFWTWPZu2CR8edC7F0PlLXGMve2o+RMT0aA60TfGdQHzvHtq1L
 ad/PUw2sJ0MCUsDGiBRb7nYA7cITdR2bN5U+/PXSd1sjvBWwRuj+dJ6uO+ZlOhcWILq/fs
 USOJjnfxCnmgmYHOF6OQWh63lHTPHZc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-0Jr1W7VaP1yHrAtcSfV2rw-1; Mon, 19 Oct 2020 06:35:07 -0400
X-MC-Unique: 0Jr1W7VaP1yHrAtcSfV2rw-1
Received: by mail-wm1-f70.google.com with SMTP id s25so4394542wmj.7
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 03:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=auHnQuL3FOrEDMH2QjEI/Yo3nXp1WUImC/u2fKGbNjY=;
 b=pRXgNAI965bpxGuxYkc5YkE1ShzNP7dgdXB6CNkKm98I6de8fpQo+qQuq2pD/wmdtl
 iFR+/wrGAEUSpEWWBbt4VclibIz6yFXn6j9L00nF4w8BSXs35+7RLaolTv982xmFgO1g
 JoBHFJLI/jwE7XdHy/8x83efe0SbpMekGG3HQHuwipXh1TuRWjzuCJYff2y1L3I/zYLU
 mMlXt7sW5yuA8BYJwWLuHov7qFZe4LpCUERhPmooZYRLW4wDe56Ef5yz7shDCoB8WlGF
 ibjmjXNUnhQ6bYkRxlcV9rbGLhk2NRi3pxIxqSrEzwG+hn3jpIkd7hNseyt59Wo2Oze4
 aKYQ==
X-Gm-Message-State: AOAM53179fiTkcx3e9mF6gj3YmoXNCUOjCfac/fr5CghaxmGLY06Tqr3
 ev5vKczmnQ7lX6xZYQ6EXkoenPDJfqsumtGt/sOrknSFbzOzdMlmjlvsMKC2uK0YCU7favlWtEy
 4VV/4MJDkF7097hw=
X-Received: by 2002:a1c:7f0f:: with SMTP id a15mr16439533wmd.97.1603103706084; 
 Mon, 19 Oct 2020 03:35:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp1CN9CWbc4b3Zn7d+6BIIw26LMil+m71QhGLBnoV0qDRMOY+7unrlDPupfPCAz5MJl8qnrg==
X-Received: by 2002:a1c:7f0f:: with SMTP id a15mr16439518wmd.97.1603103705898; 
 Mon, 19 Oct 2020 03:35:05 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id o5sm10474287wrw.76.2020.10.19.03.35.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 03:35:05 -0700 (PDT)
Subject: Re: [PATCH] microbit_i2c: Fix coredump when dump-vmstate
To: Peng Liang <liangpeng10@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201019093401.2993833-1-liangpeng10@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <786deb83-b6f4-d778-d5ed-19f3901ad211@redhat.com>
Date: Mon, 19 Oct 2020 12:35:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019093401.2993833-1-liangpeng10@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, joel@jms.id.au, xiexiangyou@huawei.com,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 11:34 AM, Peng Liang wrote:
> VMStateDescription.fields should be end with VMSTATE_END_OF_LIST().
> However, microbit_i2c_vmstate doesn't follow it.  Let's change it.

It might be easy to add a Coccinelle script to avoid future errors.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Fixes: 9d68bf564e ("arm: Stub out NRF51 TWI magnetometer/accelerometer detection")
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Peng Liang <liangpeng10@huawei.com>
> ---
>   hw/i2c/microbit_i2c.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
> index 802473982082..e92f9f84ea81 100644
> --- a/hw/i2c/microbit_i2c.c
> +++ b/hw/i2c/microbit_i2c.c
> @@ -83,6 +83,7 @@ static const VMStateDescription microbit_i2c_vmstate = {
>       .fields = (VMStateField[]) {
>           VMSTATE_UINT32_ARRAY(regs, MicrobitI2CState, MICROBIT_I2C_NREGS),
>           VMSTATE_UINT32(read_idx, MicrobitI2CState),
> +        VMSTATE_END_OF_LIST()
>       },
>   };
>   
> 


