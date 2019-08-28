Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DDBC3A5A3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 03:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D396E217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 03:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qv3SPbjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D396E217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2oE7-0002pW-34
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 23:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2oD9-0002Nf-5b
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 23:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2oD7-00037B-RO
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 23:01:27 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:41907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2oD7-0002zI-Fv
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 23:01:25 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 196so683901pfz.8
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 20:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vCVDjAbSsjSkZ3TeaYzenDdUXVRaFUtXG/QDVXsmvFo=;
 b=qv3SPbjLfYnfjYvoakrAz/e9vdnEdZPjwLJfOh2TBB85qCy5rTa8Qs54RTX5vqCvko
 cR8748uW4HjPEn37a3K8L+Bryd13W2tuEp7LEGfwpZhSB6IDYz+D0j4vjrpQvD9Ie0wP
 wmL+Zdd3C+1T3TUEY4BiNKxDaupjsNXbZECjKyVlvWKz420KI3PWwl3ID4BfMrn2TF2P
 1ai3ZsF/VVXGuymnQ/vgGIimDBHV4dc30fjaIfbnd157GHE1tP3+gsGUSDCIYt+C9vun
 SgQhR7Txno1eYGyIlnnXmSEs0jFywZ80YEkrchWOIwZV8inZQwx89Qx37VGaVkI7pr3c
 f+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vCVDjAbSsjSkZ3TeaYzenDdUXVRaFUtXG/QDVXsmvFo=;
 b=XnKacK6KLEzFd8/39XkPq9CgMYXpTbdyuKiKaRIfN4AxvqH9tE5MdkaZAZW4v8AAE9
 6U3fCMR2vkDDabt2NQdoT2GPZ+NHBIE91gDHLjlZKF0iHUyRaGRYzOMcitlem6w072aI
 AVSdi596PNeUdYtpSoqOvZ/2baJiJqmAo/41mydR8/TgZrA/kr9zQUw8qGZJkpZLQKfm
 +AiJh5G69e6eLjTZkuovHMfsYi9WDyhnaxCKR4eTL79nyJJ9YpA9xQaNah2yfU2UjGkn
 /iBZHYomoxZqxeYNsRy3jdHlWOTtjFV6Ty7OEOGgfb2X1kNHApfqG7uV6jBlUBa7LL3o
 lDCA==
X-Gm-Message-State: APjAAAWyG3DBny/9f+poHD50ezyL/m7ECjrXmvt9gFGUEmMKoxq6WJ4+
 EYPSrwJqcOMKJ92Ecb1FPEnjTQ==
X-Google-Smtp-Source: APXvYqzoRsIa4Ow+X6JcVOOMlRizyHyc941qD/WwEhyQ+ER/Y5tAYHx6g6djEfXMLIIKvl3qlpy+4w==
X-Received: by 2002:a63:4042:: with SMTP id n63mr1450149pga.75.1566961280038; 
 Tue, 27 Aug 2019 20:01:20 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r3sm742928pfr.101.2019.08.27.20.01.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Aug 2019 20:01:19 -0700 (PDT)
To: Sandra Loosemore <sandra@codesourcery.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <81a8c0ca-c5fb-fc3d-cc7b-00c4da31d621@codesourcery.com>
 <6ee9f4b4-39ff-f36a-9430-3e7a5de7a2de@linaro.org>
 <49104914-988e-d446-6b38-3ff26b7da7fa@codesourcery.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b9645a79-b331-b911-f51f-1352c8c5fa20@linaro.org>
Date: Tue, 27 Aug 2019 20:01:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <49104914-988e-d446-6b38-3ff26b7da7fa@codesourcery.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42b
Subject: Re: [Qemu-devel] libvhost-user: undefined reference to
 MADV_NOHUGEPAGE
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

On 8/27/19 6:42 PM, Sandra Loosemore wrote:
> Sorry if that was not clear.  The target is aarch64-none-elf with the provided
> semihosting facilities in QEMU.  The host is x86_64-linux-gnu. We deliberately
> link against a pretty old glibc sysroot (looks like version 2.11.1), but we did
> that for last year's 3.0 release as well, and haven't made any other changes in
> the configure options etc that we use to build QEMU for this target.

Still not clear.

The combination "glibc" and "qemu semihosting" doesn't make sense.  The triplet
"aarch64-none-elf" is a gcc thing and has no referent in qemu.

Are you building qemu-system-aarch64 for x86_64-linux, using an old x86_64 sysroot?

In any case, glibc 2.11.1 is definitely out of support.  Even CentOS 6 used
2.12 and we don't support that anymore either.  Of the current
long-term-support distros, I believe the oldest version of glibc is CentOS 7
with 2.17.

As recently mentioned in

  https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg04514.html

we may accept a small patch with a large comment, but there are no guarantees
how long we will keep such workarounds.

I encourage you to re-examine why you're carrying around a 10 year old glibc.


r~

