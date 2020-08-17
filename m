Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDBBC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7FD2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbsDX9AL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7FD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7fRu-00047Z-Eo
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 09:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7fRA-0003iM-Ra
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7fR8-0007qh-Gh
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597671868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RmBEKRJcc622lVG/IRi/a1cLa5JXHNq0cpdp8GH94bw=;
 b=CbsDX9ALO4l58mVpvsCmSCV+xRa7IUn0hs095PXg5HQmskIus/IoOpchfZacSWfOJOXEey
 Yl6kSA6PMN0DX2FU83I+j3xoTdpzB+ZQ8jjuM1ENbBZsb2p4Ai/IFXZ9kgxn9sCsYUvEiQ
 YD6XA+Imp2rIlt2L+qkL/D9VplK61rI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-6SKLy-8GNsmtjeexU8a6WQ-1; Mon, 17 Aug 2020 09:44:27 -0400
X-MC-Unique: 6SKLy-8GNsmtjeexU8a6WQ-1
Received: by mail-wm1-f71.google.com with SMTP id h7so6040387wmm.7
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 06:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RmBEKRJcc622lVG/IRi/a1cLa5JXHNq0cpdp8GH94bw=;
 b=svqffh8wnRhPBtjw79jEYm651KbHhLX4az1Tbj5H01qcGwBaD+0cktUIuulQYGWEV7
 jjA/dnqrIOyCJvQqn2xZ7dkEYOX5ciDEIve+cQfvTYBMz7ACl1NWkZ6IfurxXCVr1s4T
 BJzLA97auOegb9sfLxWZASCXCO2W4hyXh2G8qKzduFmz2isAY4rVuIpSPdbeeFZXhrjM
 5PBYkAsJXpNrmPPuPa97+QyYSBZFZ0/4XzT8Nmw2i0b/MCyTRmgqFS8D+I4OiuPsYdUu
 LSZ94oDwG3dd/D0nVeYoVKhzjGppcdFSiSx6REGh1rZbI79WI2INfqA8mRYahuuOEcYe
 6Z2Q==
X-Gm-Message-State: AOAM532SPGbvpk2/JqzOMqvOcvYMbZJSq6WN7EcJuXGVyVpUtOcuHbm7
 d9Ef33vbnMk90y3huMwhH2a3MCZqrSh9ubxp7fIGZrV5oIu4i7zXdQlkdOeL8Fh4yANljJ9D1Cx
 0qQ/vjm3HZe/D760=
X-Received: by 2002:adf:ab03:: with SMTP id q3mr13670038wrc.378.1597671865965; 
 Mon, 17 Aug 2020 06:44:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzISwIiMIRb/qSq71DqTbG44azQl2dQDMw3yL+NZirtxKeTMvCtvXnze9ldn06k7vhXBE7Gcw==
X-Received: by 2002:adf:ab03:: with SMTP id q3mr13670020wrc.378.1597671865650; 
 Mon, 17 Aug 2020 06:44:25 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id s20sm28462128wmh.21.2020.08.17.06.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 06:44:25 -0700 (PDT)
Subject: Re: [PATCH v2 000/150] Meson integration for 5.2
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20200814091326.16173-1-pbonzini@redhat.com>
 <20200817110254.GA98227@SPB-NB-133.local>
 <f8a9f236-7017-01a7-0a6d-06a2e18f95f1@redhat.com>
 <44308a0f-8f09-84c9-fb59-bbb0bb580e1b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d8568c43-1b1d-9c07-4ba4-c07fb71beb3b@redhat.com>
Date: Mon, 17 Aug 2020 15:44:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <44308a0f-8f09-84c9-fb59-bbb0bb580e1b@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 01:24:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 17/08/20 15:36, Philippe Mathieu-Daudé wrote:
>> They also include a conversion of the ROM build.
>
> There was a discussion last year, IIRC QEMU isn't supposed to build
> ROMs, the repositories are provided for the source code and licenses.
> 
> QEMU might provide a compiled ROM and describe in the commit how it
> was built, but isn't responsible of providing buildsys to build all
> the roms jungle.

I'm referring to pc-bios/optionrom and pc-bios/s390-ccw, which are
effectively part of QEMU.  So no big change there. :)

Paolo


