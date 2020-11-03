Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A83C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9418720E65
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5vAoDah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9418720E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzlu-00053w-JI
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZzhQ-0007bo-U1
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZzhO-00009g-Cd
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604422941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZirkYn6OYEdD5xiBiYgunRG1WhAcuG/3HyKICFCBH24=;
 b=b5vAoDahcGC0egxP5XVqyTjFKWMYkTyGrtLjPx3nWSexqA+KvG4fD66LYzgvBWc5XsdT67
 ax89ZE7CE5UZKIjyd5D2FZLyaJckIotjtnf7DGCGna4MVBv/eQo2ByVrzTjvyNJvZOroN+
 NpK0gHzMkYtTIYCipJ8T4T0YIjFOd5E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-IavYXMb6PnaW-fecyIED0Q-1; Tue, 03 Nov 2020 12:02:19 -0500
X-MC-Unique: IavYXMb6PnaW-fecyIED0Q-1
Received: by mail-wm1-f69.google.com with SMTP id b68so5405wme.5
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 09:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZirkYn6OYEdD5xiBiYgunRG1WhAcuG/3HyKICFCBH24=;
 b=gCG9NQD+Z5s0bgNsFIZFUQSHrgjiqWGcJt7jOsLCj4EV8Wx8bxvEXZCO+FpDTUR7+K
 XUfZsnGrUhpQYHEw//P43FWDOYAsyRK1qEfk0kfRGCePkLHExTHGLa3Dk0SDd1E5Kwsx
 E4f9PLbwgZvEVJDdhxy/aCUccVe3AAC09pGjLtt/3Z+LMKavAfBZexthz3hqml7FPlV0
 0Q/06Ejk1HkAXL9qUJK0vHc8Po6UII0sTeBA4NcXt42CKB3KqTvrF6ACucpYoqQ+4TgP
 lwqCHoZ8CAXd5+gXL9PwMGnNd08p0oZTr69JhDy/clLLmdsdqIBKFKxcm2DkXEN9JUo9
 KB4w==
X-Gm-Message-State: AOAM532VlrpvcfUeF/SOar+Bc1D9mdjM5nB6YryeGpW8fhPVIGM/mvv7
 630TzDFG6VrSbOM+dJa9A1iphroj4Mj4JLhU1hTDF9hD5AYsRFdehSRJM85jKXA4gEpxGNEFUPb
 pfP8PQSxAAZw7UPw=
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr66097wma.93.1604422938680;
 Tue, 03 Nov 2020 09:02:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5XLNvctvfWkAd3WsDDvIiUuDkbPC+K6UVrjBTeztRX1KRVkN7ePEdrzm39PQMzj7WKL/3og==
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr66080wma.93.1604422938524;
 Tue, 03 Nov 2020 09:02:18 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id 130sm3890356wmd.18.2020.11.03.09.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 09:02:17 -0800 (PST)
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
To: qemu-devel@nongnu.org
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <19bbb3e3-3951-579c-ac91-4e7283e8e8bd@redhat.com>
Date: Tue, 3 Nov 2020 18:02:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103164604.2692357-3-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 5:46 PM, Philippe Mathieu-Daudé wrote:
> We test './configure --without-default-devices' since commit
> 20885b5b169 (".travis.yml: test that no-default-device builds
> do not regress") in Travis-CI.
> 
> As we prefer to use GitLab-CI, add the equivalent job there.
> 
> One minor difference: the GitLab Ubuntu docker image has the
> Xen devel packages installed. As it is automatically selected,
> we need to disable it with the --disable-xen option, else the
> build fails:
> 
>   /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in function `xen_be_register_common':
>   hw/xen/xen-legacy-backend.c:754: undefined reference to `xen_9pfs_ops'
>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undefined reference to `local_ops'
>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): undefined reference to `synth_ops'
>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): undefined reference to `proxy_ops'
>   collect2: error: ld returned 1 exit status
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  .gitlab-ci.yml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 3b15ae5c302..6ee098ec53c 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -262,6 +262,17 @@ build-user-plugins:
>      MAKE_CHECK_ARGS: check-tcg
>    timeout: 1h 30m
>  
> +build-system-ubuntu-without-default-devices:
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: ubuntu2004
> +    CONFIGURE_ARGS: --without-default-devices --disable-user --disable-xen --disable-tools --disable-docs
> +    MAKE_CHECK_ARGS: check-build

The part below is pointless, as no job consume these artifacts.
I'll remove it in the next iteration.

> +  artifacts:
> +    expire_in: 2 days
> +    paths:
> +      - build
> +
>  build-clang:
>    <<: *native_build_job_definition
>    variables:
> 


