Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46F9C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55EDD20896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpb2tOiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EDD20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34668 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb9Ze-000226-HF
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 16:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45712)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9SN-0003VM-Po
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9SM-0002KZ-Lz
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:02:51 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38293)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hb9SM-0002Je-DX
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:02:50 -0400
Received: by mail-pl1-x643.google.com with SMTP id f97so7086397plb.5
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v1dLgcGV/Ph0MGG2awyFvNi3dyb2UKZ229Zqem4rves=;
 b=jpb2tOiOYWJN9kdIUkpMzVqhd3GXStXKDl+DCrUzABeEwyQZYKpqmRycdjAoIaJZzy
 /CeJdqXn4mKY87UbJvjEbozaqjDx94LrTMQWn7UcO/MV6/HHCcKatYoLswjQdyCBkg7W
 B+TWTSOM5bMjiS9ER8yLgq8NcUwvqbegpCG587DHDkIij7LNazpG4iaQchKnPds5Qjz0
 Y317cC28MmcMtY5EAROcBnZ7uLj3CgwtXBi7ShAI/ri59D1mrjAdO9LQi2b6CBSlPE1T
 3GTYmAGq+MRx9FXw95NaiPRP0J52vi8k/yK9XwM3GC0wunWQgdpgsEZUSWsYhlQ/R2gS
 mCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v1dLgcGV/Ph0MGG2awyFvNi3dyb2UKZ229Zqem4rves=;
 b=rebearWnAFtiYozTBZuYX8aMRs3zevjTQ01OJ48g5Zs0K9DRDLXgxJVgYTB3vzvZJ3
 wUuBVfqpJRGgM4VSU5XlWGXCZSBDjBXBMi0bKt40Ca0cKqD4/XzU4ZA3Zwb+gW6oupIZ
 QvewqESC/ou5oeEP83kWwfXSppEWTToraNa7TWq9l4BCv5uFCrV6tgg5J5uVxEX/9uz4
 lSEyrmfsC//Foq/B3iId3FhYIeoPDoXCNXU7wK9abDbDf2OxDla66HhA8gU+w7trYgvZ
 nrUh/0G/sdGc7EOKIzF0hneBT1vxz5/55Q49dhaYOHOVDbkLO9d6X0aXmdQoYD6u6BAM
 SG+A==
X-Gm-Message-State: APjAAAUa5jWjZiGIJVC/iMJpJ7zTppPK32FTN9tnXseTGFQ8GTM7KsZ6
 8dxZ0r5unx97C5rRaO0FtOR+mw==
X-Google-Smtp-Source: APXvYqzVb88c2I/UCervxrwOGSQpSD3SmUX/RrP6OOgle9bVPh9BTSqO1B0giqZ/QVQrbNfrIo85lQ==
X-Received: by 2002:a17:902:b609:: with SMTP id b9mr4680427pls.8.1560369769061; 
 Wed, 12 Jun 2019 13:02:49 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 k16sm378422pfa.87.2019.06.12.13.02.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 13:02:48 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
 gkurz@kaod.org
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
 <20190602110903.3431-6-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <25613b76-c9c6-fc73-b208-d98d20405b5f@linaro.org>
Date: Wed, 12 Jun 2019 13:02:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190602110903.3431-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v2 05/15] target/ppc: introduce
 GEN_VSX_HELPER_X3 macro to fpu_helper.c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/19 4:08 AM, Mark Cave-Ayland wrote:
> Rather than perform the VSR register decoding within the helper itself,
> introduce a new GEN_VSX_HELPER_X3 macro which performs the decode based
> upon xT, xA and xB at translation time.
> 
> With the previous changes to the VSX_CMP generator and helper macros the
> opcode parameter is no longer required in the common case and can be
> removed.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c             |  42 ++++-------
>  target/ppc/helper.h                 | 120 +++++++++++++++----------------
>  target/ppc/translate/vsx-impl.inc.c | 137 ++++++++++++++++++++----------------
>  3 files changed, 151 insertions(+), 148 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

