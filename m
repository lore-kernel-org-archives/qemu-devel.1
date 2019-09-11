Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A071BC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4BA2085B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUUomj7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4BA2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8AFN-0003s0-0U
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 17:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8AEL-00035J-Ad
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8AEI-0001KO-OP
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:32:49 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:35316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8AEI-0001Jz-9M
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:32:46 -0400
Received: by mail-qt1-x841.google.com with SMTP id u9so1177168qtq.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VjoGAPkzI76OHMq+wI3WO8RY7RMfm9D74OTV0WL6Z3Y=;
 b=cUUomj7HVdWaU4x606IQciKsyIHz5cS82S3iOZsrLVqOn5wA//ZIDPhqqKHpSMu4aW
 svBfspvznKhO0YbVX5woz/ixLxXbi9rITPoLPgbzyI84SlYxYMX3qny1arMgYl68+1/U
 TgfYmq9Dqb516Ofbnfow+eQKPt9t9wsGeLedjliWz6HUlwZUDnKUQEUNs6TLscD3GjJO
 g5b3DpjNzwyGecdV4jJzwBOF8G+QAjODxp2EpqhmMvoow1m9NsCG4ST/Nwto1IZSLfoY
 9qf1c5CEsZ+LUwCPAkiTFdqTsdecMOwk2a6ZqVyyNc/GWdSnvoEUFhvRDeiDWnLcQ7nH
 RiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VjoGAPkzI76OHMq+wI3WO8RY7RMfm9D74OTV0WL6Z3Y=;
 b=D9CjwrSOT1KffhAiG89HKqvjheAoci0/C2AWCLqDaiM5uDFiPevkariGajmnTmGMVi
 Dk0DzRatsZDcqSe8R+n/PX1X9HPx4mfKcQ7X1R3XFBksIJc0lG2SLrRZaV0DPL03eHNT
 hwvDHP5UAKDhcPPheo7qiTg2R+853XSeG3wGEjmzj08RY1yxnzwnD2MbcY6OMw5q5FSb
 eLn68cmPJgRGo3bUHIji+8B5LLXoQ312PtS0OL3LEV9jCVLHNLwHob9oI4ylrO9XvbYS
 8/S0rraWSuvNZBng6rEPGny5EqkHiF2xITiUf+tMwMMdM0VdTi18HIQuZ2+kCp56mdSD
 2Dkw==
X-Gm-Message-State: APjAAAXx5d1zaT1IZLuI7gR4ue042nkSann6NbJGRQRIvNu9JpAre5G7
 y+v3qNY5hzHL5tdlQcULBzmY/A==
X-Google-Smtp-Source: APXvYqwn2iESU/HgS2P5YY6WRVDopWO43rtBViAOxU/ATu1XDjduI+8+yK0xCjjb7eCH6FkR43VsGw==
X-Received: by 2002:ac8:7088:: with SMTP id y8mr37574357qto.184.1568237565543; 
 Wed, 11 Sep 2019 14:32:45 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id l185sm5798719qkd.20.2019.09.11.14.32.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 14:32:44 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-23-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6921c8bd-0d47-424c-24e2-6869e396fe19@linaro.org>
Date: Wed, 11 Sep 2019 17:32:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-23-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: Re: [Qemu-devel] [PATCH v2 22/28] s390x/tcg: NC: Fault-safe handling
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> We can process a maximum of 256 bytes, crossing two pages.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

