Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3312C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A3020731
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/D/xOqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A3020731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjPn-00065f-7I
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 09:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGjLA-0001QR-Ow
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:43:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25885
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGjL9-0003DI-4k
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599831826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPRQEAguP9ZNLQqmtIG+Dfw3EoY53yGQQwlV0FI12Io=;
 b=H/D/xOqPoKQh0wMsSL5aDFMTN7stgQy9wplZd8XvQhaipgf7NZwASpGWhwV2mTcbzkI7xx
 kHq2vhNrbddChGTADJXovXSbM0pa0AtIqFM4iwEU0QH9KyD6l4QTu+BE8OF7rSX3OYTGF/
 0XZHbNBi3YkAsP2G3RKBD2zjmvqFvyw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-rNP7Df3SPzOqOCXXttQYGw-1; Fri, 11 Sep 2020 09:43:44 -0400
X-MC-Unique: rNP7Df3SPzOqOCXXttQYGw-1
Received: by mail-ej1-f72.google.com with SMTP id d8so4697878ejt.14
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 06:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kPRQEAguP9ZNLQqmtIG+Dfw3EoY53yGQQwlV0FI12Io=;
 b=qGIEu7KVg1KDl5xz7KTsgWpm9fH6MZDjvucr8qWJn46MGP1VanIxsVjKHg48OAn8FW
 J9BDX6q3lfFaz+ehzg0vb2ozi2pbrkvkY4ucXOj5mcVrcxDEteo6x9T7ic1ZHBEhcce7
 Bre4Nm2+kbd79xRUo/lWsmGN0cPF4dl1CxLP6dM79xFTlHrHQTu7fXGa4N2ktO4bzC3y
 1bv/isCpOj/6fdXz/zsdAOmHBo/dhrFYJEeGOc+JRRiAUCOoszdQWNriYUZMo8/gphFP
 +VhfpxYdGVzLTI3VCNyTu66in3HuFwxZzmMmkMYZ1c0qtEVG0IyskIEvEenG4rcwiKeC
 Ih1Q==
X-Gm-Message-State: AOAM533IvXvL9hFwcMmKyZXa7KLhLQ18c22MpiSG2LR4qj8xyMO2Ssdf
 2QEUagzFsN6CNMOmHaVq8tnZzwfqv/ZO+3LF59BiUj6oYdqS/ElekLCmY1mtSowW+tZT7VbZCj8
 4Gix3DBHnAxKgfoE=
X-Received: by 2002:a17:906:480a:: with SMTP id
 w10mr2092823ejq.372.1599831823408; 
 Fri, 11 Sep 2020 06:43:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6IoIXDjnjWN+BJj1NB5vpXkR1M/FnTlpPoaOj2W9DHz9nFAzWBwP7+3tqYw+H1QWEoLuxeQ==
X-Received: by 2002:a17:906:480a:: with SMTP id
 w10mr2092802ejq.372.1599831823192; 
 Fri, 11 Sep 2020 06:43:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5568:7f99:4893:a5b6?
 ([2001:b07:6468:f312:5568:7f99:4893:a5b6])
 by smtp.gmail.com with ESMTPSA id gh21sm1630169ejb.32.2020.09.11.06.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 06:43:42 -0700 (PDT)
Subject: Re: [PATCH] target/i386/kvm: Add missing fallthrough comment
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200911125301.413081-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db773405-e9da-e98b-8da5-d13fef8b596b@redhat.com>
Date: Fri, 11 Sep 2020 15:43:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911125301.413081-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 00:33:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/09/20 14:53, Thomas Huth wrote:
> Let's make this file compilable with -Werror=implicit-fallthrough :
> Looking at the code, it seems like the fallthrough is intended here,
> so we should add the corresponding "/* fallthrough */" comment here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/i386/kvm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 205b68bc0c..283d3305d5 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1568,6 +1568,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>              if (env->nr_dies < 2) {
>                  break;
>              }
> +            /* fallthrough */
>          case 4:
>          case 0xb:
>          case 0xd:
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


