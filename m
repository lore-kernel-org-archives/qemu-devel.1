Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5FDC2BA12
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2D92073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="R8RgZzVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2D92073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKOow-0001MG-Tk
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 12:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1jKOlA-0006IW-UJ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1jKOl9-0008AN-6X
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:01:32 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1jKOl8-00087b-OK
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:01:31 -0400
Received: by mail-pg1-x541.google.com with SMTP id 142so3679725pgf.11
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=LqvGyD+24JMyraAKv5uQyvYhkRjE/KxXflK+dGY7DZA=;
 b=R8RgZzVoo84RO58LZjGvRhyZYqLw42B9YFVqL2d3UQYMauLNA3UCw3swzjZIKrXLiV
 1x0QoKbRreo9zhRo8g+4jzDdSwgWzTmLEAtPvuLNTVKq/Svfc5GyCoAVb3daMhGEZVRL
 d2r1zaPU9cUVe4N8nbSY6BuPuTwIyE2vC3H7OJ5V/UI4BDBmLxDCGcWlZe8ExyjPDETx
 TiJb6moEcqmT/GghWyZ6pQ+w1MjM4glBsZjL+MSJMupq8Noz4rPJ8WWoqiMCgQyAnm2D
 5Z+ogLJUU0xaQ24yYcw1sk5AgAdvjEWAKK51DQ42kFwrsNJAzEoy6ppwMnOSRnp4XP9P
 dJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=LqvGyD+24JMyraAKv5uQyvYhkRjE/KxXflK+dGY7DZA=;
 b=K0FbLa960awUlKyRc1RIcUuN042U+xj2KdBwyAKYEGjbB2WroJ/vd+NCKNgQIeLt6Y
 Ttb2RcuGjWszDMn0npfvSyI9ydv0PM1CccTrJQfpv+t7hpY+DK2DSzL7oMXIDPI6ghWp
 CPtoNL/I1VungbWreHCZ6pX1EFG2KUMqh9AfUR/zxCPDGR/wj1uq3SBrsWDoIuxBXMix
 78+G6URSaBInGs0SU8+4yyLo8tkJX1AJnSb4syeHONJIfIKsPDaTdbChSX5UmEtjNYFn
 BjNuBQuNsOjgkrGj1edJs98UdC1XPQ8l6HFk4tnSvvFtznMHo2SdL2vP68rNYMu1b6Tb
 mU8g==
X-Gm-Message-State: AGi0PuZ3Iw5Zoq3aWGWxg4op5R1ZUlxCeK1PK+ceVKm5VvmRzpXST5Nl
 4KeGB1prM+BNC+XbqvOjD5KdCw==
X-Google-Smtp-Source: APiQypL1rtTVuxpMyaupyr+Fh5McQhP7xb2ZdvsVvTvgcyo1a64T+ChJsE17lqg4ssuNqA4ZdfLRSA==
X-Received: by 2002:a65:578d:: with SMTP id b13mr2693946pgr.122.1585929688134; 
 Fri, 03 Apr 2020 09:01:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id c128sm5995798pfa.11.2020.04.03.09.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 09:01:27 -0700 (PDT)
Date: Fri, 03 Apr 2020 09:01:27 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Apr 2020 09:01:13 PDT (-0700)
Subject: Re: [PATCH v3 0/3] hw/riscv: Add a serial property to sifive_u
In-Reply-To: <CAEUhbmUHNLYoJutr3dg0hpEPehuzRD4r6eux1EStZxCknMst0w@mail.gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-c816dc59-981b-4410-a6c1-240a8cf35ca2@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 19:08:19 PDT (-0700), bmeng.cn@gmail.com wrote:
> Hi Palmer,
>
> On Sat, Mar 7, 2020 at 5:45 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
>>
>> At present the board serial number is hard-coded to 1, and passed
>> to OTP model during initialization. Firmware (FSBL, U-Boot) uses
>> the serial number to generate a unique MAC address for the on-chip
>> ethernet controller. When multiple QEMU 'sifive_u' instances are
>> created and connected to the same subnet, they all have the same
>> MAC address hence it creates a unusable network.
>>
>> A new "serial" property is introduced to specify the board serial
>> number. When not given, the default serial number 1 is used.
>>
>
> Could you please take this for v5.0.0?

It's in the queue, sorry I missed them.

