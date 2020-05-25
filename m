Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3171C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACBC12071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qmo8oKYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBC12071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdDen-0007HB-T9
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 10:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdDdB-0005Zm-EB
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:59:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46807
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdDdA-0002jT-GC
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590415143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5pcsVNIOelTgsHKGkBukwFKcax2B3Pw+cUNSqvZelkk=;
 b=Qmo8oKYdfOeKKPJSUMOz13kWVCGRtkMs9fxE0dw71tAj9VwPxa7eICd91LRgA/1lbHqo4d
 YbM0U9oNFBx4Nijb47eLP2nWYNixmPlKqr5v3u2acZBoT8NiXTUgS2yeCl6KJJKhRsJpsE
 rCkIBZajNHyqAn90+iDXPoUAE/WJgTo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-TezkNBCxMTaG5wle6yQNWA-1; Mon, 25 May 2020 09:59:00 -0400
X-MC-Unique: TezkNBCxMTaG5wle6yQNWA-1
Received: by mail-ed1-f72.google.com with SMTP id f10so7503943edn.10
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 06:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5pcsVNIOelTgsHKGkBukwFKcax2B3Pw+cUNSqvZelkk=;
 b=Qgl2KF216IYUwmNpBHaXWRMoUcuA1HWb67teARd3zkbtt2kfcCTqYZZSRCklSH1ERV
 qF7mn8/9+lBQzHeCYjt+ZZOiVrR2FTJghKmavoG3FfgPE6ky/4+NILFTMALoamwRkLnL
 5wvR0jQuJBC9dLEuVVNXOWpaEZXuhhZAbB10tPtEKk+Ua5v46Xf8vRo1S5Iouaf8IAuH
 1F1zfDG1Cee6ZPOcJkzcqdsku0D4edpBXFVqjboRGeNhdNhLZA8on0w/O7xCR6shMnRO
 ggCiL9xhu4qVqwmDZ7+JaJuDTsLfqDzr3024zMX0wjEdj0S8nSoPIs6BXzxKrboZYl38
 kgkQ==
X-Gm-Message-State: AOAM530HR8WE8+2cytCL+IDXp7PXzJOgG93bw8bArN69QRC6otp5u5X8
 3GwUZBfb+0EhFdR7gc6NTfGGNWTLqHTamfn4D/JEtP3SUjSd5xHcyKPMA85sAR41G9dQ88V70lb
 FvSYkrQlk+lXgfYo=
X-Received: by 2002:a50:e84b:: with SMTP id k11mr15770656edn.204.1590415139520; 
 Mon, 25 May 2020 06:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8sZJ0JG0jTCi8JEVSa7B9RvRiPFHThR2FvxfnDViKXoPuJuFi0PUcNueec1kKBMjVzBr4zw==
X-Received: by 2002:a50:e84b:: with SMTP id k11mr15770644edn.204.1590415139364; 
 Mon, 25 May 2020 06:58:59 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id u26sm15158647eje.35.2020.05.25.06.58.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 06:58:58 -0700 (PDT)
Subject: Re: [Bug 1880355] [NEW] Length restrictions for fw_cfg_dma_transfer?
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <159029353528.907.11982786579949073896.malonedeb@chaenomeles.canonical.com>
 <ced59c5e-01e9-9da6-5191-9d34ffa976b0@redhat.com>
 <CAFEAcA83E33xNjhXvbZr9oe7TO9kMa0nArroCA_mY3zy+0bq2g@mail.gmail.com>
 <c8326e26-c529-18c1-4bd2-63a5aec071fb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36adab2a-bfb4-c60b-9a5b-5fe741d01325@redhat.com>
Date: Mon, 25 May 2020 15:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c8326e26-c529-18c1-4bd2-63a5aec071fb@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Bug 1880355 <1880355@bugs.launchpad.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/05/20 16:27, Philippe Mathieu-Daudé wrote:
>> In an ideal world all our DMA devices would use some kind of common
>> framework or design pattern so they didn't hog all the CPU
>> and/or spend minutes with the BQL held if the guest requests
>> an enormous-sized DMA. In practice many of them just have
>> a simple "loop until the DMA transfer is complete" implementation...
> Is this framework already implemented in the hidden dma-helpers.c?
> 
> Apparently this file was written for BlockBackend, but the code seems
> rather generic.

The code is generic, see dma_buf_rw, but the asynchronous code is
currently used only for block devices.  Above a certain limit it would
make sense to reuse them to perform dma_buf_rw in the thread pool.

Paolo


