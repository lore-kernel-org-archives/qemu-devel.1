Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934B7C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA8E20679
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4tqp8Zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA8E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3iq6-0006F2-Ic
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 11:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3ipR-0005gL-De
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3ipQ-0002Ix-EY
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:01:01 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:38022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3ipQ-0002IU-7f
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:01:00 -0500
Received: by mail-pg1-x536.google.com with SMTP id d6so9402736pgn.5
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 08:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9KPjxQ/XLR0JpyUS0eLG2ggucwbv0Pmr8Qap3U39m6k=;
 b=H4tqp8ZvNOBU+9jSIcn7PT8l6m0rXmO/z0QIfgtaZOwnmrK2d7VTzsNve50Zryysls
 krlMsiCOpiAywxXmfis8g57vfvVLcKyK5kvSfkS9NIDSKJ4n4BJ00syH4q+Kyl8Z1IuB
 SCA13wO5/oNZMMuKulBHcYKAAY+Irh/TRo59mNRhdx+OtuuIkQFnulhM1fnXxcVxMVGt
 RQG2fRnDJk2VFewam8GKoy2aHkl+fbxo8auRmZO6UObbVWKx5IJTSkVZxQyGJTMKVGsF
 9S7wv6DTk4tIoxLgalshzsvYN/PZT8Y3ykIARdnnLwn5a5+5nySM6HAGHA/zpqcdY06I
 b/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9KPjxQ/XLR0JpyUS0eLG2ggucwbv0Pmr8Qap3U39m6k=;
 b=VSlsnXgByaCJxiUMpWTsIJqLlNSdblhaHC3Qg/sP1sPNA2nGvUVjLrNtwERSWB5qgQ
 GTVaqFHw5W6PNB/j+lFc2CFi21tcl0FUF/3BiCyEEfBfSJPVJQPVSE8ziVy2F26hpgwr
 SFNMZCo5CTj7ZK0oaHZId3NvoKDhBqLlC0BZ9IdVrSUsWfMfWbT9eMMDYJzeQ/nnuDxU
 po6In/zqzPJ8b9HXqt3sZgbrpHObCIngt0vigLmjOLOcHBJlvVdjEbDmAe3PojaxbAkQ
 eLrfC4AiJasI1qRP1Fg0MXHAdGQe2mVRh46J3sHX3nqdWE/3DUjB/g3DHXQ5M9GoBrLG
 wSbQ==
X-Gm-Message-State: APjAAAUNh/CXKMQG2g/TQpQoHovM4EqZLUZhx4V8Dk1jd4HnOaaPm9Rx
 ICo0fqgsxZLA1ABrP02SaRWzNQ==
X-Google-Smtp-Source: APXvYqyUYN4YjyPLLgtxm9RWwTvJVkjeiS4F144aQwChxaO3EKWaAuoWDKQp0WbMDfPqw1ZzcJLFSw==
X-Received: by 2002:aa7:8755:: with SMTP id g21mr17183548pfo.36.1581955258860; 
 Mon, 17 Feb 2020 08:00:58 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 196sm919794pfy.86.2020.02.17.08.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 08:00:58 -0800 (PST)
Subject: Re: [PATCH 0/3] docs: Create a 'tools' manual
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200217155415.30949-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5e72c9b1-cfa7-fd28-18bf-a99cc520fa94@linaro.org>
Date: Mon, 17 Feb 2020 08:00:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217155415.30949-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::536
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 7:54 AM, Peter Maydell wrote:
> Peter Maydell (3):
>   docs: Create new 'tools' manual
>   docs: Move qemu-option-trace.rst.inc to docs/
>   docs: Move tools documentation to tools manual

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

