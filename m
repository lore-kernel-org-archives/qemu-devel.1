Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E6CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01BA206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nh85xS/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01BA206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxof-0006OO-0v
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxnr-0005qJ-RO
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:41:27 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxnq-0003pH-Vq
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:41:27 -0400
Received: by mail-pg1-x544.google.com with SMTP id 185so4446154pgb.10
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=18PjvpBvSRFINqo26hMwWXabctIYaLUjgZxMJeJ8oos=;
 b=nh85xS/jOfs88spkBMWMknsA8QnbyEIzRTx5mOUanNRFkrVcrKEAt4k2aVHCJoGCES
 Cca6K7kUKgK+H5sbkXxXlvyrWQ0KY6fs9FBtJAMOhfPGN63jXmBekcKDf/5pk2OQen06
 h5d69+8CYHBOmlnO4pwY0qh2929+HC1FV3zlURCdCbcyI8ClQWCJIM73MtFbyxoqBV6g
 fQRTZjvJgYNIm4huhaaZ8haOurZVCPNLS+KSVGqJRYHdGxL93vbEhTHvKOlsQ7AWqJpE
 PiVYa1/1pml2YR0iSwI7OzPYCPeevs0RHw6wMnXkEdsqJJZUGwD9cYvHQgS3b2Q587wm
 ZCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=18PjvpBvSRFINqo26hMwWXabctIYaLUjgZxMJeJ8oos=;
 b=NRgdh6Es24bwxUlqQW9l5VKbW9EDy8QjsoipTLNVoEWRUlHMF3c6e1Qvevp9tV5YyE
 SyfiiP76P8RsEQ7BMPn9ec4WuYI1wNAIU2OzCll35G45EbActFCESwtFxSR8KWhprkbG
 Wdb9k5dFApKchpgR9A4R0jegATKDUhIcuLWe1y7LgOBPgZO2fXeku1a3si2wz+ytYqFJ
 ZTqyl284dgbBlVP0HHWXw7cxkLQ7HydriiNoebLTvXYecMmQcckVmCxsZ5v1+fU1i4JS
 +SwzSqcAXgxpc83EOYMkm2DZqpKLq44GNuPrg4Osx9ZqgggYHfZVX30LfctwVWhI2Gy9
 oI5Q==
X-Gm-Message-State: AOAM531XJLlOXp5qN4cBX2XWn1laS0M+ztwO66b2LDbBsZtHF7Sfl65z
 KQ5lvpQ+nO+f+dt/FzxrhcaDPw==
X-Google-Smtp-Source: ABdhPJyqwBKsVS4JT12+c/ue6jKjq4BqQGl3IV/nDOd8YsTNsAVqxl51uPlWXMCwLvZx7eXkW+1Agw==
X-Received: by 2002:a63:ec0c:: with SMTP id j12mr3788513pgh.255.1591069285547; 
 Mon, 01 Jun 2020 20:41:25 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x2sm790090pfr.186.2020.06.01.20.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:41:24 -0700 (PDT)
Subject: Re: [RFC v2 13/18] guest memory protection: Move side effect out of
 machine_set_memory_encryption()
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-14-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7af2f786-d1be-c77b-08db-cdf2dd513aa8@linaro.org>
Date: Mon, 1 Jun 2020 20:41:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-14-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 8:42 PM, David Gibson wrote:
> When the "memory-encryption" property is set, we also disable KSM
> merging for the guest, since it won't accomplish anything.
> 
> We want that, but doing it in the property set function itself is
> thereoretically incorrect, in the unlikely event of some configuration
> environment that set the property then cleared it again before
> constructing the guest.
> 
> But more important, it makes some other cleanups we want more
> difficult.  So, instead move this logic to machine_run_board_init()
> conditional on the final value of the property.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/core/machine.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


