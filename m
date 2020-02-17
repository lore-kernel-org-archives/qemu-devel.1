Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85C3C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839CF20637
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdinW8eD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839CF20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3m8n-0005nX-5U
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m7i-0004QY-Rl
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m7h-0004YB-W8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:32:06 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:45293)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m7h-0004XD-FC
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:32:05 -0500
Received: by mail-pg1-x52c.google.com with SMTP id b9so9593481pgk.12
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4/dFrR5noJxLe2AFYoJ9x3Xmktzbnp3oR+dRvkZ+kcw=;
 b=QdinW8eD4EcJsP6Co6toZGDP2fHgyyLi3/+/HG4j71eb+0GKWKGo+IsKGCRNTUJYX3
 mTKMYAZAvHrztVgntcsIJAkAp0eDiUSHNjZMiLa+SfvWckk0JeoPSh6JEmuTIkM9+k8u
 W40zBinlqOESGRlb4//0UpsY2wRZz2cAzG6t/mXDThzXCNjAzcRZi3HJx8Y/kihcJKMj
 0EGPBIjLH2kt7ylxgGuO0rItb6g69x7KVd84pxIzLQQMK71ZK9C7ZRIarpBJvexnWu1z
 vnlzDTp+p0vcfPqupMHPXe0I7ClJkJlLt6DT9tbo26Xj7iOjdVVYIapJ+yUqQY4Gfjq7
 SUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4/dFrR5noJxLe2AFYoJ9x3Xmktzbnp3oR+dRvkZ+kcw=;
 b=BnTkyS3IQ9kLz4j+CkLy7IPSQ4tM/GHxcj7YK4tKz58co5ltOoPLr66cgL/kp1npXm
 mdzYpIPYfRIbSHs8HhgeayNOndopPliVt/G+buaq1BeW3FMA/YsTW1NmQ590tXMLonzm
 gpB84fpSJl2mRPAooLlsr1+W4QZiTu3HWbyaPOmjNLIpcngQTPBVNXXNQ1yzaY+mStuM
 B1a/HAudRar2KX+VzSP7rruQPBy3uHaBGUSCU733UkY1GiE+uJ5cgBym0oRzSFk7pMhB
 1M74ICZsEUgKM91jk72X21FMnwbzTUXTc62D6+/FDlD5rUPqWw40YZ7UYSn7Y6WaiSBB
 rKQw==
X-Gm-Message-State: APjAAAXq8d/yyxn2ZPMvSq7n3oBEiHBo4Rw7kLRf7Z2zPIwFJJRadZJq
 DmTqdrJ/KXBP/5DamZa8gUNbEA==
X-Google-Smtp-Source: APXvYqwllfxn4NukWFIitLEBoH5VAV6ciCdUtRBeCFzANBvgcQFanX0HpnpTl0n3+KcP1/jhJQyafQ==
X-Received: by 2002:a63:8b41:: with SMTP id j62mr18188932pge.2.1581967924286; 
 Mon, 17 Feb 2020 11:32:04 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 i27sm1617796pgn.76.2020.02.17.11.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:32:03 -0800 (PST)
Subject: Re: [PATCH v5 58/79] ppc/e500: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-59-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ba075b9d-ab58-f267-758e-0aa66888e510@linaro.org>
Date: Mon, 17 Feb 2020 11:32:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-59-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:34 AM, Igor Mammedov wrote:
> If user provided non-sense RAM size, board will complain and
> continue running with max RAM size supported.
> Also RAM is going to be allocated by generic code, so it won't be
> possible for board to fix things up for user.
> 
> Make it error message and exit to force user fix CLI,
> instead of accepting non-sense CLI values.
> 
> While at it, replace usage of global ram_size with
> machine->ram_size
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


