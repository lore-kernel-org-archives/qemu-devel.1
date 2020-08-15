Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3547FC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003B123A6C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGuPlsH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003B123A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6y8Y-0005Eg-4U
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6y6s-0003Y2-Bf
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:28:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6y6q-00042U-TS
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:28:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id r4so10813210wrx.9
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ma5FUYg4vXSJw4cuYVtDdTnkFCbiMYuHWJ5Pvghpa7w=;
 b=EGuPlsH23YSyCm69Unn6NjAmk29jVIHe1V6FCx3SIc8ZJfxiOVy5lU//u+5/YS8asY
 jgykCN6DtCKQ4ZtU0Ts7z4MMbcQpM7WbupZXJZbXVAeab2L/TPq92ylc8b03UvemrkN3
 uROmUVdDIOspJME2ObP+O2wTs22Req0Zjxv6uA9LPPAYS5i6BodOh6/cEyIKfRwbp+sK
 8SbY+lx3IP3MAC0KGgs/ivSsBVPPzshipggwrYndqEf4pRUP+niuvZdwy7kGsGIouPRw
 acZJAMipXzL1SIWmgqqnbJINCY0y6Q9+cxZsXJXvatrclZ5Olu5Our7nuSCWsNoLpsNM
 ZFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ma5FUYg4vXSJw4cuYVtDdTnkFCbiMYuHWJ5Pvghpa7w=;
 b=gTHJ5OMaKjsrUtNtUg6/SlFNymOrQKsqAKmfrCrGHyQ7IXU1+hLTnPjBZgskJBPWHc
 K+hfA3fugp7zmvfhl1E3gI+apcmMoaYAFuGZhbgTtryZ3yURWuylhy9at2TPd1XC3I43
 ZusXuXS+C20NZlI53XvjUhy7AtlNnwHioz7S5yx+RDDtxZlvyjlgC2opD3CP5gTGUKIH
 jnsf5t0CYwwSHdE9LstQ+qz0cR6z84JtT042iaGIG6Y2O3F6hsE+ivuPXij0i6RHAYCz
 Pdlr52PZyQG2+KgbhKbjQH5dJUxOzDUrc6QKbcKFCWYdwfcr49xYeqlCMGHnzDwEK7Ns
 viNQ==
X-Gm-Message-State: AOAM532MJT7XQZUtwi85/QbXIBM7IGTnLpIxICuyPF2uCDDDOj5LbxFA
 jMaCPFOvKIL4bioYT2Jv7cQ=
X-Google-Smtp-Source: ABdhPJyEZ4snArM1MQ8tRELH9NzmpICqr8SU9Ei+5Drc0w5JCFiyT2rBtdj9n8hvSvGWpbz0yMQ3Dw==
X-Received: by 2002:adf:a287:: with SMTP id s7mr7908026wra.103.1597505319701; 
 Sat, 15 Aug 2020 08:28:39 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b139sm23217742wmd.19.2020.08.15.08.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2020 08:28:39 -0700 (PDT)
Subject: Re: [PATCH] Fixes: Fallthrough warning on line 270 of
 qemu/qapi/opts-visitor.c
To: Rohit Shinde <rohit.shinde12194@gmail.com>, qemu-devel@nongnu.org
References: <20200815151245.10640-1-rohit.shinde12194@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6bf3132c-e795-2368-0c27-4124dbcda8e3@amsat.org>
Date: Sat, 15 Aug 2020 17:28:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200815151245.10640-1-rohit.shinde12194@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is v3 with no change w.r.t. v1/v2 (except this time you correctly
Cc'ed the maintainers). Maybe something is wrong in your setup?

On 8/15/20 5:12 PM, Rohit Shinde wrote:
> Added the fallthrough comment so that the compiler doesn't emit an error on compiling with the -Wimplicit-fallthrough flag.
> 
> Signed-off-by: Rohit Shinde <rohit.shinde12194@gmail.com>
> ---
>  qapi/opts-visitor.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index 7781c23a42..43cf60d3a0 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -266,6 +266,7 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
>          }
>          ov->list_mode = LM_IN_PROGRESS;
>          /* range has been completed, fall through in order to pop option */
> +        __attribute__((fallthrough));
>  
>      case LM_IN_PROGRESS: {
>          const QemuOpt *opt;
> 


