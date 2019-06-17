Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CAEC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EF12089E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0DW+Vlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EF12089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52320 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd0F1-000239-7j
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 18:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35056)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0CK-0008TU-6m
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0CI-0007uW-Nz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:33:55 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd0CI-0007tE-I5
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:33:54 -0400
Received: by mail-pf1-x441.google.com with SMTP id r1so6414730pfq.12
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9AZfgh0L5aSUR7aBmYApTIyqKw1vfv7HMNg0MBOdvGI=;
 b=o0DW+VljSNr7GqL1raKdcUP97UCramohUj7uVHe1YzHeUrkgSM1rSeMj4qN8+ND+ke
 R1ur9hZn2gQck18Z+4T/2trtKZhFbQQH+GHCawUdoyYOdSO5+lLbDuqY9p9XpQBob3dR
 7tx71g4YyVlM9cjDN6mxpY1TjYwd9R7KhO7JO6NvdkF63c52an3jT2MpkwUtE3kYH+0V
 14zrrnx9mzLR+DPiWNzInNxt0zNMi2jkLrn6q4msSu4uJQXHYXxpVPELhyqkHY66oGIW
 RAeNItHLrl4gl2Up8CUXEYQG+EdG+xmbHyWtx8PqrLxWwQKlOuykU+KGA5msFQ9XBFKj
 z3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9AZfgh0L5aSUR7aBmYApTIyqKw1vfv7HMNg0MBOdvGI=;
 b=HeGQgSqrpQpsjiAvmUBb16wCXzQAF/+DLO0j9yEV8hYncAE2dj/zaBBnOQ4d++5FlO
 +8ZZ4KtMmGRNkFnbEmSzhR7z5Yc6rsMnbFFcG46Sw0VrfQ8HX7auW6DJ4BOY6LNZswJl
 klmSNbcYlnYIgGt08zTOO+lYFMXooHju6rSPzY6iR4HHa/IaTQ0YoUf+aQ3hv83bwVWC
 ZLhI02RxBb43pqIBJ0HPzMZ94WJMvK9RnHQQgDeI8jiBuDUIzvATJHKgpgEVbl3dJhMs
 vRDXYWsQZNHLm/EeCFhuRGfG2+EdX/8SKBrWN/F362U2KbLNnxml/xgy8/SqmTSWJTIo
 2IIQ==
X-Gm-Message-State: APjAAAUSvP0wWienLFHX2Y+gJXk+55msTWBV7u9Ro8Xmwh2FwobkPbmP
 LZw3x5p+p7yILjfWIy8RNw6wiA==
X-Google-Smtp-Source: APXvYqxkYInw4w+4GVv+zR0pTTSu3fDuB0jXrjMOEEVVhiNZ2FKKHswjB3MEdOtrvUvlEs4nemxoKA==
X-Received: by 2002:a17:90a:db44:: with SMTP id
 u4mr1515767pjx.52.1560810832488; 
 Mon, 17 Jun 2019 15:33:52 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id e184sm17430021pfa.169.2019.06.17.15.33.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 15:33:51 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-30-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9dcdc023-ebec-8ed9-8464-1c4d18cc9a65@linaro.org>
Date: Mon, 17 Jun 2019 15:33:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-30-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 29/50] target/i386: fetch code with
 translator_ld
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/i386/translate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


