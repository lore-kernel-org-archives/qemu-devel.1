Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9955BC43457
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D2C42076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSHHxra3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2C42076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRyJG-0007la-0c
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 09:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRy7V-00058B-7G
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRy7S-0008SE-1I
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602510245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qBS5Gsqxca7ckEY58GMky9P2NF9y+j97LkvL11krUPE=;
 b=YSHHxra3p31y/Mtz1WSD+juU928Ofd8tpS8qywp6+R9wDQfO9/fSZ/VyUZ3q02rToc1PYG
 Vtb6yXguhYqau2MTiZMF9n9+2CZmaqZ/xxZ5SnS63qPqKKQ4gHjofnPu31JWRfGEsu3wKw
 WePo7yU/NQMCTq8sCN44AJWqgxEE/M8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-VjzLPbFYO7ukrV8Vjw5zCg-1; Mon, 12 Oct 2020 09:44:03 -0400
X-MC-Unique: VjzLPbFYO7ukrV8Vjw5zCg-1
Received: by mail-wm1-f69.google.com with SMTP id u207so5684456wmu.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 06:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qBS5Gsqxca7ckEY58GMky9P2NF9y+j97LkvL11krUPE=;
 b=rWrvXkqRBO53lAsoFHEGichy0v7LxYIah4PMyS6ipU/xi2TksOtPv4JhFpd7LcqAe9
 r8oK2tyLqmVlu0k24duX6ORRtl9Ody+brmhpdiUUIZDyt4wo7EGophJD/W9YNejenTlX
 TMFJaF1b7rB9B7/cocAbHXHBr/1+lLsIatZ0LqOA/a+6PaP35I3QlcIpXy7DiLVGrMUx
 bhd0TLTXCVblUNpD8ENUb5yB3uC6d1kX1VUkApUKa3e4mjmzyDrh8bvSj7ePUbyosvn6
 BlvJqZuAssSoXNcKkgkgERFj4/qT7qWIw0DATvts1fY3tte+6ITuLWEz9SGP1ytSjQMu
 C5lw==
X-Gm-Message-State: AOAM531aI2gLte96hIBXyJg75o5wRnrKbje0rZdNFqBD95+2r388sMNA
 sB/xRw/qib49Ta4JYiRaPpiJ35YoEUNNFE10GQ8MOzuWULX5OdXJVdum0TfPv9ayeXv98hflfl/
 NGJ3rWSBX9p4/U6I=
X-Received: by 2002:a1c:9695:: with SMTP id
 y143mr10372983wmd.146.1602510242475; 
 Mon, 12 Oct 2020 06:44:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8NHhrt1AOhsfPmar3mhLo/Ef30NCU9outBYdPxYTGp/uoWULBZQqaurWyAWFqjOZl5RKq8Q==
X-Received: by 2002:a1c:9695:: with SMTP id
 y143mr10372963wmd.146.1602510242193; 
 Mon, 12 Oct 2020 06:44:02 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id o14sm24074153wmc.36.2020.10.12.06.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 06:44:01 -0700 (PDT)
Subject: Re: [PULL 5/7] gitlab-ci: Move edk2 and opensbi YAML files to
 .gitlab-ci.d folder
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>
References: <20200528101039.24600-1-thuth@redhat.com>
 <20200528101039.24600-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <955bad5e-51ca-5b3f-c68f-a0374fc00a43@redhat.com>
Date: Mon, 12 Oct 2020 15:44:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200528101039.24600-6-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas, Alex,

+Daniel

On 5/28/20 12:10 PM, Thomas Huth wrote:
> We have a dedicated folder for the gitlab-ci - so there is no need
> to clutter the top directory with these .yml files.
> 
> Message-Id: <20200525131823.715-5-thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml       | 0
>   .gitlab-ci-opensbi.yml => .gitlab-ci.d/opensbi.yml | 0
>   .gitlab-ci.yml                                     | 4 ++--
>   MAINTAINERS                                        | 2 +-
>   4 files changed, 3 insertions(+), 3 deletions(-)
>   rename .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml (100%)
>   rename .gitlab-ci-opensbi.yml => .gitlab-ci.d/opensbi.yml (100%)
> 
> diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci.d/edk2.yml
> similarity index 100%
> rename from .gitlab-ci-edk2.yml
> rename to .gitlab-ci.d/edk2.yml
> diff --git a/.gitlab-ci-opensbi.yml b/.gitlab-ci.d/opensbi.yml
> similarity index 100%
> rename from .gitlab-ci-opensbi.yml
> rename to .gitlab-ci.d/opensbi.yml
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index bc6aee6aba..5208d93ff8 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,6 +1,6 @@
>   include:
> -  - local: '/.gitlab-ci-edk2.yml'
> -  - local: '/.gitlab-ci-opensbi.yml'
> +  - local: '/.gitlab-ci.d/edk2.yml'
> +  - local: '/.gitlab-ci.d/opensbi.yml'

It seems these jobs are now always run, the "rules:changes"
to restrict them is ignored.

I searched a bit and found a plausible explanation here:
https://docs.gitlab.com/ee/ci/yaml/#onlychangesexceptchanges

"Caution: In pipelines with sources other than the three above changes 
can’t determine if a given file is new or old and always returns true. 
This includes pipelines triggered by pushing new tags. Configuring jobs 
to use only: changes with other only: refs keywords is possible, but not 
recommended."

I don't understand what they mean by "three", is a directory considered
a three? Then that would explain the change.

Regards,

Phil.


