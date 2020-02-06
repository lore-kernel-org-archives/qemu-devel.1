Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895C1C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A3E20661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wCSleKP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A3E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfbG-00035a-9a
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izfZq-0001mk-Db
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izfZp-0002j4-FR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:44:10 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43373)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izfZp-0002eD-6A
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:44:09 -0500
Received: by mail-wr1-x443.google.com with SMTP id z9so6741823wrs.10
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 03:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=h+QaLbH7BR84x7gP68o9HcRyjDRlsGVyKweVdJ8rYH4=;
 b=wCSleKP3Nm2G6nGSILUerT9Eo51Uv7UnvwUvodTGKKM8bbn8KQHi4T5+MjXMGkdMOG
 j3oPUHi2Cs1ynIcLru25xvkNDuJdU2U3INhnqrmF7VQ8v10YFeOcFuX2zABFwup1BFEK
 MPwOGqVNsQcAV/Ep2OJWrlkBesrVDlVjA8qpxmKe69eb09Zg3wI/ShWjRNTvUO7zI6fG
 sfl4YtJJGWlVxmVw/yb0jtPuvWnSE+RANGKDPXRw6lt9noRTCwuLUOQLhW5BE9YSyCBd
 R8PlspjdpRPPyYYITC3BKaKdxqq9ATjra+fC4L831c4tPnBKFcX7+uK66E1a/QtibDP6
 4wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h+QaLbH7BR84x7gP68o9HcRyjDRlsGVyKweVdJ8rYH4=;
 b=L8ABsj73IptzDONKWj19T0sdUpW044/WBswd01370GI4HcJIGDm2y1lg3jMbXM0wHS
 raULDK952fegfmQqKr7cY9qx3fs8vfrDm+C3z7DICFmrXnV9IxXFp6knGip/2CwGK08m
 +J4rx/oz9OJorFzL435lc3nauNkY0OSpv7amMUeu8jMaI72jRCczQk6Kyyb8ik0p6tva
 YKsqd23OHGHhQcHqqzWSEtfhXrnzh8BL/6d4WIthMashMQhXEyup3pB3msybgJ2dZDdM
 rsMyB3eE1FkKLVTIMZPHSQJoSKFzCBL4VPNtqCqTpIA3aXohGsLLHpOpFwaQMbDkZwyE
 a7FQ==
X-Gm-Message-State: APjAAAWEPye3Htjsylhfw+GqUTgLbKUJzW7Aq4lcBkL3R2l4OZTlALK7
 ki9uMTl+zWyHJVgmxj9KsHuSLw==
X-Google-Smtp-Source: APXvYqzkAbt6PihSJEtduj1oldkIYRK+Okcy47rBakr3A2RpYXucPYqrMXgGkBj5/6zeKzStW5zUhw==
X-Received: by 2002:adf:90ee:: with SMTP id i101mr3352962wri.417.1580989447874; 
 Thu, 06 Feb 2020 03:44:07 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id s8sm3335948wmh.26.2020.02.06.03.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 03:44:07 -0800 (PST)
Subject: Re: [PATCH v1 04/13] exec: Drop "shared" parameter from
 ram_block_add()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200203183125.164879-1-david@redhat.com>
 <20200203183125.164879-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07442093-1d38-471f-50a4-c640c4c81ca0@linaro.org>
Date: Thu, 6 Feb 2020 11:44:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203183125.164879-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 6:31 PM, David Hildenbrand wrote:
> Properly store it in the flags of the ram block instead (and the flag
> even already exists and is used).
> 
> E.g., qemu_ram_is_shared() now properly succeeds on all ram blocks that are
> actually shared.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  exec.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


