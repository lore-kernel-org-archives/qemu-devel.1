Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B32AC38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 18:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3B5206B6
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 18:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZIJlAPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3B5206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQEgy-0002F0-7X
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 14:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37066 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jQEfu-0001Gi-Io
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 14:28:14 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jQEft-0006aG-7K
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 14:28:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:46935)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jQEfs-0006Xy-Pn
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 14:28:12 -0400
Received: by mail-pf1-x435.google.com with SMTP id 145so1564242pfw.13
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2020 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZX6QVxCj7wdv+7Ms3OrdD/hu6nmG0qusF62bCz9dF6Y=;
 b=qZIJlAPn1TpSBlpyiCKvSebM0LBlH8FAIEs9eWUjbThPUfCJwfKeTOrCES7yJpC+yF
 e5IODNE+o6s10UlFZdgCUxiOhcpDZ3EA6N3cVjgcCgOuhdztGMfYXwOhLr4Q9dy3wCLX
 FU8Kw9DZRwNC3TjiZyZvx6Bpo5TqsT5MsDDHN3g8S+y2l5mIRzVkHbWeyjPPO0g3TQ7c
 +b82fLmSltD6VQGOUtjGtrOyGHjuaYllc7X3KgkqF+0THY6o4dEKdMifgZ6BQkFh0eJM
 tQdU3pd1w4qTqoql1k0sLLsYr5FSn5B/1DX5TsEPllYJxdxdBdor27WRGnDsyFFWmabE
 AVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZX6QVxCj7wdv+7Ms3OrdD/hu6nmG0qusF62bCz9dF6Y=;
 b=jKvBgNkcHD2lvOCpB47U3oZYKvG62XMULGz8z2e0HayFriUpH6FA77zNV6DLsoro+K
 b3fbZ/MdHHIrsrp+z63yizM3YTQfKASVjHS1jYXWMYJOKClBmZB3/aFALr3nZ9tX2AvG
 BkgU/w0j9oYA4Q+7Fa2FBmTfBVxsU4B7n4mIa7vYtEukGEnc1reIIXL9lOh983xZzy/r
 YqUp1KiM4G9nkBC2LYSqTnjXYVxixZ78XfaG1GZF1FycssLd0720Hxe66E1BgIBdtFmc
 N0/iVWXPRyapzQd2Zsdzs6daNH8Smv0EQ50g7TclML2spytl0gkbxUMntyjDSeKN8Mg/
 YJBg==
X-Gm-Message-State: AGi0PuY7+6w+D8eu/NYGg76XbTldtqYW56NA07oY8St9sAcyRRNNG0J0
 V9FAyCcsh9hQ/RiP151lVmb4AA==
X-Google-Smtp-Source: APiQypLbAfXUlG/lA71gm1APRwZISKvBT73eXdvUNdnQDG0o6i0lOuSWL2aK1/N7O6pXQyAJSrwXWA==
X-Received: by 2002:a62:fc02:: with SMTP id e2mr13209761pfh.195.1587320890832; 
 Sun, 19 Apr 2020 11:28:10 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id t188sm4591416pgc.3.2020.04.19.11.28.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Apr 2020 11:28:10 -0700 (PDT)
Subject: Re: [PATCH 0/4] target/arm: Implement last SVE2 narrowing section
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200417162231.10374-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <695f5339-9a21-ea78-f842-52169027e86f@linaro.org>
Date: Sun, 19 Apr 2020 11:28:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417162231.10374-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-detected-operating-system: by eggs1p.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::435
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/17/20 9:22 AM, Stephen Long wrote:
> Submitting patches for the section 'SVE2 integer add/subtract narrow
> high part' for early review.
> 
> Stephen Long (4):
>   target/arm: Implement SVE2 ADDHNB, ADDHNT
>   target/arm: Implement SVE2 RADDHNB, RADDHNT
>   target/arm: Implement SVE2 SUBHNB, SUBHNT
>   target/arm: Implement SVE2 RSUBHNB, RSUBHNT

Thanks.  Applied to my SVE2 branch.


r~

