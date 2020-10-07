Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5792CC47095
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC86215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxuCHkYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC86215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQBQ9-0003bk-Ct
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQBP2-00035v-F4
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQBOw-0004tP-PD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602084642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8viZlLmO/oCFfxmZKZlepe69AyUX0oonIB/oZWLXRAA=;
 b=RxuCHkYrqmE+IHx3HBz43CzM9qa/k5I0QCyU4md0E2PN0wA+GYs+bvJtwR1byjMZapbccI
 6VSu7+l0+msARo15dsAexekpKCfXjyhOKL/AyH39SzG3vpQOGOEXVT2M95a5bvZVCMfJPU
 Pq3jrkfcmlI/7P2EW3wpe/MMOMp3aug=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-IZl035HtML-8TAzdWG5xug-1; Wed, 07 Oct 2020 11:30:41 -0400
X-MC-Unique: IZl035HtML-8TAzdWG5xug-1
Received: by mail-wr1-f70.google.com with SMTP id e13so1312693wrj.8
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 08:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8viZlLmO/oCFfxmZKZlepe69AyUX0oonIB/oZWLXRAA=;
 b=pRoZzO517Z8N6BD68x/MCxXfgcdZ3hIQ5lZ7N6hM+KrzWFaoc1qLrrnLf1WkSGZuvN
 0Ey+OeJNtjh3ANLIXoSnPBSOC+ooZF4TvKWz21VU6HPSOB6ufIUKJ4dP6yShuqnBOI+z
 ILCBRq8m3nz6OMvGQ06SDLW2uTXI87Q3Qx5M8u7hnGJGqQHQIOgeJ1yHvP0lqTyZd9oA
 TXs/eDMk7OtETdafg6CMQQ6HgorLwBm8Pyt7lvTmhxcje+3n6yXMwB9oghaF6hKgz+XI
 9m7lAWlv1US2n9gaQGLV4/9Tby3v1kXXyBl6bn/iVCsNVh+YKZ3vaq9aWFJkTcrLF4nT
 OFfw==
X-Gm-Message-State: AOAM530L2aQF8LSVMbsluIY5UBWjOdU4HuvyyQN9jW/yc3Cvkh8mHwBl
 do11unmOr8YuW1DtYrAwbKSfMJApSceUTDcGNlXOhkx8ghjVq39sN3KdUv658ccZFn1dvgsa17n
 zcMZPYWC7G8hHhVk=
X-Received: by 2002:a1c:5a05:: with SMTP id o5mr3682999wmb.7.1602084640044;
 Wed, 07 Oct 2020 08:30:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQjiihlJvJ5HPdLRnDyR9wNr140NkMN1aeG63ulaGjKyUMVQvGNwBigCwease6iOQd6VwV1Q==
X-Received: by 2002:a1c:5a05:: with SMTP id o5mr3682886wmb.7.1602084638508;
 Wed, 07 Oct 2020 08:30:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff?
 ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
 by smtp.gmail.com with ESMTPSA id e18sm3273404wrx.50.2020.10.07.08.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 08:30:37 -0700 (PDT)
Subject: Re: [PATCH] configure: add option for virtiofsd
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>, qemu-devel@nongnu.org,
 virtio-fs@redhat.com
References: <20201007092913.1524199-1-misono.tomohiro@jp.fujitsu.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <15796673-2daf-70a8-4b20-b861d4c22e62@redhat.com>
Date: Wed, 7 Oct 2020 17:30:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007092913.1524199-1-misono.tomohiro@jp.fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/20 11:29, Misono Tomohiro wrote:
> Currently it is unknown whether virtiofsd will be built at
> configuration time. It will be automatically built when dependency
> is met. Also, required libraries are not clear.
> 
> To make this clear, add configure option --{enable,disable}-virtiofsd.
> The default is the same as current (enabled if available) like many
> other options. When --enable-virtiofsd is given and dependency is not
> met, we get:
> 
>   ERROR: virtiofsd requires libcap-ng devel, seccomp devel, vhost user and tools support
> 
> In addition, configuration summary now includes virtiofsd entry:
> 
>   build virtiofs daemon: YES/NO
> 
> Sidenote: this patch defines CONFIG_VIRTIOFSD for config-host.mak
> to avoid duplicate dependency check in tools/meson.build.
> 
> Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Hi Misono,

can you please handle the option via meson_options.txt?  That is, just
pass the value (auto/enabled/disabled) through from configure to meson,
and handle the default in tools/meson.build.  The logic will be
something like this:

have_virtiofsd = (targetos == 'linux' and
    'CONFIG_SECCOMP' in config_host and
    'CONFIG_LIBCAP_NG' in config_host)

if get_option('virtiofsd').enabled()
  if not have_virtiofsd
    if targetos != 'linux'
      error('virtiofsd requires Linux')
    else
      error('virtiofsd requires libcap-ng-devel and seccomp-devel')
    endif
  endif
elif get_option('virtiofsd').disabled() or not have_tools or \
     not 'CONFIG_VHOST_USER' in config_host
  have_virtiofsd = false
endif

if have_virtiofsd
  subdir('virtiofsd')
endif

This is because, when adding the option, there are some conditions that
should disable virtiofsd by default but can be overridden with
--enable-virtiofsd.

More information on how to create a new Meson option can be found in
docs/devel/build-system.rst.

Thanks,

Paolo

> -have_virtiofsd = (have_system and
> -    have_tools and
> -    'CONFIG_LINUX' in config_host and 
> -    'CONFIG_SECCOMP' in config_host and
> -    'CONFIG_LIBCAP_NG' in config_host and
> -    'CONFIG_VHOST_USER' in config_host)
> -
> -if have_virtiofsd
> +if 'CONFIG_VIRTIOFSD' in config_host
>    subdir('virtiofsd')
>  endif
> 


