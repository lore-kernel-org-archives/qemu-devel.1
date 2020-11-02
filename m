Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EC2C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDB22231B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWpl8Pbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDB22231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZaFP-0008C3-UT
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 08:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZaE8-0007FL-1n
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:50:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZaE6-0002UT-Dw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604325025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jw0+CBPAnUFXUtR/+eyBdRbfmPn9YExYA6RAcEY9adg=;
 b=PWpl8PblxG9Y1rBkWTbpnIDNpIILiNscreEwPLmq3WGOt/e5GBvcULnqx9j+mfpdR0ZD92
 LWyV/MpdKi1uDXyy6Oy6U+8nDrJATlZm6miq6NVkhy2VkfYwG/5qUQXmCf+8yhLxljARUE
 q1y6cj99+rMVeWSR0j9SCaEGDK6Cpew=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-2SIJOeICMFeikXCYluv1RA-1; Mon, 02 Nov 2020 08:50:22 -0500
X-MC-Unique: 2SIJOeICMFeikXCYluv1RA-1
Received: by mail-wr1-f69.google.com with SMTP id j13so6502840wrn.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 05:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jw0+CBPAnUFXUtR/+eyBdRbfmPn9YExYA6RAcEY9adg=;
 b=FiTmcFwNIY29l8pE/1CaX5ccZuISgEv7ZnWyP0R7Swrxi7nxhyvTTK5kWvdozHkxia
 vGKeIJKmecTg/gJTwjBJipR3VpdkonSxEYBRxCN6bYr5DSdQ+vCOQ7A6Q9gWXMhIXHVq
 TOXLVCynnPb+YJ4d7l6zh4yyBydYOOCr9YG8qtI+72068QwMtNtrQMwXk/QjJYHjfehy
 sKQfi06rS/UWD927WBFFtemEMp0Ne5UC1+VDycj4EGpPEpTONCZgaGft5NQ/dBaJ2bqy
 YhlJNyZCxTjiEzw4ZDRAE879vSTrExUVtsiN9idiUwJDqpgoXM/t8dzBuK9hdt9KXg92
 feMA==
X-Gm-Message-State: AOAM531YxN3RPoWjwUEPxZMLkcU3+f2ma6jZFHnxRHwzD7B9dPECB1XW
 t0FCi/1uB7bQSu58Wt91q/jV2ISewGYCfheir716PxEefsC7YX2ovzs3d8O3A5Te+LZw+OWfPtf
 RlYJ+C6/MWghHTvo=
X-Received: by 2002:adf:f10e:: with SMTP id r14mr19514573wro.337.1604325021359; 
 Mon, 02 Nov 2020 05:50:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydrm4UUGARKO42ulBUC96W6nfbS10vliU08yxOirwMIGJaWkwnpyGwceaRLFzeWbkZyV6GoA==
X-Received: by 2002:adf:f10e:: with SMTP id r14mr19514560wro.337.1604325021203; 
 Mon, 02 Nov 2020 05:50:21 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f2sm21853063wre.63.2020.11.02.05.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 05:50:20 -0800 (PST)
Subject: Re: [PATCH 1/4] gitlab: publish the docs built during CI
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201102130926.161183-1-berrange@redhat.com>
 <20201102130926.161183-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e496d701-c943-6bac-073b-97a9bb7567f0@redhat.com>
Date: Mon, 2 Nov 2020 14:50:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102130926.161183-2-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:09 PM, Daniel P. Berrangé wrote:
> Most of the build jobs will create the sphinx documentation. If we
> expose this as an artifact of a "pages" job in a "public" directory, it
> will get published using GitLab Pages. This means a user can push a
> branch with docs changes to GitLab and view the results at
> 
>   https://yourusername.gitlab.io/qemu/

Do we want that only for forks or also for the main repo?

For the main repo we need to keep older releases archived
but accessible.

> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.yml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 3b15ae5c30..a41725d6f7 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -423,3 +423,17 @@ check-dco:
>        - $CI_PROJECT_NAMESPACE == 'qemu-project' && $CI_COMMIT_BRANCH == 'master'
>    variables:
>      GIT_DEPTH: 1000
> +
> +pages:
> +  image: $CI_REGISTRY_IMAGE/qemu/ubuntu2004:latest
> +  stage: test
> +  needs:
> +    - job: build-system-ubuntu
> +      artifacts: true
> +  script:
> +    - mkdir public

I'd rather use public/$CI_COMMIT_BRANCH, that way we can
diff between 2 versions.

What about adding a manual job to clean public/$CI_COMMIT_BRANCH?
(depending on push-pages success).

> +    - mv build/docs/index.html public/
> +    - for i in devel interop specs system tools user ; do mv build/docs/$i public/ ; done
> +  artifacts:
> +    paths:
> +      - public
> 


