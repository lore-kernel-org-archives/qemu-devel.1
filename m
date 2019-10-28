Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F49CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAED214B2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RVwMoFSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAED214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP9pz-0000pf-Vr
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 14:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP8Jm-0008IY-Jz
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP8Jl-0004wX-2y
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:56:34 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP8Jk-0004w7-Tc
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:56:33 -0400
Received: by mail-pf1-x443.google.com with SMTP id v4so7268942pff.6
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=7QjzFN0npZElQvBMgyEyOgLMwR1v53vRNPgzVoDubjE=;
 b=RVwMoFSfrSfdW3iDDbCG5Maq/hrSrN5zfpE3QLjlyoNCk2Nhu+sh0BUh90ildNiG6Q
 wWGxYw+Ii3Td6H+cBxItDfWmHTK6rjd3h9KfQNx1l3CjNr1MDw59xIJb9CK6N9PYQqvS
 LYBojLIoScXOon0tSgmG9lULurMND3Q7DEK9yF49jMOlb9s0PYkGVyxQ520IJrpRbTkS
 tbf929v8Y1ie8GpLZgHw2rx0a2tuiqAaCVpCcFW0dEmOw3ZWDyobayvGwBNY/kKpq2xd
 +ZPXgPyq9UUPHVKSHoNj2gcVz5eYJpBEQR/4rReumjYw4g0hgVwTMda7s1Nd1jDei1NZ
 VecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=7QjzFN0npZElQvBMgyEyOgLMwR1v53vRNPgzVoDubjE=;
 b=a+6lGYIVi5E6JFhwJCyuSzmIKp/nYjlGWBdeTlvQ88sUdjVivK/AN0V9ai3yddQprt
 GssQxyyVo9WkirYW4uDbNPSHqCt/yzoDpl145usXAXsfH/FNSWL+i6hBIsdfTlRY6Gyj
 OztXzpSMd8o/t9jKWE8i23poneoXwT7ZRdflraMnLBptOQzcse7jLlXBovchzgz6yLtj
 jBTbC/axylVDkWNpg//iaWyMK0BwC+TfXVGPJDRyZQtqVHL7Oc3r5wb/Cl6xmbPQyAlj
 M9lU2/MgigpBtLW1yveQTCFwhDtv5DX7j7gf/c5sJbe8oa1nqIvMBljrbyweiKQvC1mJ
 t1Rg==
X-Gm-Message-State: APjAAAVDAy7KD3ul0tO+xgXO9H1XakMVvu6yOXdb+3T2s2DOsE59sEV7
 hgxVIk5FDvrQRX04/+oTJDu8lg==
X-Google-Smtp-Source: APXvYqxLlmDBZg/P/vEF8ikzHnQffFtewrj9TzaWVoQNGC13iKdBk6LVrKEwayd/n2sMqP5zjZigzQ==
X-Received: by 2002:a17:90a:cf8d:: with SMTP id
 i13mr238909pju.139.1572281791228; 
 Mon, 28 Oct 2019 09:56:31 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id t27sm11803729pfq.169.2019.10.28.09.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 09:56:30 -0700 (PDT)
Date: Mon, 28 Oct 2019 09:56:30 -0700 (PDT)
X-Google-Original-Date: Mon, 28 Oct 2019 09:55:55 PDT (-0700)
Subject: Re: [PATCH v1 1/1] opensbi: Upgrade from v0.4 to v0.5
In-Reply-To: <CAP+75-XUbnCDp-JH6JRnGLqVMxDWTFa9kPHJaZXm3NfCzZUbYg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: philmd@redhat.com
Message-ID: <mhng-90e9ee91-7ee7-488a-8db0-35d39043f2fc@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

On Sat, 26 Oct 2019 01:46:45 PDT (-0700), philmd@redhat.com wrote:
> On Sat, Oct 26, 2019 at 10:45 AM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
>>
>> Hi Alistair,
>>
>> On 10/26/19 1:15 AM, Alistair Francis wrote:
>> > This release has:
>> >      Lot of critical fixes
>> >      Hypervisor extension support
>> >      SBI v0.2 base extension support
>> >      Debug prints support
>> >      Handle traps when doing unpriv load/store
>> >      Allow compiling without FP support
>> >      Use git describe to generate boot-time banner
>> >      Andes AE350 platform support
>>
>> Do you mind amending the output of 'git shortlog v0.4..v0.5'?
>
> Err this comment is for Palmer, if Alistair agree (no need to repost).

Works for me.  I've included the shortlog as part of the patch on my for-master 
branch, unless there's any opposition I'll include this in my next PR.

>
>> >
>> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > ---
>> > You can get the branch from here if the binaries are causing issues:
>> > https://github.com/alistair23/qemu/tree/mainline/alistair/opensbi.next
>>
>> You can use 'git format-patch --no-binary'.
>>
>> >
>> >   pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 36888 -> 40984 bytes
>> >   pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 45064 -> 49160 bytes
>> >   pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 40968 -> 45064 bytes
>> >   roms/opensbi                                 |   2 +-
>> >   4 files changed, 1 insertion(+), 1 deletion(-)
>> [...]
>> > diff --git a/roms/opensbi b/roms/opensbi
>> > index ce228ee091..be92da280d 160000
>> > --- a/roms/opensbi
>> > +++ b/roms/opensbi
>> > @@ -1 +1 @@
>> > -Subproject commit ce228ee0919deb9957192d723eecc8aaae2697c6
>> > +Subproject commit be92da280d87c38a2e0adc5d3f43bab7b5468f09
>> >

