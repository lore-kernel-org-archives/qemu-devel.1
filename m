Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19EAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8CC220850
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vq+Broh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CC220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1F14-0007uI-1r
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1EzI-0005tb-C2
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1EzH-000637-5j
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:12:40 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1EzG-00062i-Va
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:12:39 -0400
Received: by mail-pg1-x543.google.com with SMTP id l21so6262611pgm.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zjNKCGgc8eEH+Mj/zexRAYauoUMXDDFTTXhPK8J5dU4=;
 b=vq+Broh9f1ht8RAJPO7c++nWB2qxIdntgdzWtPB/VMlrc+cK9dp3hQn0HBiF1jyXZw
 +/xKZ1kZcBbAUn0p0EBG4X6/TS6gHnUe5vG9jB3E1RXtf4m/BHhDHYaammVeGhG6vFeZ
 JLZJiMH//8j3fNOX9eJMfIkp8jnGPdeGtybL5cTowQmNdWCX5YbxO07dNBV4/uA2Qxxw
 mzvHPoArW8r1sIkKskOsNHZ1hSZ1/dmTw1SoiPFymNCMB5N59O16AEBwxk5zb8USjwSb
 66T5UXLZSY8quzDojQc6Atd2fRGTvzbjJ6vJG3GUg/HvgdYnLo9tqasUqfLoBD6DJPtD
 uQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zjNKCGgc8eEH+Mj/zexRAYauoUMXDDFTTXhPK8J5dU4=;
 b=lFN7ghPhdVyT7yXYUmsrX0xMHiJGF7XlNlpFPook7HpJ8s8LZdMi12PQNAz/d3EBT0
 hzw3hdMF2sAr4eea8rH5l3KhXdh8QgzI4yDfuFrn6jD+/EudYc0vMyVeYwtUoaYw4JAw
 9SJJKUWVo6tyWEJVREODbzZcOwYZsk7No9Qh09xTzWzAYfy9iGoiqMPC4Jb9EO8PzpZp
 tf3YNYm+WjZwjyQJfLWIi1jAYWPce6HeCsIgXuUm2peRYfGdhcZRiX2F1H5dd8nxkhc6
 rvATVt4qd7yqlBErKSy3ZoFCMJLjXygnkNCxVJ29dTqymHda3aEeqA/J1eODnhDplB5c
 dFtA==
X-Gm-Message-State: APjAAAUZHuXQdQLoXN3tGVMrXeT1ZenRs353f6PN6D2qfaycUiILuF3k
 0zA8K6lEHqYItjkH2I7h+cuJ9Q==
X-Google-Smtp-Source: APXvYqxAzpafUFiSpTiTKdFt2JYQiFbfm8X1FfsU3qnz/uFZTPP/7zrqwdLBIIxl+UykTIwnk208qg==
X-Received: by 2002:a63:5765:: with SMTP id h37mr5169408pgm.183.1566587557490; 
 Fri, 23 Aug 2019 12:12:37 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n185sm2647283pga.16.2019.08.23.12.12.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 12:12:36 -0700 (PDT)
To: Tony Nguyen <tony.nguyen@bt.com>, qemu-devel@nongnu.org
References: <cover.1566466906.git.tony.nguyen@bt.com>
 <911ff31af11922a9afba9b7ce128af8b8b80f316.1566466906.git.tony.nguyen@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <543522bf-2809-8277-1baf-0ee7656c04ac@linaro.org>
Date: Fri, 23 Aug 2019 12:12:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <911ff31af11922a9afba9b7ce128af8b8b80f316.1566466906.git.tony.nguyen@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v9 16/20] memory: Single byte swap along
 the I/O path
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 11:36 AM, Tony Nguyen wrote:
> Now that MemOp has been pushed down into the memory API, and
> callers are encoding endianness, we can collapse byte swaps
> along the I/O path into the accelerator and target independent
> adjust_endianness.
> 
> Collapsing byte swaps along the I/O path enables additional endian
> inversion logic, e.g. SPARC64 Invert Endian TTE bit, with redundant
> byte swaps cancelling out.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  accel/tcg/cputlb.c     | 42 ++--------------------------
>  exec.c                 | 17 +++---------
>  hw/virtio/virtio-pci.c | 10 +++----
>  memory.c               | 33 ++++++++--------------
>  memory_ldst.inc.c      | 63 ------------------------------------------
>  5 files changed, 23 insertions(+), 142 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


