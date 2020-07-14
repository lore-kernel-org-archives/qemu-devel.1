Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C363CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C41722AAE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vYy66G49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C41722AAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvQjz-0005Ud-SA
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 15:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvQjP-0004wD-BX
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:36:47 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvQjM-0007rE-Vs
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:36:47 -0400
Received: by mail-pf1-x443.google.com with SMTP id j20so8011187pfe.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AkzKjzcpZZ6V+5dJ0AMAwarmuZaZ2SA0/OwS5u5zcM4=;
 b=vYy66G492hs2XKYL3b5dB74Arnw4CsxTIXh7FeiaRagkuDjpTx3ne0EeL7QmmB2IcC
 J1goyCePmLtY6nKpp4ULo+kqABje0BLqEMlGhl8CHr5E4xuQjq8NbBkRl+dL0+csQs0i
 yGpE/RZzIGsHFIE7rARLb8h3cUCiZ2RopxN1GB6fJHvisvzc+loCjTxqZr7opBMt7Hf9
 10W2JWyUo6/1IC6hbotN9GYQHVP2dLW8/WQKeRDrK1O8Tsrc/drErqTWcmATUOA1GxZN
 JO9cFRg4XY3XWj+RidgbE43gXb9TAO+Z3HM4viIlnXBlChRNhggD+03yp8AI56H0CJhp
 Zi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AkzKjzcpZZ6V+5dJ0AMAwarmuZaZ2SA0/OwS5u5zcM4=;
 b=Y4Q9V5HMm9yRGaPrKO10t9abPKspHI6+yFBAUulmoIABTMsuk+YjeHynMA3rIeaf9h
 9jisZopIjPbtl4YEv4baSCioXDqr/MqyWmXVQQ6wAEdvVoiV016waRKlfUd6Odx5dQ2M
 sFG0Ev7Gg1ZHGA+0i8cKqc8hMpkA0U4r4YLmTVlpVitMieH44WFrz9d4hBuReSwUbKFa
 T2baIPlZTqzWgR01QQfzp/PL90gWXzyBEf/1ycsc7vho5QLnFKucG9EYJBjz4W2bErjg
 49PbpuQk2oUEgsR5czfZkCd7gsrsbRLEnvRVJ80k7ZyNWyVIuB4LrAvJjhIpmOLYbx2y
 qDRg==
X-Gm-Message-State: AOAM532XXaTNsEa1W8Di+rLXcMbq+506n+vx9DENMGF75MKJIpHyY1us
 fvRk9bp4i2eHJZ1LzChEft7NQg==
X-Google-Smtp-Source: ABdhPJyk+YQYzkm1sKfFrb+5sfZnL7XVVX/5Q8HvLPikfWqZpa2+trtI7HKDbgp13C/zKy+X/Yuh5Q==
X-Received: by 2002:a63:c947:: with SMTP id y7mr4487627pgg.357.1594755403330; 
 Tue, 14 Jul 2020 12:36:43 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a30sm8517pfr.87.2020.07.14.12.36.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 12:36:42 -0700 (PDT)
Subject: Re: [PATCH v3 4/9] host trust limitation: Rework the
 "memory-encryption" property
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, pair@us.ibm.com, pbonzini@redhat.com,
 dgilbert@redhat.com, frankja@linux.ibm.com
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <20200619020602.118306-5-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <33b0169a-1c9a-276f-361f-b27c39f366b6@linaro.org>
Date: Tue, 14 Jul 2020 12:36:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200619020602.118306-5-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 david@redhat.com, cohuck@redhat.com, mdroth@linux.vnet.ibm.com,
 pasic@linux.ibm.com, qemu-s390x@nongnu.org, mst@redhat.com,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 7:05 PM, David Gibson wrote:
> Currently the "memory-encryption" property is only looked at once we get to
> kvm_init().  Although protection of guest memory from the hypervisor isn't
> something that could really ever work with TCG, it's not conceptually tied
> to the KVM accelerator.
> 
> In addition, the way the string property is resolved to an object is
> almost identical to how a QOM link property is handled.
> 
> So, create a new "host-trust-limitation" link property which sets this QOM
> interface link directly in the machine.  For compatibility we keep the
> "memory-encryption" property, but now implemented in terms of the new
> property.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  accel/kvm/kvm-all.c | 23 +++++++----------------
>  hw/core/machine.c   | 41 ++++++++++++++++++++++++++++++++++++-----
>  include/hw/boards.h |  2 +-
>  3 files changed, 44 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

