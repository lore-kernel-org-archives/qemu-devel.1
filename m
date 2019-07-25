Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADFEC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B99229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IohPyasE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B99229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqeoa-0004IH-Mf
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35804)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hqeoM-0003tX-27
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hqeoK-0000aU-Nf
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:33:37 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hqeoK-0000a9-Ff
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:33:36 -0400
Received: by mail-pg1-x544.google.com with SMTP id s1so16837285pgr.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VmrnczcifkRwwQ3AAnmpupYNAk/dmJOQkvQAwQziGzg=;
 b=IohPyasEgMjUU1MC4+etO5syGNceyd2HUMamXy8ZhKyPyNXfKiHc2x8Fh2JLX/OWlV
 BFPtmk/k28NR0GCWCDRbh5YQQq9EiGG+K5WW62oo1fV4w53tH6eKnZxmOqlMrjEWEQ4j
 z4YnMF10MEVBzARG2Yb4rVtyd7dOvEErX/L5Z0idA77lWhBS8cNNUVFKkr4PEMEvYWPg
 KUytlMy+pus2pUmM+q+8rhSPOlnY/IY1M9enff/Lqj3C48HyGIJPXKXj4kxzaIX2TDnb
 dHJUITEHQgY4mbCzvUcarh38LLu+8/79CVGOAfc5k2qXjDqElKMJGXK9XByGat4e8Fr9
 EqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VmrnczcifkRwwQ3AAnmpupYNAk/dmJOQkvQAwQziGzg=;
 b=h2+XNvWdXU7wDAEYBjX3LtAJPCs8lEA4ZgMs4yXVbsvS/fE59euIY0gKeeVb14Bzfp
 xo7fDpzC58WVudkk+Wa48t/XbZLn7CNsMxa3A5X8HAcz/aOnGehGoAT98RdfeRtRoAK+
 BQmIHtic64NSgqG0lQl+jW8bKWQhjwbzf4nVHy9i/oTOe4M1fP2DuBbIuOTYiG+tksoR
 pfzY6rmofSLOgARF2yQOYgWsIA6TjPFPXIqrNqVNgdK0L5YHP6bK1u4a1f9Zn3QBxE2S
 43q2M82ywP8iwJoUXxgSd7HnZYR6GrKYXBiEF1+To4ktEXpOMIFYskESRfujQR/7tJpK
 aDWg==
X-Gm-Message-State: APjAAAViDHemcp08q08vOPW96Ic2Ud61FMfuo3EaxG3GOMbDttlqE9EF
 rsvWuP2Umn8hy2WA4e8C6Z1EFw==
X-Google-Smtp-Source: APXvYqy95IbDyMvnJ2GNjXkHyLxFmb5MqAPlE+BPxBUc8pSV7aVjKpPdUTdkAwL+DZM/SMajTntvAw==
X-Received: by 2002:aa7:8752:: with SMTP id g18mr16386913pfo.201.1564065215289; 
 Thu, 25 Jul 2019 07:33:35 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id n7sm57904308pff.59.2019.07.25.07.33.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 07:33:34 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190725131645.19501-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4a4fbeee-e389-81a8-0264-355a8e8af2bf@linaro.org>
Date: Thu, 25 Jul 2019 07:33:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725131645.19501-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH for-4.1] linux-user: Make sigaltstack
 stacks per-thread
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 patches@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 6:16 AM, Peter Maydell wrote:
> The alternate signal stack set up by the sigaltstack syscall is
> supposed to be per-thread.  We were incorrectly implementing it as
> process-wide.  This causes problems for guest binaries that rely on
> this.  Notably the Go runtime does, and so we were seeing crashes
> caused by races where two guest threads might incorrectly both
> execute on the same stack simultaneously.
> 
> Replace the global target_sigaltstack_used with a field
> sigaltstack_used in the TaskState, and make all the references to the
> old global instead get a pointer to the TaskState and use the field.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1696773
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

