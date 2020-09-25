Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A98C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 07:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A1423730
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 07:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLUrusAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A1423730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLidA-00030x-MJ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 03:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLib1-0000uT-Ur
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 03:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLiaz-000707-Oi
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 03:56:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601020604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g0gKI6BaAtro+EHbyl+ACthzw2UGmgCOzzB0nAizzKc=;
 b=CLUrusAkQVSx1IgXgAq3xN8L7hdwN9ZzRqNv/9AKStA1v2JkvtF3SKrv0PXeF4fYvehRA+
 nyKCIzNM/ChMfWkPt/Uv5+44BntePxTLjm/LOzTCH0f3tIItWFuFyEQ2y0TNWxa+f50/fg
 7Lkz5I/mF/KfKK9FGGOFTNUocv31P/Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-Fh4I3a79PeSvNyurRA7FGQ-1; Fri, 25 Sep 2020 03:56:39 -0400
X-MC-Unique: Fh4I3a79PeSvNyurRA7FGQ-1
Received: by mail-wm1-f70.google.com with SMTP id l15so772867wmh.9
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=g0gKI6BaAtro+EHbyl+ACthzw2UGmgCOzzB0nAizzKc=;
 b=pZeUvjcggYMcLSxJj0kZKtd6UaIXHHbDuFBhdPlhRaY3ks8ityukojNSHLLjKxKe5N
 EaO1BOy+oIFqMMU/NQ84jJzguMRDumdqhHW+hKRQp94rirQdy9tocdmFjDbr+Tw4cSrI
 BBW46Cpbdm6ZuxgMz/I4EsReL4tObc+Yy/0XDrxb4Rus4cPeqIBuRkdo/fYgpCgNReSB
 wpCiwmfvR+rGvAlPFebPKM635RbVCiXLm4AuP1CnboEz05V0XJXsqBJXUf5pm5hFKn2J
 7XfQeT+LrdnotNG+SkGi6xuyeb6f154MeXaeqmdqZSDRrhDU4BSFHdsSwewdxksww4X4
 tyiA==
X-Gm-Message-State: AOAM533JkyJXeG6LU2BAOpmPsM1SVwXzY5i8VNBMmr3xrYf0ulUyX6is
 9YOgSUgid+rihaNxwgytvNDjxpukPgIvtknr4FZue2RVXru0KaY6bRIpi2itcixJGOpNH0WUjEs
 HjY4XBE4eNZZAoMc=
X-Received: by 2002:adf:f852:: with SMTP id d18mr3018316wrq.245.1601020598740; 
 Fri, 25 Sep 2020 00:56:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUZLykhxawVXtGas8msdc1pIXAx2v5/35B+n+PEVGjeLKxkRn7MWhwOPxhTDE0CWrp1rxq6g==
X-Received: by 2002:adf:f852:: with SMTP id d18mr3018300wrq.245.1601020598528; 
 Fri, 25 Sep 2020 00:56:38 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id l17sm1891674wme.11.2020.09.25.00.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 00:56:37 -0700 (PDT)
Subject: Re: [PATCH] configure: Fix build dependencies with vhost-vdpa.
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200924210023.160679-1-lvivier@redhat.com>
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
Message-ID: <c683996a-a3ba-be56-5c89-a1fa37f55803@redhat.com>
Date: Fri, 25 Sep 2020 09:56:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924210023.160679-1-lvivier@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: marcandre.lureau@redhat.com, Jason Wang <jasowang@redhat.com>,
 pbonzini@redhat.com, lulu@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/20 11:00 PM, Laurent Vivier wrote:
> Following the same logic as for vhost-net-user and vhost-kernel,
> enable vhost-net if vhost-net-vdpa is enabled and vhost-net is not
> explicitly disabled.
> See 299e6f19b3e2 ("vhost-net: revamp configure logic")
> 
> Autoselect VHOST if VHOST_VDPA is set
> See 21c6b0c87e85 ("configure: simplify vhost condition with Kconfig")
> See 2becc36a3e53 ("meson: infrastructure for building emulators"
> 
> Problems can be triggered using;
> ... --enable-vhost-vdpa --disable-vhost-user --disable-vhost-kernel ...
> 
> Fixes: 108a64818e69 ("vhost-vdpa: introduce vhost-vdpa backend")
> Cc: lulu@redhat.com
> Cc: pbonzini@redhat.com
> Cc: marcandre.lureau@redhat.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Superfluous trailing '.' in subject.

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  Kconfig.host | 4 ++++
>  configure    | 3 ++-
>  meson.build  | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Kconfig.host b/Kconfig.host
> index 4af19bf70ef9..a9a55a9c315c 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -24,6 +24,10 @@ config VHOST_USER
>      bool
>      select VHOST
>  
> +config VHOST_VDPA
> +    bool
> +    select VHOST
> +
>  config VHOST_KERNEL
>      bool
>      select VHOST
> diff --git a/configure b/configure
> index e8e8e984f245..8ee15810c882 100755
> --- a/configure
> +++ b/configure
> @@ -2494,9 +2494,10 @@ if test "$vhost_net_vdpa" = "yes" && test "$vhost_vdpa" = "no"; then
>    error_exit "--enable-vhost-net-vdpa requires --enable-vhost-vdpa"
>  fi
>  
> -# OR the vhost-kernel and vhost-user values for simplicity
> +# OR the vhost-kernel, vhost-vdpa and vhost-user values for simplicity
>  if test "$vhost_net" = ""; then
>    test "$vhost_net_user" = "yes" && vhost_net=yes
> +  test "$vhost_net_vdpa" = "yes" && vhost_net=yes
>    test "$vhost_kernel" = "yes" && vhost_net=yes
>  fi
>  
> diff --git a/meson.build b/meson.build
> index f4d1ab109680..488ca205fad2 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -521,6 +521,7 @@ kconfig_external_symbols = [
>    'CONFIG_OPENGL',
>    'CONFIG_X11',
>    'CONFIG_VHOST_USER',
> +  'CONFIG_VHOST_VDPA',
>    'CONFIG_VHOST_KERNEL',
>    'CONFIG_VIRTFS',
>    'CONFIG_LINUX',
> 


