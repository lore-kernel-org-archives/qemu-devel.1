Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81C1C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8681D23A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0wvVA+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8681D23A6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44970 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWj4G-00087O-T7
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 11:03:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWj2s-0007MY-Ud
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWj2r-0000pf-Tz
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:02:14 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWj2r-0000oP-PC
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:02:13 -0400
Received: by mail-ot1-x343.google.com with SMTP id i8so9442541oth.10
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=97DXUicvkb6RxW1FypmtfqFRG5RHcy/75INNLeM9Izk=;
	b=t0wvVA+DwDN9AfGCSJPplnMu+JUDWjzJbFzPMJ4YxUWRWqJvyitXGjWf9kJ0+0yCWG
	7P6j/9b4gAo2R6uJI7GAwadeMCskbgZpGYJdmA05FDFcUUqLQJQiDxJ6N2Xq7tMxuYLh
	K/LwbKVlr8CHajetjGPgBRJgEy4i1PiiiqTr9XEvPzThqjYkJ5OoOImRxhk4SlUpmCUO
	/rKAfMxoRPvSDpCpk4YyEZoVFUy9CKhoUgECpZaWAGTpIKl9wdu5VZIeT0n9Gooba9TW
	PdHppPYZTSxE/oaYNRJMfvtJPkN+HFW/gDh9gBGpZO0kSc+mqcCtf4v7GOn5dL5DVYhJ
	TNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=97DXUicvkb6RxW1FypmtfqFRG5RHcy/75INNLeM9Izk=;
	b=OrAHM3l7M7NwN9tQf7joYdSx4kYtOCmehmlXOFutBOWak6zLgVLefQtTbDU0VOxlH4
	t5B45B0fuEGGKXxrMcQTHL5boAMvK1hFtidrJQO6RHg17rOyMmsTSMOOUrWuwECVlyST
	KNSLsH70NsRP5NoLCll8gY1u/Erd1+IjaRi6n/3nLomkYNi3JSXTA8SOB6Wglg5tZ8UY
	/ci3aBJ3UC28vjQiOH+R/8u4q2luvGe1kyL65uhWfhk/jFQ7PW1j8wNNunVH24neEqd8
	uRocralJRG993qK2ZC8Hl/i1bUEUfjO0Kn3EErtumoxU4ZnoNJea4KV/V23KWlmN1xQ1
	26Gg==
X-Gm-Message-State: APjAAAVz1E7X7lp6gzsk3W6HDujPxIrvh5x7qzFCJ6SIJuiYZ8QceMi2
	Naeqv5Td8LEL0tw8i0SU096GMQ==
X-Google-Smtp-Source: APXvYqyS2Psg/xqHJiCeFeG6BZ9JswJ23M7LBfOhM2JXUF3HrjatWXxJScGNOoAccCzjRqSwTRZfPQ==
X-Received: by 2002:a9d:6b99:: with SMTP id b25mr2075271otq.242.1559314932022; 
	Fri, 31 May 2019 08:02:12 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id 37sm2431929oti.45.2019.05.31.08.02.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 08:02:11 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531145608.28183-1-david@redhat.com>
	<20190531145608.28183-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <399e11f9-7af7-778c-698c-6036e87f0f2b@linaro.org>
Date: Fri, 31 May 2019 10:02:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531145608.28183-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v1 1/2] s390x/tcg: Fix max_byte detection
 for stfle
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 9:56 AM, David Hildenbrand wrote:
> used_stfl_bytes() is 0, before initialized via prepare_stfl() on the
> first invocation. We have to move the calculation of max_bytes after
> prepare_stfl().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/misc_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

