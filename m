Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC052C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 08:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C531208C7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 08:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9fFj/SO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C531208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFCCg-0002ei-D8
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 04:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFCC9-0002DZ-3r
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 04:08:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25488
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFCC7-00006J-FD
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 04:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599466086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pZnmffS2PWsCEspL4W5ayg3k2tZ17JyLTDPGu1SOQ6w=;
 b=W9fFj/SOr6+9f/iIo025aSfrijpjaV+GPu8ixn0DipvgssXZ4SZZ4m1/cBYPnGuvF/hVI+
 0BMCU5duf9A/sz3/DtXwCYy2X/x35KcCJ6oOrXffKX0N/5WNIjD5OTBy0rYVkWJC3iqoX4
 fOr8PL00a4DUSY7AAWXGdyr+/nlZtmI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-mpO49VgFMvqSUe3jkJRXtg-1; Mon, 07 Sep 2020 04:08:05 -0400
X-MC-Unique: mpO49VgFMvqSUe3jkJRXtg-1
Received: by mail-wm1-f70.google.com with SMTP id d22so1495141wmd.6
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 01:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pZnmffS2PWsCEspL4W5ayg3k2tZ17JyLTDPGu1SOQ6w=;
 b=N992he9WS5bsKZMrO3pweVckzcwHUvDwiNM2UdLB2oX7UZeS4VFStr6MVogIW9FlZA
 JvtmCSluJcF+IMTsX8ZsiEKNE4Y0+CBKTpIn610cpT2ywJzvMFLtvv85VcatYV6JyB+U
 cgw/nOur23F3UgdvOtjmpW/6fCakXbUSiQ+kDS55rdiyjB+ECzno7ssoMHK62V87nWey
 HgKPQ5NOeWR+HDSAwCyaiGUd1G1dmGdGE5knZxqpj6qYGhysddCKS/LkwJzNTPMAf7ch
 iYcw38SYWED+t8pAPQA40+/gmOA99/yD3R2K8ggRXWc34UkGRqsP3gTMA8pwq5uJpbj6
 aIpQ==
X-Gm-Message-State: AOAM532TJ5JQc308F8co5rmSCLA2QUBPJu80IBt3pq03QItTBU2TfFQm
 BsjL5VeCesw2RwhkAf8bo4AAYqra91jzPAOck/k2YcQZcWUUt8p4iKJ47ldaffflFd3TJ+BMTUU
 7/vngbvaV36RM4Tg=
X-Received: by 2002:a5d:6406:: with SMTP id z6mr19417833wru.133.1599466084160; 
 Mon, 07 Sep 2020 01:08:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBcGgRrHjtlOTDMwztxzZi1/C9MojthI1DIJIq51Zxvky2FYYfgiAQhlcIS8BskMu6qNXRNg==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr19417823wru.133.1599466084039; 
 Mon, 07 Sep 2020 01:08:04 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a85sm28111873wmd.26.2020.09.07.01.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 01:08:03 -0700 (PDT)
Subject: Re: [PATCH 2/2] meson: remove duplicate qxl sources
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200907071903.8065-1-kraxel@redhat.com>
 <20200907071903.8065-3-kraxel@redhat.com>
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
Message-ID: <81b7c304-14b6-3ab2-7caa-323cfbd00809@redhat.com>
Date: Mon, 7 Sep 2020 10:08:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907071903.8065-3-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.69, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/7/20 9:19 AM, Gerd Hoffmann wrote:
> We should add sources to the softmmu_ss or module_ss but not both.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/meson.build | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 78adaf9db463..ef8eb093acbb 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -45,8 +45,6 @@ if config_all_devices.has_key('CONFIG_QXL')
>    hw_display_modules += {'qxl': qxl_ss}
>  endif
>  
> -softmmu_ss.add(when: 'CONFIG_QXL', if_true: files('qxl.c', 'qxl-logger.c', 'qxl-render.c'))
> -
>  softmmu_ss.add(when: 'CONFIG_DPCD', if_true: files('dpcd.c'))
>  softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx_dp.c'))
>  

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


