Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194A9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 01:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4288A22206
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 01:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2ZY7KLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4288A22206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVPE5-00074u-QT
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 21:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVPDB-0006ef-0x
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 21:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVPD6-0004QY-Qp
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 21:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603329367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8X4083wH3uDyl+AcjLfLBSmNq9pXvAYgNZFA/7c7aIU=;
 b=H2ZY7KLUdFXNRMLBfwdimINHlr2KMEK3dsKtX/4MiouDt8zw1F+0OoXcajEFTSOagCfIz8
 5VmXXzs5eVaB33c43YN/EsNhfO+juyNYIiCgWlBBXGU0+JNNS8Mi/J9J8OWj/xlKHLp4ZZ
 a5tidLAqAtCuDmxIyZWNeAz0JeL9KqU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-vY2l7i1IPyapg6ue0ZCpog-1; Wed, 21 Oct 2020 21:16:03 -0400
X-MC-Unique: vY2l7i1IPyapg6ue0ZCpog-1
Received: by mail-wm1-f71.google.com with SMTP id r19so21913wmh.9
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 18:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8X4083wH3uDyl+AcjLfLBSmNq9pXvAYgNZFA/7c7aIU=;
 b=bwpl6eKb/dLrMm+sHhE1mDVR52OetCFYkubJ4vYbudNdh5cbTquSW8LJ6KJgNgTOsp
 R5SduKbgRsKumxanIUvTYyQ4+e5ZmEiI95+ko6lW9vq/El95QN9yPnzJo1KdVBAfTO3w
 l8/vzyDbyBfwmHItEo4puFr8zIRYdQXsWhq+aJJP3+pCL02+YPyg2toBh+LCirLfqdeX
 LoEmDuYdrWC4j8vfLfBK1AoM00NEXgJ8oQuNs69u4PF1epZ3n27tmlQYbyzYQzJ7WFGC
 uRNtIEdvB45jy7KoGOC4xX/+MmYYWcQT0AEjgNwQx4pnK+zsgTeQc/b3GylxhedFMU1F
 wJNw==
X-Gm-Message-State: AOAM531APxFRARnpRO5e/gYcNVMN37YV5r8hP5GSZ0o4eLyBnHPZleT1
 wzbWKzx/CempCoKMwaTMic00pauX3ZB49mOG+/hWe6X1eZoEBVVP3LKSZeAagm0kV3s/UwxZ40b
 P0MbbwEEnn0awyOw=
X-Received: by 2002:a1c:9dcc:: with SMTP id g195mr132361wme.113.1603329361679; 
 Wed, 21 Oct 2020 18:16:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQFjc+HHE/tEy3Ky7uU/9DojE7qtYIDnNuYu1PVV4IowDkN6USSMVIBg9NOgEF2X2FOiHCLQ==
X-Received: by 2002:a1c:9dcc:: with SMTP id g195mr132346wme.113.1603329361418; 
 Wed, 21 Oct 2020 18:16:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id w5sm253133wmg.42.2020.10.21.18.16.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 18:16:00 -0700 (PDT)
Subject: Re: [PATCH] WHPX: Fix WHPX build break
To: Sunil Muthuswamy <sunilmut@microsoft.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <SN4PR2101MB0880D706A85793DDFC411304C01D0@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6530a0a3-2d98-89f5-414e-8bd4400e0be2@redhat.com>
Date: Thu, 22 Oct 2020 03:16:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB0880D706A85793DDFC411304C01D0@SN4PR2101MB0880.namprd21.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 21:16:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/20 02:27, Sunil Muthuswamy wrote:
> With upstream commit#8a19980e3fc4, logic was introduced to only
> allow WHPX build on x64. But, the logic checks for the cpu family
> and not the cpu. On my fedora container build, the cpu family is
> x86 and the cpu is x86_64. Fixing the build break by checking for
> the cpu, instead of the cpu family.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 7627a0ae46..2d84e90495 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -198,7 +198,7 @@ else
>    have_xen_pci_passthrough = false
>  endif
>  if not get_option('whpx').disabled() and targetos == 'windows'
> -  if get_option('whpx').enabled() and cpu != 'x86_64'
> +  if get_option('whpx').enabled() and host_machine.cpu() != 'x86_64'
>      error('WHPX requires 64-bit host')
>    elif cc.has_header('WinHvPlatform.h', required: get_option('whpx')) and \
>         cc.has_header('WinHvEmulation.h', required: get_option('whpx'))
> 

Queued, thanks.

Paolo


