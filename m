Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99DEC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4A321D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 09:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgCmFqs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4A321D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVAaQ-0006aM-QH
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 05:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVAZZ-0005xW-1b
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVAZW-00081e-Oc
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 05:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603273096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a69OysY5MjEhpXr8udbVzm6utzKlJUq/IRUQWfuz5qY=;
 b=LgCmFqs0B0vJgms2+IkJ05izF2tfHV5PMbTOcojDx2XqmrqkoAG54C+33hkVH6pTze8NEc
 t7sWa6HZfBI+pIbttjPqYduj8xRhsFnJ4XvjPwvQOw2NfZPxOdaOkKpNCeHQJCxxLf3/Ye
 eVApu+e6Wh06FM45pZ2YSMOiNL+bH6M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-5aJNi9fdNoqKFAuCPWN6HA-1; Wed, 21 Oct 2020 05:38:15 -0400
X-MC-Unique: 5aJNi9fdNoqKFAuCPWN6HA-1
Received: by mail-wm1-f72.google.com with SMTP id y83so665511wmc.8
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 02:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a69OysY5MjEhpXr8udbVzm6utzKlJUq/IRUQWfuz5qY=;
 b=GxO4dXfwe7G9OZxEvkTuhOdVrINEIbB8FAsCkZZTfvnPi1pqXhfv71BScZXvAsMGLs
 xnAGgt5X3SGh+41FOlXsG7R+0z3YVOJ1737Pgag26u2C/pHpP3hP/Fr4ZKY8tEsoWpIg
 vH8jGDn32axUOTryCwA/aKGb5kYgHhw1q5ykf8maHkrZ4z5Umw7xDRfp4TIrYmwmvNBs
 h5zHz7wsdrziVADhbncceLjz94CNlflwby7747CC+C1mfeZmCBieWuKPASr25x0OnODA
 7izolh7dgea0aJRqHgk1l4JlpiquHvBHd13dhbKwzvRL0z7sHJIIgm+wIQWRaGGZM4YD
 0wAA==
X-Gm-Message-State: AOAM5309/JqPIFXc7eWaTrMTHZL2e0VDj6jcDW8LnR9VQ/F+p5fJf7+6
 evpSszN4wfFLkCwNMk1OEIXp2bjdrcCszsc5zwRbThEMHJV/UYSDh13h1AblM7wk8ZvF5P0PQrp
 2KmxmrOmVZI6Xrxw=
X-Received: by 2002:a5d:4843:: with SMTP id n3mr3667553wrs.416.1603273094038; 
 Wed, 21 Oct 2020 02:38:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5EpkTu47TfadKUaezzxf7r2TRxZF4RcCKaUb2n87TivE64FWK2yEtXaJ17ETgPJFcl+WfUg==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr3667536wrs.416.1603273093856; 
 Wed, 21 Oct 2020 02:38:13 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id z18sm2932355wrs.82.2020.10.21.02.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 02:38:13 -0700 (PDT)
Subject: Re: [PATCH] tests/docker/dockerfiles/centos: Use SDL2 instead of SDL1
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201021072308.9224-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e7ac0344-24d1-d53f-7e7f-798be452adcb@redhat.com>
Date: Wed, 21 Oct 2020 11:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021072308.9224-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 9:23 AM, Thomas Huth wrote:
> We do not support SDL1 in QEMU anymore. Use SDL2 instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/docker/dockerfiles/centos7.docker | 2 +-
>   tests/docker/dockerfiles/centos8.docker | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
> index 8b273725ee..6f11af1989 100644
> --- a/tests/docker/dockerfiles/centos7.docker
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -31,7 +31,7 @@ ENV PACKAGES \
>       perl-Test-Harness \
>       pixman-devel \
>       python3 \
> -    SDL-devel \
> +    SDL2-devel \
>       spice-glib-devel \
>       spice-server-devel \
>       tar \
> diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
> index 585dfad9be..f86931f955 100644
> --- a/tests/docker/dockerfiles/centos8.docker
> +++ b/tests/docker/dockerfiles/centos8.docker
> @@ -2,7 +2,7 @@ FROM centos:8.1.1911
>   
>   RUN dnf -y update
>   ENV PACKAGES \
> -    SDL-devel \
> +    SDL2-devel \
>       bzip2 \
>       bzip2-devel \
>       dbus-daemon \

I wonder if we are having docker image caching issues...

build-system-centos job passed but then in check-system-centos:

FAILED: libcommon.fa.p/ui_sdl2-input.c.o
ui/sdl2.h:7:10: fatal error: SDL.h: No such file or directory
  #include
           ^~~~~~~

And then in acceptance-system-centos:

./qemu-system-x86_64: error while loading shared libraries: 
libSDL2-2.0.so.0: cannot open shared object file: No such file or directory


