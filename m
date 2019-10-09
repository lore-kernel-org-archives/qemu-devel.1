Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FAAC4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26AF22070B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnvXqCRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26AF22070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iI12o-0006Cg-9P
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 21:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI11b-0005dR-9Q
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI11a-0002dy-03
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:44:23 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:33579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI11Z-0002bA-Ps
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:44:21 -0400
Received: by mail-yb1-xb42.google.com with SMTP id w141so217955ybe.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 18:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6s7UxI89Tq3xECMZhOe4OMWISZLQ8DtsnpHEeheVaqQ=;
 b=dnvXqCRUaydcQvMEZFQO5+piK7lURlNNrd1wh+3qQRx0TkjPipIIEEPvbNvuo3SqG1
 gEmZTM3IP7dUCJUhIoWEmZm+/DMTILPrTT+zwLjwXK50zp9HjUrTIvafmdZfPUCHKYI3
 4lfBRR5a6eofLqYsohynAIbECYJ9O6cUN5ebVKVJe7E4goqNIM/kv+ibBX2XYf6X674w
 75SjTDGuZc63l8KXimgXNErRahLecvZD1Ubgg+wplDwheaGsXZw7KKl73TQHOBYiShb1
 5OFEWPOGJhfIoGqbRz2JMw573V8GHv90AxOsV1rWm7h41O1SyYL/c4rwdsOhUxlGlLj7
 Z+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6s7UxI89Tq3xECMZhOe4OMWISZLQ8DtsnpHEeheVaqQ=;
 b=jidAoQBoCqwcHDbEzy7TQ1EqADyQ5p5M/Ft/msXPHGDdD4jxAwr65Ko0gfvRSgIuaz
 GHRkektDIBa9027S5GmCkvVFhOGSI3SrTk1ttx7NiaBF5K895NY2rt/7uJ1mMrduAcWj
 rYs9n/mpFMF0LqGaOf7kbIJz9gPhRukthoZLj5EYhPJeo6BsBjjBmFAc+myHeIoSGFg0
 ot+ktYQMjn9AaXfyQUcBWyF9KZLYoyEJpHUX5WofBjC0IC44UI1rPiLPjiRlJLwpyRw3
 Jww1NdmIAdS5/9WgrQYm2sg8D9sl2rWgqUOpOwb6QfvNHAEim30uYvqnONA9D/UC9YH6
 KHAA==
X-Gm-Message-State: APjAAAWgfzaPl0KpOy+wu8Oot/ifQsQCiUElmz7dD7J5vaGpzp3vFt77
 eWEeJGO9Vrp1AVHU19pVH3/0Gw==
X-Google-Smtp-Source: APXvYqzb2dngvoJg+EC0m2+vHvPO1C1FtCqxLvpevQ5/tvVPtCN9pwLshUiIgiR7hgCOAasMIXRIjw==
X-Received: by 2002:a25:ba84:: with SMTP id s4mr464960ybg.79.1570585460807;
 Tue, 08 Oct 2019 18:44:20 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id l24sm216012ywh.108.2019.10.08.18.44.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 18:44:19 -0700 (PDT)
Subject: Re: [PATCH v2 02/21] ptimer: Provide new transaction-based API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3a24d643-20ba-7328-f643-5a7d6be20ae5@linaro.org>
Date: Tue, 8 Oct 2019 21:44:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:17 PM, Peter Maydell wrote:
> Provide the new transaction-based API. If a ptimer is created
> using ptimer_init() rather than ptimer_init_with_bh(), then
> instead of providing a QEMUBH, it provides a pointer to the
> callback function directly, and has opted into the transaction
> API. All calls to functions which modify ptimer state:
>  - ptimer_set_period()
>  - ptimer_set_freq()
>  - ptimer_set_limit()
>  - ptimer_set_count()
>  - ptimer_run()
>  - ptimer_stop()
> must be between matched calls to ptimer_transaction_begin()
> and ptimer_transaction_commit(). When ptimer_transaction_commit()
> is called it will evaluate the state of the timer after all the
> changes in the transaction, and call the callback if necessary.
> 
> In the old API the individual update functions generally would
> call ptimer_trigger() immediately, which would schedule the QEMUBH.
> In the new API the update functions will instead defer the
> "set s->next_event and call ptimer_reload()" work to
> ptimer_transaction_commit().
> 
> Because ptimer_trigger() can now immediately call into the
> device code which may then call other ptimer functions that
> update ptimer_state fields, we must be more careful in
> ptimer_reload() not to cache fields from ptimer_state across
> the ptimer_trigger() call. (This was harmless with the QEMUBH
> mechanism as the BH would not be invoked until much later.)
> 
> We use assertions to check that:
>  * the functions modifying ptimer state are not called outside
>    a transaction block
>  * ptimer_transaction_begin() and _commit() calls are paired
>  * the transaction API is not used with a QEMUBH ptimer
> 
> There is some slight repetition of code:
>  * most of the set functions have similar looking "if s->bh
>    call ptimer_reload, otherwise set s->need_reload" code
>  * ptimer_init() and ptimer_init_with_bh() have similar code
> We deliberately don't try to avoid this repetition, because
> it will all be deleted when the QEMUBH version of the API
> is removed.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

