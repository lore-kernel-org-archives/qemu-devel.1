Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951DDC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51BE020709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5cMRfkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BE020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWD3-0000jf-E3
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDWBy-0007e9-97
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDWBw-0000eT-9u
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599066295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NROyPkG/KPZUMSlzJD4HiWi4nfM5oy8edIY1njV4oLU=;
 b=R5cMRfknZKDnQc/CrTHU6e0GrR37qYXfoeqMekcG7uBugQBW4OKLRSHOPCqfpdLNIDCJZT
 pz8w2C3BQfWch5VL7UCPBYzmGOg9kbjiMFohTVlnJQkKv4DHTPCL4dWAIjykb0WBO3Zl95
 CzkxrA5/IBKebKYmHYr/a4YHxYHay7I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-8iFGiFhvOrq88TamVrGlQQ-1; Wed, 02 Sep 2020 13:04:54 -0400
X-MC-Unique: 8iFGiFhvOrq88TamVrGlQQ-1
Received: by mail-wm1-f72.google.com with SMTP id l26so1962407wmg.7
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NROyPkG/KPZUMSlzJD4HiWi4nfM5oy8edIY1njV4oLU=;
 b=TAwICqRzA/L0cnX7Bs8JPNMXFfnsT5jcgtBKgumY2LpmFu3gmS6+mbJHhCTEnEBE4c
 JFcbBHvtaeWuDb4az1BOfjpuuibSzPb2zurez+S5tuec0R+vGlCwztSJaAWVXDZyBgHn
 Xm+3KRdcQjKQxAYcw1F3Sg9eRfe50nMtbM5/EEmHIuTZtvCyzgQJ8KKyNjkxxSLMJY/W
 jMc5qiW2G+xjCkeJCwxf9mIfMRY2IzFJy1sU5k43dULPTuf/vMfM+SkmIza9ow/aY//4
 z0+NbEyCuKEmg0+C7N6ibEE9NpDH7IB+MKTO3elLNWxV1YJAHyU91BdGQyfGSypJWJZd
 d2wg==
X-Gm-Message-State: AOAM5320Z3sGFYjt5QifedEKfgV9iYs1rsNLL89qlx9MWGNs3QrePCAp
 B/pIzyAFmJJ07Jq1xYYuUc4Qc8QaRTs1WEVhw4osZcr+EJO4vC/+Ul7EcNZRo0Qm+FXObQroB3a
 uvW2+wgmSAE3JaCE=
X-Received: by 2002:a7b:c769:: with SMTP id x9mr1678628wmk.65.1599066292626;
 Wed, 02 Sep 2020 10:04:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXZF9WrdFEeEf5Go+QbxUVITBoolCYhJipu9b3K+WzzKkSpc1v6+1NVcPmjp5Zlpgg/Z8ZNg==
X-Received: by 2002:a7b:c769:: with SMTP id x9mr1678614wmk.65.1599066292310;
 Wed, 02 Sep 2020 10:04:52 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id k184sm426146wme.1.2020.09.02.10.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 10:04:51 -0700 (PDT)
Subject: Re: [PATCH 5/6] tests: handling signal on win32 properly
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-6-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <26c3fe4a-009e-dfa2-f824-515f470924b1@redhat.com>
Date: Wed, 2 Sep 2020 19:04:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902170054.810-6-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 19:00, Yonggang Luo wrote:
> SIGABRT should use signal(SIGABRT, sigabrt_handler) to handle on win32
> 
> The error:
> E:/CI-Cor-Ready/xemu/qemu.org/tests/test-replication.c:559:33: error: invalid use of undefined type 'struct sigaction'
>   559 |     sigact = (struct sigaction) {
>       |                                 ^
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/test-replication.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/test-replication.c b/tests/test-replication.c
> index e0b03dafc2..9ab3666a90 100644
> --- a/tests/test-replication.c
> +++ b/tests/test-replication.c
> @@ -554,6 +554,9 @@ static void sigabrt_handler(int signo)
>  
>  static void setup_sigabrt_handler(void)
>  {
> +#ifdef _WIN32
> +    signal(SIGABRT, sigabrt_handler);
> +#else
>      struct sigaction sigact;
>  
>      sigact = (struct sigaction) {
> @@ -562,6 +565,7 @@ static void setup_sigabrt_handler(void)
>      };
>      sigemptyset(&sigact.sa_mask);
>      sigaction(SIGABRT, &sigact, NULL);
> +#endif
>  }
>  
>  int main(int argc, char **argv)
> 

This is already fixed by a patch from Thomas.

Paolo


