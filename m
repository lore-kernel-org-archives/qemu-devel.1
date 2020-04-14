Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6032EC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 21:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3652074D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 21:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXOWOa56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3652074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOSke-0004Qt-9X
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 17:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jOSjm-0003ua-Dp
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jOSjl-0002gg-FS
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:04:54 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:32927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jOSjl-0002gT-Ak
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:04:53 -0400
Received: by mail-pg1-x52d.google.com with SMTP id d17so485031pgo.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=veAH+l2i6qe1cosWs9I0eHFIkTrMxuIn58EjU8uXJkE=;
 b=LXOWOa56CH9h3w7ANnuvTXAcZ61+GBWimUb+bWXWXVDnWuZpOsWXVHP/CMt+b5pXxW
 fuefgawlRePRH2oAiOfLdyXXoRFXsJFir0pTVTkVgvqZFtjjR8HlRnGr39f62ujepR9Z
 NhkaWbTXUSoXl3ueJ4/nYZwBFBkf4XFnP1Qr9dMap6JRfvbOckSaQXM+uqLFcnbWGV8d
 X5klzcntk71W7xUbR3OLWF/GXp2qvIahhrRUgM4coyu+r9ABnDB4H7OvF+HutMRg4i0C
 w+XtunUHAs6AKRhnd9kHMLD+8QCwDlRHV1hgPmjFMaYD5JHA7e7PJjw/6MQqi3TN2RZ1
 97cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=veAH+l2i6qe1cosWs9I0eHFIkTrMxuIn58EjU8uXJkE=;
 b=Pm09M4olYSGXQwhB1p9gv6IBH0Org2qpQXYsr0FRxydojbWvhb3Ec9OLietZ67PL8A
 ccbVypxCJNj4Rn7Pz8hhBj3B+6leFI6IgqxfENXPgVEnUdhKJQu7Kycv4hrAb6fzxrF+
 Z9S+J46XlFJgXkkTdcPkp++B7Fk3K3/n/yvZvHYDUd7CYVZebzSUOJn3vQdUzTCcgWfM
 u8Z38zkWyAjKZDMFxHDu3z7FWyWI0oJKr0hvlM5W5YcMAVna0TOgwWgsCXgNzxzu9hUh
 o1tvup8IMK8WvrlgxPJuWL0boZdT6mrEu2g+Vj/2GGabXENV83fOYt54VOcVSwwsBfB5
 /paw==
X-Gm-Message-State: AGi0PubQ/Y2+Y9ND7c4/z63NhufIiNtPpmAp+dag5TYahHQPLv8fq/5n
 5UBqGKxO2rlEjJuf1gNTw00tSg==
X-Google-Smtp-Source: APiQypLJ178kephfhiGK6AJlFB6wLfJ9uxvNmmuTn7Q4JChhxo1kWWCkfh2MKme8++f2yf4XvSr7hg==
X-Received: by 2002:a63:c34e:: with SMTP id e14mr23874366pgd.212.1586898277719; 
 Tue, 14 Apr 2020 14:04:37 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id k14sm12001020pfg.15.2020.04.14.14.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 14:04:36 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v2 1/2] gdbstub: Introduce gdb_get_float32() to
 get 32-bit float registers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200414143240.21764-1-philmd@redhat.com>
 <20200414143240.21764-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f7acef91-9e26-0a88-240e-4d64df8ee65d@linaro.org>
Date: Tue, 14 Apr 2020 14:04:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414143240.21764-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
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
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 7:32 AM, Philippe Mathieu-Daudé wrote:
> Since we now use a GByteArray, we can not use stfl_p() directly.
> Introduce the gdb_get_float32() helper to load a float32 register.
> 
> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/exec/gdbstub.h | 12 ++++++++++++
>  target/sh4/gdbstub.c   |  6 ++----
>  2 files changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

