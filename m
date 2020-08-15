Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4379DC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1378323A79
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjwZCzJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1378323A79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6y6N-00027Q-9n
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6y4v-0007nk-6Z
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:26:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6y4p-0003cS-Cj
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:26:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id r2so10841008wrs.8
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 08:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uSx4PNi9NwKxcaJDCpjGPgfm27Av4fsBT+kDtIViRTA=;
 b=VjwZCzJnm0dFAs/2O51q7Yc+MKlg7ai34HdlJEPUPnzomK6tLcGU9kQ9iCWdhR4/4E
 GBaaQpkX90iLT9RoMLuptMhQWb+Y54b5EV04XBH6K8xSBjGTDRZpdivQE/CNRjPMJIyE
 MBlsz4rMrPYMtE5LVM5i4SNZVnZkmyZuI/3Q5362TlY8c/CaqgN7XxrCgOMwBxSVpst5
 1XWDHidGuDDKr8sX3OetmZZJTgzfPcWEWl1CplVweidVjOKaD78fLT+YNNPqxyz+niwu
 YkqZWSt7N6XX+eyEsH8bQxHLx9TlvTbMmOhz7y+odEjQnVFSu4KKzRb74lpZkBLVDP17
 cX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uSx4PNi9NwKxcaJDCpjGPgfm27Av4fsBT+kDtIViRTA=;
 b=D7xgESka4gqEDaDO+PKLvwUnBIDWQDr8ENtBT0Mn43jLqrGTBiWKrzvJ/aRwejlZAz
 wyEPuZY++ueu5Nqn2GiDDX3wqyxJiERzbsJqduS2Q/4R8W/kYlxmqw6n6YZt4M/Dn8J4
 pz/0RnFa5d6/R+7KSjlK4kivFsFkZKLDZVldvfYzkNm8DlxRW/HG4kGg1u0usWyMWBnt
 F7EvT6orOrInjTdAzKRwk/ms95C02vSFByaWcXsP5LTzMffqlW7iNEm+Ozg8rAZ5o6Hj
 n6eNVX45d/QRrW4HM6zI9ab6gBHLRGxoiB1oZrdF2TKueD8OBinDuj7QCbL++MIgvzFJ
 OOrw==
X-Gm-Message-State: AOAM532HriUJQPLOAM6xqN9e/G5Wm2joV5eWMCESoMt9dgYENRwrTWym
 lylDihRNq3bOalak52baoh3WlMTOCZQ=
X-Google-Smtp-Source: ABdhPJwWSbJbqC2ZtZOqBrCUTsbzNSX9rJLaGibNFFG9me9xnY1KdCSSnnZHFSib0JSOt9981v1psA==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr7806574wrp.180.1597505193691; 
 Sat, 15 Aug 2020 08:26:33 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id k204sm22136051wma.21.2020.08.15.08.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2020 08:26:33 -0700 (PDT)
Subject: Re: [PATCH] Fixes: Fallthrough warning on line 270 of
 qemu/qapi/opts-visitor.c
To: Rohit Shinde <rohit.shinde12194@gmail.com>, qemu-devel@nongnu.org
References: <20200815151148.10571-1-rohit.shinde12194@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c0d4bcdd-fec8-c9ba-44af-11e9e9fbf956@amsat.org>
Date: Sat, 15 Aug 2020 17:26:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200815151148.10571-1-rohit.shinde12194@gmail.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When you repost a patch, please add a version. This is patch v2.
Next (once you read my v1 comments) should be v3.

Watch out, v1 correctly Cc'ed the maintainers, this v2 doesn't.

On 8/15/20 5:11 PM, Rohit Shinde wrote:
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


