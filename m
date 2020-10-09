Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7717C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7102225D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rc+9Wp+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7102225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuxZ-0003rD-Fk
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQupn-0003cn-5x
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQupk-00016W-Od
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602259288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WzfW2G2YyArVvPSRfAD+ZcXcvWq+k4EkN7y6hBkUoCM=;
 b=Rc+9Wp+7a07A0AjayI16W2wuzSZYnRtF6PyPLtpvOTles+CsSJwY5R+QouDTwXvIq8xEyk
 LZz5r8lAKbe95ELPvuigWlKbiNHwInBOzy0IAZBWcBqTA0sF0KKwL2eoRo/NYXNU0naOTu
 WcV5Xk71D3EzMqRZCTo2UMhZy32KPpU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-pPgIaW-NOQ6XKZjV8Jtihw-1; Fri, 09 Oct 2020 12:01:23 -0400
X-MC-Unique: pPgIaW-NOQ6XKZjV8Jtihw-1
Received: by mail-wm1-f70.google.com with SMTP id w23so4279408wmi.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WzfW2G2YyArVvPSRfAD+ZcXcvWq+k4EkN7y6hBkUoCM=;
 b=PMRtrc18uroFbl36uV4zaKtK6U1s6CuFnf8qyCT5bX/DmHKF03t/miVvMGwLkQM6rb
 Rl4gJp5JVtpMQBkPenna0WhZc3c6tI9x4xGyvNViBHqQvg87sjD5UH/84H65Bx8HMyHm
 ye5N/7bM0WdbSPHa/2SmiQoGkJlmLQrABePkRW+wNoLGmMGJBwvN6V2aOLTugvrApH2Z
 KeYvtkGV4AVwS+y9q1lCVUIgwhmdsfSixBEytqnVfkI8M7ZPj4JDJQqL6Zmv3Ddiceso
 albWi2GAryQ16+yk+Xzdy80zlipLTwj6qVsFZUGX/9QGrdCLUQ4fwaSRr/psRDzTG0ud
 0HTA==
X-Gm-Message-State: AOAM531babNZZsNs3L6C9Xw1k7hnEbh2Co/+FZ88lYpakOuJZBdij3kC
 PzoqXMC1HuiRsljrClXb8JakW1orsh51fXkYAITef4wo6avOYVwHSGhTt/KJlENzs5FsHvJQcNp
 GnlZ3DGTMC3BiElw=
X-Received: by 2002:a5d:6a43:: with SMTP id t3mr16295853wrw.426.1602259282511; 
 Fri, 09 Oct 2020 09:01:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbJ4919KL0TjSqGLFKGoKgwxjShxGH6C65OV6Y7M14mIo9t3NMAZVojut/VQaD3wqpThW1Cw==
X-Received: by 2002:a5d:6a43:: with SMTP id t3mr16295826wrw.426.1602259282298; 
 Fri, 09 Oct 2020 09:01:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cee1:4797:6958:7698?
 ([2001:b07:6468:f312:cee1:4797:6958:7698])
 by smtp.gmail.com with ESMTPSA id w11sm12782744wrn.27.2020.10.09.09.01.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 09:01:21 -0700 (PDT)
Subject: Re: [RFC v1 3/4] qtest: do not build ide-test if TCG is not available
To: Claudio Fontana <cfontana@suse.de>
References: <20201009152108.16120-1-cfontana@suse.de>
 <20201009152108.16120-4-cfontana@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <673c52e5-e22e-bda1-b262-ec476a966f3f@redhat.com>
Date: Fri, 9 Oct 2020 18:01:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201009152108.16120-4-cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/20 17:21, Claudio Fontana wrote:
> it seems that ide-test depends on TCG currently.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  tests/qtest/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index ad33ac311d..3418f65e2a 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -46,9 +46,9 @@ qtests_i386 = \
>    (config_all_devices.has_key('CONFIG_TPM_TIS_ISA') ? ['tpm-tis-test'] : []) +              \
>    (config_all_devices.has_key('CONFIG_TPM_TIS_ISA') ? ['tpm-tis-swtpm-test'] : []) +        \
>    (config_all_devices.has_key('CONFIG_RTL8139_PCI') ? ['rtl8139-test'] : []) +              \
> +  (config_all.has_key('CONFIG_TCG') ? ['ide-test'] : []) +                                  \
>    qtests_pci +                                                                              \
>    ['fdc-test',
> -   'ide-test',
>     'hd-geo-test',
>     'boot-order-test',
>     'bios-tables-test',
> 

Interesting, why?...

Paolo


