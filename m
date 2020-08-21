Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B70C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DD82076E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1AvH5sA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DD82076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k98hi-0005Hq-8y
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 11:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k98gt-0004JL-B2
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k98gr-0004Br-Mj
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598022649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wOhC0A5tHx1/nYevk525JBIpOuyPxMXewPMHCSR4/SU=;
 b=F1AvH5sAZoCnD8JlyMfDYO0yKrlizJm/ePTf4zzi2Lzf6lofSUkhJV2/kYonUH6K+FWRbJ
 XiSDC86QwAF6I1pQS+3Uz5mk29kuCH8nQy99wdkipRVrSM9i/oxACAbAFp5XjFY2XtSMlp
 atxWhg8FVlCGe0C+TrTjnx80RraxOJU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-utwwfg5kNi2XsfjXZIj64A-1; Fri, 21 Aug 2020 11:10:47 -0400
X-MC-Unique: utwwfg5kNi2XsfjXZIj64A-1
Received: by mail-wr1-f71.google.com with SMTP id w1so638734wro.4
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 08:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wOhC0A5tHx1/nYevk525JBIpOuyPxMXewPMHCSR4/SU=;
 b=FLClE/kS4w10k3xQJ+ApPOZn71a9vGlYj/fURpy7c+hs50KhqLcepy9Nlc5uasQnRF
 uMS45pWmSmdpkxPEmo/MHXK9xF1IBZ57JJXWPYu9TodD0EKsIKlPD/v9WvGOGf6cqo5z
 4pAPkWFNi2T+Hla8ZgoKeKQa3qwsD1rBQPxdrSHDZFOnsitNPAVuyrZKz+KJGBh/Eucj
 kUtsiHljwMJrgUcLNyOZooP8toHQMT7XmQ0uQ5A6INRbMQO2F9tXo0tkJ3YvP3txVgf+
 2CCTKi+SyfBFOMhRLMTn623aNMTp/jpVkm2K24K122Hei5vmxTb8SCbF0WMUV3gpJwJq
 c2Hg==
X-Gm-Message-State: AOAM531eFv9Cxf3Bor/WOkjpqpLm5JJiSpErMqPNSz0TUkHRnmfQJZWl
 rZH89kNtKaZsD1PTjr8DgjrDde2KzsP0UZmfKGNkppQoMqLxzUPeu1Tig/UfzL6rV7PIyK12TnO
 tMuekYyL/h5pSWFM=
X-Received: by 2002:a1c:4844:: with SMTP id v65mr3740873wma.149.1598022646116; 
 Fri, 21 Aug 2020 08:10:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgt32T6E65beBkwOHK2lcvXQqlulz+Ryl29iqbe0ElnzdCqOxaSZYhQk+mkB8Zj/LsMXMwyw==
X-Received: by 2002:a1c:4844:: with SMTP id v65mr3740855wma.149.1598022645924; 
 Fri, 21 Aug 2020 08:10:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id v29sm4779180wrv.51.2020.08.21.08.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 08:10:45 -0700 (PDT)
Subject: Re: [PATCH] meson: Fix --disable-tools --enable-system builds
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200821150556.1235625-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ea6a347-6dbe-35d5-dc14-d191fa705216@redhat.com>
Date: Fri, 21 Aug 2020 17:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200821150556.1235625-1-philmd@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/20 17:05, Philippe Mathieu-Daudé wrote:
> Fixes:
> 
>  $ ../configure --disable-tools --disable-user
>  ../tests/qemu-iotests/meson.build:7:0: ERROR: Unknown variable "qemu_block_tools".
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  meson.build | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 808f50b07ef..e76f8f6d084 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1062,12 +1062,13 @@ if 'CONFIG_GUEST_AGENT' in config_host
>    subdir('qga')
>  endif
>  
> +qemu_block_tools = []
>  if have_tools
>    qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
>               dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
>    qemu_io = executable('qemu-io', files('qemu-io.c'),
>               dependencies: [block, qemuutil], install: true)
> -  qemu_block_tools = [qemu_img, qemu_io]
> +  qemu_block_tools += [qemu_img, qemu_io]
>    if targetos == 'linux' or targetos == 'sunos' or targetos.endswith('bsd')
>      qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
>                 dependencies: [block, qemuutil], install: true)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


