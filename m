Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D307C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 22:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB6120714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 22:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzcMJpo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB6120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1eO7-0001E4-W9
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 17:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1eNG-0000ma-J7
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 17:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1eNF-0006jE-Fz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 17:51:22 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:44889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1eNF-0006ij-9C
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 17:51:21 -0500
Received: by mail-pf1-x429.google.com with SMTP id y5so170365pfb.11
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 14:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Eyd8u66f7I+ePw7pjJ3s9FTs19TeRN1ce7UkQqoqgBk=;
 b=VzcMJpo5c2WHBKhkXixzdKSAv6u4Ec/DNRJVSG+nEhgM1JTBKrQkZI3fndSbBJTSF9
 vb+SVx+5JjATfCnX2vrMbB3Cdxo0H2T1/GVecdg9oO/fN+BaBJQpjSfmHP4bCDZKBTPY
 eeYO17nkWU/dJOrdJJC2SZOd0aA7fO/DhddxAsymKweDcCVJrscCmH/tHnGWbybS4rBs
 clL0iMusOVjK/3uJKItngkMK0ChEKE1dZU+84n7qut8ZDGrjbh73wC7SrB8rWiOVWKL5
 ttBw3gw/qBcQ8PUqS5xGWO9epjjVNkyuKpK3JaekbLP0RqrUngY0aRVm9ECA/mvgcrCu
 GTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Eyd8u66f7I+ePw7pjJ3s9FTs19TeRN1ce7UkQqoqgBk=;
 b=qk07sQW8PXu5OeAcvoOxh6N5zn02DK/jzUvgRruFHuq97fXc7Ak6S+tq7MbKZ1i4E6
 NksGeuImjx5IPqoAR89vQEVQbl7LJiEbsC9FqOLLYWEc3qOKZFS0WjJJJ9azypcxXsVz
 7eUKTGaR3qKseKXVbMn+8auR7l+xAZv6CDKxX4K5eWfddlK8fUP8omHU5x4+H2UKs6Hv
 q/e063C7MKHxmcM3x0CFAQo7Z8s4GeqBp+1WzhAaA0YIwsXZ8AZzNMU9Wr6lc7aVffB8
 nMj/DnTaIRCi62u7fhxs/pfHqDcrfT0DGtNz/3t601Pmn6GAJ+2U0crhmYHKttG6xcou
 r83g==
X-Gm-Message-State: APjAAAWrUNTQt1XEwW18P26AQOlS8b3kNaMpRp0oeI7JHPHxwTR6cQ4U
 R8z7Vi0MuTX7mntk/FEX2RoQug==
X-Google-Smtp-Source: APXvYqzLArNiIhzGXwIvUvPkyOCnX0BgryW2mGhqI2e2b/kS7OTXBYMZ+tPabPp3dARKeTRAxF8VqQ==
X-Received: by 2002:aa7:8618:: with SMTP id p24mr5468647pfn.3.1581461479972;
 Tue, 11 Feb 2020 14:51:19 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z30sm5776980pfq.154.2020.02.11.14.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 14:51:19 -0800 (PST)
Subject: Re: [PULL 5/5] qemu_set_log_filename: filename argument may be NULL
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200130213814.334195-1-stefanha@redhat.com>
 <20200130213814.334195-6-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <906a4b84-8f4f-fe12-3357-02d02d5dac7d@linaro.org>
Date: Tue, 11 Feb 2020 14:51:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130213814.334195-6-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::429
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salvador Fandino <salvador@qindel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 1:38 PM, Stefan Hajnoczi wrote:
> From: Salvador Fandino <salvador@qindel.com>
> 
> NULL is a valid log filename used to indicate we want to use stderr
> but qemu_set_log_filename (which is called by bsd-user/main.c) was not
> handling it correctly.
> 
> That also made redundant a couple of NULL checks in calling code which
> have been removed.
> 
> Signed-off-by: Salvador Fandino <salvador@qindel.com>
> Message-Id: <20200123193626.19956-1-salvador@qindel.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  trace/control.c |  4 +---
>  util/log.c      | 28 ++++++++++++++++------------
>  vl.c            |  5 +----
>  3 files changed, 18 insertions(+), 19 deletions(-)

This patch has broken -D <filename> for *-linux-user.
After e144a605a, all logging goes to stderr.

> +    if (filename) {
> +            char *pidstr = strstr(filename, "%");
> +            if (pidstr) {

Also, the indentation is off.


r~

