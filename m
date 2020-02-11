Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFEBC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC45206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqIWuSWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC45206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Q0L-0004yq-11
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1PzI-0004XL-Q1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1PzC-0003Pa-Ti
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:29:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23254
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1PzC-0003P9-M5
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581406174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dAS/8WH2p8TMp2GuhaabtUmr3wR6t7Sr9h+VimZK/ek=;
 b=QqIWuSWIMJbBlZfWfJDx0gX3rUtSr/WFJU1+aTDBxMq/+Q2g2MfO0IFXqescT4fa2shCdS
 At0duh+OdQ4pxzk3yOzBk7HHNZ/5CTnn+AbZUESnIX03jjHje/yGMDB3wW8GADmrd98Vsk
 BcQ2r47NdKBDJK1MT0Ays7oHXznJifU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-Tk34rbysMj60GFoaW61ADw-1; Tue, 11 Feb 2020 02:29:32 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so6444462wrm.16
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dAS/8WH2p8TMp2GuhaabtUmr3wR6t7Sr9h+VimZK/ek=;
 b=pmxK1yaL2TLStFm6n+WypUZvLqLAH2ZVT72WDlqrBvOlhxliGdyTTIQYvE13gW7smU
 PQMgihs7HPv+Zb9+BzhY5Ut+lGiuDwz8ghA4K58ID5m/jJ/D5iAwZDzb1j+a8qH7xx+W
 trsuLLwxQqwQBZNgsfcw+7zRSklFcv1mxwMtv1eBtjxnuvEEho+PEfzbhnlyVqcv/3Jn
 VDkTMdpGg6o1ACculk/sDVi+23U3W7ysplbD/DHhJW4l6sPxOB42nx3rR4khqrsBMjTs
 JBzcT1tu/cZBkNOa48VbqvveLPvwyfQd6cFGA8NguBUT9DICh/AOEcbWkVWs7fUhoQb0
 tdOA==
X-Gm-Message-State: APjAAAXEPDHKNyZzEFa4Bj9iEfUsvcR23qesTRYmPEeL05RlXXOq8X/A
 upJd+jkNflT7rVeEdsDmYMxTMWphCS7qlI5HfHnogeR9NZXBbL5VDdzAWvhaQd6EJ6/E4z/CfLw
 tIeD7M9bQVdR3GXE=
X-Received: by 2002:a05:600c:2c53:: with SMTP id
 r19mr3892197wmg.39.1581406170346; 
 Mon, 10 Feb 2020 23:29:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhfp71J9ZhYt9eX2f2SmEHImw1qKvy14CQiztUHYfxq9NeiN10O2/5hHmDlTnnicdHqYuZvw==
X-Received: by 2002:a05:600c:2c53:: with SMTP id
 r19mr3892109wmg.39.1581406169394; 
 Mon, 10 Feb 2020 23:29:29 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g18sm2429136wmh.48.2020.02.10.23.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:29:28 -0800 (PST)
Subject: Re: [RFC PATCH 19/66] Hexagon instruction utility functions
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-20-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9831c7d0-a954-6c73-9729-a3eb7041b979@redhat.com>
Date: Tue, 11 Feb 2020 08:29:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-20-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: Tk34rbysMj60GFoaW61ADw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 1:39 AM, Taylor Simpson wrote:
> Utility functions called by various instructions
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/arch.c     | 664 +++++++++++++++++++++++++++++++++
>   target/hexagon/arch.h     |  62 ++++
>   target/hexagon/conv_emu.c | 370 +++++++++++++++++++
>   target/hexagon/conv_emu.h |  50 +++
>   target/hexagon/fma_emu.c  | 918 ++++++++++++++++++++++++++++++++++++++++++++++
>   target/hexagon/fma_emu.h  |  30 ++
>   6 files changed, 2094 insertions(+)
>   create mode 100644 target/hexagon/arch.c
>   create mode 100644 target/hexagon/arch.h
>   create mode 100644 target/hexagon/conv_emu.c
>   create mode 100644 target/hexagon/conv_emu.h
>   create mode 100644 target/hexagon/fma_emu.c
>   create mode 100644 target/hexagon/fma_emu.h
> 
> diff --git a/target/hexagon/arch.c b/target/hexagon/arch.c
> new file mode 100644
> index 0000000..2f22e60
> --- /dev/null
> +++ b/target/hexagon/arch.c
> @@ -0,0 +1,664 @@
> +/*
> + *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <stdio.h>

You don't need this one, "qemu/osdep.h" include it for you.
Please include it first however.

> +#include <math.h>
> +#include "qemu/osdep.h"
> +#include "fma_emu.h"
> +#include "arch.h"
> +#include "macros.h"
> +
> +/*
> + * These three tables are used by the cabacdecbin instruction
> + */
> +size1u_t rLPS_table_64x4[64][4] = {
> +    {128, 176, 208, 240},
> +    {128, 167, 197, 227},
> +    {128, 158, 187, 216},
> +    {123, 150, 178, 205},
> +    {116, 142, 169, 195},
> +    {111, 135, 160, 185},
> +    {105, 128, 152, 175},
> +    {100, 122, 144, 166},
> +    {95, 116, 137, 158},
> +    {90, 110, 130, 150},
> +    {85, 104, 123, 142},
> +    {81, 99, 117, 135},
> +    {77, 94, 111, 128},
> +    {73, 89, 105, 122},
> +    {69, 85, 100, 116},
> +    {66, 80, 95, 110},
> +    {62, 76, 90, 104},
> +    {59, 72, 86, 99},
> +    {56, 69, 81, 94},
> +    {53, 65, 77, 89},
> +    {51, 62, 73, 85},
> +    {48, 59, 69, 80},
> +    {46, 56, 66, 76},
> +    {43, 53, 63, 72},
> +    {41, 50, 59, 69},
> +    {39, 48, 56, 65},
> +    {37, 45, 54, 62},
> +    {35, 43, 51, 59},
> +    {33, 41, 48, 56},
> +    {32, 39, 46, 53},
> +    {30, 37, 43, 50},
> +    {29, 35, 41, 48},
> +    {27, 33, 39, 45},
> +    {26, 31, 37, 43},
> +    {24, 30, 35, 41},
> +    {23, 28, 33, 39},
> +    {22, 27, 32, 37},
> +    {21, 26, 30, 35},
> +    {20, 24, 29, 33},
> +    {19, 23, 27, 31},
> +    {18, 22, 26, 30},
> +    {17, 21, 25, 28},
> +    {16, 20, 23, 27},
> +    {15, 19, 22, 25},
> +    {14, 18, 21, 24},
> +    {14, 17, 20, 23},
> +    {13, 16, 19, 22},
> +    {12, 15, 18, 21},
> +    {12, 14, 17, 20},
> +    {11, 14, 16, 19},
> +    {11, 13, 15, 18},
> +    {10, 12, 15, 17},
> +    {10, 12, 14, 16},
> +    {9, 11, 13, 15},
> +    {9, 11, 12, 14},
> +    {8, 10, 12, 14},
> +    {8, 9, 11, 13},
> +    {7, 9, 11, 12},
> +    {7, 9, 10, 12},
> +    {7, 8, 10, 11},
> +    {6, 8, 9, 11},
> +    {6, 7, 9, 10},
> +    {6, 7, 8, 9},
> +    {2, 2, 2, 2}
> +};
> +
> +size1u_t AC_next_state_MPS_64[64] = {
> +    1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
> +    11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
> +    21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
> +    31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
> +    41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
> +    51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
> +    61, 62, 62, 63
> +};
> +
> +
> +size1u_t AC_next_state_LPS_64[64] = {
> +    0, 0, 1, 2, 2, 4, 4, 5, 6, 7,
> +    8, 9, 9, 11, 11, 12, 13, 13, 15, 15,
> +    16, 16, 18, 18, 19, 19, 21, 21, 22, 22,
> +    23, 24, 24, 25, 26, 26, 27, 27, 28, 29,
> +    29, 30, 30, 30, 31, 32, 32, 33, 33, 33,
> +    34, 34, 35, 35, 35, 36, 36, 36, 37, 37,
> +    37, 38, 38, 63
> +};
> +
> +size4u_t fbrevaddr(size4u_t pointer)
> +{
> +    size4u_t offset = pointer & 0xffff;
> +    size4u_t brevoffset = 0;
> +    int i;
> +
> +    for (i = 0; i < 16; i++) {
> +        fSETBIT(i, brevoffset, (fGETBIT((15 - i), offset)));
> +    }
> +    return (pointer & 0xffff0000) | brevoffset;
> +}
> +
> +/*
> + * Counting bits set, Brian Kernighan's way
> + * Brian Kernighan's method goes through as many iterations as there are
> + * set bits. So if we have a 32-bit word with only the high bit set,
> + * then it will only go once through the loop.
> + */
> +size4u_t count_ones_2(size2u_t src)
> +{
> +    int ret;
> +    for (ret = 0; src; ret++) {
> +        src &= src - 1;    /* clear the least significant bit set */
> +    }
> +    return ret;
> +}
> +
> + size4u_t count_ones_4(size4u_t src)
> +{
> +    int ret;
> +    for (ret = 0; src; ret++) {
> +        src &= src - 1;    /* clear the least significant bit set */
> +    }
> +    return ret;
> +}
> +
> +size4u_t count_ones_8(size8u_t src)
> +{
> +    int ret;
> +    for (ret = 0; src; ret++) {
> +        src &= src - 1;    /* clear the least significant bit set */
> +    }
> +    return ret;
> +}
> +
> +size4u_t count_leading_ones_8(size8u_t src)
> +{
> +    int ret;
> +    for (ret = 0; src & 0x8000000000000000LL; src <<= 1) {
> +        ret++;
> +    }
> +    return ret;
> +}
> +
> +
> +size4u_t count_leading_ones_4(size4u_t src)
> +{
> +    int ret;
> +    for (ret = 0; src & 0x80000000; src <<= 1) {
> +        ret++;
> +    }
> +    return ret;
> +}
> +
> +size4u_t count_leading_ones_2(size2u_t src)
> +{
> +    int ret;
> +    for (ret = 0; src & 0x8000; src <<= 1) {
> +        ret++;
> +    }
> +    return ret;
> +}
> +
> +size4u_t count_leading_ones_1(size1u_t src)
> +{
> +    int ret;
> +    for (ret = 0; src & 0x80; src <<= 1) {
> +        ret++;
> +    }
> +    return ret;
> +}
> +
> +#define BITS_MASK_8 0x5555555555555555ULL
> +#define PAIR_MASK_8 0x3333333333333333ULL
> +#define NYBL_MASK_8 0x0f0f0f0f0f0f0f0fULL
> +#define BYTE_MASK_8 0x00ff00ff00ff00ffULL
> +#define HALF_MASK_8 0x0000ffff0000ffffULL
> +#define WORD_MASK_8 0x00000000ffffffffULL
> +
> +size8u_t reverse_bits_8(size8u_t src)
> +{
> +    src = ((src >> 1) & BITS_MASK_8) | ((src & BITS_MASK_8) << 1);
> +    src = ((src >> 2) & PAIR_MASK_8) | ((src & PAIR_MASK_8) << 2);
> +    src = ((src >> 4) & NYBL_MASK_8) | ((src & NYBL_MASK_8) << 4);
> +    src = ((src >> 8) & BYTE_MASK_8) | ((src & BYTE_MASK_8) << 8);
> +    src = ((src >> 16) & HALF_MASK_8) | ((src & HALF_MASK_8) << 16);
> +    src = ((src >> 32) & WORD_MASK_8) | ((src & WORD_MASK_8) << 32);
> +    return src;
> +}
> +
> +
> +#define BITS_MASK_4 0x55555555ULL
> +#define PAIR_MASK_4 0x33333333ULL
> +#define NYBL_MASK_4 0x0f0f0f0fULL
> +#define BYTE_MASK_4 0x00ff00ffULL
> +#define HALF_MASK_4 0x0000ffffULL
> +
> +size4u_t reverse_bits_4(size4u_t src)
> +{
> +    src = ((src >> 1) & BITS_MASK_4) | ((src & BITS_MASK_4) << 1);
> +    src = ((src >> 2) & PAIR_MASK_4) | ((src & PAIR_MASK_4) << 2);
> +    src = ((src >> 4) & NYBL_MASK_4) | ((src & NYBL_MASK_4) << 4);
> +    src = ((src >> 8) & BYTE_MASK_4) | ((src & BYTE_MASK_4) << 8);
> +    src = ((src >> 16) & HALF_MASK_4) | ((src & HALF_MASK_4) << 16);
> +    return src;
> +}
> +
> +#define BITS_MASK_2 0x5555ULL
> +#define PAIR_MASK_2 0x3333ULL
> +#define NYBL_MASK_2 0x0f0fULL
> +#define BYTE_MASK_2 0x00ffULL
> +#define HALF_MASK_2 0x0000ULL
> +
> +size4u_t reverse_bits_2(size2u_t src)
> +{
> +    src = ((src >> 1) & BITS_MASK_2) | ((src & BITS_MASK_2) << 1);
> +    src = ((src >> 2) & PAIR_MASK_2) | ((src & PAIR_MASK_2) << 2);
> +    src = ((src >> 4) & NYBL_MASK_2) | ((src & NYBL_MASK_2) << 4);
> +    src = ((src >> 8) & BYTE_MASK_2) | ((src & BYTE_MASK_2) << 8);
> +    return src;
> +}
> +
> +#define BITS_MASK_1 0x55ULL
> +#define PAIR_MASK_1 0x33ULL
> +#define NYBL_MASK_1 0x0fULL
> +#define BYTE_MASK_1 0x00ULL
> +#define HALF_MASK_1 0x00ULL
> +
> +size4u_t reverse_bits_1(size1u_t src)
> +{
> +    src = ((src >> 1) & BITS_MASK_1) | ((src & BITS_MASK_1) << 1);
> +    src = ((src >> 2) & PAIR_MASK_1) | ((src & PAIR_MASK_1) << 2);
> +    src = ((src >> 4) & NYBL_MASK_1) | ((src & NYBL_MASK_1) << 4);
> +    return src;
> +}
> +
> +size8u_t exchange(size8u_t bits, size4u_t cntrl)
> +{
> +    int i;
> +    size4u_t mask = 1 << 31;
> +    size8u_t mask0 = 0x1LL << 62;
> +    size8u_t mask1 = 0x2LL << 62;
> +    size8u_t outbits = 0;
> +    size8u_t b0, b1;
> +
> +    for (i = 0; i < 32; i++) {
> +        b0 = (bits & mask0) >> (2 * i);
> +        b1 = (bits & mask1) >> (2 * i);
> +        if (cntrl & mask) {
> +            outbits |= (b1 >> 1) | (b0 << 1);
> +        } else {
> +            outbits |= (b1 | b0);
> +        }
> +        outbits <<= 2;
> +        mask >>= 1;
> +        mask0 >>= 2;
> +        mask1 >>= 2;
> +    }
> +    return outbits;
> +}
> +
> +size8u_t interleave(size4u_t odd, size4u_t even)
> +{
> +    /* Convert to long long */
> +    size8u_t myodd = odd;
> +    size8u_t myeven = even;
> +    /* First, spread bits out */
> +    myodd = (myodd | (myodd << 16)) & HALF_MASK_8;
> +    myeven = (myeven | (myeven << 16)) & HALF_MASK_8;
> +    myodd = (myodd | (myodd << 8)) & BYTE_MASK_8;
> +    myeven = (myeven | (myeven << 8)) & BYTE_MASK_8;
> +    myodd = (myodd | (myodd << 4)) & NYBL_MASK_8;
> +    myeven = (myeven | (myeven << 4)) & NYBL_MASK_8;
> +    myodd = (myodd | (myodd << 2)) & PAIR_MASK_8;
> +    myeven = (myeven | (myeven << 2)) & PAIR_MASK_8;
> +    myodd = (myodd | (myodd << 1)) & BITS_MASK_8;
> +    myeven = (myeven | (myeven << 1)) & BITS_MASK_8;
> +    /* Now OR together */
> +    return myeven | (myodd << 1);
> +}
> +
> +size8u_t deinterleave(size8u_t src)
> +{
> +    /* Get odd and even bits */
> +    size8u_t myodd = ((src >> 1) & BITS_MASK_8);
> +    size8u_t myeven = (src & BITS_MASK_8);
> +
> +    /* Unspread bits */
> +    myeven = (myeven | (myeven >> 1)) & PAIR_MASK_8;
> +    myodd = (myodd | (myodd >> 1)) & PAIR_MASK_8;
> +    myeven = (myeven | (myeven >> 2)) & NYBL_MASK_8;
> +    myodd = (myodd | (myodd >> 2)) & NYBL_MASK_8;
> +    myeven = (myeven | (myeven >> 4)) & BYTE_MASK_8;
> +    myodd = (myodd | (myodd >> 4)) & BYTE_MASK_8;
> +    myeven = (myeven | (myeven >> 8)) & HALF_MASK_8;
> +    myodd = (myodd | (myodd >> 8)) & HALF_MASK_8;
> +    myeven = (myeven | (myeven >> 16)) & WORD_MASK_8;
> +    myodd = (myodd | (myodd >> 16)) & WORD_MASK_8;
> +
> +    /* Return odd bits in upper half */
> +    return myeven | (myodd << 32);
> +}
> +
> +size4u_t carry_from_add64(size8u_t a, size8u_t b, size4u_t c)
> +{
> +    size8u_t tmpa, tmpb, tmpc;
> +    tmpa = fGETUWORD(0, a);
> +    tmpb = fGETUWORD(0, b);
> +    tmpc = tmpa + tmpb + c;
> +    tmpa = fGETUWORD(1, a);
> +    tmpb = fGETUWORD(1, b);
> +    tmpc = tmpa + tmpb + fGETUWORD(1, tmpc);
> +    tmpc = fGETUWORD(1, tmpc);
> +    return tmpc;
> +}
> +
> +size4s_t conv_round(size4s_t a, int n)
> +{
> +    size8s_t val;
> +
> +    if (n == 0) {
> +        val = a;
> +    } else if ((a & ((1 << (n - 1)) - 1)) == 0) {    /* N-1..0 all zero? */
> +        /* Add LSB from int part */
> +        val = ((fSE32_64(a)) + (size8s_t) (((size4u_t) ((1 << n) & a)) >> 1));
> +    } else {
> +        val = ((fSE32_64(a)) + (1 << (n - 1)));
> +    }
> +
> +    val = val >> n;
> +    return (size4s_t)val;
> +}
> +
> +size16s_t cast8s_to_16s(size8s_t a)
> +{
> +    size16s_t result = {.hi = 0, .lo = 0};
> +    result.lo = a;
> +    if (a < 0) {
> +        result.hi = -1;
> +    }
> +    return result;
> +}
> +
> +size8s_t cast16s_to_8s(size16s_t a)
> +{
> +    return a.lo;
> +}
> +
> +size4s_t cast16s_to_4s(size16s_t a)
> +{
> +    return (size4s_t)a.lo;
> +}
> +
> +size16s_t add128(size16s_t a, size16s_t b)
> +{
> +    size16s_t result = {.hi = 0, .lo = 0};
> +    result.lo = a.lo + b.lo;
> +    result.hi = a.hi + b.hi;
> +
> +    if (result.lo < b.lo) {
> +        result.hi++;
> +    }
> +
> +    return result;
> +}
> +
> +size16s_t sub128(size16s_t a, size16s_t b)
> +{
> +    size16s_t result = {.hi = 0, .lo = 0};
> +    result.lo = a.lo - b.lo;
> +    result.hi = a.hi - b.hi;
> +    if (result.lo > a.lo) {
> +        result.hi--;
> +    }
> +
> +    return result;
> +}
> +
> +size16s_t shiftr128(size16s_t a, size4u_t n)
> +{
> +    size16s_t result;
> +    result.lo = (a.lo >> n) | (a.hi << (64 - n));
> +    result.hi = a.hi >> n;
> +    return result;
> +}
> +
> +size16s_t shiftl128(size16s_t a, size4u_t n)
> +{
> +    size16s_t result;
> +    result.lo = a.lo << n;
> +    result.hi = (a.hi << n) | (a.lo >> (64 - n));
> +    return result;
> +}
> +
> +size16s_t and128(size16s_t a, size16s_t b)
> +{
> +    size16s_t result;
> +    result.lo = a.lo & b.lo;
> +    result.hi = a.hi & b.hi;
> +    return result;
> +}
> +
> +/* Floating Point Stuff */
> +
> +static const int roundingmodes[] = {
> +    FE_TONEAREST,
> +    FE_TOWARDZERO,
> +    FE_DOWNWARD,
> +    FE_UPWARD
> +};
> +
> +void arch_fpop_start(CPUHexagonState *env)
> +{
> +    fegetenv(&env->fenv);
> +    feclearexcept(FE_ALL_EXCEPT);
> +    fesetround(roundingmodes[fREAD_REG_FIELD(USR, USR_FPRND)]);
> +}
> +
> +#define NOTHING             /* Don't do anything */
> +
> +#define TEST_FLAG(LIBCF, MYF, MYE) \
> +    do { \
> +        if (fetestexcept(LIBCF)) { \
> +            if (GET_USR_FIELD(USR_##MYF) == 0) { \
> +                SET_USR_FIELD(USR_##MYF, 1); \
> +                if (GET_USR_FIELD(USR_##MYE)) { \
> +                    NOTHING \
> +                } \
> +            } \
> +        } \
> +    } while (0)
> +
> +void arch_fpop_end(CPUHexagonState *env)
> +{
> +    if (fetestexcept(FE_ALL_EXCEPT)) {
> +        TEST_FLAG(FE_INEXACT, FPINPF, FPINPE);
> +        TEST_FLAG(FE_DIVBYZERO, FPDBZF, FPDBZE);
> +        TEST_FLAG(FE_INVALID, FPINVF, FPINVE);
> +        TEST_FLAG(FE_OVERFLOW, FPOVFF, FPOVFE);
> +        TEST_FLAG(FE_UNDERFLOW, FPUNFF, FPUNFE);
> +    }
> +    fesetenv(&env->fenv);
> +}
> +
> +#undef TEST_FLAG
> +
> +
> +void arch_raise_fpflag(unsigned int flags)
> +{
> +    feraiseexcept(flags);
> +}
> +
> +int arch_sf_recip_common(size4s_t *Rs, size4s_t *Rt, size4s_t *Rd, int *adjust)
> +{
> +    int n_class;
> +    int d_class;
> +    int n_exp;
> +    int d_exp;
> +    int ret = 0;
> +    size4s_t RsV, RtV, RdV;
> +    int PeV = 0;
> +    RsV = *Rs;
> +    RtV = *Rt;
> +    n_class = fpclassify(fFLOAT(RsV));
> +    d_class = fpclassify(fFLOAT(RtV));
> +    if ((n_class == FP_NAN) && (d_class == FP_NAN)) {
> +        if (fGETBIT(22, RsV & RtV) == 0) {
> +            fRAISEFLAGS(FE_INVALID);
> +        }
> +        RdV = RsV = RtV = fSFNANVAL();
> +    } else if (n_class == FP_NAN) {
> +        if (fGETBIT(22, RsV) == 0) {
> +            fRAISEFLAGS(FE_INVALID);
> +        }
> +        RdV = RsV = RtV = fSFNANVAL();
> +    } else if (d_class == FP_NAN) {
> +        /* EJP: or put NaN in num/den fixup? */
> +        if (fGETBIT(22, RtV) == 0) {
> +            fRAISEFLAGS(FE_INVALID);
> +        }
> +        RdV = RsV = RtV = fSFNANVAL();
> +    } else if ((n_class == FP_INFINITE) && (d_class == FP_INFINITE)) {
> +        /* EJP: or put Inf in num fixup? */
> +        RdV = RsV = RtV = fSFNANVAL();
> +        fRAISEFLAGS(FE_INVALID);
> +    } else if ((n_class == FP_ZERO) && (d_class == FP_ZERO)) {
> +        /* EJP: or put zero in num fixup? */
> +        RdV = RsV = RtV = fSFNANVAL();
> +        fRAISEFLAGS(FE_INVALID);
> +    } else if (d_class == FP_ZERO) {
> +        /* EJP: or put Inf in num fixup? */
> +        RsV = fSFINFVAL(RsV ^ RtV);
> +        RtV = fSFONEVAL(0);
> +        RdV = fSFONEVAL(0);
> +        if (n_class != FP_INFINITE) {
> +            fRAISEFLAGS(FE_DIVBYZERO);
> +        }
> +    } else if (d_class == FP_INFINITE) {
> +        RsV = 0x80000000 & (RsV ^ RtV);
> +        RtV = fSFONEVAL(0);
> +        RdV = fSFONEVAL(0);
> +    } else if (n_class == FP_ZERO) {
> +        /* EJP: Does this just work itself out? */
> +        /* EJP: No, 0/Inf causes problems. */
> +        RsV = 0x80000000 & (RsV ^ RtV);
> +        RtV = fSFONEVAL(0);
> +        RdV = fSFONEVAL(0);
> +    } else if (n_class == FP_INFINITE) {
> +        /* EJP: Does this just work itself out? */
> +        RsV = fSFINFVAL(RsV ^ RtV);
> +        RtV = fSFONEVAL(0);
> +        RdV = fSFONEVAL(0);
> +    } else {
> +        PeV = 0x00;
> +        /* Basic checks passed */
> +        n_exp = fSF_GETEXP(RsV);
> +        d_exp = fSF_GETEXP(RtV);
> +        if ((n_exp - d_exp + fSF_BIAS()) <= fSF_MANTBITS()) {
> +            /* Near quotient underflow / inexact Q */
> +            PeV = 0x80;
> +            RtV = fSF_MUL_POW2(RtV, -64);
> +            RsV = fSF_MUL_POW2(RsV, 64);
> +        } else if ((n_exp - d_exp + fSF_BIAS()) > (fSF_MAXEXP() - 24)) {
> +            /* Near quotient overflow */
> +            PeV = 0x40;
> +            RtV = fSF_MUL_POW2(RtV, 32);
> +            RsV = fSF_MUL_POW2(RsV, -32);
> +        } else if (n_exp <= fSF_MANTBITS() + 2) {
> +            RtV = fSF_MUL_POW2(RtV, 64);
> +            RsV = fSF_MUL_POW2(RsV, 64);
> +        } else if (d_exp <= 1) {
> +            RtV = fSF_MUL_POW2(RtV, 32);
> +            RsV = fSF_MUL_POW2(RsV, 32);
> +        } else if (d_exp > 252) {
> +            RtV = fSF_MUL_POW2(RtV, -32);
> +            RsV = fSF_MUL_POW2(RsV, -32);
> +        }
> +        RdV = 0;
> +        ret = 1;
> +    }
> +    *Rs = RsV;
> +    *Rt = RtV;
> +    *Rd = RdV;
> +    *adjust = PeV;
> +    return ret;
> +}
> +
> +int arch_sf_invsqrt_common(size4s_t *Rs, size4s_t *Rd, int *adjust)
> +{
> +    int r_class;
> +    size4s_t RsV, RdV;
> +    int PeV = 0;
> +    int r_exp;
> +    int ret = 0;
> +    RsV = *Rs;
> +    r_class = fpclassify(fFLOAT(RsV));
> +    if (r_class == FP_NAN) {
> +        if (fGETBIT(22, RsV) == 0) {
> +            fRAISEFLAGS(FE_INVALID);
> +        }
> +        RdV = RsV = fSFNANVAL();
> +    } else if (fFLOAT(RsV) < 0.0) {
> +        /* Negative nonzero values are NaN */
> +        fRAISEFLAGS(FE_INVALID);
> +        RsV = fSFNANVAL();
> +        RdV = fSFNANVAL();
> +    } else if (r_class == FP_INFINITE) {
> +        /* EJP: or put Inf in num fixup? */
> +        RsV = fSFINFVAL(-1);
> +        RdV = fSFINFVAL(-1);
> +    } else if (r_class == FP_ZERO) {
> +        /* EJP: or put zero in num fixup? */
> +        RsV = RsV;
> +        RdV = fSFONEVAL(0);
> +    } else {
> +        PeV = 0x00;
> +        /* Basic checks passed */
> +        r_exp = fSF_GETEXP(RsV);
> +        if (r_exp <= 24) {
> +            RsV = fSF_MUL_POW2(RsV, 64);
> +            PeV = 0xe0;
> +        }
> +        RdV = 0;
> +        ret = 1;
> +    }
> +    *Rs = RsV;
> +    *Rd = RdV;
> +    *adjust = PeV;
> +    return ret;
> +}
> +
> +int arch_recip_lookup(int index)
> +{
> +    index &= 0x7f;
> +    unsigned const int roundrom[128] = {
> +        0x0fe, 0x0fa, 0x0f6, 0x0f2, 0x0ef, 0x0eb, 0x0e7, 0x0e4,
> +        0x0e0, 0x0dd, 0x0d9, 0x0d6, 0x0d2, 0x0cf, 0x0cc, 0x0c9,
> +        0x0c6, 0x0c2, 0x0bf, 0x0bc, 0x0b9, 0x0b6, 0x0b3, 0x0b1,
> +        0x0ae, 0x0ab, 0x0a8, 0x0a5, 0x0a3, 0x0a0, 0x09d, 0x09b,
> +        0x098, 0x096, 0x093, 0x091, 0x08e, 0x08c, 0x08a, 0x087,
> +        0x085, 0x083, 0x080, 0x07e, 0x07c, 0x07a, 0x078, 0x075,
> +        0x073, 0x071, 0x06f, 0x06d, 0x06b, 0x069, 0x067, 0x065,
> +        0x063, 0x061, 0x05f, 0x05e, 0x05c, 0x05a, 0x058, 0x056,
> +        0x054, 0x053, 0x051, 0x04f, 0x04e, 0x04c, 0x04a, 0x049,
> +        0x047, 0x045, 0x044, 0x042, 0x040, 0x03f, 0x03d, 0x03c,
> +        0x03a, 0x039, 0x037, 0x036, 0x034, 0x033, 0x032, 0x030,
> +        0x02f, 0x02d, 0x02c, 0x02b, 0x029, 0x028, 0x027, 0x025,
> +        0x024, 0x023, 0x021, 0x020, 0x01f, 0x01e, 0x01c, 0x01b,
> +        0x01a, 0x019, 0x017, 0x016, 0x015, 0x014, 0x013, 0x012,
> +        0x011, 0x00f, 0x00e, 0x00d, 0x00c, 0x00b, 0x00a, 0x009,
> +        0x008, 0x007, 0x006, 0x005, 0x004, 0x003, 0x002, 0x000,
> +    };
> +    return roundrom[index];
> +};
> +
> +int arch_invsqrt_lookup(int index)
> +{
> +    index &= 0x7f;
> +    unsigned const int roundrom[128] = {
> +        0x069, 0x066, 0x063, 0x061, 0x05e, 0x05b, 0x059, 0x057,
> +        0x054, 0x052, 0x050, 0x04d, 0x04b, 0x049, 0x047, 0x045,
> +        0x043, 0x041, 0x03f, 0x03d, 0x03b, 0x039, 0x037, 0x036,
> +        0x034, 0x032, 0x030, 0x02f, 0x02d, 0x02c, 0x02a, 0x028,
> +        0x027, 0x025, 0x024, 0x022, 0x021, 0x01f, 0x01e, 0x01d,
> +        0x01b, 0x01a, 0x019, 0x017, 0x016, 0x015, 0x014, 0x012,
> +        0x011, 0x010, 0x00f, 0x00d, 0x00c, 0x00b, 0x00a, 0x009,
> +        0x008, 0x007, 0x006, 0x005, 0x004, 0x003, 0x002, 0x001,
> +        0x0fe, 0x0fa, 0x0f6, 0x0f3, 0x0ef, 0x0eb, 0x0e8, 0x0e4,
> +        0x0e1, 0x0de, 0x0db, 0x0d7, 0x0d4, 0x0d1, 0x0ce, 0x0cb,
> +        0x0c9, 0x0c6, 0x0c3, 0x0c0, 0x0be, 0x0bb, 0x0b8, 0x0b6,
> +        0x0b3, 0x0b1, 0x0af, 0x0ac, 0x0aa, 0x0a8, 0x0a5, 0x0a3,
> +        0x0a1, 0x09f, 0x09d, 0x09b, 0x099, 0x097, 0x095, 0x093,
> +        0x091, 0x08f, 0x08d, 0x08b, 0x089, 0x087, 0x086, 0x084,
> +        0x082, 0x080, 0x07f, 0x07d, 0x07b, 0x07a, 0x078, 0x077,
> +        0x075, 0x074, 0x072, 0x071, 0x06f, 0x06e, 0x06c, 0x06b,
> +    };
> +    return roundrom[index];
> +};
> +
> diff --git a/target/hexagon/arch.h b/target/hexagon/arch.h
> new file mode 100644
> index 0000000..665a97f
> --- /dev/null
> +++ b/target/hexagon/arch.h
> @@ -0,0 +1,62 @@
> +/*
> + *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef ARCH_H
> +#define ARCH_H
> +
> +#include "cpu.h"
> +#include "hex_arch_types.h"
> +
> +extern size1u_t rLPS_table_64x4[64][4];
> +extern size1u_t AC_next_state_MPS_64[64];
> +extern size1u_t AC_next_state_LPS_64[64];
> +
> +extern size4u_t fbrevaddr(size4u_t pointer);
> +extern size4u_t count_ones_2(size2u_t src);
> +extern size4u_t count_ones_4(size4u_t src);
> +extern size4u_t count_ones_8(size8u_t src);
> +extern size4u_t count_leading_ones_8(size8u_t src);
> +extern size4u_t count_leading_ones_4(size4u_t src);
> +extern size4u_t count_leading_ones_2(size2u_t src);
> +extern size4u_t count_leading_ones_1(size1u_t src);
> +extern size8u_t reverse_bits_8(size8u_t src);
> +extern size4u_t reverse_bits_4(size4u_t src);
> +extern size4u_t reverse_bits_2(size2u_t src);
> +extern size4u_t reverse_bits_1(size1u_t src);
> +extern size8u_t exchange(size8u_t bits, size4u_t cntrl);
> +extern size8u_t interleave(size4u_t odd, size4u_t even);
> +extern size8u_t deinterleave(size8u_t src);
> +extern size4u_t carry_from_add64(size8u_t a, size8u_t b, size4u_t c);
> +extern size4s_t conv_round(size4s_t a, int n);
> +extern size16s_t cast8s_to_16s(size8s_t a);
> +extern size8s_t cast16s_to_8s(size16s_t a);
> +extern size4s_t cast16s_to_4s(size16s_t a);
> +extern size16s_t add128(size16s_t a, size16s_t b);
> +extern size16s_t sub128(size16s_t a, size16s_t b);
> +extern size16s_t shiftr128(size16s_t a, size4u_t n);
> +extern size16s_t shiftl128(size16s_t a, size4u_t n);
> +extern size16s_t and128(size16s_t a, size16s_t b);
> +extern void arch_fpop_start(CPUHexagonState *env);
> +extern void arch_fpop_end(CPUHexagonState *env);
> +extern void arch_raise_fpflag(unsigned int flags);
> +extern int arch_sf_recip_common(size4s_t *Rs, size4s_t *Rt, size4s_t *Rd,
> +                                int *adjust);
> +extern int arch_sf_invsqrt_common(size4s_t *Rs, size4s_t *Rd, int *adjust);
> +extern int arch_recip_lookup(int index);
> +extern int arch_invsqrt_lookup(int index);
> +
> +#endif
> diff --git a/target/hexagon/conv_emu.c b/target/hexagon/conv_emu.c
> new file mode 100644
> index 0000000..79c2823
> --- /dev/null
> +++ b/target/hexagon/conv_emu.c
> @@ -0,0 +1,370 @@
> +/*
> + *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hex_arch_types.h"
> +#include "macros.h"
> +#include <stdio.h>
> +#include <math.h>
> +#include "conv_emu.h"
> +
> +#define isz(X) (fpclassify(X) == FP_ZERO)
> +#define DF_BIAS 1023
> +#define SF_BIAS 127
> +
> +#define LL_MAX_POS 0x7fffffffffffffffULL
> +#define MAX_POS 0x7fffffffU
> +
> +#ifdef VCPP
> +/*
> + * Visual C isn't GNU C and doesn't have __builtin_clzll
> + */
> +
> +static int __builtin_clzll(unsigned long long int input)
> +{
> +    int total = 0;
> +    if (input == 0) {
> +        return 64;
> +    }
> +    total += ((input >> (total + 32)) != 0) ? 32 : 0;
> +    total += ((input >> (total + 16)) != 0) ? 16 : 0;
> +    total += ((input >> (total +  8)) != 0) ?  8 : 0;
> +    total += ((input >> (total +  4)) != 0) ?  4 : 0;
> +    total += ((input >> (total +  2)) != 0) ?  2 : 0;
> +    total += ((input >> (total +  1)) != 0) ?  1 : 0;
> +    return 63 - total;
> +}
> +#endif
> +
> +typedef union {
> +    double f;
> +    size8u_t i;
> +    struct {
> +        size8u_t mant:52;
> +        size8u_t exp:11;
> +        size8u_t sign:1;
> +    } x;
> +} df_t;
> +
> +
> +typedef union {
> +    float f;
> +    size4u_t i;
> +    struct {
> +        size4u_t mant:23;
> +        size4u_t exp:8;
> +        size4u_t sign:1;
> +    } x;
> +} sf_t;
> +
> +
> +#define MAKE_CONV_8U_TO_XF_N(FLOATID, BIGFLOATID, RETTYPE) \
> +static RETTYPE conv_8u_to_##FLOATID##_n(size8u_t in, int negate) \
> +{ \
> +    FLOATID##_t x; \
> +    size8u_t tmp, truncbits, shamt; \
> +    int leading_zeros; \
> +    if (in == 0) { \
> +        return 0.0; \
> +    } \
> +    leading_zeros = __builtin_clzll(in); \
> +    tmp = in << (leading_zeros); \
> +    tmp <<= 1; \
> +    shamt = 64 - f##BIGFLOATID##_MANTBITS(); \
> +    truncbits = tmp & ((1ULL << (shamt)) - 1); \
> +    tmp >>= shamt; \
> +    if (truncbits != 0) { \
> +        feraiseexcept(FE_INEXACT); \
> +        switch (fegetround()) { \
> +        case FE_TOWARDZERO: \
> +            break; \
> +        case FE_DOWNWARD: \
> +            if (negate) { \
> +                tmp += 1; \
> +            } \
> +            break; \
> +        case FE_UPWARD: \
> +            if (!negate) { \
> +                tmp += 1; \
> +            } \
> +            break; \
> +        default: \
> +            if ((truncbits & ((1ULL << (shamt - 1)) - 1)) == 0) { \
> +                tmp += (tmp & 1); \
> +            } else { \
> +                tmp += ((truncbits >> (shamt - 1)) & 1); \
> +            } \
> +            break; \
> +        } \
> +    } \
> +    if (((tmp << shamt) >> shamt) != tmp) { \
> +        leading_zeros--; \
> +    } \
> +    x.x.mant = tmp; \
> +    x.x.exp = BIGFLOATID##_BIAS + f##BIGFLOATID##_MANTBITS() - \
> +              leading_zeros + shamt - 1; \
> +    x.x.sign = negate; \
> +    return x.f; \
> +}
> +
> +MAKE_CONV_8U_TO_XF_N(df, DF, double)
> +MAKE_CONV_8U_TO_XF_N(sf, SF, float)
> +
> +double conv_8u_to_df(size8u_t in)
> +{
> +    return conv_8u_to_df_n(in, 0);
> +}
> +
> +double conv_8s_to_df(size8s_t in)
> +{
> +    if (in == 0x8000000000000000) {
> +        return -0x1p63;
> +    }
> +    if (in < 0) {
> +        return conv_8u_to_df_n(-in, 1);
> +    } else {
> +        return conv_8u_to_df_n(in, 0);
> +    }
> +}
> +
> +double conv_4u_to_df(size4u_t in)
> +{
> +    return conv_8u_to_df((size8u_t) in);
> +}
> +
> +double conv_4s_to_df(size4s_t in)
> +{
> +    return conv_8s_to_df(in);
> +}
> +
> +float conv_8u_to_sf(size8u_t in)
> +{
> +    return conv_8u_to_sf_n(in, 0);
> +}
> +
> +float conv_8s_to_sf(size8s_t in)
> +{
> +    if (in == 0x8000000000000000) {
> +        return -0x1p63;
> +    }
> +    if (in < 0) {
> +        return conv_8u_to_sf_n(-in, 1);
> +    } else {
> +        return conv_8u_to_sf_n(in, 0);
> +    }
> +}
> +
> +float conv_4u_to_sf(size4u_t in)
> +{
> +    return conv_8u_to_sf(in);
> +}
> +
> +float conv_4s_to_sf(size4s_t in)
> +{
> +    return conv_8s_to_sf(in);
> +}
> +
> +
> +static size8u_t conv_df_to_8u_n(double in, int will_negate)
> +{
> +    df_t x;
> +    int fracshift, endshift;
> +    size8u_t tmp, truncbits;
> +    x.f = in;
> +    if (isinf(in)) {
> +        feraiseexcept(FE_INVALID);
> +        if (in > 0.0) {
> +            return ~0ULL;
> +        } else {
> +            return 0ULL;
> +        }
> +    }
> +    if (isnan(in)) {
> +        feraiseexcept(FE_INVALID);
> +        return ~0ULL;
> +    }
> +    if (isz(in)) {
> +        return 0;
> +    }
> +    if (x.x.sign) {
> +        feraiseexcept(FE_INVALID);
> +        return 0;
> +    }
> +    if (in < 0.5) {
> +        /* Near zero, captures large fracshifts, denorms, etc */
> +        feraiseexcept(FE_INEXACT);
> +        switch (fegetround()) {
> +        case FE_DOWNWARD:
> +            if (will_negate) {
> +                return 1;
> +            } else {
> +                return 0;
> +            }
> +        case FE_UPWARD:
> +            if (!will_negate) {
> +                return 1;
> +            } else {
> +                return 0;
> +            }
> +        default:
> +            return 0;    /* nearest or towards zero */
> +        }
> +    }
> +    if ((x.x.exp - DF_BIAS) >= 64) {
> +        /* way too big */
> +        feraiseexcept(FE_INVALID);
> +        return ~0ULL;
> +    }
> +    fracshift = fMAX(0, (fDF_MANTBITS() - (x.x.exp - DF_BIAS)));
> +    endshift = fMAX(0, ((x.x.exp - DF_BIAS - fDF_MANTBITS())));
> +    tmp = x.x.mant | (1ULL << fDF_MANTBITS());
> +    truncbits = tmp & ((1ULL << fracshift) - 1);
> +    tmp >>= fracshift;
> +    if (truncbits) {
> +        /* Apply Rounding */
> +        feraiseexcept(FE_INEXACT);
> +        switch (fegetround()) {
> +        case FE_TOWARDZERO:
> +            break;
> +        case FE_DOWNWARD:
> +            if (will_negate) {
> +                tmp += 1;
> +            }
> +            break;
> +        case FE_UPWARD:
> +            if (!will_negate) {
> +                tmp += 1;
> +            }
> +            break;
> +        default:
> +            if ((truncbits & ((1ULL << (fracshift - 1)) - 1)) == 0) {
> +                /* Exactly .5 */
> +                tmp += (tmp & 1);
> +            } else {
> +                tmp += ((truncbits >> (fracshift - 1)) & 1);
> +            }
> +        }
> +    }
> +    /*
> +     * If we added one and it carried all the way out,
> +     * check to see if overflow
> +     */
> +    if ((tmp & ((1ULL << (fDF_MANTBITS() + 1)) - 1)) == 0) {
> +        if ((x.x.exp - DF_BIAS) == 63) {
> +            feclearexcept(FE_INEXACT);
> +            feraiseexcept(FE_INVALID);
> +            return ~0ULL;
> +        }
> +    }
> +    tmp <<= endshift;
> +    return tmp;
> +}
> +
> +static size4u_t conv_df_to_4u_n(double in, int will_negate)
> +{
> +    size8u_t tmp;
> +    tmp = conv_df_to_8u_n(in, will_negate);
> +    if (tmp > 0x00000000ffffffffULL) {
> +        feclearexcept(FE_INEXACT);
> +        feraiseexcept(FE_INVALID);
> +        return ~0U;
> +    }
> +    return (size4u_t)tmp;
> +}
> +
> +size8u_t conv_df_to_8u(double in)
> +{
> +    return conv_df_to_8u_n(in, 0);
> +}
> +
> +size4u_t conv_df_to_4u(double in)
> +{
> +    return conv_df_to_4u_n(in, 0);
> +}
> +
> +size8s_t conv_df_to_8s(double in)
> +{
> +    size8u_t tmp;
> +    df_t x;
> +    x.f = in;
> +    if (isnan(in)) {
> +        feraiseexcept(FE_INVALID);
> +        return -1;
> +    }
> +    if (x.x.sign) {
> +        tmp = conv_df_to_8u_n(-in, 1);
> +    } else {
> +        tmp = conv_df_to_8u_n(in, 0);
> +    }
> +    if (tmp > (LL_MAX_POS + x.x.sign)) {
> +        feclearexcept(FE_INEXACT);
> +        feraiseexcept(FE_INVALID);
> +        tmp = (LL_MAX_POS + x.x.sign);
> +    }
> +    if (x.x.sign) {
> +        return -tmp;
> +    } else {
> +        return tmp;
> +    }
> +}
> +
> +size4s_t conv_df_to_4s(double in)
> +{
> +    size8u_t tmp;
> +    df_t x;
> +    x.f = in;
> +    if (isnan(in)) {
> +        feraiseexcept(FE_INVALID);
> +        return -1;
> +    }
> +    if (x.x.sign) {
> +        tmp = conv_df_to_8u_n(-in, 1);
> +    } else {
> +        tmp = conv_df_to_8u_n(in, 0);
> +    }
> +    if (tmp > (MAX_POS + x.x.sign)) {
> +        feclearexcept(FE_INEXACT);
> +        feraiseexcept(FE_INVALID);
> +        tmp = (MAX_POS + x.x.sign);
> +    }
> +    if (x.x.sign) {
> +        return -tmp;
> +    } else {
> +        return tmp;
> +    }
> +}
> +
> +size8u_t conv_sf_to_8u(float in)
> +{
> +    return conv_df_to_8u(in);
> +}
> +
> +size4u_t conv_sf_to_4u(float in)
> +{
> +    return conv_df_to_4u(in);
> +}
> +
> +size8s_t conv_sf_to_8s(float in)
> +{
> +    return conv_df_to_8s(in);
> +}
> +
> +size4s_t conv_sf_to_4s(float in)
> +{
> +    return conv_df_to_4s(in);
> +}
> +
> diff --git a/target/hexagon/conv_emu.h b/target/hexagon/conv_emu.h
> new file mode 100644
> index 0000000..a5ee206
> --- /dev/null
> +++ b/target/hexagon/conv_emu.h
> @@ -0,0 +1,50 @@
> +/*
> + *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef CONV_EMU_H
> +#define CONV_EMU_H
> +
> +#include "hex_arch_types.h"
> +
> +extern size8u_t conv_sf_to_8u(float in);
> +extern size4u_t conv_sf_to_4u(float in);
> +extern size8s_t conv_sf_to_8s(float in);
> +extern size4s_t conv_sf_to_4s(float in);
> +
> +extern size8u_t conv_df_to_8u(double in);
> +extern size4u_t conv_df_to_4u(double in);
> +extern size8s_t conv_df_to_8s(double in);
> +extern size4s_t conv_df_to_4s(double in);
> +
> +extern double conv_8u_to_df(size8u_t in);
> +extern double conv_4u_to_df(size4u_t in);
> +extern double conv_8s_to_df(size8s_t in);
> +extern double conv_4s_to_df(size4s_t in);
> +
> +extern float conv_8u_to_sf(size8u_t in);
> +extern float conv_4u_to_sf(size4u_t in);
> +extern float conv_8s_to_sf(size8s_t in);
> +extern float conv_4s_to_sf(size4s_t in);
> +
> +extern float conv_df_to_sf(double in);
> +
> +static inline double conv_sf_to_df(float in)
> +{
> +    return in;
> +}
> +
> +#endif
> diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
> new file mode 100644
> index 0000000..93cac0d
> --- /dev/null
> +++ b/target/hexagon/fma_emu.c
> @@ -0,0 +1,918 @@
> +/*
> + *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include <stdio.h>
> +#include <math.h>
> +#include "macros.h"
> +#include "conv_emu.h"
> +#include "fma_emu.h"
> +
> +#define DF_INF_EXP 0x7ff
> +#define DF_BIAS 1023
> +
> +#define SF_INF_EXP 0xff
> +#define SF_BIAS 127
> +
> +#define HF_INF_EXP 0x1f
> +#define HF_BIAS 15
> +
> +#define WAY_BIG_EXP 4096
> +
> +#define isz(X) (fpclassify(X) == FP_ZERO)
> +
> +#define debug_fprintf(...)    /* nothing */
> +
> +typedef union {
> +    double f;
> +    size8u_t i;
> +    struct {
> +        size8u_t mant:52;
> +        size8u_t exp:11;
> +        size8u_t sign:1;
> +    } x;
> +} df_t;
> +
> +typedef union {
> +    float f;
> +    size4u_t i;
> +    struct {
> +        size4u_t mant:23;
> +        size4u_t exp:8;
> +        size4u_t sign:1;
> +    } x;
> +} sf_t;
> +
> +typedef struct {
> +    union {
> +        size8u_t low;
> +        struct {
> +            size4u_t w0;
> +            size4u_t w1;
> +        };
> +    };
> +    union {
> +        size8u_t high;
> +        struct {
> +            size4u_t w3;
> +            size4u_t w2;
> +        };
> +    };
> +} int128_t;
> +
> +typedef struct {
> +    int128_t mant;
> +    size4s_t exp;
> +    size1u_t sign;
> +    size1u_t guard;
> +    size1u_t round;
> +    size1u_t sticky;
> +} xf_t;
> +
> +static inline void xf_debug(const char *msg, xf_t a)
> +{
> +    debug_fprintf(stdout, "%s %c0x%016llx_%016llx /%d/%d/%d p%d\n", msg,
> +                  a.sign ? '-' : '+', a.mant.high, a.mant.low, a.guard,
> +                  a.round, a.sticky, a.exp);
> +}
> +
> +static inline void xf_init(xf_t *p)
> +{
> +    p->mant.low = 0;
> +    p->mant.high = 0;
> +    p->exp = 0;
> +    p->sign = 0;
> +    p->guard = 0;
> +    p->round = 0;
> +    p->sticky = 0;
> +}
> +
> +static inline size8u_t df_getmant(df_t a)
> +{
> +    int class = fpclassify(a.f);
> +    switch (class) {
> +    case FP_NORMAL:
> +    return a.x.mant | 1ULL << 52;
> +    case FP_ZERO:
> +        return 0;
> +    case FP_SUBNORMAL:
> +        return a.x.mant;
> +    default:
> +        return -1;
> +    };
> +}
> +
> +static inline size4s_t df_getexp(df_t a)
> +{
> +    int class = fpclassify(a.f);
> +    switch (class) {
> +    case FP_NORMAL:
> +        return a.x.exp;
> +    case FP_SUBNORMAL:
> +        return a.x.exp + 1;
> +    default:
> +        return -1;
> +    };
> +}
> +
> +static inline size8u_t sf_getmant(sf_t a)
> +{
> +    int class = fpclassify(a.f);
> +    switch (class) {
> +    case FP_NORMAL:
> +        return a.x.mant | 1ULL << 23;
> +    case FP_ZERO:
> +        return 0;
> +    case FP_SUBNORMAL:
> +        return a.x.mant | 0ULL;
> +    default:
> +        return -1;
> +    };
> +}
> +
> +static inline size4s_t sf_getexp(sf_t a)
> +{
> +    int class = fpclassify(a.f);
> +    switch (class) {
> +    case FP_NORMAL:
> +        return a.x.exp;
> +    case FP_SUBNORMAL:
> +        return a.x.exp + 1;
> +    default:
> +        return -1;
> +    };
> +}
> +
> +static inline int128_t int128_mul_6464(size8u_t ai, size8u_t bi)
> +{
> +    int128_t ret;
> +    int128_t a, b;
> +    size8u_t pp0, pp1a, pp1b, pp1s, pp2;
> +
> +    debug_fprintf(stdout, "ai/bi: 0x%016llx/0x%016llx\n", ai, bi);
> +
> +    a.high = b.high = 0;
> +    a.low = ai;
> +    b.low = bi;
> +    pp0 = (size8u_t)a.w0 * (size8u_t)b.w0;
> +    pp1a = (size8u_t)a.w1 * (size8u_t)b.w0;
> +    pp1b = (size8u_t)b.w1 * (size8u_t)a.w0;
> +    pp2 = (size8u_t)a.w1 * (size8u_t)b.w1;
> +
> +    debug_fprintf(stdout,
> +                  "pp2/1b/1a/0: 0x%016llx/0x%016llx/0x%016llx/0x%016llx\n",
> +                  pp2, pp1b, pp1a, pp0);
> +
> +    pp1s = pp1a + pp1b;
> +    if ((pp1s < pp1a) || (pp1s < pp1b)) {
> +        pp2 += (1ULL << 32);
> +    }
> +    ret.low = pp0 + (pp1s << 32);
> +    if ((ret.low < pp0) || (ret.low < (pp1s << 32))) {
> +        pp2 += 1;
> +    }
> +    ret.high = pp2 + (pp1s >> 32);
> +
> +    debug_fprintf(stdout,
> +                  "pp1s/rethi/retlo: 0x%016llx/0x%016llx/0x%016llx\n",
> +                  pp1s, ret.high, ret.low);
> +
> +    return ret;
> +}
> +
> +static inline int128_t int128_shl(int128_t a, size4u_t amt)
> +{
> +    int128_t ret;
> +    if (amt == 0) {
> +        return a;
> +    }
> +    if (amt > 128) {
> +        ret.high = 0;
> +        ret.low = 0;
> +        return ret;
> +    }
> +    if (amt >= 64) {
> +        amt -= 64;
> +        a.high = a.low;
> +        a.low = 0;
> +    }
> +    ret.high = a.high << amt;
> +    ret.high |= (a.low >> (64 - amt));
> +    ret.low = a.low << amt;
> +    return ret;
> +}
> +
> +static inline int128_t int128_shr(int128_t a, size4u_t amt)
> +{
> +    int128_t ret;
> +    if (amt == 0) {
> +        return a;
> +    }
> +    if (amt > 128) {
> +        ret.high = 0;
> +        ret.low = 0;
> +        return ret;
> +    }
> +    if (amt >= 64) {
> +        amt -= 64;
> +        a.low = a.high;
> +        a.high = 0;
> +    }
> +    ret.low = a.low >> amt;
> +    ret.low |= (a.high << (64 - amt));
> +    ret.high = a.high >> amt;
> +    return ret;
> +}
> +
> +static inline int128_t int128_add(int128_t a, int128_t b)
> +{
> +    int128_t ret;
> +    ret.low = a.low + b.low;
> +    if ((ret.low < a.low) || (ret.low < b.low)) {
> +        /* carry into high part */
> +        a.high += 1;
> +    }
> +    ret.high = a.high + b.high;
> +    return ret;
> +}
> +
> +static inline int128_t int128_sub(int128_t a, int128_t b, int borrow)
> +{
> +    int128_t ret;
> +    ret.low = a.low - b.low;
> +    if (ret.low > a.low) {
> +        /* borrow into high part */
> +        a.high -= 1;
> +    }
> +    ret.high = a.high - b.high;
> +    if (borrow == 0) {
> +        return ret;
> +    } else {
> +        a.high = 0;
> +        a.low = 1;
> +        return int128_sub(ret, a, 0);
> +    }
> +}
> +
> +static inline int int128_gt(int128_t a, int128_t b)
> +{
> +    if (a.high == b.high) {
> +        return a.low > b.low;
> +    }
> +    return a.high > b.high;
> +}
> +
> +static inline xf_t xf_norm_left(xf_t a)
> +{
> +    a.exp--;
> +    a.mant = int128_shl(a.mant, 1);
> +    a.mant.low |= a.guard;
> +    a.guard = a.round;
> +    a.round = a.sticky;
> +    return a;
> +}
> +
> +static inline xf_t xf_norm_right(xf_t a, int amt)
> +{
> +    if (amt > 130) {
> +        a.sticky |=
> +            a.round | a.guard | (a.mant.low != 0) | (a.mant.high != 0);
> +        a.guard = a.round = a.mant.high = a.mant.low = 0;
> +        a.exp += amt;
> +        return a;
> +
> +    }
> +    while (amt >= 64) {
> +        a.sticky |= a.round | a.guard | (a.mant.low != 0);
> +        a.guard = (a.mant.low >> 63) & 1;
> +        a.round = (a.mant.low >> 62) & 1;
> +        a.mant.low = a.mant.high;
> +        a.mant.high = 0;
> +        a.exp += 64;
> +        amt -= 64;
> +    }
> +    while (amt > 0) {
> +        a.exp++;
> +        a.sticky |= a.round;
> +        a.round = a.guard;
> +        a.guard = a.mant.low & 1;
> +        a.mant = int128_shr(a.mant, 1);
> +        amt--;
> +    }
> +    return a;
> +}
> +
> +
> +/*
> + * On the add/sub, we need to be able to shift out lots of bits, but need a
> + * sticky bit for what was shifted out, I think.
> + */
> +static xf_t xf_add(xf_t a, xf_t b);
> +
> +static inline xf_t xf_sub(xf_t a, xf_t b, int negate)
> +{
> +    xf_t ret;
> +    xf_init(&ret);
> +    int borrow;
> +
> +    xf_debug("-->Sub/a: ", a);
> +    xf_debug("-->Sub/b: ", b);
> +
> +    if (a.sign != b.sign) {
> +        b.sign = !b.sign;
> +        return xf_add(a, b);
> +    }
> +    if (b.exp > a.exp) {
> +        /* small - big == - (big - small) */
> +        return xf_sub(b, a, !negate);
> +    }
> +    if ((b.exp == a.exp) && (int128_gt(b.mant, a.mant))) {
> +        /* small - big == - (big - small) */
> +        return xf_sub(b, a, !negate);
> +    }
> +
> +    xf_debug("OK: Sub/a: ", a);
> +    xf_debug("OK: Sub/b: ", b);
> +
> +    while (a.exp > b.exp) {
> +        /* Try to normalize exponents: shrink a exponent and grow mantissa */
> +        if (a.mant.high & (1ULL << 62)) {
> +            /* Can't grow a any more */
> +            break;
> +        } else {
> +            a = xf_norm_left(a);
> +        }
> +    }
> +
> +    xf_debug("norm_l: Sub/a: ", a);
> +    xf_debug("norm_l: Sub/b: ", b);
> +
> +    while (a.exp > b.exp) {
> +        /* Try to normalize exponents: grow b exponent and shrink mantissa */
> +        /* Keep around shifted out bits... we might need those later */
> +        b = xf_norm_right(b, a.exp - b.exp);
> +    }
> +
> +    xf_debug("norm_r: Sub/a: ", a);
> +    xf_debug("norm_r: Sub/b: ", b);
> +
> +    if ((int128_gt(b.mant, a.mant))) {
> +        xf_debug("retry: Sub/a: ", a);
> +        xf_debug("retry: Sub/b: ", b);
> +        return xf_sub(b, a, !negate);
> +    }
> +
> +    /* OK, now things should be normalized! */
> +    ret.sign = a.sign;
> +    ret.exp = a.exp;
> +    assert(!int128_gt(b.mant, a.mant));
> +    borrow = (b.round << 2) | (b.guard << 1) | b.sticky;
> +    ret.mant = int128_sub(a.mant, b.mant, (borrow != 0));
> +    borrow = 0 - borrow;
> +    ret.guard = (borrow >> 2) & 1;
> +    ret.round = (borrow >> 1) & 1;
> +    ret.sticky = (borrow >> 0) & 1;
> +    if (negate) {
> +        ret.sign = !ret.sign;
> +    }
> +    return ret;
> +}
> +
> +static xf_t xf_add(xf_t a, xf_t b)
> +{
> +    xf_t ret;
> +    xf_init(&ret);
> +    xf_debug("-->Add/a: ", a);
> +    xf_debug("-->Add/b: ", b);
> +    if (a.sign != b.sign) {
> +        b.sign = !b.sign;
> +        return xf_sub(a, b, 0);
> +    }
> +    if (b.exp > a.exp) {
> +        /* small + big ==  (big + small) */
> +        return xf_add(b, a);
> +    }
> +    if ((b.exp == a.exp) && int128_gt(b.mant, a.mant)) {
> +        /* small + big ==  (big + small) */
> +        return xf_add(b, a);
> +    }
> +
> +    xf_debug("OK? Add/a: ", a);
> +    xf_debug("OK? Add/b: ", b);
> +
> +    while (a.exp > b.exp) {
> +        /* Try to normalize exponents: shrink a exponent and grow mantissa */
> +        if (a.mant.high & (1ULL << 62)) {
> +            /* Can't grow a any more */
> +            break;
> +        } else {
> +            a = xf_norm_left(a);
> +        }
> +    }
> +
> +    xf_debug("norm_l: Add/a: ", a);
> +    xf_debug("norm_l: Add/b: ", b);
> +
> +    while (a.exp > b.exp) {
> +        /* Try to normalize exponents: grow b exponent and shrink mantissa */
> +        /* Keep around shifted out bits... we might need those later */
> +        b = xf_norm_right(b, a.exp - b.exp);
> +    }
> +
> +    xf_debug("norm_r: Add/a: ", a);
> +    xf_debug("norm_r: Add/b: ", b);
> +
> +    /* OK, now things should be normalized! */
> +    if (int128_gt(b.mant, a.mant)) {
> +        xf_debug("retry: Add/a: ", a);
> +        xf_debug("retry: Add/b: ", b);
> +        return xf_add(b, a);
> +    };
> +    ret.sign = a.sign;
> +    ret.exp = a.exp;
> +    assert(!int128_gt(b.mant, a.mant));
> +    ret.mant = int128_add(a.mant, b.mant);
> +    ret.guard = b.guard;
> +    ret.round = b.round;
> +    ret.sticky = b.sticky;
> +    return ret;
> +}
> +
> +/* Return an infinity with the same sign as a */
> +static inline df_t infinite_df_t(xf_t a)
> +{
> +    df_t ret;
> +    ret.x.sign = a.sign;
> +    ret.x.exp = DF_INF_EXP;
> +    ret.x.mant = 0ULL;
> +    return ret;
> +}
> +
> +/* Return a maximum finite value with the same sign as a */
> +static inline df_t maxfinite_df_t(xf_t a)
> +{
> +    df_t ret;
> +    ret.x.sign = a.sign;
> +    ret.x.exp = DF_INF_EXP - 1;
> +    ret.x.mant = 0x000fffffffffffffULL;
> +    return ret;
> +}
> +
> +static inline df_t f2df_t(double in)
> +{
> +    df_t ret;
> +    ret.f = in;
> +    return ret;
> +}
> +
> +/* Return an infinity with the same sign as a */
> +static inline sf_t infinite_sf_t(xf_t a)
> +{
> +    sf_t ret;
> +    ret.x.sign = a.sign;
> +    ret.x.exp = SF_INF_EXP;
> +    ret.x.mant = 0ULL;
> +    return ret;
> +}
> +
> +/* Return a maximum finite value with the same sign as a */
> +static inline sf_t maxfinite_sf_t(xf_t a)
> +{
> +    sf_t ret;
> +    ret.x.sign = a.sign;
> +    ret.x.exp = SF_INF_EXP - 1;
> +    ret.x.mant = 0x007fffffUL;
> +    return ret;
> +}
> +
> +static inline sf_t f2sf_t(float in)
> +{
> +    sf_t ret;
> +    ret.f = in;
> +    return ret;
> +}
> +
> +#define GEN_XF_ROUND(TYPE, MANTBITS, INF_EXP) \
> +static inline TYPE xf_round_##TYPE(xf_t a) \
> +{ \
> +    TYPE ret; \
> +    ret.i = 0; \
> +    ret.x.sign = a.sign; \
> +    if ((a.mant.high == 0) && (a.mant.low == 0) \
> +        && ((a.guard | a.round | a.sticky) == 0)) { \
> +        /* result zero */ \
> +        switch (fegetround()) { \
> +        case FE_DOWNWARD: \
> +            return f2##TYPE(-0.0); \
> +        default: \
> +            return f2##TYPE(0.0); \
> +        } \
> +    } \
> +    /* Normalize right */ \
> +    /* We want MANTBITS bits of mantissa plus the leading one. */ \
> +    /* That means that we want MANTBITS+1 bits, or 0x000000000000FF_FFFF */ \
> +    /* So we need to normalize right while the high word is non-zero and \
> +    * while the low word is nonzero when masked with 0xffe0_0000_0000_0000 */ \
> +    xf_debug("input: ", a); \
> +    while ((a.mant.high != 0) || ((a.mant.low >> (MANTBITS + 1)) != 0)) { \
> +        a = xf_norm_right(a, 1); \
> +    } \
> +    xf_debug("norm_right: ", a); \
> +    /* \
> +     * OK, now normalize left \
> +     * We want to normalize left until we have a leading one in bit 24 \
> +     * Theoretically, we only need to shift a maximum of one to the left if we \
> +     * shifted out lots of bits from B, or if we had no shift / 1 shift sticky \
> +     * shoudl be 0  \
> +     */ \
> +    while ((a.mant.low & (1ULL << MANTBITS)) == 0) { \
> +        a = xf_norm_left(a); \
> +    } \
> +    xf_debug("norm_left: ", a); \
> +    /* \
> +     * OK, now we might need to denormalize because of potential underflow. \
> +     * We need to do this before rounding, and rounding might make us normal \
> +     * again \
> +     */ \
> +    while (a.exp <= 0) { \
> +        a = xf_norm_right(a, 1 - a.exp); \
> +        /* \
> +         * Do we have underflow? \
> +         * That's when we get an inexact answer because we ran out of bits \
> +         * in a denormal. \
> +         */ \
> +        if (a.guard || a.round || a.sticky) { \
> +            feraiseexcept(FE_UNDERFLOW); \
> +        } \
> +    } \
> +    xf_debug("norm_denorm: ", a); \
> +    /* OK, we're relatively canonical... now we need to round */ \
> +    if (a.guard || a.round || a.sticky) { \
> +        feraiseexcept(FE_INEXACT); \
> +        switch (fegetround()) { \
> +        case FE_TOWARDZERO: \
> +            /* Chop and we're done */ \
> +            break; \
> +        case FE_UPWARD: \
> +            if (a.sign == 0) { \
> +                a.mant.low += 1; \
> +            } \
> +            break; \
> +        case FE_DOWNWARD: \
> +            if (a.sign != 0) { \
> +                a.mant.low += 1; \
> +            } \
> +            break; \
> +        default: \
> +            if (a.round || a.sticky) { \
> +                /* round up if guard is 1, down if guard is zero */ \
> +                a.mant.low += a.guard; \
> +            } else if (a.guard) { \
> +                /* exactly .5, round up if odd */ \
> +                a.mant.low += (a.mant.low & 1); \
> +            } \
> +            break; \
> +        } \
> +    } \
> +    xf_debug("post_round: ", a); \
> +    /* \
> +     * OK, now we might have carried all the way up. \
> +     * So we might need to shr once \
> +     * at least we know that the lsb should be zero if we rounded and \
> +     * got a carry out... \
> +     */ \
> +    if ((a.mant.low >> (MANTBITS + 1)) != 0) { \
> +        a = xf_norm_right(a, 1); \
> +    } \
> +    xf_debug("once_norm_right: ", a); \
> +    /* Overflow? */ \
> +    if (a.exp >= INF_EXP) { \
> +        /* Yep, inf result */ \
> +        xf_debug("inf: ", a); \
> +        feraiseexcept(FE_OVERFLOW); \
> +        feraiseexcept(FE_INEXACT); \
> +        switch (fegetround()) { \
> +        case FE_TOWARDZERO: \
> +            return maxfinite_##TYPE(a); \
> +        case FE_UPWARD: \
> +            if (a.sign == 0) { \
> +                return infinite_##TYPE(a); \
> +            } else { \
> +                return maxfinite_##TYPE(a); \
> +            } \
> +        case FE_DOWNWARD: \
> +            if (a.sign != 0) { \
> +                return infinite_##TYPE(a); \
> +            } else { \
> +                return maxfinite_##TYPE(a); \
> +            } \
> +        default: \
> +            return infinite_##TYPE(a); \
> +        } \
> +    } \
> +    /* Underflow? */ \
> +    if (a.mant.low & (1ULL << MANTBITS)) { \
> +        /* Leading one means: No, we're normal. So, we should be done... */ \
> +        xf_debug("norm: ", a); \
> +        ret.x.exp = a.exp; \
> +        ret.x.mant = a.mant.low; \
> +        return ret; \
> +    } \
> +    xf_debug("denorm: ", a); \
> +    if (a.exp != 1) { \
> +        printf("a.exp == %d\n", a.exp); \
> +    } \
> +    assert(a.exp == 1); \
> +    ret.x.exp = 0; \
> +    ret.x.mant = a.mant.low; \
> +    return ret; \
> +}
> +
> +GEN_XF_ROUND(df_t, fDF_MANTBITS(), DF_INF_EXP)
> +GEN_XF_ROUND(sf_t, fSF_MANTBITS(), SF_INF_EXP)
> +
> +static inline double special_fma(df_t a, df_t b, df_t c)
> +{
> +    df_t ret;
> +    ret.i = 0;
> +
> +    /*
> +     * If A multiplied by B is an exact infinity and C is also an infinity
> +     * but with the opposite sign, FMA returns NaN and raises invalid.
> +     */
> +    if (fISINFPROD(a.f, b.f) && isinf(c.f)) {
> +        if ((a.x.sign ^ b.x.sign) != c.x.sign) {
> +            ret.i = fDFNANVAL();
> +            feraiseexcept(FE_INVALID);
> +            return ret.f;
> +        }
> +    }
> +    if ((isinf(a.f) && isz(b.f)) || (isz(a.f) && isinf(b.f))) {
> +        ret.i = fDFNANVAL();
> +        feraiseexcept(FE_INVALID);
> +        return ret.f;
> +    }
> +    /*
> +     * If none of the above checks are true and C is a NaN,
> +     * a NaN shall be returned
> +     * If A or B are NaN, a NAN shall be returned.
> +     */
> +    if (isnan(a.f) || isnan(b.f) || (isnan(c.f))) {
> +        if (isnan(a.f) && (fGETBIT(51, a.i) == 0)) {
> +            feraiseexcept(FE_INVALID);
> +        }
> +        if (isnan(b.f) && (fGETBIT(51, b.i) == 0)) {
> +            feraiseexcept(FE_INVALID);
> +        }
> +        if (isnan(c.f) && (fGETBIT(51, c.i) == 0)) {
> +            feraiseexcept(FE_INVALID);
> +        }
> +        ret.i = fDFNANVAL();
> +        return ret.f;
> +    }
> +    /*
> +     * We have checked for adding opposite-signed infinities.
> +     * Other infinities return infinity with the correct sign
> +     */
> +    if (isinf(c.f)) {
> +        ret.x.exp = DF_INF_EXP;
> +        ret.x.mant = 0;
> +        ret.x.sign = c.x.sign;
> +        return ret.f;
> +    }
> +    if (isinf(a.f) || isinf(b.f)) {
> +        ret.x.exp = DF_INF_EXP;
> +        ret.x.mant = 0;
> +        ret.x.sign = (a.x.sign ^ b.x.sign);
> +        return ret.f;
> +    }
> +    g_assert_not_reached();
> +    ret.x.exp = 0x123;
> +    ret.x.mant = 0xdead;
> +    return ret.f;
> +}
> +
> +static inline float special_fmaf(sf_t a, sf_t b, sf_t c)
> +{
> +    df_t aa, bb, cc;
> +    aa.f = a.f;
> +    bb.f = b.f;
> +    cc.f = c.f;
> +    return special_fma(aa, bb, cc);
> +}
> +
> +double internal_fmax(double a_in, double b_in, double c_in, int scale)
> +{
> +    df_t a, b, c;
> +    xf_t prod;
> +    xf_t acc;
> +    xf_t result;
> +    xf_init(&prod);
> +    xf_init(&acc);
> +    xf_init(&result);
> +    a.f = a_in;
> +    b.f = b_in;
> +    c.f = c_in;
> +
> +    debug_fprintf(stdout,
> +                  "internal_fmax: 0x%016llx * 0x%016llx + 0x%016llx sc: %d\n",
> +                  fUNDOUBLE(a_in), fUNDOUBLE(b_in), fUNDOUBLE(c_in),
> +                  scale);
> +
> +    if (isinf(a.f) || isinf(b.f) || isinf(c.f)) {
> +        return special_fma(a, b, c);
> +    }
> +    if (isnan(a.f) || isnan(b.f) || isnan(c.f)) {
> +        return special_fma(a, b, c);
> +    }
> +    if ((scale == 0) && (isz(a.f) || isz(b.f))) {
> +        return a.f * b.f + c.f;
> +    }
> +
> +    /* (a * 2**b) * (c * 2**d) == a*c * 2**(b+d) */
> +    prod.mant = int128_mul_6464(df_getmant(a), df_getmant(b));
> +
> +    /*
> +     * Note: extracting the mantissa into an int is multiplying by
> +     * 2**52, so adjust here
> +     */
> +    prod.exp = df_getexp(a) + df_getexp(b) - DF_BIAS - 52;
> +    prod.sign = a.x.sign ^ b.x.sign;
> +    xf_debug("prod: ", prod);
> +    if (!isz(c.f)) {
> +        acc.mant = int128_mul_6464(df_getmant(c), 1);
> +        acc.exp = df_getexp(c);
> +        acc.sign = c.x.sign;
> +        xf_debug("acc: ", acc);
> +        result = xf_add(prod, acc);
> +    } else {
> +        result = prod;
> +    }
> +    xf_debug("sum: ", result);
> +    debug_fprintf(stdout, "Scaling: %d\n", scale);
> +    result.exp += scale;
> +    xf_debug("post-scale: ", result);
> +    return xf_round_df_t(result).f;
> +}
> +
> +float internal_fmafx(float a_in, float b_in, float c_in, int scale)
> +{
> +    sf_t a, b, c;
> +    xf_t prod;
> +    xf_t acc;
> +    xf_t result;
> +    xf_init(&prod);
> +    xf_init(&acc);
> +    xf_init(&result);
> +    a.f = a_in;
> +    b.f = b_in;
> +    c.f = c_in;
> +
> +    debug_fprintf(stdout,
> +                  "internal_fmax: 0x%016x * 0x%016x + 0x%016x sc: %d\n",
> +                  fUNFLOAT(a_in), fUNFLOAT(b_in), fUNFLOAT(c_in), scale);
> +    if (isinf(a.f) || isinf(b.f) || isinf(c.f)) {
> +        return special_fmaf(a, b, c);
> +    }
> +    if (isnan(a.f) || isnan(b.f) || isnan(c.f)) {
> +        return special_fmaf(a, b, c);
> +    }
> +    if ((scale == 0) && (isz(a.f) || isz(b.f))) {
> +        return a.f * b.f + c.f;
> +    }
> +
> +    /* (a * 2**b) * (c * 2**d) == a*c * 2**(b+d) */
> +    prod.mant = int128_mul_6464(sf_getmant(a), sf_getmant(b));
> +
> +    /*
> +     * Note: extracting the mantissa into an int is multiplying by
> +     * 2**23, so adjust here
> +     */
> +    prod.exp = sf_getexp(a) + sf_getexp(b) - SF_BIAS - 23;
> +    prod.sign = a.x.sign ^ b.x.sign;
> +    if (isz(a.f) || isz(b.f)) {
> +        prod.exp = -2 * WAY_BIG_EXP;
> +    }
> +    xf_debug("prod: ", prod);
> +    if ((scale > 0) && (fpclassify(c.f) == FP_SUBNORMAL)) {
> +        acc.mant = int128_mul_6464(0, 0);
> +        acc.exp = -WAY_BIG_EXP;
> +        acc.sign = c.x.sign;
> +        acc.sticky = 1;
> +        xf_debug("special denorm acc: ", acc);
> +        result = xf_add(prod, acc);
> +    } else if (!isz(c.f)) {
> +        acc.mant = int128_mul_6464(sf_getmant(c), 1);
> +        acc.exp = sf_getexp(c);
> +        acc.sign = c.x.sign;
> +        xf_debug("acc: ", acc);
> +        result = xf_add(prod, acc);
> +    } else {
> +        result = prod;
> +    }
> +    xf_debug("sum: ", result);
> +    debug_fprintf(stdout, "Scaling: %d\n", scale);
> +    result.exp += scale;
> +    xf_debug("post-scale: ", result);
> +    return xf_round_sf_t(result).f;
> +}
> +
> +
> +float internal_fmaf(float a_in, float b_in, float c_in)
> +{
> +    return internal_fmafx(a_in, b_in, c_in, 0);
> +}
> +
> +double internal_fma(double a_in, double b_in, double c_in)
> +{
> +    return internal_fmax(a_in, b_in, c_in, 0);
> +}
> +
> +float internal_mpyf(float a_in, float b_in)
> +{
> +    if (isz(a_in) || isz(b_in)) {
> +        return a_in * b_in;
> +    }
> +    return internal_fmafx(a_in, b_in, 0.0, 0);
> +}
> +
> +double internal_mpy(double a_in, double b_in)
> +{
> +    if (isz(a_in) || isz(b_in)) {
> +        return a_in * b_in;
> +    }
> +    return internal_fmax(a_in, b_in, 0.0, 0);
> +}
> +
> +static inline double internal_mpyhh_special(double a, double b)
> +{
> +    return a * b;
> +}
> +
> +double internal_mpyhh(double a_in, double b_in,
> +                      unsigned long long int accumulated)
> +{
> +    df_t a, b;
> +    xf_t x;
> +    unsigned long long int prod;
> +    unsigned int sticky;
> +
> +    a.f = a_in;
> +    b.f = b_in;
> +    sticky = accumulated & 1;
> +    accumulated >>= 1;
> +    xf_init(&x);
> +    if (isz(a_in) || isnan(a_in) || isinf(a_in)) {
> +        return internal_mpyhh_special(a_in, b_in);
> +    }
> +    if (isz(b_in) || isnan(b_in) || isinf(b_in)) {
> +        return internal_mpyhh_special(a_in, b_in);
> +    }
> +    x.mant = int128_mul_6464(accumulated, 1);
> +    x.sticky = sticky;
> +    prod = fGETUWORD(1, df_getmant(a)) * fGETUWORD(1, df_getmant(b));
> +    x.mant = int128_add(x.mant, int128_mul_6464(prod, 0x100000000ULL));
> +    x.exp = df_getexp(a) + df_getexp(b) - DF_BIAS - 20;
> +    xf_debug("formed: ", x);
> +    if (!isnormal(a_in) || !isnormal(b_in)) {
> +        /* crush to inexact zero */
> +        x.sticky = 1;
> +        x.exp = -4096;
> +        xf_debug("crushing: ", x);
> +    }
> +    x.sign = a.x.sign ^ b.x.sign;
> +    xf_debug("with sign: ", x);
> +    return xf_round_df_t(x).f;
> +}
> +
> +float conv_df_to_sf(double in_f)
> +{
> +    xf_t x;
> +    df_t in;
> +    if (isz(in_f) || isnan(in_f) || isinf(in_f)) {
> +        return in_f;
> +    }
> +    xf_init(&x);
> +    in.f = in_f;
> +    x.mant = int128_mul_6464(df_getmant(in), 1);
> +    x.exp = df_getexp(in) - DF_BIAS + SF_BIAS - 52 + 23;
> +    x.sign = in.x.sign;
> +    xf_debug("conv to sf: x: ", x);
> +    return xf_round_sf_t(x).f;
> +}
> +
> diff --git a/target/hexagon/fma_emu.h b/target/hexagon/fma_emu.h
> new file mode 100644
> index 0000000..e38cad9
> --- /dev/null
> +++ b/target/hexagon/fma_emu.h
> @@ -0,0 +1,30 @@
> +/*
> + *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef FMA_EMU_H
> +#define FMA_EMU_H
> +
> +extern float internal_fmafx(float a_in, float b_in, float c_in, int scale);
> +extern float internal_fmaf(float a_in, float b_in, float c_in);
> +extern double internal_fma(double a_in, double b_in, double c_in);
> +extern double internal_fmax(double a_in, double b_in, double c_in, int scale);
> +extern float internal_mpyf(float a_in, float b_in);
> +extern double internal_mpy(double a_in, double b_in);
> +extern double internal_mpyhh(double a_in, double b_in,
> +                             unsigned long long int accumulated);
> +
> +#endif
> 


