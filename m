Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9177EC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B57020731
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aI5hNrAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B57020731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYTDM-0007P6-HJ
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 07:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jYTC9-0006Fh-Ke
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:35:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35764
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jYTC8-000717-ID
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589283331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+BiTuuhaiRCRuygJo/UfgMumeWw31HiTY05kAioh0sw=;
 b=aI5hNrAW8dWtsg8iX64oeJ+bBnCen+LPzVDJpI6j/48p3MTV4viLvyDnxCGXfnx7f0Zjch
 zf7sMIqGfqZ8EtSUZUWV8QEsREW8lVsbo8vpLJftZ/ytxRA9V6/wC3gG/0l7SyUlFjBNly
 x52UXqYwkSth8uoPvc55swUzjzPNlls=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-_TFC3jGqNGamOm0gXK2jqA-1; Tue, 12 May 2020 07:35:29 -0400
X-MC-Unique: _TFC3jGqNGamOm0gXK2jqA-1
Received: by mail-wr1-f72.google.com with SMTP id r7so585174wrc.13
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 04:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+BiTuuhaiRCRuygJo/UfgMumeWw31HiTY05kAioh0sw=;
 b=oNvgLzFQyqXA01hGx9dECYvqrJWlo2kI9sx2rdLo41AeRLbtH49tFuICKF7BoNnPIv
 8pspnHvGX5Ex6LdUd7PmN8PZcYripoRUIdtZp/KlnjaFr9uvgV7GrblNCMZUkio6yTZm
 3U+HbDVrieBLZ9o3N+ujmnYn+NYh7dG1wCRFbGNP1oGsrpYPNlEjGqPV7uVZca97FI6r
 suXbakcZCYWe7M/buxV0gCi5HRNPjMA/vtbWvMb+KiR2gqfDwKC9jBgCsllCUzdEsSpv
 pYSGSXL6wbo9yCjkZUepJfv6C6gTQj5KbDiY8c1PrXWRBO2z90N89VqtZRUJKPcer4rs
 tblw==
X-Gm-Message-State: AGi0PuaVOwIbNplgxiWQxMgicd6tpYu+I7TJfBwchhia3I007U3LvwlJ
 W6bjXFJ7Y2yShf5TGxMJ6GQh4iKTMK8VJHz4F4HtIc7ezr0yz0c+rjWdUzRK1NOorg8Dck0y5Zz
 rF4Zk0TLsVvl5ukg=
X-Received: by 2002:a7b:c5d4:: with SMTP id n20mr38375028wmk.92.1589283328827; 
 Tue, 12 May 2020 04:35:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypIZBWCP2oEj/S8LiXheSW7eg8C7utjhj4b5hLWz7aH6Dpnc1ic28b7BJX+0qQj2+ajALvIbPA==
X-Received: by 2002:a7b:c5d4:: with SMTP id n20mr38374993wmk.92.1589283328508; 
 Tue, 12 May 2020 04:35:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4c95:a679:8cf7:9fb6?
 ([2001:b07:6468:f312:4c95:a679:8cf7:9fb6])
 by smtp.gmail.com with ESMTPSA id g184sm16877850wmg.1.2020.05.12.04.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 04:35:27 -0700 (PDT)
Subject: Re: [PATCH v4 4/6] scripts/kvm/vmxcap: Use Python 3 interpreter and
 add pseudo-main()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200512103238.7078-1-philmd@redhat.com>
 <20200512103238.7078-5-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c1a9a41-6e94-c20b-fdbd-445e260507ec@redhat.com>
Date: Tue, 12 May 2020 13:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200512103238.7078-5-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, kvm@vger.kernel.org,
 qemu-trivial@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/20 12:32, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  scripts/kvm/vmxcap | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
> index 971ed0e721..6fe66d5f57 100755
> --- a/scripts/kvm/vmxcap
> +++ b/scripts/kvm/vmxcap
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python3
>  #
>  # tool for querying VMX capabilities
>  #
> @@ -275,5 +275,6 @@ controls = [
>          ),
>      ]
>  
> -for c in controls:
> -    c.show()
> +if __name__ == '__main__':
> +    for c in controls:
> +        c.show()
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


