Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF3CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639D720792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLiNfJFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639D720792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjgGo-0007M1-Mn
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 05:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjgFr-0006Id-Fq
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 05:45:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35739
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjgFp-0007PT-CW
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 05:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591955139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ozsvLs5qelBHfjKOA5cneiBnDKaNpMO/sFFObBQ6CrA=;
 b=XLiNfJFPBVaX3rH+gue1hBcG3qrVK12524gyCfTg159H4aDUTt3/EXYrz4VV+vGd9lyXLp
 HCavycw3vCHmzag+qz87RTYaZT2pCTe8xLDdFwuJydWp12YsVgN2bHV47yXJ3ZNkS1sC8i
 zEAoDYX48TDGXv5Kg3bjJImjDz5BzcY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-vBtncB4LPniWJr0v-AEJ3Q-1; Fri, 12 Jun 2020 05:45:33 -0400
X-MC-Unique: vBtncB4LPniWJr0v-AEJ3Q-1
Received: by mail-wr1-f71.google.com with SMTP id j16so3667979wre.22
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 02:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ozsvLs5qelBHfjKOA5cneiBnDKaNpMO/sFFObBQ6CrA=;
 b=KNXZ9Y0npGXAoDuc4AlXse2Zxxe/uFwQPS3zJlCutaL6haeY8NiULeRn0Zt2ocp9JE
 l6TukvoXqz8A0C2iineVae6uVyJeXXq8TSpBXJoIZwF6DeyKXFnuB4UAMcxWZttgofv6
 QMYVHfG3Y51E8po2Q6h4Z8ymhAsvyuEbV1NcycDWl/SX7J/79R/JJfjxIIG2z8o9meTi
 eo7RVk3mfEN12iSkqWiUEf84RbCxNvBkhQo+GrZxVZHKAL6dwJkRfot36HOfi/6FYQZ9
 Kj/mrILRCs+yx1zXwjnBpPXWFfakJ9RukNweTUngHxXlTkbSKcKp+wf/fKEREScjA3lU
 UcJw==
X-Gm-Message-State: AOAM533BCe5HAbi6EY4wfiwPCj2X1bbYzCsLgqjwLu2WxmhZh/G0qXFg
 P0YF8+OEe/NB9HvwkxMLYCv2YtTUKYyEaYi9bkkfKjh08OTb2qinbYodyt+ZvVwKAqSGg824jgH
 8Rl+2WokW16JaEDw=
X-Received: by 2002:a1c:b703:: with SMTP id h3mr12044000wmf.81.1591955131912; 
 Fri, 12 Jun 2020 02:45:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3RggoPXO8D5hpvlqlUJUXusgBrmdvxQ8YSvCtG/KA1hzoieOF6vMD/lv5Spx4NZyOUTn8/w==
X-Received: by 2002:a1c:b703:: with SMTP id h3mr12043977wmf.81.1591955131654; 
 Fri, 12 Jun 2020 02:45:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29ed:810e:962c:aa0d?
 ([2001:b07:6468:f312:29ed:810e:962c:aa0d])
 by smtp.gmail.com with ESMTPSA id s8sm9168414wrm.96.2020.06.12.02.45.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2020 02:45:31 -0700 (PDT)
Subject: Re: [PATCH 1/1] util/getauxval: Porting to FreeBSD getauxval feature
To: David CARLIER <devnexen@gmail.com>, Laurent Vivier <laurent@vivier.eu>
References: <CA+XhMqwHSBd_TSFqipO6bn=hVSV8+Mdm3y=_i6gQoGBxRsjS0g@mail.gmail.com>
 <e7df4877-7700-ea36-ceb0-3bf84fec8df8@vivier.eu>
 <CA+XhMqxTU6PUSQBpbA9VrS1QZfqgrCAKUCtUF-x2aF=fCMTDOw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c53d8c5-1298-8017-e2ea-ff4119fae830@redhat.com>
Date: Fri, 12 Jun 2020 11:45:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+XhMqxTU6PUSQBpbA9VrS1QZfqgrCAKUCtUF-x2aF=fCMTDOw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:54:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/06/20 10:46, David CARLIER wrote:
> From d7f9d40777d1ed7c9450b0be4f957da2993dfc72 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Fri, 12 Jun 2020 09:39:17 +0100
> Subject: [PATCH] util/getauxval: Porting to FreeBSD getauxval feature
> 
> FreeBSD has a similar API for auxiliary vector.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  util/getauxval.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/util/getauxval.c b/util/getauxval.c
> index 36afdfb9e6..b124107d61 100644
> --- a/util/getauxval.c
> +++ b/util/getauxval.c
> @@ -98,6 +98,16 @@ unsigned long qemu_getauxval(unsigned long type)
>      return 0;
>  }
> 
> +#elif defined(__FreeBSD__)
> +#include <sys/auxv.h>
> +
> +unsigned long qemu_getauxval(unsigned long type)
> +{
> +    unsigned long aux = 0;
> +    elf_aux_info(type, &aux, sizeof(aux));
> +    return aux;
> +}
> +
>  #else
> 
>  unsigned long qemu_getauxval(unsigned long type)
> 

Queued, thanks.

Paolo


