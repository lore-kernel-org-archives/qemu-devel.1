Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F725C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 02:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC8D2067D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 02:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNOoxggh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC8D2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXyrA-0000zK-CR
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 21:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iXyqS-0000W4-DU
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 21:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iXyqR-0006G5-Cv
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 21:38:52 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:32832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iXyqR-0006Ft-5Z
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 21:38:51 -0500
Received: by mail-pg1-x544.google.com with SMTP id h27so2631894pgn.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 18:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=jbn83bUftGc+2g8sczxL72tqKHzM4oLYdHruB05Msz4=;
 b=FNOoxgghtOTqEw2oJ2ZCCdJ3AEwldSEBpCHa05p0qvc7s7JMwX8UsROVuM9GTdFukd
 rRb34eGuzk97MzehAHo5XgFZcMm4lfGGg5cuKP+aAlYbdAvgZi08ZUX2VUbKH8hjyVwh
 B9qi2HJQPBVEqdEzv2auCbIx/0oTdGcm8SrJkuiYjfwisEh23Mru5iXBteD/rSC3r1Fv
 //GjcBcKpSwN2KSly7O7U/qXcCayAoW7sBcE6gJ3s2IJDjc13l7nREX3gTriReIGvvjK
 qFcJ15PhsgMrkXSYdT3vmH9ZgFkkMrgHX258FtGY9HRjI5SB8opDk1srWQv/FpFC1dEH
 y5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=jbn83bUftGc+2g8sczxL72tqKHzM4oLYdHruB05Msz4=;
 b=WC2ld2XuRr20iMO7u6FBUBa3g1VBbHZFIJHeo0vgUAbiDhyyoGJ3OLiyMaW8gmWplo
 m1swtdU8jeO3oTy7TZ3habbfLEelSD/jEP24Tzy7wCfzfp1NMFjXNTqLDPnZmv46I19R
 7lV1dZB9F+wux85mjky0Ujj5dCAkLX3DJQJebX6AYauWkaQEHwB7pCUm5o637D1Vimif
 bdAitkB471GJcjO5GCbA5yWF03whgvmwNFCXJiX1KUmLBHLwXC5v1i14643PwMC/LPes
 pe/yXoLvl4Aq9EBIkerkXohtbwmYulcHZSQH71Eqvd6ijDNBNMBObFjvPTF6gDcFqKs9
 /UVg==
X-Gm-Message-State: APjAAAVOHpvAabiCDr4LYoVnI4gQMFtMcQU9y1wcwCm3Rhr+/FSqe0Nh
 D6tC+pVf7Y4ByvGABXvytBLKmQ==
X-Google-Smtp-Source: APXvYqzxNJeu5wHQiHTTnQaLj+mojMHHkJ+5Equ7rqdqGjxa8deQid5nCJ+diZWyhGWQVSJmTGXlIQ==
X-Received: by 2002:a65:47c1:: with SMTP id f1mr12823367pgs.393.1574390329340; 
 Thu, 21 Nov 2019 18:38:49 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
 by smtp.gmail.com with ESMTPSA id r22sm5275105pfg.54.2019.11.21.18.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 18:38:48 -0800 (PST)
Date: Thu, 21 Nov 2019 18:38:48 -0800 (PST)
X-Google-Original-Date: Thu, 21 Nov 2019 18:18:47 PST (-0800)
Subject: Re: [PATCH] riscv: sifive_u: Add a "serial" property for board serial
 number
In-Reply-To: <CAEUhbmUuCOzd_Y6ip_oh13gt83rM8EffdXWRCa=KybOjAvEN-A@mail.gmail.com>
CC: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-b2e05f4a-7c3d-4be1-a843-a19b4054760a@palmerdabbelt.mtv.corp.google.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 17:10:18 PST (-0800), bmeng.cn@gmail.com wrote:
> On Sat, Nov 16, 2019 at 11:08 PM Bin Meng <bmeng.cn@gmail.com> wrote:
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
>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> ---
>>
>>  hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
>>  include/hw/riscv/sifive_u.h |  1 +
>>  2 files changed, 21 insertions(+), 1 deletion(-)
>>
>
> ping?

Sorry, it looks like I dropped this one.  I've put it in the queue for 5.0,
with a 

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!

