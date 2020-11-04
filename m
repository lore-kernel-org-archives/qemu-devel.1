Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68712C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A373920870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDOw522y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A373920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaJ4j-00019H-D3
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 08:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaJ3n-0000h3-D6
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:42:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaJ3k-0003F1-HP
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604497361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyFp/fDsCTeCpd9OZzj2ZNNsxAckdXXmUeEbUoO6Xvo=;
 b=NDOw522y7rRsjJZLHF+IBuLnzM0F4YE1Ob1nJP1vm91lDRHVGAy5f/VDB3Ni73xftC9Qlc
 Rh8KT1grXgx7ksNGMcThm0n/1vl84/9wRq6dunFjfY+Ii//S7P8HhJtDzRwHho7tN8m4TK
 0v4Duvo/6ehYK/xNAWnz78aNfS/f1u8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-fuXZ1x7DNtCmplnuV2daLQ-1; Wed, 04 Nov 2020 08:42:39 -0500
X-MC-Unique: fuXZ1x7DNtCmplnuV2daLQ-1
Received: by mail-wr1-f70.google.com with SMTP id j15so9291252wrd.16
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 05:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fyFp/fDsCTeCpd9OZzj2ZNNsxAckdXXmUeEbUoO6Xvo=;
 b=UwVcUzeBkD6+YsZPiYncxgWIG9yrmafv8e7RaefsinUTitxyYPhwIurq9PzNz9dVO+
 h0Xuv8CCDECSWSqLY5d1l3qOeK7qGBD62T1Y+CpVOQt/2aSjF2NhWXRt5k8sgP0G9MAf
 EDb8s4g6RtsMmbsqmB1GIDK4A+SyBt3cRvZS1nbJmY5VxIWUJonj/XKSc5bI3fTo9Vvq
 dnlSt58lL+Y0T+AnnlzaSN5+horgF2BfKHz8PajmBHMyfvplqwhDecpG5nG2RGG7pLlR
 HncagpasiXl3JPuyj+XX3zZ6u6EynacupNZRy9jbuMJKPXTZBP4YYRyrRty3pzH0g8DL
 YwzA==
X-Gm-Message-State: AOAM533a/Av57LcvUkRGfkZTkvspyIpQ+LwSmHAw09L4YxxVv/JoVIfw
 DJMxJpe4CsSA2YYRnDEpv9BLv5xTUzHkMzYk+d1M0YntdxRPYnTNxFNFGd3LXxritlQ9py+XDBJ
 ouyoN52Jsrz7EJl4=
X-Received: by 2002:adf:80c8:: with SMTP id 66mr33109188wrl.415.1604497358532; 
 Wed, 04 Nov 2020 05:42:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySBFIbwiS95e2nNv5dqoKlLTB7DXvKVWeA8ywzc+sCuzFdjLdKGL2QyvoeR/UWbF7WMT6slg==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr33109161wrl.415.1604497358336; 
 Wed, 04 Nov 2020 05:42:38 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y187sm2264059wmg.33.2020.11.04.05.42.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 05:42:37 -0800 (PST)
Subject: Re: [PATCH 3/3] docker: remove libblockdev-mpath-devel package
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201104131924.593522-1-berrange@redhat.com>
 <20201104131924.593522-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8dbfd8d4-5f9b-a787-f0fa-a020b60281c5@redhat.com>
Date: Wed, 4 Nov 2020 14:42:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104131924.593522-4-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 2:19 PM, Daniel P. Berrangé wrote:
> This package was added in
> 
>   commit 8ea5962f286272ac2533892c07f9b7e2a77d8819
>   Author: Philippe Mathieu-Daudé <philmd@redhat.com>
>   Date:   Sat May 4 07:54:40 2019 +0200
> 
>     tests/docker: Test more components on the Fedora default image
> 
> but this is never used by QEMU. The multipath support in QEMU
> requires the device-mapper-multipath-devel package instead, which
> is already present.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  scripts/coverity-scan/coverity-scan.docker | 1 -
>  tests/docker/dockerfiles/fedora.docker     | 1 -
>  2 files changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


