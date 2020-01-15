Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DD4C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8132081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qs1gw+cR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8132081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irrM9-00045T-0Z
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 17:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irrKk-000306-I1
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irrKj-0000r9-DY
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:40:18 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:40730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irrKj-0000oa-5F
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:40:17 -0500
Received: by mail-pg1-x52c.google.com with SMTP id k25so8873227pgt.7
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 14:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rUKxely0jB5mCwPXbWuNTZPyd3SSVMnADY3Cx3KuDYY=;
 b=qs1gw+cR1YdX0tXV+r/13bvUaiNtMxgd2AAOJ4cjgJ4ZCGJ6V64Sz5PKfUy8SxdbSU
 IWDS6+7Ka3gQxqJNdi4zsw9a9SQZ1oH8nlMtn0IAfSlWZSnzd2sAKFdqxvroavxd68lK
 LXJaw9ZTtUcvqehRcBltJVnMWWysdSxQVEzpz1vUPm6UiMQ4p7n0ZnZnhoTtzOWpWS4B
 6l96igMl6YJAta5XhZsJ2f8W96/jFewsujLp7w/2hHSJ/BNT7yrzWRmASzdUnw4JMOQ+
 JfJGCJQUEMzjRoV2SKmRHDHF/IXHcam7aK1JeI0ND1zzHLokd+F/8lt7tHUBkxEcBhLT
 s5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rUKxely0jB5mCwPXbWuNTZPyd3SSVMnADY3Cx3KuDYY=;
 b=ae/WOicFcNurNODPWaq3cBhJXULvyRclVKXPUv+4zuHQ4kwOWSrqFsv5WhDJutifqE
 VUuqxbh27TN6n1J7mS/DA+2PCX02qoABM90C7ugxVMrqaxxnkfYiYp+wUKmlOsv/3jf3
 K8OsoqRwupil327BS5aaJPn/IQCoto+YvzK06JcywjQaxfMLwJJZPzklenZPGPtvSoyr
 QBEkKUYTunK0rucgCzZG1YCDJjAxYavb40IHEsKExXDrKCRcT2bdbTUZeW2zh+ygEKUl
 BGRpEWYSNTUzmpK+nL1dP75zFlO75eLzxQ/f+JD2nme4VBmJLxNMdyF8eW8sUfQK37nT
 kY9Q==
X-Gm-Message-State: APjAAAXqCh3JbuR/gWyfzV/J8VGkL8SHE0IeJYRf6LEyVSIdkbkyGVVH
 b9V7Dej6Kr4qYcAykOB7uHdFl64dk3k=
X-Google-Smtp-Source: APXvYqzRUfizG3sfOmSH+PvsyvJYbrnq/YuPWmCC9knk/sYJdk4GiUf+ZhJwHCvRnA3awFSqf150hQ==
X-Received: by 2002:a63:2cc8:: with SMTP id
 s191mr35431686pgs.206.1579128015872; 
 Wed, 15 Jan 2020 14:40:15 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id d2sm827381pjv.18.2020.01.15.14.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 14:40:14 -0800 (PST)
Subject: Re: [PATCH v5 17/22] tests/guest-debug: add a simple test runner
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ee254519-7a8f-aeeb-4c55-07c7dfdab109@linaro.org>
Date: Wed, 15 Jan 2020 12:40:10 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114150953.27659-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52c
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

On 1/14/20 5:09 AM, Alex Bennée wrote:
> +    gdb_cmd = "%s %s -ex 'target remote localhost:1234' -x %s" % (args.gdb, args.binary, args.test)

It'd be nice to wrap this line.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

