Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6145C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F4D2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WeMSFRTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F4D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBuuB-0006xs-Lp
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBut6-00068S-5P
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBut5-0004FI-74
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:30:40 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBut5-0004EQ-0d
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:30:39 -0400
Received: by mail-pg1-x542.google.com with SMTP id c7so626076pgw.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/ZFCBzt3mdxUbQN7SJLjCTwX6DUCbWCRyGVoGQqSXtQ=;
 b=WeMSFRTROG5nqHDIV8MCUXTcVB47E2k/md8zOWkz5Pq9KXsZj1Rkw3DuyQCNHBvUwC
 9NHKOR2kyUw3mPujwUvQjdbodnTv1puWV5TzAxNlcDRxTiHWwRcGbUPIRF+AYfZh/P3a
 TbKWAjAXLCKLRvb/o+jk8D7GcfBwMkrvxCipe0WugMTkf7eDE/Ga//pD8GUQ6syQtWSr
 MHlrNF60bg4BXrxi4DXWacUD+yqEwREfkll8mAryYwblU1IezzO/UWQ1d+W4ytjKcRyI
 vo4Jzq8sEOi0e27sgFY062slQGAZuIuYwFtqLVcp+bICd98u92rnK+NVvLKT+aAegq7x
 /wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/ZFCBzt3mdxUbQN7SJLjCTwX6DUCbWCRyGVoGQqSXtQ=;
 b=pXENZpzMhKXS94VDvhh/H0sb3KqDeMfYZIwulq0ROVoOZdkW9kLl19RabiJJosGF8Z
 or3VJl0kYeO1P+RViE2BlDW2bq2LkxnSwY2O7wzENsHF23BuxktwLL3gUKZmFetgsJVR
 ps1mKPee+TjhyA+d/AyXqP/3N9KnwXnzxuarFSYNdORSv0QnuejdIDovB4AG8BfEMc41
 Jx2dc8j3JmmsWB6536aYypAYv98ehZJZ0Fdio8vuEbzxHvoMDsG2pCQzv+KpD9TqN0SN
 avL4uklvl3MzJMCXflnMJCK6f2tb8PQ+R/Qk9AbBlM2dDj1Zc2Z5N/Qmtc6VwozcIIqk
 71tw==
X-Gm-Message-State: ANhLgQ23FgmkXhDeeRXcOrAiuxbPMiBQ7FCN6pFHVunvWxV+CugsDjtl
 cyOFAVTeo26g1chpb4Q8VHMJTECWH64=
X-Google-Smtp-Source: ADFU+vuDLff8lSjB6Hk4bC0Od3j8n6iP6v/B3CYx1J3JkKp9Zh2Jrgn4pl2jibT9AQkOI6qpwsi+cw==
X-Received: by 2002:a63:4e01:: with SMTP id c1mr1334586pgb.435.1583908237978; 
 Tue, 10 Mar 2020 23:30:37 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z17sm1329107pff.12.2020.03.10.23.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:30:37 -0700 (PDT)
Subject: Re: [PATCH v4 16/18] Remove Texinfo related files from .gitignore and
 git.orderfile
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-17-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c0d576fb-a769-1189-99a8-0846fef4aaf4@linaro.org>
Date: Tue, 10 Mar 2020 23:30:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 8:44 AM, Peter Maydell wrote:
> We don't use Texinfo any more; we can remove the references to the
> .texi source files and the generated output files from our
> .gitignore and git.orderfile.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  .gitignore            | 15 ---------------
>  scripts/git.orderfile |  1 -
>  2 files changed, 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

