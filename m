Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B4FC388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8D1206A5
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSV1tUsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8D1206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbslJ-0003I9-Lg
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 17:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbsjs-0002ek-Hu
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:00:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbsjo-0000J7-Bw
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604872836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFPY0cQ/Jorg5vSPE+0tEmA6/5gFXK6WA5ifFlgle7c=;
 b=WSV1tUsRd9xmE9stLEOYdBkkN2r47z8bUFOt7n+WfDo2dOtlOqH2dbyuS4EI1inTqLNSSG
 k5DxMKNDYpJJj1SMHp/nfA6HbZPgvh43kBlXzmn3svmyUCvJvbPHOKmeEyY4vmO+chgAqq
 280ulPNZPjpI5dxV2dhmGMq6W9VkeTU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-qSyqvBF5OAakbWdt_Glz4A-1; Sun, 08 Nov 2020 17:00:35 -0500
X-MC-Unique: qSyqvBF5OAakbWdt_Glz4A-1
Received: by mail-wr1-f71.google.com with SMTP id e18so3435677wrs.23
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 14:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UFPY0cQ/Jorg5vSPE+0tEmA6/5gFXK6WA5ifFlgle7c=;
 b=jOwsV75ZSzPK/idiTDszXJszmet4UOhsbkhlyLmaaAYjREFTUq6YJZX12kXfXmKOJ1
 C8MupfzSa3CZAkaQ0zUN83awo8nn27HCe3ivye8NsKF5j+36vCE+o4YabubDnBXPfgKU
 pYNG1omllM7Vg7BI0t0PIAsO2cm6HXhJQXGxKnbVU9v/2w4BgH6gEBk43RFki6vIpsZy
 BNrfMX1+qNVqUTt+Geqdy1FRbSu1H5COcQvfTg9MxObQsCDuspiUHqiRPwtFYhl6JlsV
 DDsJNsuCvV9CabcZeXkSjN8D7sGqQPbp9wx8EkYdKRjAvNKQbIMP9RcWqdjr14215zs9
 T9Og==
X-Gm-Message-State: AOAM530a6/eIOdMV7QaK4hA2EbSmqw4F6+WeeL/TucwiOuyttmS4Qaa2
 F4w/W6hQL89I8z114pN8rRXJ4LT3ny19yxfL2wS+cAX8wPDAO3FWOIuxgOAxOOhFempOCK7/AmT
 1UO5jCp3uQdvtjsk=
X-Received: by 2002:adf:e28c:: with SMTP id v12mr14354272wri.230.1604872834068; 
 Sun, 08 Nov 2020 14:00:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWCHj3u9Mo629xUoIGpY/66HM0oeKI+oQeqzo2evblZwtdDFx/pOaWZfkqQsEOW4nOOGjTXQ==
X-Received: by 2002:adf:e28c:: with SMTP id v12mr14354238wri.230.1604872833743; 
 Sun, 08 Nov 2020 14:00:33 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id h4sm10865916wrp.52.2020.11.08.14.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 14:00:33 -0800 (PST)
Subject: Re: [PATCH-for-6.0 v4 16/17] gitlab-ci: Make some ARM 32-bit jobs
 optional
To: qemu-devel@nongnu.org
References: <20201108204535.2319870-1-philmd@redhat.com>
 <20201108204535.2319870-17-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <901a30ce-1a72-90a5-dea7-f9eab9fac7fb@redhat.com>
Date: Sun, 8 Nov 2020 23:00:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201108204535.2319870-17-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:03:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/20 9:45 PM, Philippe Mathieu-Daudé wrote:
> The armel/armhf targets have a lot in common. Instead of
> testing both user/system emulation on each target, test
> each one once. Mark the other combination optional, so
> user can still run the tests manually.
> 
> We now test system-mode emulation on armel target, and
> user-mode emulation to armhf target:
> 
> - armel-system          Yes
> - armel-user            Optional
> - armhf-system          Optional
> - armhf-user            Yes
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: qemu-arm@nongnu.org
> Cc: Laurent Vivier <laurent@vivier.eu>
> ---
>  .gitlab-ci.d/crossbuilds.yml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> index 03ebfabb3fa..e4526e98232 100644
> --- a/.gitlab-ci.d/crossbuilds.yml
> +++ b/.gitlab-ci.d/crossbuilds.yml
> @@ -32,11 +32,17 @@ cross-armel-user:
>    <<: *cross_user_build_job_definition
>    variables:
>      IMAGE: debian-armel-cross
> +  rules:

As I only want to restrict this to push events, I'll add:

       - if: '$CI_PIPELINE_SOURCE != "push"'
         when: always

So all other events (merge request, pipeline triggered via WebUI)
the job is automatically executed.

> +    - when: manual
> +      allow_failure: true
>  
>  cross-armhf-system:
>    <<: *cross_system_build_job_definition
>    variables:
>      IMAGE: debian-armhf-cross
> +  rules:
> +    - when: manual
> +      allow_failure: true

Ditto (and in the MIPS job in next patch).

>  
>  cross-armhf-user:
>    <<: *cross_user_build_job_definition
> 


