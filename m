Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5106CC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20E3206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhZhGXl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20E3206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjN8-0004d7-MJ
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPjMR-0004Ay-EN
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPjMP-000107-MH
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601976857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Zln8eASLsFRRK1yXOmkY/w+I2GWHigt2GgVKUcc7TvE=;
 b=WhZhGXl+wuBIHVtc96U9rgHsurJqZoBSnK5Jpew64hAIiwc/XdYUFnOJ+Fn5ffVGpyhoxO
 LR6kC707oL70h0bXEr21t5D86s94XN9+XxXSbKZB4ZPH32aZAeD3VgI+uaUPbfQh+doJMe
 f+mBoJlLXKvg4OtgQQd2vL1/UeZGjG0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-kBoMGHQRMguO2oOuKRqYdA-1; Tue, 06 Oct 2020 05:34:15 -0400
X-MC-Unique: kBoMGHQRMguO2oOuKRqYdA-1
Received: by mail-wm1-f72.google.com with SMTP id v14so897768wmj.6
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 02:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zln8eASLsFRRK1yXOmkY/w+I2GWHigt2GgVKUcc7TvE=;
 b=KKPdRr0Dp/jCoCKbSPvRP2ojNWqabWgmwGbfO4U1WpnlklxfCD2+ro41Vkutk9a704
 Sj09KPbTKTzlLQ72zE4nOkdbufD+Xif2dA6B3CUMkwu4Z85BQUBOicitNOdHicowTgZZ
 tJKT3C9wMAh1uvRQR+jEFwilBhM8XsNTiHipJxMBjaxvBpWVM3g0mbtgFK+QCiJs3zuC
 wXBEjApxDxI8wDgS6LgOhLoB+ynrCM7db44Y5U/aw8S8iBtGntZsOf/HTwGTQVtd2We9
 7tRNAJtWoP5PWB/hsLsblkrZzccb7rkuCLUYDlgdsiw+rJ1MyZKwRwrcFPGlOne2KQ/H
 PoBg==
X-Gm-Message-State: AOAM533XaLy2yqfnN6knGAxqdBOAFen8X1tBlvpc8TcY3D61PHrKFPMn
 hfQ0AeEqmikwi4BmF7NVa9Sqc12F8lQQdM+dI8rQqoWt6rBRd+M5GBH/3ctGTkvog/YhfhDalww
 2jAAe3wWFC7xU+/8=
X-Received: by 2002:adf:f212:: with SMTP id p18mr4026959wro.386.1601976853623; 
 Tue, 06 Oct 2020 02:34:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA1dzcK674/6ae6YRzKfCaT+VFpRmy0EG9HjjJi3nXh5lbcuoE4I2V+VtJ5VrJ2kileJevIw==
X-Received: by 2002:adf:f212:: with SMTP id p18mr4026941wro.386.1601976853380; 
 Tue, 06 Oct 2020 02:34:13 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t15sm3489191wrp.20.2020.10.06.02.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 02:34:12 -0700 (PDT)
Subject: Re: [PATCH 1/2] softmmu: move more files to softmmu/
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201006091922.331832-1-pbonzini@redhat.com>
 <20201006091922.331832-2-pbonzini@redhat.com>
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
Message-ID: <dac9fc9a-b4f3-422b-71d8-266bf24da268@redhat.com>
Date: Tue, 6 Oct 2020 11:34:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006091922.331832-2-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 11:19 AM, Paolo Bonzini wrote:
> Keep most softmmu_ss files into the system-emulation-specific
> directory.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                              | 10 ----------
>  bootdevice.c => softmmu/bootdevice.c     |  0
>  device_tree.c => softmmu/device_tree.c   |  0
>  dma-helpers.c => softmmu/dma-helpers.c   |  0
>  softmmu/meson.build                      | 10 ++++++++++
>  qdev-monitor.c => softmmu/qdev-monitor.c |  0
>  qemu-seccomp.c => softmmu/qemu-seccomp.c |  0
>  tpm.c => softmmu/tpm.c                   |  0
>  8 files changed, 10 insertions(+), 10 deletions(-)
>  rename bootdevice.c => softmmu/bootdevice.c (100%)
>  rename device_tree.c => softmmu/device_tree.c (100%)
>  rename dma-helpers.c => softmmu/dma-helpers.c (100%)
>  rename qdev-monitor.c => softmmu/qdev-monitor.c (100%)

TIL qdev-monitor.c :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  rename qemu-seccomp.c => softmmu/qemu-seccomp.c (100%)
>  rename tpm.c => softmmu/tpm.c (100%)


