Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A827EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76EAF215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrMdf56n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EAF215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Bfd-0005kJ-6C
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BFs-0002Jq-NX
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BFn-0008W1-VQ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:02:04 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BFn-0008VU-OF
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:01:59 -0400
Received: by mail-pg1-x543.google.com with SMTP id u17so9383680pgi.6
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SJGTeZae2hswjIgZLpujzH5TpXpJTXB+oKJPPXtp5Uw=;
 b=LrMdf56nfe8vjGpq2vPjJI0+HtO6Cqohy89QIPG814wEBb84tIdzwbfXSPCpeq2ukC
 96lMaiAoGNXucAl+2mqI4I7zK3vNT1f95VSnX3swJ71Hrqr9bbTqCT4LIBJJrqRkB3MF
 670SjEj5Q+PwTQL7LhIN+rX4ClEHKaaAFm+z0Uy0Y4SqmcMRq/PM3L5qGaJEYbAA2jrm
 sVbIUqcX7OFbF7xq72Ym22n1VZm9697f3oVOW/kQvlxkDEnddORRVdFTGSoXU1DPSPBK
 2bAwJbsLvdMSLKDhBFI/HBiijOTivW0kPqOVoHZa9ZZFV3eOr+j46a6cSEvQpMDwHPQI
 EcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SJGTeZae2hswjIgZLpujzH5TpXpJTXB+oKJPPXtp5Uw=;
 b=WLvKY3XRB/COvvKQW2j7ufQO12ZVDwBiC+yxWtmAVGntFmOYoCujnRqlbF9/8RZxTW
 XUm3mkxn/t7j05qKSwXtzVM2MQTLI54Lohha8ijnf/WFiNjATxmqo1LLQLJBBj8KsdBn
 F9gQ5LJ3mBUz3ynUlfDml0u+FJSM93kCNIXN515kBL9NVxeQuZjJgjTb+EL+bEgvJcM3
 Aoq/x01Uqb6BM1nOuHw8aiBlAyWERuia3HbNmVXK/ilaCsUEqh8KUTCtNJSaOp44Zwk0
 CRa7AWSPpsiwoY8ftTIzs8NTBf2wgV4mRV0SJ6jddYaUcx0aieStjJ0CmhY+cJ9qBl6K
 IQ9A==
X-Gm-Message-State: APjAAAUvYtaWMlNPn2l0RMYjXQIDz5IyY7kUPcyd1M1uivqWwADM+310
 BJDQQZQpwykuIA1kZvcg/8aKig==
X-Google-Smtp-Source: APXvYqxUORW2QKxQiPdwTEWIUeGI/vKznHuvyjt+yX/kEbW4l7BQZJK33ahyxo45Bjhkp6uaIJXj9Q==
X-Received: by 2002:a63:4c46:: with SMTP id m6mr32064094pgl.59.1567526518187; 
 Tue, 03 Sep 2019 09:01:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a18sm21928397pfn.156.2019.09.03.09.01.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Sep 2019 09:01:57 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190903154810.27365-1-thuth@redhat.com>
 <20190903154810.27365-2-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <69233989-78d6-716f-210a-0372fd4881a0@linaro.org>
Date: Tue, 3 Sep 2019 09:01:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903154810.27365-2-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] target/arm: Make cpu_register()
 and set_feature() available for other files
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/19 8:48 AM, Thomas Huth wrote:
> Move the common set_feature() and unset_feature() functions from cpu.c and
> cpu64.c to cpu.h, and make cpu_register() (renamed to arm_cpu_register())
> available from there, too, so we can register CPUs also from other files
> in the future.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/arm/cpu.c   | 20 ++------------------
>  target/arm/cpu.h   | 18 ++++++++++++++++++
>  target/arm/cpu64.c | 16 ----------------
>  3 files changed, 20 insertions(+), 34 deletions(-)

internals.h would be better, since presumably the uses will not leave target/arm/.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

