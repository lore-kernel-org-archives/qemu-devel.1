Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E7CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 22:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02636206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 22:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3RIUZbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02636206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1I2N-00024N-5S
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 18:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1I1V-0001Si-1u
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 18:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1I1S-0007VG-UE
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 18:27:08 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1I1S-0007UN-N3
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 18:27:06 -0400
Received: by mail-pf1-x443.google.com with SMTP id w26so7373620pfq.12
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 15:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3tX+/pZa4ztDsSyRMmOAfWL0Hs18AN+ia/ekLZ1wU8U=;
 b=h3RIUZbtntFRoM00TcckY6y5bNi9KKrIhpF4VpDMTrolJAxnogS90kPOpoVex0QGxS
 ujmbqJnZKatZbRDLTDJxWYimHXJJ7q8Nx+AlN5FC2SgCG1HXu/cWPqveULMXxqQJetMg
 XXbnlNAZWYT0hUPcxUDVn7SvczgIbZVJcj8TUdk5EQ59+FeWEmvKWmBQSi52PzZ2C+CR
 UJwVCXfIZvBVeQPRfinv84VG5aVRNejs3HlrTZxnHiGrEquyCy8cEJDWvpcSJtK8shpO
 0i47l5Q+uz2/DnPqJNjpMxieclLeRkSzEDqlbBWzz/ADhqWRYkDeIUw6OtCIqZLhEwz8
 wnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3tX+/pZa4ztDsSyRMmOAfWL0Hs18AN+ia/ekLZ1wU8U=;
 b=EHGi6IMYuR2AQSpT1HqDyOl1cuL+KZbDM+4I5pr+POTleb8El2sjWjxyFv18mGvmVG
 Z8dVMGIqR6wcTP6wMOXff3jAK5h7xBGhJ2VwaYPEdALHGcMI1BnxfK6qRP7hlqhOlgB7
 WfZvD/7o85xUjzj+W7sS3hPq/sEY99FAMwBviuLug1i1aTBKv25lH2a1QunUuVKLbgpW
 Xo/m6Yw9PshwmhesstYW4DJGwMWXycHhvuGuth6TSgJn4A03nsOKNXq1UYJHumNxxd/E
 VZ5ey5LpmWiyMM9/CsqZ6I63uwTfUQYguDzIVYBBK0Yqua9OB5CYC2xDHhqiVcssZyTz
 Al/A==
X-Gm-Message-State: APjAAAVxoy8S8yTXoMokMPSNsDc3+5OGVg5uOUUledciGwUt4EcHov1l
 mkACr5586O1XvHvZZbhNrwR4HQ==
X-Google-Smtp-Source: APXvYqxFoJ98T6Wv2TCRykwaVUSggQOGnGRg4ZVQTSuq0+PTJOlaetpRzu1imdW/GqbqFxF1ESsReg==
X-Received: by 2002:a63:4404:: with SMTP id r4mr5778467pga.245.1566599225002; 
 Fri, 23 Aug 2019 15:27:05 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b3sm4883437pfp.65.2019.08.23.15.27.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 15:27:03 -0700 (PDT)
To: Tony Nguyen <tony.nguyen@bt.com>, qemu-devel@nongnu.org
References: <cover.1566466906.git.tony.nguyen@bt.com>
 <4b71fd52ebd39e3122f8b702b53ecb04f6af4c26.1566466906.git.tony.nguyen@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5690df72-4140-5c3e-3a6c-0606b1d37083@linaro.org>
Date: Fri, 23 Aug 2019 15:27:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4b71fd52ebd39e3122f8b702b53ecb04f6af4c26.1566466906.git.tony.nguyen@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v9 17/20] cpu: TLB_FLAGS_MASK bit to force
 memory slow path
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 11:36 AM, Tony Nguyen wrote:
> The fast path is taken when TLB_FLAGS_MASK is all zero.
> 
> TLB_FORCE_SLOW is simply a TLB_FLAGS_MASK bit to force the slow path,
> there are no other side effects.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

FYI, while looking at this again, we do not need a new bit.  You can simply set
TLB_MMIO for this use case, like we do for ROM.

This seems to be the only change to be made for this patch set; I can fix this
up myself while queuing.


r~

