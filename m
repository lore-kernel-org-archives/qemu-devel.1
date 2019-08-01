Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB49C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87AB2080C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrqiCI3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87AB2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htD9K-0002vM-6B
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38836)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htD3V-0007dJ-GS
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htD3O-0002GS-OS
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:31:43 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htD3O-0002GF-0i
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:31:42 -0400
Received: by mail-pf1-x443.google.com with SMTP id c3so11135743pfa.13
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3HbZBeqyRkllPzWvTYPEaD8DR9NTzXXhaavBXfc1mWI=;
 b=QrqiCI3XIxJhAsjCMGW20l/Vil72/bwlGHSAGkQTMYZdJ5DIf4gFsABjEgrCDYfL8Z
 qU2n9O1JhW9+1SS4+FQmn+Kc1jSf/rEKnkzxHAZbBvA6MdNQTyWjzqT81oaAP43h6Jh3
 AXUVnNdZedJCw3B9RVx71BhDErUQZxOkXMSH/9Tl0N7cqiEqyDrZENnbTr8Pc9Yy0zP0
 L6xU5oH4IueMp5OgFq1z9M36fJxHG6bIdNQqrrzl9V0A20jbHdL3URVccev0MwVGfq+r
 xU7mGckBSiZ3ob+8oheMHjtxnOTaMH/0p27Ts58akjIjvWfwqNvf/F8SrwA7kZ1tM7Fa
 SHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3HbZBeqyRkllPzWvTYPEaD8DR9NTzXXhaavBXfc1mWI=;
 b=JSrrzMioBlu/7Tl57DoYkI4peR0OHZ6gWNy0KIeKKU3hxBtYd3i1pasxzPhb25m+OW
 LXIAbatAi5/YzI/IzxBrpsNfWonRyb+3t4nnIoe5NH5+Xvp1LJQHQdFfRTUP6hSiBAIe
 mhTk613swK+kjgPYhTvlssSjkrQY8TEhcLhb/gE893543/mOZNouOFPaCHqEuqCwlZ6N
 LXYlrr4Yu3MSyEaG/6R4BVdJqTyVBM611O8+UMLwN+LdfjbF/N1w+YJcJEH2BxJht88O
 najNNogjFdUU5yrPvnkgzuH+M/JQ5kQ9QcucVtxn6r5Rqm7niWF+nXwt4GQtTIrrv+s0
 sgcQ==
X-Gm-Message-State: APjAAAUV08bF+TLLlYoM5vArZaNvz+gjviO5EY/Z4SOdV7TN/EM4Cg7U
 qrRvelmAlS+Fc2aoOyyqKzDjjg==
X-Google-Smtp-Source: APXvYqzUC+mUMgeSsZsYrdpmX+Ft8MakbjFQsZ+95JxItIZYBxsXLxbONce9AYVjm9BPnka8Kqrf3g==
X-Received: by 2002:a17:90a:8984:: with SMTP id
 v4mr9306530pjn.133.1564673500582; 
 Thu, 01 Aug 2019 08:31:40 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m101sm4266092pjb.7.2019.08.01.08.31.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 08:31:39 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d55a5180-df5d-bf03-0bae-6aeeabb701a6@linaro.org>
Date: Thu, 1 Aug 2019 08:31:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v4 11/54] docs/devel: add plugins.rst
 design document
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
Cc: bobby.prani@gmail.com, cota@braap.org, aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> This is mostly extracted from Emilio's more verbose commit comments
> with some additional verbiage from me.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v4
>   - some rewording and tweaks
>   - made non-atomicity of inline ops more explicit
>   - expanded description of plugin unload
> ---
>  docs/devel/index.rst   |   1 +
>  docs/devel/plugins.rst | 107 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)
>  create mode 100644 docs/devel/plugins.rst

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


