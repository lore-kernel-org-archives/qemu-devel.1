Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F865C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC93E205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNQiFSUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC93E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPRGC-0004Kg-1M
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPRFb-0003ug-Tu
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:14:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPRFY-0002sA-Qg
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601907239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=To2N2KqTzHz/KqPthlwaTBLCxR7wlBJn5++Nldh1r00=;
 b=cNQiFSUPlhoXmRdHDz7tXuWAVV9yDH/GjFxLFg+Y+zsIFZ405Ub63jwGYjXuoT0K8cKF25
 ld9lp2qM6XZDF/+6WQiQADWtB0gB0uTnIdaL+21e7m/I4qNOXadgbszc/+Me5UWtRuhvyK
 BdLMyq6JiOx5E/d8N4n0QDUzZKQDOkA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-JuCyyy8XPHq9anxZ4Df8GA-1; Mon, 05 Oct 2020 10:13:42 -0400
X-MC-Unique: JuCyyy8XPHq9anxZ4Df8GA-1
Received: by mail-wr1-f72.google.com with SMTP id l15so4062343wro.10
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 07:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=To2N2KqTzHz/KqPthlwaTBLCxR7wlBJn5++Nldh1r00=;
 b=diT/AZ30Ut55foX6ygTr6ISFG2PuRYFTZG2pV/8fwIUE3BOFRC5CgnB6JsPzjiPW8B
 SpkS2syUlNq6+DXBn3MOgFN2NdPq70ClCMY/71z+bVwC9TMaqb1rTL1vke7SM/5wHI/e
 B/fwDi2sd+Q5rTKHfpH3Yye+7W7E3zo0gzpg7kOaYzvc1RaZMNmZjGMgmJrq8PKc+8Oj
 yDpe3sXlBZKGPxZck90mS4SebFkx098nTsczdsYLl1jORKlMLb5cR3cok+/BolE3JN7O
 BGLaJXCs/IJIAR6D343PmvRchZDQtc5dkSJSzkR43h95CgOUdqjbMfuy352kUP/A2+CV
 Z++g==
X-Gm-Message-State: AOAM532AHPnqdFTqTg+4n0+MV6Rk1bxFPcbmrqrsHtiguPD1MDSMoqGn
 ZSaCDUbuEFgG7Sssox03w0PlMTRcS6P6LsbVK2MXDLb9IbXbzPZvUaVii+Jx+1Cz7/PJUXsDY4K
 Xcp4qkeX5DyQrDek=
X-Received: by 2002:a5d:67d0:: with SMTP id n16mr19382953wrw.198.1601907221479; 
 Mon, 05 Oct 2020 07:13:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTvT4ZfgG6LujUTCNGdjhQICOYn3qIhALcvmt+W0dOXqLqX/X8MWY4jYpqF3JW3I+kbtPoIg==
X-Received: by 2002:a5d:67d0:: with SMTP id n16mr19382927wrw.198.1601907221224; 
 Mon, 05 Oct 2020 07:13:41 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id h17sm136268wro.27.2020.10.05.07.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 07:13:40 -0700 (PDT)
Subject: Re: [PATCH 2/4] dtc: Convert Makefile bits to meson bits
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201005135613.435932-1-pbonzini@redhat.com>
 <20201005135613.435932-3-pbonzini@redhat.com>
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
Message-ID: <9fba8d68-ab43-1b2a-5af9-e19255b234c6@redhat.com>
Date: Mon, 5 Oct 2020 16:13:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005135613.435932-3-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: marcandre.lureau@redhat.com, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 3:56 PM, Paolo Bonzini wrote:
> Build the library via the main meson.build just like for capstone.
> This improves the current state of affairs in that we will re-link
> the qemu executables against a changed libfdt.a, which we wouldn't
> do before-hand, and lets us remove the whole recursive make machinery.
> 
> The list of targets that require FDT is now obtained from default-configs/
> instead of being hardcoded in the configure script.

Could this be a machine Kconfig instead of a target makevar?
(Not asking to rewrite this patch, looking if this can be
improved later).

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile                                      | 23 +----
>  configure                                     | 93 ++++---------------
>  default-configs/targets/aarch64-softmmu.mak   |  1 +
>  default-configs/targets/arm-softmmu.mak       |  1 +
>  .../targets/microblaze-softmmu.mak            |  1 +
>  .../targets/microblazeel-softmmu.mak          |  1 +
>  default-configs/targets/mips64el-softmmu.mak  |  1 +
>  default-configs/targets/ppc-softmmu.mak       |  1 +
>  default-configs/targets/ppc64-softmmu.mak     |  1 +
>  default-configs/targets/riscv32-softmmu.mak   |  1 +
>  default-configs/targets/riscv64-softmmu.mak   |  1 +
>  default-configs/targets/rx-softmmu.mak        |  1 +
>  meson.build                                   | 61 ++++++++++--
>  meson_options.txt                             |  3 +
>  14 files changed, 84 insertions(+), 106 deletions(-)


