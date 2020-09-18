Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E557EC43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7508520878
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkD7sVRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7508520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGgc-0004jz-Cx
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJGeL-0002mk-3M
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:42:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34655
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJGeI-0004SC-B7
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600436520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SQDNln5ETn1oZTVml124jGef3HAq/cL+PUX9mbJxH78=;
 b=EkD7sVRoQAe2KHuKNA5VVHxqXhR+yh1hrnb68rYLcVQDpYOYRMYo4BTbRcoYoq/qqzmwBA
 LRr0f2ql6Y/zovP5tdNAbJSr6VzTfellcagxu64Dzjgj7j+XIN7ucspreqFTPAOj+J861A
 qBvLmU1N8PE5otNyPf7kp5X+mTjcpM4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435--F9uoIh1O52zk7xM0EArZg-1; Fri, 18 Sep 2020 09:41:54 -0400
X-MC-Unique: -F9uoIh1O52zk7xM0EArZg-1
Received: by mail-wr1-f71.google.com with SMTP id g6so2157754wrv.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 06:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=qRfbqwB866n2bg9j0YnNIJVsrBOqh4pDkjdn1e/H+9A=;
 b=fdyW0V23wJEPw7M1RQxZKjjapX3nQsXcCnfNKIB2D1xnD0Pkg6Nv+ULj7j0BMLoQ7H
 2keqo+yclbZ6o/0EXR6Fo/SKlfhsX/eC2fJUFnVH2l7/O1pz8Ns6Yim7jB79ojm7ZCqg
 aI05UoDGeDsMr4Xfcm/a7LbWaXOLeVuiaj5+N1wW5Z3LtR5cHzWgDP2OEnYdK8IdExyw
 4p3umNIyoN4+92b3SZM6JL9wTuxkY095vq35fFzRq00d/1GR+mwK3ckulTOhQBPWavcX
 mPPTU2nFGp6h78N8pUH4D19CUNBe4xTFTuXgUFrQ37r+59hbmG9HjYAii45iB9UkvxW3
 iOGA==
X-Gm-Message-State: AOAM531P4jbMYh3xoAKKIv0AbRFzsFwZvgXxVcUSHwR286PHyo6fQlHP
 9oXL/yJ2pX7GcFoiDlUFg2kBV5hIlhmxtkuc9BZF9HLolFqmEzb1ehh+2VUXfapLaquWgrNj2DX
 X5WRslB7kibRVEhs=
X-Received: by 2002:a1c:4e16:: with SMTP id g22mr14873946wmh.99.1600436513673; 
 Fri, 18 Sep 2020 06:41:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWOt6EV93kPjLlq8k2sM3Y3NYzWIzdAHOKOVujayCC8pYdl86KPzuctQzWavK6DMuoF8pYRA==
X-Received: by 2002:a1c:4e16:: with SMTP id g22mr14873915wmh.99.1600436513399; 
 Fri, 18 Sep 2020 06:41:53 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id g12sm5173938wro.89.2020.09.18.06.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 06:41:52 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/virt: use pflash image real size when mapping
To: =?UTF-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?= <haibinzhang@tencent.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <790EEEF3-0799-4507-BF30-DA85440E766F@tencent.com>
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
Message-ID: <52eb89e8-3602-2a2a-df9e-66130bce4070@redhat.com>
Date: Fri, 18 Sep 2020 15:41:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <790EEEF3-0799-4507-BF30-DA85440E766F@tencent.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 07:01:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_CHARSET_FARAWAY=2.45, NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Laszlo Ersek <lersek@redhat.com>, Leif Lindholm <leif@nuviainc.com>,
 Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing firmware experts.

On 9/18/20 2:26 PM, haibinzhang(张海斌) wrote:
> Default size of arm-virt pflash image is 64MB which
> will cost extra 128MB(64MBx2) memory per qemu process
> and 12.5GB for 100 qemu processes. Host memory is
> precious and it is valuable to reduce pflash image size.
> For compatibility arm-virt uses real size when mapping.

Flash#0 is a device because eventually its model will handle
sector/block protection, so firmware can do CapsuleUpdate
(updating itself). Meanwhile you could treat flash#0 as a pure
ROM device... But this wouldn't be the 'arm-virt' machine anymore.

> 
> Signed-off-by: Haibin Zhang <haibinzhang@tencent.com>
> ---
>  hw/arm/virt.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index acf9bfbece..3545e12865 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -50,6 +50,7 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/tpm.h"
>  #include "sysemu/kvm.h"
> +#include "sysemu/block-backend.h"
>  #include "hw/loader.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/bitops.h"
> @@ -1001,10 +1002,27 @@ static void virt_flash_map(VirtMachineState *vms,
>       */
>      hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
>      hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
> +    int64_t realsize;
> +    BlockBackend *blk;
> 
> -    virt_flash_map1(vms->flash[0], flashbase, flashsize,
> +    realsize = flashsize;
> +    blk = pflash_cfi01_get_blk(vms->flash[0]);
> +    if (blk) {
> +        realsize = blk_getlength(blk);
> +        realsize = realsize < flashsize ? realsize : flashsize;
> +    }

Stefan recently posted "nvdimm: read-only file support" which
might be a better way to achieve what you want:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg741137.html

> +
> +    virt_flash_map1(vms->flash[0], flashbase, realsize,
>                      secure_sysmem);
> -    virt_flash_map1(vms->flash[1], flashbase + flashsize, flashsize,
> +
> +    realsize = flashsize;
> +    blk = pflash_cfi01_get_blk(vms->flash[1]);
> +    if (blk) {
> +        realsize = blk_getlength(blk);
> +        realsize = realsize < flashsize ? realsize : flashsize;
> +    }
> +
> +    virt_flash_map1(vms->flash[1], flashbase + flashsize, realsize,
>                      sysmem);
>  }
> 
> --
> 2.23.0
> 


