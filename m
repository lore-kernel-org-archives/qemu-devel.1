Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF280C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 00:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5CC206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 00:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clJQC5+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5CC206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIMbI-0002mi-Ge
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 20:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIMZx-00024U-Hi
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 20:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIMZw-0003ed-IZ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 20:45:17 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:44394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIMZw-0003eS-D8
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 20:45:16 -0400
Received: by mail-yw1-xc41.google.com with SMTP id m13so1513166ywa.11
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 17:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EqF5wQy3S5cpOWsddpe39MMWz/IJTIVyMBKbLO/w7lw=;
 b=clJQC5+MNe/c3hIlHkDRaBkzCXl6zB3VtJS58pNnw6691LBsFJp83NivXpcvbB0NT0
 SwfpRZoXAfTNXzRljGdSVjqYudbMpwhDRWPV8mGIxZ263GPw7TzKMNP2EA7bwb42k+OE
 0mGGkq/eAL/GZDqxCM27mm5u3efWzo/Kq9siS1PbrLA6hZnYLz+/dsO+FkS1ImLt/Uxt
 RqaP/audbgQy4HIS5pZkb45jvjmSadecFv+RkuAaEJ7sGScEjnO4YQWf3TClyGezbkt8
 G17+/GLPdFHNqVmO8GhiY78ShkAF5mARsR5xyzgEX6So9ylAeJGL/MSQKN01B3XNvX4P
 ng/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EqF5wQy3S5cpOWsddpe39MMWz/IJTIVyMBKbLO/w7lw=;
 b=H3z+IsngaBWrVAPCxODeH8Uq+NZJuVbQaTSRZTfpZmzeisGvFOnzVU4SKjvPlgQZYI
 njbfFBxUEoDW6UMSYwMp1pZLkisqHRXPE38huQY8rll5DM7JX/UJUtbB34+aKAcdKYzt
 m3lheiIJLe0p5d8fFM94ERYWDIM9CHN5riwU9F5Xprhg833RrjJxzYwOPtXros/XnBil
 oZ+4+AeRB9UeHeoc/NOpGnsFQNZibwyh7nPtmjuyfblY9gBdaQxsrsjOqAofOsS3etEZ
 /DcqM0oveBnJIcHnYsnDa76YweIPT24pvrqLbAwP76e4TgjBQVLQYqFduCIDO3W5hYi6
 RYsQ==
X-Gm-Message-State: APjAAAXNFaVEavU0AiHDelZKjJNsMhEMqx3B3sg1bDqspCIWHcLnRTQL
 npEK7fWgcfHb9EiN0nmAOu38EQ==
X-Google-Smtp-Source: APXvYqyknSpL6YrEVhCGlgpFDlHGwO1kEFPoABiiyYQRWLoeA7QdtAwQj3wCFK1HsD8BOYYo0eC5Mg==
X-Received: by 2002:a81:4108:: with SMTP id o8mr4836728ywa.182.1570668315514; 
 Wed, 09 Oct 2019 17:45:15 -0700 (PDT)
Received: from [192.168.1.44] (67.216.151.25.pool.hargray.net. [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id q124sm1066397ywq.8.2019.10.09.17.45.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Oct 2019 17:45:14 -0700 (PDT)
Subject: Re: [RFC PATCH 2/5] timer: arm: Introduce functions to get the host
 cntfrq
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20191007170622.1814-1-drjones@redhat.com>
 <20191007170622.1814-3-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <670594fd-3c29-13bd-e67e-69c96140c738@linaro.org>
Date: Wed, 9 Oct 2019 20:45:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007170622.1814-3-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 1:06 PM, Andrew Jones wrote:
> When acceleration like KVM is in use it's necessary to use the host's
> counter frequency when converting ticks to or from time units.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  include/qemu/timer.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

