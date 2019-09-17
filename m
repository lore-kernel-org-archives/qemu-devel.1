Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38435C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003B72054F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tiulpBot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003B72054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAKB4-0005Nm-U7
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 16:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAK9Q-0004P9-I5
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAK9P-0007Ti-Fu
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:32:40 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAK9P-0007Sz-8X
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:32:39 -0400
Received: by mail-pf1-x442.google.com with SMTP id y22so2829365pfr.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PgcH1xIdzRwjhnVhoxnojhctD2lMsauDz8vl0j3Q3BU=;
 b=tiulpBotOAZa9Q0DEXY6U6BeKvXFhvb7pRxBYHxrJbxq0SNyZpB4zAyhV0IeP2DvQc
 mEwm6iP5Wrys/lzKq/rRu6IK/ncKjPvUmLsyJsdCF2R6gHifea5P5LNl25Im8XQpXtku
 EWzFGXsiUxvH92PZ5whkQR2NSOdk7Mj1FJjuwBiGPcOdg6IYQMfL0cvWLzh9DbdFP3vH
 n5cpY+6Eh+20NKlz4rpBtIWbWgU1LqJ8mycTH73AhRPHpJFfzmiDb8rYt8MNJD7J2ycx
 /yOjD+xvhW1XSofdivqf5KRUWdKVMFqnNGyvYosfT2UnF14RSfhOH/Dwx27iJnGQ5VUd
 M69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PgcH1xIdzRwjhnVhoxnojhctD2lMsauDz8vl0j3Q3BU=;
 b=Z/UOV+8xykkgQJ9Q/1t/jON6rf+1rXuJUillFs4lqKRTdnUvDJ8GP3MiBLy1Iu7aXO
 nBHXrf5gXX7xd6UtlnyPl5S+jYiiOwzSSY/979OVp/Tudd1aP2DbQ7fWphvcdHRSvjhb
 cjFEIiS6JquM82ci7lujzRjFj2kOTpCJB68bbtjy0xTrFueNhsmcH4ru6p2dTo+e74bD
 oVTmYXp+2KM99G05B8Jp1CrfDZUBlWD9cIhZKezXaHWAhe+U/ANi7xjXRuhBfrubzBjr
 XrHqOb9sP0XJaQRHALUzOyo+lXdT22+FR0mwc03WWZFBs8KXaiQ8JEIaxPN6YZHvPUtW
 +hTg==
X-Gm-Message-State: APjAAAXUeAdZOyCXCc5kZvgZfJVfrgHdBE497WvYgD6mSYJKTpqJ6H9Y
 00/qxO+wiwUFui2Qa7qH0MihXw==
X-Google-Smtp-Source: APXvYqzXg89o4mqihstdFYt8HH6lmh84XhwbP5oBu/Hy/snShvkdWlmYQaeVWjZLoFKhU2icwQCS0w==
X-Received: by 2002:a65:6901:: with SMTP id s1mr666714pgq.338.1568752357934;
 Tue, 17 Sep 2019 13:32:37 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b26sm3487785pfd.61.2019.09.17.13.32.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 13:32:37 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-4-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <dd8bdcd6-9e43-3721-7b39-f53d906988b3@linaro.org>
Date: Tue, 17 Sep 2019 13:32:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916154847.28936-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 03/13] hw: Move MC146818 device from
 hw/timer/ to hw/rtc/ subdirectory
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 11:48 AM, Philippe Mathieu-Daudé wrote:
>  include/hw/rtc/mc146818rtc.h                 | 38 ++++++++++++++++++++

Same rebase failure as for patch 4?


r~

