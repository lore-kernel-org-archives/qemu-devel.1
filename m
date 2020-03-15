Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAA3C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 20:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C2420674
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 20:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HM0vAKAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C2420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDa6j-0005dD-Tq
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 16:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDZji-0007BM-DX
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDZjh-0007PB-F0
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:19:50 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDZjh-0007NA-8p
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:19:49 -0400
Received: by mail-pf1-x444.google.com with SMTP id d25so672524pfn.6
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rgAzwP1RNdbzF19h1Tajq+qOWbKSzm/2QF2DRk4/VSA=;
 b=HM0vAKACykr+cRWDfm0nJRMCVT/PRe2cnmJKHIYjmgwjXKlFAL3QF/EIrkPE98mKrY
 oNSVVRBtizAqBwSG/1Ov1R3JxP/B9UP5FtPpQc64sDDBZ6Bbu0dcQOQVNuoeGVR819nR
 40R6TIpNaJu35M5EWJZrTGvgGmHzwEJrxHr/riKasCmJ5qN3FLl4VfOeaBzlqCGFoh0R
 S/gutPjWU9tLvTA6wXQdUtkfqlJQa53716Fo1ogQbfna/0ZGhgTL6+5hxjnbtXx8/fRr
 4RbOpykM/Di10FWpb+DVx8cDeyqXv5lKDwTafABSW0j0+qYPUuOOOK2PvnbA45H9gB1t
 BkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rgAzwP1RNdbzF19h1Tajq+qOWbKSzm/2QF2DRk4/VSA=;
 b=fi6RGDSdUNkSI/BLkInZDOgXaYmPgZgN9XvK3Qcs648BmwmQe8DA713OYDPWDfwQ1h
 osdRBFMHzmgXuvtARl8erwfG5Ot7LJVKrWF/1yGiNZogL8PuaEbVxf3hu576ZQmPtMLp
 sfaItCA36iFVZ6TjyZmwXLvnOtzI7GR65MgRT59OCQyOZ9BJbpWBUzjsPh7uD2QNB+/S
 U4opJoCWobsGYuVj3KBiZdRwDNeubXtLcfvdBjNbZ2xDO20l1TcJ4vqzAFBaheKGZX4l
 iByBEqffZTXeiibjbeZtWzrnMBigGu4grZxFcTyXV9HbaMTQ0CLe5AP6B+zn1pfX50aZ
 oicw==
X-Gm-Message-State: ANhLgQ27JS/48L07ARXTI18W2jtj+eC5HTHokkgBEDwNIcp6/88tilgi
 tc8QGji6c2/RAzHfSPgmNDJI5Q==
X-Google-Smtp-Source: ADFU+vs6JkeiTZmfEUpTqoxA9cFlC+QBG6k/LOz3q4+6Qo1BH6dI+qUP2CmFNpJGYeSEMpg1XHZQrA==
X-Received: by 2002:a63:7c1d:: with SMTP id x29mr22588491pgc.197.1584303588218; 
 Sun, 15 Mar 2020 13:19:48 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 8sm25288960pfp.67.2020.03.15.13.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 13:19:47 -0700 (PDT)
Subject: Re: [PATCH 08/14] exec: Assert CPU migration is not used on user-only
 build
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-9-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c61d62a5-ceca-745d-ed60-78719955912a@linaro.org>
Date: Sun, 15 Mar 2020 13:19:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313183652.10258-9-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:36 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  exec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

