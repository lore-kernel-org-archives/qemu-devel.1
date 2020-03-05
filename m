Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC050C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 21:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64292072A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 21:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="VN8EUSIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64292072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9yMb-0001UM-0L
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 16:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1j9yM0-0000vq-M1
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 16:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1j9yLy-0000EK-OP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 16:48:28 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:50724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1j9yLy-0000CQ-1j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 16:48:26 -0500
Received: by mail-pj1-x1043.google.com with SMTP id nm6so160846pjb.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 13:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=kK7DAQhSovPQIHP7NJRB9OBqnwzxugQmovRNvrNYNqI=;
 b=VN8EUSIHMPWB15j1ItimJ//QpF9wD1DLE15MmlC8AEGbP2rAWFuNLR8Eb0PL6LJy9g
 J0R6gR2xmHG2Mrdf5mwcUKry7FQPaDn7eq0zW1n6BSd8yCWI9sL3g8OXJKCRkYkzkXKk
 zRgV/Ye2UDBG4LAjPS1I8AHVcmi/06UcYljWJtAKkCPcHmnNAZcAgHdgaGgHCDIN40Fd
 lE2jqp1O3tlXYvNkifiIF5yUP3QHmqKeZOA95PQBo77mfoUXOLir6f71TmdgYEoKWnAf
 0GHVpGSmcjHfe8oYFV5rJ0v/H1uj8XPOVJQB/CCPxDgsnDJ09t0fIfXyBBihgL10Xt0l
 Tmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=kK7DAQhSovPQIHP7NJRB9OBqnwzxugQmovRNvrNYNqI=;
 b=QCYAwWHSh+ns6SENm1ko4QiuVTyMwCkOazq981eyMzUt3I02sQmnMGqA7YtZGVa956
 oiBLcRr5JJKdmA+NgfvEbeOX+oWd1e7jRvjsYKkTopTQPRMYkoDsep9NG++hKW11xtkJ
 txan+4eVuA6xTsS+Bia2KRnDc0MLMVwTX/0BmgEn2+aoeu5fs5iC20IYjnW1PrkKNdxZ
 DobiZ2M3S7M3zfgKNHDqyFW1XswC9WejpuU5AKy3lzvfa8oduNpyO2YYYs69RpJR/T7/
 9iGWXwme3/qNRIyYrC+A4TTH9894HaIFXf8/qhfM5sfDa2KGynEtdi1Hu97P1q1BlzTn
 H6Hw==
X-Gm-Message-State: ANhLgQ2Un/o79koK/ORRRtv3SJAuIFWNQnAbY72OLOlXvXiNKh3ZNXkz
 uQT/zMV9KjEGQHDIxcEVtQNL9A==
X-Google-Smtp-Source: ADFU+vv7aYTWfRw73C18X7VOZMfb+IPxVAwTiz/ZtqRwuno90kZJ32JAUyABbKViyNypUshEEn/k8Q==
X-Received: by 2002:a17:90a:280a:: with SMTP id
 e10mr148301pjd.145.1583444904027; 
 Thu, 05 Mar 2020 13:48:24 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id q12sm32835848pfh.158.2020.03.05.13.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 13:48:23 -0800 (PST)
Date: Thu, 05 Mar 2020 13:48:23 -0800 (PST)
X-Google-Original-Date: Thu, 05 Mar 2020 13:34:29 PST (-0800)
Subject: Re: [PATCH v1 1/1] target/riscv: Correctly implement TSR trap
In-Reply-To: <CAKmqyKPGJQMqW7ZbWBYRDUxH_PRRSvUW6tEwBAdW+MTE-RG5+w@mail.gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alistair23@gmail.com
Message-ID: <mhng-11dd6ba7-bf5a-4a16-b8d7-e7b887338cf1@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 10:41:35 PST (-0800), alistair23@gmail.com wrote:
> On Mon, Jan 20, 2020 at 9:43 PM Alistair Francis
> <alistair.francis@wdc.com> wrote:
>>
>> As reported in: https://bugs.launchpad.net/qemu/+bug/1851939 we weren't
>> correctly handling illegal instructions based on the value of MSTATUS_TSR
>> and the current privledge level.
>>
>> This patch fixes the issue raised in the bug by raising an illegal
>> instruction if TSR is set and we are in S-Mode.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>
> @Palmer Dabbelt  Ping!

Sorry, I must have missed this.  It's in the queue (with the reviews as
collected by patchwork).

Thanks!

>
> Alistair
>
>> ---
>>  target/riscv/op_helper.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>> index 331cc36232..eed8eea6f2 100644
>> --- a/target/riscv/op_helper.c
>> +++ b/target/riscv/op_helper.c
>> @@ -83,7 +83,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>>      }
>>
>>      if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
>> -        get_field(env->mstatus, MSTATUS_TSR)) {
>> +        get_field(env->mstatus, MSTATUS_TSR) && !(env->priv >= PRV_M)) {
>>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>>      }
>>
>> --
>> 2.24.1
>>

