Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C170CC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DF42051A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tfwk/su/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DF42051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDbqe-0007sM-08
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 18:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDbm1-0006Me-Oh
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDblz-0005tr-Mq
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:30:21 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDblz-0005hv-CR
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:30:19 -0400
Received: by mail-pl1-x643.google.com with SMTP id f16so7068890plj.4
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 15:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XtIKQERzsJh0JQqqzVU/bHC32eAFn0sJtdTYRMyvy0Q=;
 b=Tfwk/su/YsvjpzBkj50lo3sVvRtQaccf6GnIltpUlDNlOwYac3KdX8sSLWbigOJhKm
 SFP6q+lwucIScSSXF+J88dPBckp4FDv2PDg0I79cztcUsap2jZAXmVgr4NIMl2XVlq7N
 8r5RMeH3ZsHLG9KeiuBvVltXQTkp1Myi2qJymFRixyUEgWKmzRwAptjQlC0TDyNCE8CX
 kjgfNVG9QDVFiwdQPQlaJdqoseHm7cv+jGP0xJDnxO02K+nsMhlsJadB9xSpgftBpku/
 Kqeb2Djk9uJVUjVw4rc4cygI2afU+6RbPTGtoDi3xFoLkVBpIVQ12sQ9sgdH9oysUahk
 pXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XtIKQERzsJh0JQqqzVU/bHC32eAFn0sJtdTYRMyvy0Q=;
 b=fF3VH9vInMkrzMgNqKeTIyIQiHLRdWawY270wBbrbeqqt3BFYSculu1JzlHstiOYGm
 9WjS7wGo7jODERyqwfZRsFSKIfHSuKU3A8Ipo5mUR8F7Ts8ZpGjSZOdGy1KsvKVjpHP/
 xgVube01IYW8m4cdgGvPQ6nb3sDnWoSIyUbMWwN4D3gZzuoAzqb49yfPGWZBljmnAbJx
 e8vt8APXvgYtKExpIINfLLoySKz/d8fR05QlRuqMhRYi6k7ZxZwKDfbKIPJzggbXdKBr
 fIZW8+lxJBuM/2M6U77J5+ofMZJGI7cw0ySsZdOebp5cLtMT9Gi9OumPSniW9wsUESZB
 BCgQ==
X-Gm-Message-State: ANhLgQ2WcR/wP9EyZZMlIuAity99UzTdXUqYFjUdIZcRapi/RgBqr1fg
 fDfEkPyAIOjb2f93mWufEofS+Q==
X-Google-Smtp-Source: ADFU+vtkiP+jTDgjnbkYjAjzly1bNxb5Q3LpcUEE3wNu9PHTTl9Wy05bJ66WRBmNGhE5Q9UCyx4BYg==
X-Received: by 2002:a17:90a:1d0:: with SMTP id
 16mr3124011pjd.113.1584311417880; 
 Sun, 15 Mar 2020 15:30:17 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 p4sm4134502pfg.163.2020.03.15.15.30.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 15:30:17 -0700 (PDT)
Subject: Re: [PATCH 7/9] hw/core/qdev-properties: Extract system-mode specific
 properties
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313184607.11792-1-philmd@redhat.com>
 <20200313184607.11792-8-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <840248d9-d62a-0abc-276c-8100f1d47da4@linaro.org>
Date: Sun, 15 Mar 2020 15:30:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313184607.11792-8-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:46 AM, Philippe Mathieu-Daudé wrote:
> Move properties specific to machines into a separate file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/core/qdev-properties-system.c | 602 ++++++++++++++++++++++++++++++-
>  hw/core/qdev-properties.c        | 590 ------------------------------
>  2 files changed, 594 insertions(+), 598 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

