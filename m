Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5751C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE9320663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aw6b4Wf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE9320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuxy-0000mE-Jp
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuuR-0002j7-2h
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuuP-0007MM-Rm
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:56:18 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:34975)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDuuP-0007HJ-KV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:56:17 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mq3so9186941pjb.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Z0Mfj9/7R94RJlMQNj7AyIsYbkmBW+29a4buXrrjXRQ=;
 b=aw6b4Wf+WOuyRybaz8Hbq2MR422NhF1FqI2l4OrqRWVOgfbTgeWZntjk5QX5g8XFCx
 avkZ+87xHV/KtazV9ciWYgx2/9nmk23sbjojb4GhO2v6OYOcv6XUDhLmHenTBf1HJrY1
 HRu+vCwmkl0biMDlztTplbAJuxymqA+j+84OQ1CpkZ79OM1LxIzUHKKjawpZ2yAW7pvb
 Yna6NPKDgim64Ww39IHx8w0F/uGswM9KeOZyel8eZYowanXbzjn3MkEtFL3yhAIVCmmh
 WNpSeH8tOQ8zGj/tsc3vmjJTFdF2S3GP8N6ViSHWIhbvDBj3Q2De3Mr/tblg6IIbiXSr
 6i7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z0Mfj9/7R94RJlMQNj7AyIsYbkmBW+29a4buXrrjXRQ=;
 b=ij9+oy3krdZqTdO5smCWsUI5vJG8qe3bH9TALdD9kP/byJE04WRW61mVSf7Cf7VkMk
 CrTeIWSEhfATi8/xvAV0zLIaPGj/iEeayLd5yPZN0jXOgDjqbq03YgtmqChlYjGHlCis
 GfXCN4WKE/hBjW1KmcyZ6ziB0wa4r80iruo1HYxceidx4l/tAC2SrGdsFuwXCIY5O/xA
 3jy0WysYq1+QwJiY62G/KTY0L4hIM925rGIQZqYA6Rw6aB860pgUfkXZLq8u2fhk0xxB
 yDkvUYnTa7pbCFWesz8i18B0gh1Lv6OlyKFLLDLx6SHWKZu6LmNMFlCBrH1c7mnd6jOV
 YR/A==
X-Gm-Message-State: ANhLgQ0QSUk7+/HrZPuFpIwAgqFPBDrLXLclMdJXjQJizZ/Iti4mJXCy
 ulAB8OuSDQLdcQCHrdy8CkIrdQ==
X-Google-Smtp-Source: ADFU+vvjaXKa/eXbYjRAvM+YMD6OhcaaxIUCBTuFZf9ybv6H0sMV6f2YVMMQkboS24hx2B7i5lUKOw==
X-Received: by 2002:a17:902:d909:: with SMTP id
 c9mr534859plz.228.1584384976278; 
 Mon, 16 Mar 2020 11:56:16 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 gc16sm514163pjb.8.2020.03.16.11.56.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 11:56:15 -0700 (PDT)
Subject: Re: [PATCH v2 8/9] hw/core: Add qdev stub for user-mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316001111.31004-1-philmd@redhat.com>
 <20200316001111.31004-9-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fc93f85a-6f55-a793-a311-04e00afac65f@linaro.org>
Date: Mon, 16 Mar 2020 11:56:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316001111.31004-9-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 5:11 PM, Philippe Mathieu-Daudé wrote:
> While user-mode does not use peripherals (devices), it uses a
> CPU which is a device.
> In the next commit we will reduce the QAPI generated code for
> user-mode. Since qdev.c calls qapi_event_send_device_deleted(),
> let's add a stub for it.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: use common-obj-$(CONFIG_ALL) (Paolo)
> ---
>  hw/core/qdev-stubs.c  | 20 ++++++++++++++++++++
>  hw/core/Makefile.objs |  3 +++
>  2 files changed, 23 insertions(+)
>  create mode 100644 hw/core/qdev-stubs.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


