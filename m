Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B93C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1980E206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoB9g+Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1980E206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3Ip-0005Aa-2m
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:17:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc3BN-00059k-O1
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc3BL-0007As-Uf
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604912987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LBX00fUtgNFIVUH8PiEVFNdlldoPk7nWKF4IpHuZdfI=;
 b=LoB9g+Zmw1weqeHbw6D8cnZa9WFOcYjh4mIvDrdYCugOznuWhS/dON8SIPe1wVzBoJsbsX
 7j99mVLTcRnxyCrEUSfXhiu9tWk7r/+ZIC8+6MvK2whOejDGXec6h7NH+yj+sfM1I9+MUP
 iTj8FqxgISNrqWYO6F2K42oNcw4HsOg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-3FTBm0m7Owm-_8qtBFxEbw-1; Mon, 09 Nov 2020 04:09:45 -0500
X-MC-Unique: 3FTBm0m7Owm-_8qtBFxEbw-1
Received: by mail-ed1-f69.google.com with SMTP id c2so2447191edw.21
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 01:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LBX00fUtgNFIVUH8PiEVFNdlldoPk7nWKF4IpHuZdfI=;
 b=jHjvEy0czEUfuzFtc93W1uA0WaXCSSOMTtjjUAti9UVdoXfANYk33giRH2Oev7fh/H
 VRhDFumURrgCoWbx2hNsvCs0ysndI6RFNHz1TMMYck79ECfFtirvDfEF8ZK9xq144aMj
 CrOF/kzT6wvOgP2B131FxIRZsMX1u4JGczaBsteabow0+MezzWzrjYWMH0HvMl4vk7wV
 9CE9WtyEW3z7eZEuFpBry6jPYt6wgF+tx/scpsCz+wsy8ZEgpOJFPWhm5WYmvI9rXhBd
 tNcpcanaJzwurPTWP4lj58uPbQsh6JlrmVcvkfKGFL5CFCwUql+kWODXziNvbaDwORDZ
 Nytw==
X-Gm-Message-State: AOAM532gnwEOXsP0bYGjChR/V1wtOHyHm64abx9j6cuTJQJ0bhnvlR9h
 MG0ulDinMfwZn5YWS4gkWVUP1Ey6PpO0Tj5qqtk3ulPxiuILZAzddXg0w0J4GO9zkbQ582VMA2y
 QwhqBifa0hRgbG9U=
X-Received: by 2002:a17:906:c298:: with SMTP id
 r24mr14027691ejz.76.1604912984378; 
 Mon, 09 Nov 2020 01:09:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy57r1PLWAZqBd1c+NehszR+uDXWOpb4AxlKuKUdLHznYltkv3uoy0vwp8G9cO7pnBNJbsr8g==
X-Received: by 2002:a17:906:c298:: with SMTP id
 r24mr14027677ejz.76.1604912984173; 
 Mon, 09 Nov 2020 01:09:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id k23sm8325206ejo.108.2020.11.09.01.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 01:09:43 -0800 (PST)
Subject: Re: [PATCH] meson: Clarify the confusing vhost-user vs. vhost-kernel
 output
To: Thomas Huth <thuth@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 qemu-devel@nongnu.org
References: <20201109085906.87921-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db279473-2610-8599-100f-a7fdf3fc22a4@redhat.com>
Date: Mon, 9 Nov 2020 10:09:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109085906.87921-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 09:59, Thomas Huth wrote:
> The configuration summary prints a line with "vhost-user: YES/NO",
> but the value is currently the vhost-kernel setting instead which
> looks wrong. Print the kernel setting in a separate line and switch
> the "vhost-user:" line to CONFIG_VHOST_USER instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index b473620321..61d883bc07 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2098,11 +2098,12 @@ summary_info += {'madvise':           config_host.has_key('CONFIG_MADVISE')}
>   summary_info += {'posix_madvise':     config_host.has_key('CONFIG_POSIX_MADVISE')}
>   summary_info += {'posix_memalign':    config_host.has_key('CONFIG_POSIX_MEMALIGN')}
>   summary_info += {'libcap-ng support': config_host.has_key('CONFIG_LIBCAP_NG')}
> +summary_info += {'vhost-kernel support': config_host.has_key('CONFIG_VHOST_KERNEL')}
>   summary_info += {'vhost-net support': config_host.has_key('CONFIG_VHOST_NET')}
>   summary_info += {'vhost-crypto support': config_host.has_key('CONFIG_VHOST_CRYPTO')}
>   summary_info += {'vhost-scsi support': config_host.has_key('CONFIG_VHOST_SCSI')}
>   summary_info += {'vhost-vsock support': config_host.has_key('CONFIG_VHOST_VSOCK')}
> -summary_info += {'vhost-user support': config_host.has_key('CONFIG_VHOST_KERNEL')}
> +summary_info += {'vhost-user support': config_host.has_key('CONFIG_VHOST_USER')}
>   summary_info += {'vhost-user-fs support': config_host.has_key('CONFIG_VHOST_USER_FS')}
>   summary_info += {'vhost-vdpa support': config_host.has_key('CONFIG_VHOST_VDPA')}
>   summary_info += {'Trace backends':    config_host['TRACE_BACKENDS']}
> 

Queued, thanks.

Paolo


