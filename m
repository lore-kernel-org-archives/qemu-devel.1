Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A8EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67C422210
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ML2gWhz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67C422210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6y4-0007Zp-MK
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kT6oM-0000b7-OD
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 13:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kT6oK-0004Mi-VV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 13:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602781984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Dmrh7h21hXNYTr0lO7qAQYu1jlPXffv2TzrX/Xh//A=;
 b=ML2gWhz1ijQuLMayvf/fIhcJOJLft5VE9hBltt/JpXl/q+XyNFqE8feDCOFurR37BKXwbT
 GIyPM1H5AWQc3xb8B/QPvx+BpTHZwHS06+UH0l1m7GX1N0dSvMlBCMfox/XtplLJ8yihXa
 SWfKfVSYbsJpT0x21BFAbb6rvA1FtcQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-8Kk-aTFjMz-GaO79r3AshA-1; Thu, 15 Oct 2020 13:13:00 -0400
X-MC-Unique: 8Kk-aTFjMz-GaO79r3AshA-1
Received: by mail-wm1-f72.google.com with SMTP id f26so1476946wml.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 10:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+Dmrh7h21hXNYTr0lO7qAQYu1jlPXffv2TzrX/Xh//A=;
 b=UZ6j8jDuFSXQghQFvWCYMdmHB492G+dMoP52FWYSwI5PKEbjpOXOjg2nuP83ljOqFv
 ds/xLGqDyf6pvV6GZS1nXS7EloxgUyer5KOmgs2pPnUw1KDiwr6DIvBSt5UC4CwvNTIB
 C+FuDf0Fhd6tu94kXdVw3QGasZmX+FamiSxPNBx4Y2I6Gg0zZ3MNwOsOQUYqCB4QaCS/
 9S6JyWI86zB1uGVcKn2AdwwJTijyU03UTsmCyd3Guilv6vL+K6RWZLTnfr/Fl5d0BMFc
 So+UMyNq71ih8TBB1ZzIaMAiGs3Vk16l2RqhRhSaZ0b3I+z+wXquMyX1poR/SJA1CABh
 8KlQ==
X-Gm-Message-State: AOAM533LCbqwi2HrXX5lz7lvkHqeRMV6XRieGr4ssHh/30gA3C8mz+ZC
 jQPHMm5NveQHXHWN5a85t52fCf/lALsBvSwMoRKiToWIKryFpOWD52TjYa2nBAx5m+uwlCX658G
 0QbyBItoWOE6235M=
X-Received: by 2002:adf:9f0a:: with SMTP id l10mr4876431wrf.427.1602781979066; 
 Thu, 15 Oct 2020 10:12:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF4b3vxXGNP/yc0A8pES14EYUKjew1ixM9pZhRZrg2/fiVFPnLFjXhIS9ACmiX4I3I8w8HZg==
X-Received: by 2002:adf:9f0a:: with SMTP id l10mr4876409wrf.427.1602781978790; 
 Thu, 15 Oct 2020 10:12:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2110:4ced:a13b:6857?
 ([2001:b07:6468:f312:2110:4ced:a13b:6857])
 by smtp.gmail.com with ESMTPSA id p4sm5666716wrf.67.2020.10.15.10.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 10:12:58 -0700 (PDT)
Subject: Re: [PATCH] meson.build: don't condition iconv detection on library
 detection
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
References: <20201014221939.196958-1-brogers@suse.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ffbb4a4-9e87-bb36-505b-3a190f9aec96@redhat.com>
Date: Thu, 15 Oct 2020 19:12:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201014221939.196958-1-brogers@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: luoyonggang@gmail.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/10/20 00:19, Bruce Rogers wrote:
> It isn't necessarily the case that use of iconv requires an additional
> library. For that reason we shouldn't conditionalize iconv detection on
> libiconv.found.
> 
> Fixes: 5285e593c33 (configure: Fixes ncursesw detection under msys2/mingw by convert them to meson)
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  meson.build | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 1a4a482492..84c8ec9541 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -431,15 +431,13 @@ if not get_option('iconv').disabled()
>    libiconv = cc.find_library('iconv',
>                               required: false,
>                               static: enable_static)
> -  if libiconv.found()
> -    if cc.links('''
> -      #include <iconv.h>
> -      int main(void) {
> -        iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
> -        return conv != (iconv_t) -1;
> -      }''', dependencies: [libiconv])
> -      iconv = declare_dependency(dependencies: [libiconv])
> -    endif
> +  if cc.links('''
> +    #include <iconv.h>
> +    int main(void) {
> +      iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
> +      return conv != (iconv_t) -1;
> +    }''', dependencies: [libiconv])
> +    iconv = declare_dependency(dependencies: [libiconv])
>    endif
>  endif
>  if get_option('iconv').enabled() and not iconv.found()
> 

Queued, thanks.

Paolo


