Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2892EC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D103D20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZC+eRRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D103D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDtbg-0007yH-T6
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 14:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDtak-0006Zs-Hi
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:04:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30728
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDtai-0007Zt-RA
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599156247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VCfdvTsMsxUBW40XfN+KZgwSYFG/fONRe2B9oGaPC2k=;
 b=PZC+eRRjqReQT5KIK1yz8hutfimEMuDWlEd9JFnL9ixEkgSyx2cF9pb21OlpVIhptrMBVl
 +VNGzSJO2wiKMoirhb8nwmdoYa7oMxOgypft0P77onYELxTLbtoFgWKlEiHcsvkSn2FNWF
 odXBshyE+7v2OE0EIgYYWervoptcd6A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-BxD8t-L1ONqLLsMPlP6VYg-1; Thu, 03 Sep 2020 14:04:03 -0400
X-MC-Unique: BxD8t-L1ONqLLsMPlP6VYg-1
Received: by mail-wr1-f71.google.com with SMTP id i10so1355859wrq.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 11:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VCfdvTsMsxUBW40XfN+KZgwSYFG/fONRe2B9oGaPC2k=;
 b=ZtcmuwapS0kYX84Q0R4iT5E9z2GSG181Wp8cVSYZEfgqq/J2YOdjFTj05r49pqK0xF
 /hbXs7dV3MEI3oH1/geWC7i5i8UX4Pf4kNpHqtOEpInFyDZMTptctD4urmEtZM0fWDoz
 47s0I16gS2IRSx0/p0awUnROFpDRlT6+fCYjTX41xiKdizvcXNQBcG7XNwzV5o5P498f
 WMKQN+ZcOWhSGNTho2oShHYxYlMcNtEfuIJUqi+m60aSMHIgpJIHoyZNVj83QDdFe3/3
 uMUANe4gAeq5GGhxZt/EOd5ToMqVftBcxt+uiwDay0pViYbU//4fVd6MhtolbAmJ88xW
 nOPw==
X-Gm-Message-State: AOAM532xnN5BlHiXeDseD1QlLMA5xCI5pRebo2Fs9lBe3ESdNkYBOyIo
 3jkNZO85y/k4ECWZ/8Qj7Ig5rNuLWAc/BZKrmxhxyzSEfCBhzI7/s8zM5+FGERBpfBUj3ratm+x
 czcvcrvv6u91L6ew=
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr3957625wrm.229.1599156242511; 
 Thu, 03 Sep 2020 11:04:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/RImMpAu+7rKRCrdc22jljj8cnZyEeOROk96kEizmCuI3PNAsmTWnYKmOOdYVOx8xiKeRKA==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr3957596wrm.229.1599156242290; 
 Thu, 03 Sep 2020 11:04:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:197c:daa0:48d1:20b2?
 ([2001:b07:6468:f312:197c:daa0:48d1:20b2])
 by smtp.gmail.com with ESMTPSA id b1sm5887488wru.54.2020.09.03.11.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 11:04:01 -0700 (PDT)
Subject: Re: [PATCH] meson: remove linkage of sdl to baum
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
References: <20200903152933.97838-1-brogers@suse.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c5a33e9f-1831-627d-6294-12c1ca9a4389@redhat.com>
Date: Thu, 3 Sep 2020 20:04:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903152933.97838-1-brogers@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: samuel.thibault@ens-lyon.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/20 17:29, Bruce Rogers wrote:
> Ever since commit 537fe2d63f744e7c96ff45b60d09486a81958e06 there
> has been a 'linkage' to sdl for compiling baum.c. Originally it
> had to do with including sdl cflags for any file including sdl
> headers. There is no longer any such need for baum.c, but the
> association has persisted in the make system, and with the switch
> to meson it has now become a hard requirement, which now causes
> chardev-baum.so to not be produced if sdl is not configured.
> Remove this bogus linkage.
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  chardev/meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/chardev/meson.build b/chardev/meson.build
> index 27a9a28f4c..54e88d0310 100644
> --- a/chardev/meson.build
> +++ b/chardev/meson.build
> @@ -36,9 +36,9 @@ softmmu_ss.add(when: ['CONFIG_SPICE', spice], if_true: files('spice.c'))
>  
>  chardev_modules = {}
>  
> -if config_host.has_key('CONFIG_BRLAPI') and sdl.found()
> +if config_host.has_key('CONFIG_BRLAPI')
>    module_ss = ss.source_set()
> -  module_ss.add(when: [sdl, brlapi], if_true: [files('baum.c'), pixman])
> +  module_ss.add(when: [brlapi], if_true: [files('baum.c'), pixman])
>    chardev_modules += { 'baum': module_ss }
>  endif
>  
> 

Queued, thanks.

Paolo


