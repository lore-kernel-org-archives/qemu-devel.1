Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723E7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E91B22CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cc+HGD9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E91B22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1CFF-0001Ie-AJ
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1CEB-0000kf-7p
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1CE9-0004go-3M
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:15:51 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1CE8-0004gC-TP
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:15:49 -0400
Received: by mail-pg1-x543.google.com with SMTP id w10so6025281pgj.7
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jjsO6fieTRofrTUFMoky3pzEzEw4HyxmMG8WuRCXLjM=;
 b=cc+HGD9sd3MTqLYyz93RG2oeeFWs5My0lhYBct6hpII65v79Xny3jxuHYH8nvQVEao
 nYJxrlGlRbORVd96TZiSNNT82vtyzBRcDsR+43Bh3loHYPFANGAmBnToli9y9GQwIMZI
 HTLeb5/02PeR6CsXDjuf+VenSif5t11nUGSbpt+OtAAiMdbRSEjx+yS/v6A6nmC/Nkwp
 ez9pFWBzdGGxBooZXR3JJN6psfauQ8XKxobKjzCcmIpVIOx+Gxn80KjDViCoHi64Fglz
 KWQ4xMGHOn+NA4wyUFUD67cq+hoRyTxIeF96tYumNivxROWlqzlbYOzGXvoA8YelMfOM
 k3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jjsO6fieTRofrTUFMoky3pzEzEw4HyxmMG8WuRCXLjM=;
 b=FZC5MFPdPNQCgCqASBf2qMo1HG8LT62nwCzefWjx+Ns2bBuRsSOBTuBswlONOohxyt
 Qr7IOwr2BZTAo2/EVERHHbkuwIqmmdN+B7YQ5KG/IvVjlmM3vnKZNPZ7PxvHhqYvzy9R
 nIPt+/Fqvi5AFM0WRXyWSHFW5E1yFf0zYWYFlJPJZYN44XQk2iCcWBJ71gDyJYdZMobj
 a1sX73pa134mKk1eXArwUZ8bjHW3RpXfDX43suHE8Dq3AlZ0wni0cMkDGK2LAAhGWn3x
 jGOwqyserKXDNhguxMedDfZ/DuStRtzqm6AVSQeHqgIcrAKB5vzMy1KvLqwxlPaw5oCa
 VV7Q==
X-Gm-Message-State: APjAAAUSZp31BsSCBKQN4yUrUsYvAVpKmjlLzpkyLfmyxAYUuQlH4Sa0
 FZJdzJNYxjOadrobeUscCpMP6A==
X-Google-Smtp-Source: APXvYqwB0Nbcmri92sx4HMQuMqYIFnMy1jWUKKXu3VMBrdUCzOMUaD7dJCNI47MlS350AIPYmV9E4A==
X-Received: by 2002:aa7:8814:: with SMTP id c20mr6098287pfo.87.1566576947599; 
 Fri, 23 Aug 2019 09:15:47 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id j187sm4119919pfg.178.2019.08.23.09.15.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 09:15:46 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190823100741.9621-1-david@redhat.com>
 <20190823100741.9621-10-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d0f24d7d-85b6-61d3-2f1e-09b7db491001@linaro.org>
Date: Fri, 23 Aug 2019 09:15:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823100741.9621-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v1 9/9] tcg: Check for watchpoints in
 probe_write()
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 3:07 AM, David Hildenbrand wrote:
> Let's check for write watchpoints. We'll want to do something similar
> for probe_read() in the future (once we introduce that).
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  accel/tcg/cputlb.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


