Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE06C47426
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078C1207DE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpvqIOGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078C1207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO02L-0002S4-4o
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kNzxT-0002ol-7I
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:53:24 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:45572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kNzxM-0003ds-16
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:53:22 -0400
Received: by mail-oo1-xc43.google.com with SMTP id h8so1529998ooc.12
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gIKWcBQS9M/5jnv0F2l3vc76CkH5jiVr/EaYyEulpQE=;
 b=TpvqIOGOqhzkPQHiyIgDI9eFi7y5uKzC59m3+H3ywBg44s+i4nEHzP8It7mwev6GJs
 td/lXGjCcRTKJjTCh0lqgD0+Q4UqmkUTorO+oTrafuai0ISssMsfT+yzsE9tET8IiPRj
 nCCwBj5kJKTAx2JKUh+kvrg6OIJmr4JS8TUoLneKS+hz+RIZzYkvOGRae+pBqdSBLxMz
 LxUrErgaqT2d4+C9fio78Mr0cl6gNvtzPqWuCU/Ch1235zqa7ZtwdEc2//IairW+zJWR
 TMfTOF+EBUuJfaaLb/5Xhu+AFTKut7+i0tU/qqGTjGYNRGJyHKKA3y2Up+esmdYBOkDl
 hpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gIKWcBQS9M/5jnv0F2l3vc76CkH5jiVr/EaYyEulpQE=;
 b=dnKuDcPuAQ0qz+gVmiQYKKOuuWQkkjYkVF4F4yfzVG6nvND+uZU9NjIT/6iqy+z9i3
 TMnGT2598j5V/caqUdPnXRaHMhlRQh25BwvAFfLtU4tuBwjc4djoaGRbtJBu3KiGV+AC
 7i3EvQ6l8/0jmaMFvu54h0LedRpnv/MpclMocLHgBWDXu7YsZouoOaxjh2b3XCNGnK40
 MaydeIBBZfjGj3ngHhK/DWQw483nzkgTxyRUxSy/ka6ijEmyQSKgtEDcjOw4Luq6Wf/p
 o09POn9EX5aTpI9Nlo9YYY221vi2jg69A+651fXu7YiXSPI5OZFzkAkumZl+mRRg+ygu
 iIkw==
X-Gm-Message-State: AOAM531VJX2FLiWEjBfmJ3XduP8A6KL8Yxv21uTWjBikM3WBy5kEZgUJ
 /ISj/XUdWrP5XQN2BMhGDpUAwA==
X-Google-Smtp-Source: ABdhPJyjAB0lEFAD06PoW+iqjhxBDQFpx+/lI290otBgW4AB/tl46MSPVh3eoLi0FrzNHSkqQGUOtg==
X-Received: by 2002:a4a:b3c9:: with SMTP id q9mr5953586ooo.84.1601563993261;
 Thu, 01 Oct 2020 07:53:13 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id c19sm1315574ooq.35.2020.10.01.07.53.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 07:53:12 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] s390x/tcg: Implement BRANCH INDIRECT ON CONDITION
 (BIC)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200928122717.30586-1-david@redhat.com>
 <20200928122717.30586-7-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8cf7a689-87dd-a45a-60a8-134646397595@linaro.org>
Date: Thu, 1 Oct 2020 09:53:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928122717.30586-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 7:27 AM, David Hildenbrand wrote:
> Just like BRANCH ON CONDITION - however the address is read from memory
> (always 8 bytes are read), we have to wrap the address manually. The
> address is read using current CPU DAT/address-space controls, just like
> ordinary data.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def | 2 ++
>  target/s390x/translate.c   | 8 ++++++++
>  2 files changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

