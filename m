Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDE1C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643E72087D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYExgnMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643E72087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kakhF-00038L-By
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 14:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kakfa-0002ER-Kq
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:11:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kakfQ-0006Qu-9S
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604603479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RyWfbqN+dIwS2ENcpOVqTpd50IsLeju1DTWilze/lLA=;
 b=QYExgnMUpAyI182t8U8CJhpbw0yKiu/iU/l1+vPiEGcxahA1EF8K3vLsQ+VzuY6PmJvjiq
 9CkXpDEizqGzPQXppXsAS6O9Yug5LskbhY2SJ3/3xWKL2MxpRPQpzDgDf45TvLl63rjkft
 ysKEfubK5uknnFGi/bI9poeAQJoXvrA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-uNK5rhUtMxmaQFVtoUw4Tg-1; Thu, 05 Nov 2020 14:11:17 -0500
X-MC-Unique: uNK5rhUtMxmaQFVtoUw4Tg-1
Received: by mail-wm1-f69.google.com with SMTP id u9so692356wmb.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 11:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RyWfbqN+dIwS2ENcpOVqTpd50IsLeju1DTWilze/lLA=;
 b=iJiqW03w6SXgrlPnbOvm+m2Fc3O3Nc0rIZeE15hY0Tq821rMDU8C08Gx7PoxHuO+SO
 iBt0kqyah2NYfT9/Van+h0izSR2mK/1rhV7293Adn5c6MTSToDY2G724JrNaQg7KtIkl
 lwfGyHtEr/7XPqzqUoilQTWUi6fbmSqUytJ5bpOfaM2Na8UKA7xokuNIy0MvWBxtdqYa
 msRe8+UlgWjuDgqduNqbf5MUO/+2oNbsxXzlCPcm7iGRhaHoIA7OPWa/OJxZAu5Hcu0u
 rG9mcUK9LkExw552Ufcuzcg9CP31ZEVOddAvpbQjtubysQNhpnCoiD+WJTs8mjsevTL3
 DFZA==
X-Gm-Message-State: AOAM5300jhaiya2+HvIAn8/6NSXliWAB+ZE0YMPJP4tLwGW2Vn46P3H7
 CwFS0zw6Vwhu+vPPHEvapKfbLkUppZ5i8HWjgMig55Gihd3UIR+XaqNM/RPyAo3QVtBkfcnZf+L
 4Yy7HyhnyoCiZdio=
X-Received: by 2002:adf:dd50:: with SMTP id u16mr4925101wrm.419.1604603476748; 
 Thu, 05 Nov 2020 11:11:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytboe+6dG91thZhrYTdfjFjHwhR3uYrQxNdm1LWqamhVywMf1+gcvLPG8L+scOnM1Zx+2NAA==
X-Received: by 2002:adf:dd50:: with SMTP id u16mr4925080wrm.419.1604603476538; 
 Thu, 05 Nov 2020 11:11:16 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t7sm3533182wrx.42.2020.11.05.11.11.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 11:11:15 -0800 (PST)
Subject: Re: [RFC PATCH 10/15] meson.build: clean-up summary reporting of XEN
 and it's features
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f9a80c4e-848c-f1f3-9d44-9d5cbab01b19@redhat.com>
Date: Thu, 5 Nov 2020 20:11:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105175153.30489-11-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 stefano.stabellini@xilinx.com, stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 6:51 PM, Alex Bennée wrote:
> Report XEN support along with the rest of the accelerators. Repurposed
> the existing Xen support line to display details about the control API
> version and the additional enabled features.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  meson.build | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 46e4c2fc3a..79b74fbda7 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2078,8 +2078,15 @@ if vnc.found()
>    summary_info += {'VNC JPEG support':  jpeg.found()}
>    summary_info += {'VNC PNG support':   png.found()}
>  endif
> -summary_info += {'xen support':       config_host.has_key('CONFIG_XEN_BACKEND')}
>  if config_host.has_key('CONFIG_XEN_BACKEND')
> +  xen_features = ['backend']
> +  if config_all.has_key('CONFIG_XEN_HVM')
> +    xen_features += 'HVM'
> +  endif
> +  if config_all.has_key('CONFIG_XEN_PCI_PASSTHROUGH')
> +    xen_features += 'PCI Passthrough'
> +  endif
> +  summary_info += {'xen features':      ' '.join(xen_features)}

Maybe ','.join, as ' ' already in 'PCI Passthrough'.

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>    summary_info += {'xen ctrl version':  config_host['CONFIG_XEN_CTRL_INTERFACE_VERSION']}
>  endif
>  summary_info += {'brlapi support':    config_host.has_key('CONFIG_BRLAPI')}
> @@ -2092,6 +2099,7 @@ summary_info += {'Linux io_uring support': config_host.has_key('CONFIG_LINUX_IO_
>  summary_info += {'ATTR/XATTR support': config_host.has_key('CONFIG_ATTR')}
>  summary_info += {'Install blobs':     get_option('install_blobs')}
>  summary_info += {'KVM support':       config_all.has_key('CONFIG_KVM')}
> +summary_info += {'XEN support':       config_all.has_key('CONFIG_XEN')}
>  summary_info += {'HAX support':       config_all.has_key('CONFIG_HAX')}
>  summary_info += {'HVF support':       config_all.has_key('CONFIG_HVF')}
>  summary_info += {'WHPX support':      config_all.has_key('CONFIG_WHPX')}
> 


