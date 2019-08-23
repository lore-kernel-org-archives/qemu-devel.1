Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDB9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4674220870
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y25er+sc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4674220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1B3i-00046L-PH
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1Au1-0001wb-OP
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1Au0-000779-OJ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:50:57 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1Au0-00076Z-H8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:50:56 -0400
Received: by mail-pg1-x541.google.com with SMTP id o13so5897992pgp.12
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=81vmEaQooM/4GcOyzuSEBSKSxz1JzTUbDoYReabzV1c=;
 b=Y25er+scCLNd6aRjS9tNTMthrOlOP7/8k1GqlVVH+BpNIHwfuA5is8hLf58SVXH9Vc
 5luWHVFv5gN4Bp5TotmLLQGVqPnW+pbR1zYlpQ3miZ/wMo2JGNk9DifHVB+prGeyRyHb
 Rt/6fIAEIE2/D2tKKCSl6tkMw/ZDSOHdKXXo1ve4D1+RRbeBnCsCEOY1Ul2xCh6ESdQR
 rcaTIJF8CiHMmpSik81ZNt0VbXKy+xfuQsf1/cpiU9HoypRdZ6ghddZnYmHNijWf9Y5p
 e3BdBw4PwyIqIlnrE2WOuQRyeBHbVxXGQlXozo2SOG+ek4N5d29pdBtkxdEOgsYI7+wP
 KDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=81vmEaQooM/4GcOyzuSEBSKSxz1JzTUbDoYReabzV1c=;
 b=COQzg5vqXmbNwhulWr12m4jZN8EkqXc3ZDVtsbF/NDzZSyuxb6CAAreqPkyhPqOeG6
 zPbEB/Hee+7gxCXHHP2q8Wcwr63OsqnJg2YRKVmN9ul+X/APlliTZjlxdy+iSYmimlH0
 xBKGGJT8OpTxRd7xuE0Xk64hgLRseDlyhX+mAoHf3YjKPJa7PPsnzkW9JOlte1NfwiSb
 2xNTIV/E1PoW+RHDRn6U0wp//few1OIOnHJkbb//+bFUPzFXunryEKV4vCoXMSkdi7iA
 nJJywCB88lrWSTyT4edF3e4VsK0hCq7CP2tyDfBebhTsreMk9ybY5Ts2BxMxkLKKAO04
 Vl7g==
X-Gm-Message-State: APjAAAVB+FLekSn6G5TyvnHdXvZ5x153/BChRhnSdBuXyGfZf5M8vU1d
 dWRVgGu+Got7jT8vaYz35GTPNA==
X-Google-Smtp-Source: APXvYqzF3c24A4bt4yAofm/PvLIp0ICRiAuoyTohKQ4AieH9bL1PphtP4IJpCYt4RaumFR2iD2xK5A==
X-Received: by 2002:a62:7d0d:: with SMTP id y13mr5535138pfc.150.1566571855558; 
 Fri, 23 Aug 2019 07:50:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d16sm5723896pfd.81.2019.08.23.07.50.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 07:50:54 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190823100741.9621-1-david@redhat.com>
 <20190823100741.9621-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c21b333b-7b5a-3c6e-c9e5-b0103b5b06c0@linaro.org>
Date: Fri, 23 Aug 2019 07:50:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823100741.9621-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v1 2/9] s390x/tcg: Fix length calculation
 in probe_write_access()
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 3:07 AM, David Hildenbrand wrote:
> Hm,, how did that "-" slip in (-TAGRET_PAGE_SIZE would be correct). This
> currently makes us exceed one page in a single probe_write() call,
> essentially leaving some memory unchecked.
> 
> Fixes: c5a7392cfb96 ("s390x/tcg: Provide probe_write_access helper")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


