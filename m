Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2CFCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1D02070B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3DADWu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1D02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLXaa-00034H-33
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 15:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLXZS-00023c-GH
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLXZR-0001Zy-GW
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:05:54 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLXZR-0001YZ-9H
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:05:53 -0400
Received: by mail-pg1-x542.google.com with SMTP id p1so3867049pgi.4
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NgIfSjnAflMh+9+qvmcvy3K4PQ5PK1k0CPbCdWmm830=;
 b=q3DADWu+E7AhIZvukpiQh1hl0fwfnQbGM+0kkHws88VKSJOeZkRUOyCgEImKaTWHaW
 1z4QacS+aA5FhQLpyq+eYCWKZT1GPKf5Rwcfa5zYQAiGDGoLLGCOIHjnEJ27syhUD+QP
 GyM4hGToeZ2W089dUZzji55Lpgen0WrZ0TS1xu5n3LrOWIB2x2mFVcmMNx+fkjfXyqKd
 yDGb4qGRlLJNq5AXTYfIyyINJGAgxHyErx0we18iBx9f7o63PibkZwu6DYY8qyCprT1e
 j+QinOXoRH4z5q7PYF23ye009m2imL0Vxn9MYJFuZB48nmtc5Zqi+S56aFD7YEVD88zh
 /U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NgIfSjnAflMh+9+qvmcvy3K4PQ5PK1k0CPbCdWmm830=;
 b=T3aKG0fl6q7GwamBeLiiuU8tIkVfQ87tvWUi2i01rM2cK6UvX85LqYhA+ea+4LgRHn
 JkqINRskJ3Qm6ClkruhoFz3uyW+r8Vd80tGNtsjQ8Em0t0vB7UGcRlcZE9DFYk2oi88Z
 gLaTsTiXKlV9RFfOhmPGyUde6A8lE0zHpFbOHJvBYYtiWUU7znemirlxbXkCesT0JKUV
 65NAy/h6JbWxnjpbBaOCfIh6bRcJwipaA9JsyZkpdxShnk48zG4rcX44TuXEELTLxBRM
 p++fKiZ8ytkUN4sMNwdbLS18ivLLEQPk0nyS8rhlqiShQQdLq2AXoWVUhmpfvGZjFgT6
 CrNw==
X-Gm-Message-State: APjAAAX1hrwbWnDlgn5+8ZfW51KMQQ7/tRk7nNJAdxTbccbIhPUNBQmo
 NwgwIC9RQmjedzqJYIhQ03msYg==
X-Google-Smtp-Source: APXvYqwvkuTuaiIy/fBEYDl43GaPNKvHBanbT4hSa3fMLMQGH4sIrImRPaaBDT5FrSdsGC27eUBBnw==
X-Received: by 2002:a63:1316:: with SMTP id i22mr12278289pgl.238.1571425552196; 
 Fri, 18 Oct 2019 12:05:52 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b20sm9886336pff.158.2019.10.18.12.05.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Oct 2019 12:05:51 -0700 (PDT)
Subject: Re: [PATCH v1 2/6] s390x/tcg: Fix VECTOR MULTIPLY AND ADD *
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191018161044.6983-1-david@redhat.com>
 <20191018161044.6983-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <667b8332-0626-b636-08c8-e70abed8dcc5@linaro.org>
Date: Fri, 18 Oct 2019 12:05:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018161044.6983-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Ivan Warren <ivan@vmfacility.fr>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 9:10 AM, David Hildenbrand wrote:
> We missed that we always read a "double-wide even-odd element
> pair of the fourth operand". Fix it in all four variants.
> 
> Fixes: 1b430aec4157 ("s390x/tcg: Implement VECTOR MULTIPLY AND ADD *")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/vec_int_helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


