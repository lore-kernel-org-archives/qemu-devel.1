Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E38C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F642070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SA+inFQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F642070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsR10-0001Eo-4a
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 09:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsR0P-0000mx-Nw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:17:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47783
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsR0O-0000dd-5y
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594041475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCbkvK965TgWnmR8O3fuwYAnC30NDtNmRJBAhGc8Rdc=;
 b=SA+inFQQ9QWXFAZPKO2ZsZ8Q5xwBFDgSlMHqlhfsqE/QRbxyEnIw+ySZFBe2QzDVMr3yG/
 lnxjXDAENNPD3dnB1RjjmZYnZ/aL6J50pDQ1zUoKyAnDj14G9Su59+SYjWbxC2ATJ09tHI
 IGjsWm+nG+MpqhFKQBfVSamCS7IbOGk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-3hO1s62YNPOrVs26S7lA3g-1; Mon, 06 Jul 2020 09:17:53 -0400
X-MC-Unique: 3hO1s62YNPOrVs26S7lA3g-1
Received: by mail-wm1-f71.google.com with SMTP id z11so46528306wmg.5
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 06:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vCbkvK965TgWnmR8O3fuwYAnC30NDtNmRJBAhGc8Rdc=;
 b=Y8cQi7z155EOREJeytYTUvn6iNcBEnW14uV9mRctqQtPBGp4OS0kWS9lkxId5NL0ts
 pUm/eP6voUYlaSC7yhG4F+f87hEt2U75oB1yQRzIDXzbs5uJ6Np8ZVL1BXYU9rTXhYBC
 mV2cTDLJe2lEyMG9Vz+UlMnIMtNNg4lMM1f/3CxDoGdB6YnQnPTQLQDfTqJF/sJF5bpj
 27Db6vqz7P9kuMNYA/8qbryga62VQfKTaqsTy7CYwgkoOxZPq2vx5qUJYShGtR38BlTF
 jHGhO6xvqPm8eeJinS7xeI67yTtIGI+OCkMlTK0vNUSHQ7HRm8JhbyTzzWn+6TciemL3
 PoNg==
X-Gm-Message-State: AOAM533nw4gWjCzJkmkCTdejWQ4srXvqDqr2B29FxvcE0VhVPm6GESta
 /lkfGvcUUUjbYMQ4pksZs8hDT2f8OXtIOY6B35Wc3TeZeGbHPQCizFB5zigMRLXT9Z8e+1SZba/
 Pl3bpEmzLDoQ4mXg=
X-Received: by 2002:a1c:7706:: with SMTP id t6mr8265124wmi.3.1594041472726;
 Mon, 06 Jul 2020 06:17:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLbKdcwd7yyFBjtneCdGaDr/N+3V983yUqqcBXxp+kLKnp2vpqV3DPwDz1wqL0JMCNhsFhRg==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr8265111wmi.3.1594041472460;
 Mon, 06 Jul 2020 06:17:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3181:5745:c591:c33e?
 ([2001:b07:6468:f312:3181:5745:c591:c33e])
 by smtp.gmail.com with ESMTPSA id a3sm22776652wmb.7.2020.07.06.06.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 06:17:51 -0700 (PDT)
Subject: Re: [PATCH] scripts: improve message when TAP based tests fail
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200706125054.2619012-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1697f18e-7a06-86e6-d366-001b29d3c893@redhat.com>
Date: Mon, 6 Jul 2020 15:17:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200706125054.2619012-1-berrange@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 06/07/20 14:50, Daniel P. Berrangé wrote:
> If one of the qtests fails, the TAP driver prints out a message like:
> 
>   ERROR - too few tests run (expected 3, got 1)
> 
> which fails to tell you which test program failed. This is a critical
> ommission when many tests are running in parallel as their output is
> interleaved. The improved message is:
> 
>   ERROR endianness-test - too few tests run (expected 3, got 1)
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  scripts/tap-driver.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/tap-driver.pl b/scripts/tap-driver.pl
> index 6621a5cd67..b1d3880c50 100755
> --- a/scripts/tap-driver.pl
> +++ b/scripts/tap-driver.pl
> @@ -217,7 +217,7 @@ sub report ($;$)
>  
>  sub testsuite_error ($)
>  {
> -  report "ERROR", "- $_[0]";
> +  report "ERROR", "$test_name - $_[0]";
>  }
>  
>  sub handle_tap_result ($)
> 

Queued, thanks.

Paolo


