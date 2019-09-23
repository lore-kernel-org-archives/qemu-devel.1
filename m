Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B300C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98CD2089F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aO4uZ9xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98CD2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCQy6-0002Mf-1j
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCQqQ-0004rU-KG
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCQqO-0007fw-EG
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:05:45 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCQqO-0007fM-73
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:05:44 -0400
Received: by mail-pf1-x441.google.com with SMTP id h195so9395075pfe.5
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QclpvSZ8fxlQ+bpNyW0TSTZIBSzR44vpuwTPcww8XGk=;
 b=aO4uZ9xV5S0ZrAqJ0Gt3ixxtecXEVhzlYS2KnsHRKtOEvPodYi06GX+hPrLJmXaKJd
 70mjqS9VHdLZ6KTKQ5RaiKjHiZ5x7LEEkuy3j51q4uxky0aT7HA8ri8xZoDBAQpglFN+
 XVQ+ElmIjQVpSIHU2lK0DEi3ltOL0S4YVSGAsyH1iKeKotHGppXmOor+eRmVBOo4uHNU
 EnTu80ZE0NKT6ga45OajDbC/SGB/1fkp7tfCwGk8zUmz4iONfOFoVL+wJlhrZhPn+ECE
 /xFoZh3HKRz2zZ/nEYXmnnASZVe+GzHDIaKZcuBRIViKOuTK31VZnYss6197ELLfJpyt
 Vxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QclpvSZ8fxlQ+bpNyW0TSTZIBSzR44vpuwTPcww8XGk=;
 b=dkpSdJ/yBVE3+pzxOiOeU8BMK5bA4/N7uFNGwOqkqXKOWnWR40/JFCQdRBiNvHdrCY
 eCMmIdJjoIF9pjbyieYQeX/exsGdyPH9mKIyN60b88D5pwCEBdNHdMmvKcMPOGYGu9Jh
 mrjzX8ThN9xLNlE7mcv93Ti4DJpGAZu0OAIjqef27bNa0NudaYkrFzpAbah71Xqbc5Bf
 IStdCQUiZaj9CKiFLOv/jD+4JKreDE/xlKpoGxaYBqqQhJx4v8aszbNcQG0JKFPaenL6
 fxH/xVG3aAKhuTMYsp98q6jLWYRb7KlYpJi3qjffgCivPGGpByMr5hjwBID6Hs2kFTfE
 Up5A==
X-Gm-Message-State: APjAAAVLtqwbilNX22uPVfl3WnalP4ORGDm0OdWA1UuH+E9clW1XkH94
 c5mW1uPpJkJKf/LhHs5yJaO5Mw==
X-Google-Smtp-Source: APXvYqxzDHptTtSDnfZTynPaGRtKRkLu038ki99pcVg13U+cS2pcfsKkJODlZMj4m1zUUI6gHe10RQ==
X-Received: by 2002:a17:90a:8416:: with SMTP id
 j22mr232889pjn.39.1569254742604; 
 Mon, 23 Sep 2019 09:05:42 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.118])
 by smtp.gmail.com with ESMTPSA id e3sm9742217pjs.15.2019.09.23.09.05.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Sep 2019 09:05:41 -0700 (PDT)
Subject: Re: [PATCH v3 18/20] cputlb: Remove tb_invalidate_phys_page_range
 is_cpu_write_access
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-19-richard.henderson@linaro.org>
 <4926b925-7019-3146-c9c7-a7fe18b8c378@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5410485a-d14b-57ad-67a2-c4eb876417af@linaro.org>
Date: Mon, 23 Sep 2019 09:05:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4926b925-7019-3146-c9c7-a7fe18b8c378@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 1:52 AM, David Hildenbrand wrote:
>> -    tb_invalidate_phys_page_range__locked(pages, p, start, end,
>> -                                          is_cpu_write_access);
>> +    tb_invalidate_phys_page_range__locked(pages, p, start, end, 0);
> 
> I'd prefer "false" to highlight the semantics, but as it's and int ...
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

I did think of that, but then the next patch changes this last argument to
"uintptr_t retaddr", so then it's not really a boolean argument anymore, and
"0" is exactly what we want.


r~


