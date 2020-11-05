Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F85C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544712065D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4i5S08b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544712065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaf16-0002rj-LA
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaf0I-0001vW-9g
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:08:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaf0G-00013b-FW
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604581715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJ0qqWoi01M/zwVQvGH4G2f8PNM5oPR4Y/W9WrhChVk=;
 b=e4i5S08bLdxabxELlGn9pKVeeHij5Pta8nkJqQo64wyA4lFj0fSCp9dAMkgjS2l/opCQkz
 +hveIx2sergr9d9vfNc9gts9PBYDZ8b6l2a8Mi1sElwP8kzS9xXXxuCQQdOLcVX3QsCNAF
 aNygcgYff8mbREsT+5xE869uhwNQEbw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-0-fQcrDXME2fBRY40epmGQ-1; Thu, 05 Nov 2020 08:08:34 -0500
X-MC-Unique: 0-fQcrDXME2fBRY40epmGQ-1
Received: by mail-ej1-f70.google.com with SMTP id c10so554599ejm.15
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 05:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WJ0qqWoi01M/zwVQvGH4G2f8PNM5oPR4Y/W9WrhChVk=;
 b=e4E1PpZIblyhFQdCM8X2WsDylp5oiqZy1w7BKaZwS3vCB9nCpQdolHjJ/YCLQ7k5+1
 aahTmMW/O/+c4a37jFVmUcOa3UtygND3cmnn6F1vie9hMRvxuWHu3j/+Htaa/BQJqYgQ
 GaYyjsurYTU4/XbgNUMeKbaHP6wj+bbNLQScH44QWCbgcCboaEB5UvGGZYdIS8YVTKd4
 QNEig77tls3hNMMaYscFWIHND3KfbiTdPfannllGy3MksyRj2++63UqDVD8GGow4U+GR
 5VVECdhGvhT+AipRE+jd33xwo2tGRNeGzLzaUW8hI6W5NYvXgOH4V47VodBGZihPOwQT
 1y5Q==
X-Gm-Message-State: AOAM531SuBI+xzaZU8986J1W8bmQoZHsrbbfxLz1ZnDPTRX3V3UTE50J
 HZrGUtFV1DTEKPb0WxMG8oMt9SrhOtNsrCmzGOaKJ6nwluc9pRWejheifBaoo9Cu4st6Ck5DB8t
 qTI++1yNammYxK6k=
X-Received: by 2002:a05:6402:31a5:: with SMTP id
 dj5mr2490361edb.325.1604581713025; 
 Thu, 05 Nov 2020 05:08:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVc4liEw4Md7GbshfO/fDevZGVnn4kNVtLLYPXtt+0kaGArKHX7T/dXNrUzIFkupsGnTULLg==
X-Received: by 2002:a05:6402:31a5:: with SMTP id
 dj5mr2490301edb.325.1604581712697; 
 Thu, 05 Nov 2020 05:08:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id k1sm879352edl.0.2020.11.05.05.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 05:08:31 -0800 (PST)
Subject: Re: [PATCH-for-6.0 1/3] hw/virtio: Add configure switch to disable
 legacy VIRTIO
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201105124353.3680057-1-philmd@redhat.com>
 <20201105124353.3680057-2-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e61e8533-4ee5-7584-409e-4b21a6f1007b@redhat.com>
Date: Thu, 5 Nov 2020 14:08:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105124353.3680057-2-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/11/20 13:43, Philippe Mathieu-Daudé wrote:
> +virtio_legacy="enabled"
>   virtiofsd="auto"
>   virtfs=""
>   libudev="auto"
> @@ -1001,6 +1002,10 @@ for opt do
>     ;;
>     --enable-libudev) libudev="enabled"
>     ;;
> +  --disable-virtio-legacy) virtio_legacy="disabled"
> +  ;;
> +  --enable-virtio-legacy) virtio_legacy="enabled"
> +  ;;
>     --disable-virtiofsd) virtiofsd="disabled"
>     ;;
>     --enable-virtiofsd) virtiofsd="enabled"
> @@ -1764,6 +1769,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>     vnc-png         PNG compression for VNC server
>     cocoa           Cocoa UI (Mac OS X only)
>     virtfs          VirtFS
> +  virtio-legacy   enable support for legacy virtio (before VIRTIO 1.0)
>     virtiofsd       build virtiofs daemon (virtiofsd)
>     libudev         Use libudev to enumerate host devices
>     mpath           Multipath persistent reservation passthrough
> @@ -6816,6 +6822,10 @@ if test "$safe_stack" = "yes"; then
>     echo "CONFIG_SAFESTACK=y" >> $config_host_mak
>   fi
>   
> +if test "$virtio_legacy" = "enabled"; then
> +  echo "CONFIG_VIRTIO_LEGACY=y" >> $config_host_mak
> +fi

Please use meson_options.txt instead (you can make it a boolean option 
with true/false as the choices for the shell variable).

Paolo

>   # If we're using a separate build tree, set it up now.
>   # DIRS are directories which we simply mkdir in the build tree;
>   # LINKS are things to symlink back into the source tree
> diff --git a/meson.build b/meson.build
> index 39ac5cf6d8a..51406c28c6e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2061,6 +2061,7 @@
>   summary_info += {'Block whitelist (rw)': config_host['CONFIG_BDRV_RW_WHITELIST']}
>   summary_info += {'Block whitelist (ro)': config_host['CONFIG_BDRV_RO_WHITELIST']}
>   summary_info += {'VirtFS support':    config_host.has_key('CONFIG_VIRTFS')}
> +summary_info += {'Legacy VIRTIO support': config_host.has_key('CONFIG_VIRTIO_LEGACY')}


