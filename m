Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514F5C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9B6207EA
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxclBsJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9B6207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlEz-00018e-1e
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPlAX-0005BB-1S
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPlAU-0007aJ-AL
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601983805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJKUEfLZ54RfXWzROszm0ADiVjY/Gtmh1hx5IBOGY1o=;
 b=fxclBsJEn1vZ7oLr2UcF9sEYSe8DzFu5fNwi0QxNgeJduKGlKtOgElm6+u9A1ZzQ2PsixF
 TcTvRZ0ndS20Z5b8g8cD12RKuFOjgfisk+MPS4NphsMoIPDTbkfhqfXf7BWEfUXcMukhws
 xlqBpmlZjv+cSVFMf91x5o/hLPsqwy8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-pV7Aoj91MfeKZS-81a9ZXQ-1; Tue, 06 Oct 2020 07:30:03 -0400
X-MC-Unique: pV7Aoj91MfeKZS-81a9ZXQ-1
Received: by mail-wr1-f71.google.com with SMTP id e13so670966wrj.8
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SJKUEfLZ54RfXWzROszm0ADiVjY/Gtmh1hx5IBOGY1o=;
 b=o7+m/TSGf/FOpHlO77M2nBLuZTiEY0KaqmDp4U579k8QtpW0ErVMLVcGZFrvZg5Hpo
 Hzw1GEWflqdBYSIvUCw/yhovYC2n8ABYJreiGpmNuuzFX9cGsCO4d1kL6rfVBPlh9y32
 iwgM6azVb3w1p3xmGerqXOanPUQGz8QOW6L/xIFDEIInj/Ql3pn4HXG8r2YfB/8Y/IBi
 79ke6p0IGfptd2cxNcEM0iU1o6IAXjjTwNJ5bifbSsPGFBsykgBQpo9bmuvylg532iUc
 0q4ACiks6vZ3wrLgaNG4aqnfodL9XsiKb51w2fHbaY95d5ISBxTlg5vUZogbJmGysEZw
 UPIw==
X-Gm-Message-State: AOAM530KjWzCxV+5DF35WPgM6siLTp8n+r65XdWyRichHmkYh9I2fqVZ
 xk2dMU4gh5QZ053M7wXdUzEThpdbWIpRfnbxiOPA6ettduAmrhpXQEWF2xAHN4oGoXcCxN0dBZo
 9S8AMx0Jjy27YVDU=
X-Received: by 2002:adf:eccb:: with SMTP id s11mr4477454wro.135.1601983802096; 
 Tue, 06 Oct 2020 04:30:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjy73vxVb45zO8DPlxjdp+RrbaaZSXqIe8sijvAtnSdxmhFlL3iicF7WOOrgGudofYdJdn7Q==
X-Received: by 2002:adf:eccb:: with SMTP id s11mr4477441wro.135.1601983801893; 
 Tue, 06 Oct 2020 04:30:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e?
 ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id f12sm3399157wmf.26.2020.10.06.04.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 04:30:01 -0700 (PDT)
Subject: Re: [PATCH 00/10] meson: Move the creation of the library to the main
 meson.build
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201006111219.2300921-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c3fe9454-dd67-62c5-d3dd-8852810e7969@redhat.com>
Date: Tue, 6 Oct 2020 13:29:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006111219.2300921-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/20 13:12, Philippe Mathieu-Daudé wrote:
> Make Meson machinery more consistent, as requested by Paolo.
> 
> Philippe Mathieu-Daudé (10):
>   migration: Only add migration files to the Meson sourceset
>   meson.build: Add comments to clarify code organization
>   meson.build: Sort sourcesets alphabetically
>   hw/core: Move the creation of the library to the main meson.build
>   chardev: Move the creation of the library to the main meson.build
>   migration: Move the creation of the library to the main meson.build
>   io: Move the creation of the library to the main meson.build
>   crypto: Move the creation of the library to the main meson.build
>   authz: Move the creation of the library to the main meson.build
>   qom: Move the creation of the library to the main meson.build
> 
>  meson.build           | 86 ++++++++++++++++++++++++++++++++++++++-----
>  authz/meson.build     | 10 -----
>  chardev/meson.build   |  6 ---
>  crypto/meson.build    | 10 -----
>  hw/core/meson.build   |  6 ---
>  io/meson.build        | 10 -----
>  migration/meson.build |  8 +---
>  qom/meson.build       |  8 ----
>  8 files changed, 77 insertions(+), 67 deletions(-)
> 

Nice!  Apart from the change to patch 1, perhaps move the "Targets"
headline a little earlier, namely just before

foreach m : block_mods + softmmu_mods
...
endforeach

Thanks!

Paolo


