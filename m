Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A79AC3F362
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA222084E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="huGRMdHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA222084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Jbq-0004Ga-BD
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7JbD-0003f6-9o
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7JbC-00034F-7X
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:53:11 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:51612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7JbB-000332-VT
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:53:10 -0500
Received: by mail-pj1-x1042.google.com with SMTP id fa20so1176948pjb.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M5P1rDTGO+oizNpB6uI7bw6ZjsPwNQ/42mt+6B1sD2M=;
 b=huGRMdHGxc6ELp8XmmbQoDmIxuA9/DHVovn7hNTMJEZs5uecpPco2r9s6+ezVmTB+v
 STIesyAxmmn8oThBCxKcjcoK3B87/uLsPWHBLd3PdP3hdML5X8Syu+p9S+hCh6YHvDYy
 iWLqFfKdkdtTNgSmcw6VYbP5e6hU3yUZG8OoO2aTCtGiXKDzfH2FWLxUlAiLJSpcQy12
 AygEomopu2j99vBohHzF9ty5OEiqYiw7S1ga4BOFW6PuW9Xeg5eFyjHuI5gxDNrDUq53
 U9hZ24CfKmRt9dESqj9tM/i3ioZ3vrI7Di8dmYfL4UXnpM8B9VOUmUTWjIeIdR7wqif1
 +7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M5P1rDTGO+oizNpB6uI7bw6ZjsPwNQ/42mt+6B1sD2M=;
 b=aFCOaUMc/SMeoarKhaNMJKxxhty2KFj4QkhLfuNAxbonaUql0qbqNO6LCAHWycc6r8
 mBxtKCBzPD+9eV+BAtyIue+lyd3810ocRFJ2zJHkP6fETWKkXyn5l7dSvvTNzHi8xVBW
 eWoyXzZ6Kpl6M0u7aOiUIxjhxUz5AJyplWadXgAy0qM34qiDd3obrWbeYNRGAVQN0EDk
 BHlK5uoEj7aR5eQSNUw3jc/m0ixftvz5UxTcIhM0BMPuAHf1tjyRP2Q1cpw9iSDVFvOT
 98jOtpo9C5h2r+dHqAkIbPzDFZ05fulqiMQhf3rNW/h2dqtkink7yy+gBRpgbuaiBI8q
 Phew==
X-Gm-Message-State: APjAAAUyqtKy7MqtN+aF+mgST4Vit2v2i67oSk0w1UXR2oOK1iGoUq81
 yUMA/s3FjWUXpfjpGIp4rns7gw==
X-Google-Smtp-Source: APXvYqy1EpfmUrZsmYTx+TR8szTDkiH9n2aR8kDnp5yCaEh9h+KKK+qFUH04R1aJy2eqT+3spO/dnA==
X-Received: by 2002:a17:902:8a89:: with SMTP id
 p9mr4585773plo.286.1582811588880; 
 Thu, 27 Feb 2020 05:53:08 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 k63sm6740974pjb.10.2020.02.27.05.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 05:53:08 -0800 (PST)
Subject: Re: [PATCH v3 01/12] qapi/qapi-schema.json: Put headers in their own
 doc-comment blocks
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200225140437.20609-1-peter.maydell@linaro.org>
 <20200225140437.20609-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <16d20e11-190c-24fc-a966-24345b780720@linaro.org>
Date: Thu, 27 Feb 2020 05:53:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225140437.20609-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 6:04 AM, Peter Maydell wrote:
> Our current QAPI doc-comment markup allows section headers
> (introduced with a leading '=' or '==') anywhere in any documentation
> comment.  This works for texinfo because the texi generator simply
> prints a texinfo heading directive at that point in the output
> stream.  For rST generation, since we're assembling a tree of
> docutils nodes, this is awkward because a new section implies
> starting a new section node at the top level of the tree and
> generating text into there.
> 
> New section headings in the middle of the documentation of a command
> or event would be pretty nonsensical, and in fact we only ever output
> new headings using 'freeform' doc comment blocks whose only content
> is the single line of the heading, with two exceptions, which are in
> the introductory freeform-doc-block at the top of
> qapi/qapi-schema.json.
> 
> Split that doc-comment up so that the heading lines are in their own
> doc-comment.  This will allow us to tighten the specification to
> insist that heading lines are always standalone, rather than
> requiring the rST document generator to look at every line in a doc
> comment block and handle headings in odd places.
> 
> This change makes no difference to the generated texi.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/qapi-schema.json | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

