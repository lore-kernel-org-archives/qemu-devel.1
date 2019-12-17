Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B45C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7F320733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ca7SpgfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7F320733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHr1-0006Fq-FS
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1ihHq6-0005MK-JF
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1ihHq5-0008Pv-4k
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:44:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60391
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1ihHq5-0008Pf-1L
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576608296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=inO2Uvvr/+UyNZ4fVPGyM15afdt7XWMDhucdRr2VY8M=;
 b=ca7SpgfEX+oKtj3unuqEXgL6Xrvdvn6I9TEruXWjq5YotvYoek3xN4XbmaBMiBiXHmcAwe
 fuJeJQEY7iYhHh+hWXI7E42OE0Zi5zmu/3lN09S8tiBb5+5r90+MAqtnwwI6aYaUdeQ0KX
 TvQfyem5mRnfYaSjPjK6itKbzIOeQYI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-fmDD8AKjNZeK2fSQdcEzSQ-1; Tue, 17 Dec 2019 13:44:55 -0500
Received: by mail-wr1-f70.google.com with SMTP id y7so4374549wrm.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 10:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=inO2Uvvr/+UyNZ4fVPGyM15afdt7XWMDhucdRr2VY8M=;
 b=KDrpTZttlhdIpDv1vgXtHQrEKVWwWeR1/ChAaAVwpi95bsjJbRQeUfDhhk0BTmZ5fZ
 L9QyU4+3RF96wDzcE4iy8YpgVwQ5yevxivHc0lLo1INaZhG5Yq/eZx4oI3hI9lBtSma3
 2c4tP5MygDv/+bzB+iUuX7DRCMIr6LFWV/7kdXzK90VLMIRQBsl4IQUFslnmh2wxUbyg
 OwYHKM1MEUUyI4umNWkXgr3mMTqhXFRAqbQX8MRHyWz/dbIaf98xzU4VEYtPxysQFaiB
 KdxPLGduKKzjK5RLGn72U0TS+X3zLrSlgaSTt6Xz6f1QABLYxMAjyTRTOuHyyrRMV4ng
 1J7Q==
X-Gm-Message-State: APjAAAXhj+C30h9oiOyhePs5amXoWz7A0qDt86x0yqzAf3rQ1Hp11Anl
 yb9PO0zyKaBqLom6QC1vRPx80M+htvimk5ymEGViGbuawMKATbwKGCcmEy6OGexK++uQVSzX42A
 6ngoFFtOIf7WO0wNXVLZ3ocnGXCSwyQc=
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr6994538wmk.172.1576608293010; 
 Tue, 17 Dec 2019 10:44:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQmZIakMmipkWikrnanyG1m/X1ssgzoqaSqNwu0niOI7iN4rFpPdxfao2JtqbH5U66dfNQbZ9c03MFgLaJwrU=
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr6994513wmk.172.1576608292742; 
 Tue, 17 Dec 2019 10:44:52 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
 <CAL1e-=jvmJNiZR4iLDL-97qm=v+2s0cwn5YTzJQ=JZ_gwOe4tQ@mail.gmail.com>
 <BYAPR02MB4886C8D82898F1E406C124F8DE7E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <BYAPR02MB48865884056A88B660B620FCDE770@BYAPR02MB4886.namprd02.prod.outlook.com>
 <87d0dw83uz.fsf@linaro.org>
 <BYAPR02MB48866E2D82D9C76ABBECA842DE760@BYAPR02MB4886.namprd02.prod.outlook.com>
 <ffe58977-f251-df34-4bd0-62e32f78cc1a@linaro.org>
 <SN6PR02MB48953397AA553FA7456E7CFCDE700@SN6PR02MB4895.namprd02.prod.outlook.com>
 <BYAPR02MB488640DD7CC887E5FCC0F167DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <CAFEAcA-TpZfqbWjGX-tD0Osapt_K4yuTBg6+B=ZxU4MuVr7omg@mail.gmail.com>
 <ffdee96f-c9dc-0281-d4bc-da53e518e020@redhat.com>
In-Reply-To: <ffdee96f-c9dc-0281-d4bc-da53e518e020@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 17 Dec 2019 19:44:41 +0100
Message-ID: <CAP+75-UqzHE6FYymt-LoLW83bDHRuJTKZf7qb4ED9ZyZrrwAjg@mail.gmail.com>
Subject: Re: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
To: Peter Maydell <peter.maydell@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>
X-MC-Unique: fmDD8AKjNZeK2fSQdcEzSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Alessandro Di Federico <ale@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Niccol=C3=B2_Izzo?= <izzoniccolo@gmail.com>,
 "nizzo@rev.ng" <nizzo@rev.ng>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 17, 2019 at 7:41 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 12/17/19 7:21 PM, Peter Maydell wrote:
> > On Tue, 17 Dec 2019 at 18:16, Taylor Simpson <tsimpson@quicinc.com> wro=
te:
> >> Question 2:
> >> What is the best source of guidance on breaking down support for a new=
 target into a patch series?
> >
> > Look at how previous ports did it.
>
> Recent ports were system (softmmu), this is a linux-user port. The last
> architecture merged is RISCV, they did that with commit, so I'm not sure
> this is our best example on breaking down:
>
> $ git show --stat ea10325917c8
> commit ea10325917c8a8f92611025c85950c00f826cb73
> Author: Michael Clark <mjc@sifive.com>
> Date:   Sat Mar 3 01:31:10 2018 +1300
>
>      RISC-V Disassembler
>
>      The RISC-V disassembler has no dependencies outside of the 'disas'
>      directory so it can be applied independently. The majority of the
>      disassembler is machine-generated from instruction set metadata:
>
>      - https://github.com/michaeljclark/riscv-meta
>
>      Expected checkpatch errors for consistency and brevity reasons:
>
>      ERROR: line over 90 characters
>      ERROR: trailing statements should be on next line
>      ERROR: space prohibited between function name and open parenthesis '=
('
>
>      Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>      Signed-off-by: Michael Clark <mjc@sifive.com>
>
>   include/disas/bfd.h |    2 +
>   disas.c             |    2 +
>   disas/riscv.c       | 3048
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   disas/Makefile.objs |    1 +
>   4 files changed, 3053 insertions(+)
>
> $ git show --stat 55c2a12cbcd3d
> commit 55c2a12cbcd3d417de39ee82dfe1d26b22a07116
> Author: Michael Clark <mjc@sifive.com>
> Date:   Sat Mar 3 01:31:11 2018 +1300
>
>      RISC-V TCG Code Generation
>
>      TCG code generation for the RV32IMAFDC and RV64IMAFDC. The QEMU
>      RISC-V code generator has complete coverage for the Base ISA v2.2,
>      Privileged ISA v1.9.1 and Privileged ISA v1.10:
>
>      - RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
>      - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.=
9.1
>      - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.=
10
>
>      Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>      Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>      Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
>      Signed-off-by: Michael Clark <mjc@sifive.com>
>
>   target/riscv/instmap.h   |  364 ++++++++++++++++++++++++++++++++++++++
>   target/riscv/translate.c | 1978
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 2342 insertions(+)
>
> $ git show --stat 47ae93cdfed
> commit 47ae93cdfedc683c56e19113d516d7ce4971c8e6
> Author: Michael Clark <mjc@sifive.com>
> Date:   Sat Mar 3 01:31:11 2018 +1300
>
>      RISC-V Linux User Emulation
>
>      Implementation of linux user emulation for RISC-V.
>
>      Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>      Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
>      Signed-off-by: Michael Clark <mjc@sifive.com>
>
>   linux-user/riscv/syscall_nr.h     | 287
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++
>   linux-user/riscv/target_cpu.h     |  18 +++++++++++++
>   linux-user/riscv/target_elf.h     |  14 ++++++++++
>   linux-user/riscv/target_signal.h  |  23 ++++++++++++++++
>   linux-user/riscv/target_structs.h |  46 +++++++++++++++++++++++++++++++=
+
>   linux-user/riscv/target_syscall.h |  56
> ++++++++++++++++++++++++++++++++++++++
>   linux-user/riscv/termbits.h       | 222
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
>   linux-user/syscall_defs.h         |  13 +++++----
>   target/riscv/cpu_user.h           |  13 +++++++++
>   linux-user/elfload.c              |  22 +++++++++++++++
>   linux-user/main.c                 |  99
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   linux-user/signal.c               | 203
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   linux-user/syscall.c              |   2 ++
>   13 files changed, 1012 insertions(+), 6 deletions(-)

I sent too quick. You can read a summary of the different review
comments before the final merge in tag 'riscv-qemu-upstream-v8.2'.


