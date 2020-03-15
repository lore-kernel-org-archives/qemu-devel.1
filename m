Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521E3C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A3920663
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNFPTvgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A3920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDanz-00058F-UG
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 17:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDaPz-0004I6-1K
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDaPy-0003WT-0p
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:03:30 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDaPx-0003S9-RH
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:03:29 -0400
Received: by mail-pl1-x641.google.com with SMTP id w12so6968243pll.13
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Tf2d/Pl21azP6oW+6DBWLXnY3oSLQe0tdutvXKmprPs=;
 b=dNFPTvgljfFOiJ2YAsaIlCtKqscBDJvAI8JT6p8y6vGZdv4Kdn4jqyC0lXIw9QHlXd
 21T2NyX1+7TOBoNjxtYVFf7MSleW5NO2ntxLDzQywJcfK8+/C+ISJdkK0ztYLe4Q5i2F
 qPZNYEmu4h4KIlDvc518jQy1KMx7bSKhhWSWp4Gybj2cjcPQY4pU+/Hb+ec2a56E7EO1
 A21W7zYYcGr/60BGPqWBzs8FzY+k7Ef1R9hrT6pyhKCahiM/IICoLpyv5QCntxFkwbeo
 HsYqxnpWiGDLJ9eJGfiH1hu2Q9SIBxSXn/Mfv6l/dYdhmEmugo1ngCkYkzT4GjutJRR6
 Iqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tf2d/Pl21azP6oW+6DBWLXnY3oSLQe0tdutvXKmprPs=;
 b=NBjffc2WsWdc4EPpHchi3jD8+uH5ut0cHKdlATy4wbswStr5bHctWxKDXMbvkH9956
 YbRSI8sskmqnDgoeF0hYrbsMt7TLGV46GlyYU3dQdiKKbP9IxeUEnabhVX47+s+fWIdZ
 xyLhWHM+U6iQrHF+hKaEDDsX+KAgtZGl8iZULqMMEX//Y8HpaZgW8MVL1sDciO5h/5Iw
 u012ccnCN8W/p4zzTLDqMGFMOLSUY7XjASJv1vobREctsUI+CS1xGGSjjlTg9rpGEkO4
 e1ciXqMV2RocNRSmElfnjAG/g6RIeGOU4Kn+ONRLQNMnzr6VS4Wo78hkGy4aHtf4CM8P
 3wMw==
X-Gm-Message-State: ANhLgQ0x1DYbPH5vrOlDuKOujXDoymDbVrfo10vrCg3845gC3bYwFrIR
 dRlBdl5sxO7MqWGP1I6BkwiFwg==
X-Google-Smtp-Source: ADFU+vvY8QDsdzkr3n15NQNan1u7ji2ivB7a+dbOciaTSo03WB6wWvQWtqSei9LxDxPKFJZf1CI8eQ==
X-Received: by 2002:a17:90a:d081:: with SMTP id
 k1mr23020343pju.57.1584306207058; 
 Sun, 15 Mar 2020 14:03:27 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 e6sm14756519pgu.44.2020.03.15.14.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 14:03:26 -0700 (PDT)
Subject: Re: [PATCH 14/14] hw/core: Restrict CpuClass::get_crash_info() to
 system-mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-15-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ad894cd9-7916-0a24-8466-adb41c3ad854@linaro.org>
Date: Sun, 15 Mar 2020 14:03:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313183652.10258-15-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
>  include/hw/core/cpu.h | 7 ++++++-
>  hw/core/cpu.c         | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


