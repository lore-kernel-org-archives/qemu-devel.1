Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA94C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AED2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBqFYcpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AED2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1XXa-0002kM-8b
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1XWQ-0001qP-U0
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1XWP-0002sm-8Z
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:32:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27417
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1XWP-0002rd-45
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581435140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9p7W8vCwgbs6Z24ZZ/d+o9d2u4NmLyjWKbsRozZS0B4=;
 b=eBqFYcpyXDHPssfVvawV9L2f6Eed5w9dwMUxm5Cs4Ca+fciarWnu2K0sl/vKowx/aFRX+/
 wSrnDBmLICaCNUxTU2tcUrt1KZn5uHtrkT1u+RvpVGKycwzJ4mbQMLqlKZbwnv7S24GOeE
 CyELCIzmzSv1lkOtwzscYNsUFCVG+HE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-GYbn-70FPXSOiGU6TwGczg-1; Tue, 11 Feb 2020 10:32:18 -0500
Received: by mail-wm1-f70.google.com with SMTP id t17so1562041wmi.7
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 07:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9p7W8vCwgbs6Z24ZZ/d+o9d2u4NmLyjWKbsRozZS0B4=;
 b=r+p0qENCWSBi/MoLpssDBaRhiVtApx2gnC/NsFpcOMBmiA8aChNC4qzwvnTFplgAbt
 0N8p6Jmgezap1dwEPskTVTJYgaiF9ylTHmUDZQhV1hhLeJaSbzS+lavAMnZ7ULeJF4Xp
 H6MlmdqQJOLICz0i2d/7aX7o4EGRC4/4znIYIPEXZ+t7ZTCv/IBAhDO3wLMOE4vU6WhT
 8+U1HKXFImO2FxPErl3kcI9G9wwL4JZpcrNADiwloNYTr871Etom8veS3v3hTu8lrTor
 xZ+Y8CNewINacO1okpq0LKuAbbDtQiU0KYas+DA8kHCCr/HSHch1IwSASml4i4wq88oD
 0ZPw==
X-Gm-Message-State: APjAAAXobx+LeGB5Q/0VA7ut1lCge0kLKlp0tXNTQDUcq3HVGnDkaFCx
 HUlGodieIgHfdHxSznJAoMWsl+jeM17xG6FbagLM1BXaUc4uc/23Ieu4CgM5c7YEaF3D2ibSj/w
 rjI2nUqatiN9xIbE=
X-Received: by 2002:a5d:6646:: with SMTP id f6mr9748899wrw.276.1581435137407; 
 Tue, 11 Feb 2020 07:32:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZ8UKqCcAYJWUin5du2aWHq/4ffUuKvvWRb03xiiVUPkSiifbOQe3Qf6VMMjIf5Zz02UNPdQ==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr9748884wrw.276.1581435137181; 
 Tue, 11 Feb 2020 07:32:17 -0800 (PST)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id g79sm4026392wme.17.2020.02.11.07.32.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 07:32:16 -0800 (PST)
Subject: Re: [RFC PATCH 00/66] Hexagon patch series
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cc5cf589-f27e-151e-964b-6a263e2f668d@redhat.com>
Date: Tue, 11 Feb 2020 16:32:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: GYbn-70FPXSOiGU6TwGczg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Hi Taylor,

On 2/11/20 1:39 AM, Taylor Simpson wrote:
> This series adds support for the Hexagon processor with Linux user support
> 
[...]>   MAINTAINERS                                  |    8 +
>   configure                                    |    9 +
>   default-configs/hexagon-linux-user.mak       |    1 +
>   disas/Makefile.objs                          |    1 +
>   disas/hexagon.c                              |   56 +
>   include/disas/dis-asm.h                      |    1 +
>   include/elf.h                                |    2 +
>   linux-user/elfload.c                         |   16 +
>   linux-user/hexagon/cpu_loop.c                |  173 ++
>   linux-user/hexagon/signal.c                  |  276 ++
>   linux-user/hexagon/sockbits.h                |   18 +
>   linux-user/hexagon/syscall_nr.h              |  346 +++
>   linux-user/hexagon/target_cpu.h              |   44 +
>   linux-user/hexagon/target_elf.h              |   38 +
>   linux-user/hexagon/target_fcntl.h            |   18 +
>   linux-user/hexagon/target_signal.h           |   34 +
>   linux-user/hexagon/target_structs.h          |   46 +
>   linux-user/hexagon/target_syscall.h          |   32 +
>   linux-user/hexagon/termbits.h                |   18 +
>   linux-user/syscall.c                         |    2 +
>   linux-user/syscall_defs.h                    |   33 +
>   scripts/qemu-binfmt-conf.sh                  |    6 +-
>   target/hexagon/Makefile.objs                 |  109 +
>   target/hexagon/arch.c                        |  664 +++++
>   target/hexagon/arch.h                        |   62 +
>   target/hexagon/attribs.h                     |   32 +
>   target/hexagon/attribs_def.h                 |  404 +++
>   target/hexagon/conv_emu.c                    |  370 +++
>   target/hexagon/conv_emu.h                    |   50 +
>   target/hexagon/cpu-param.h                   |   26 +
>   target/hexagon/cpu.c                         |  356 +++
>   target/hexagon/cpu.h                         |  207 ++
>   target/hexagon/cpu_bits.h                    |   37 +
>   target/hexagon/decode.c                      |  792 +++++
>   target/hexagon/decode.h                      |   39 +
>   target/hexagon/dectree.py                    |  354 +++
>   target/hexagon/do_qemu.py                    | 1198 ++++++++
>   target/hexagon/fma_emu.c                     |  918 ++++++
>   target/hexagon/fma_emu.h                     |   30 +
>   target/hexagon/gdbstub.c                     |  111 +
>   target/hexagon/gen_dectree_import.c          |  205 ++
>   target/hexagon/gen_semantics.c               |  101 +
>   target/hexagon/genptr.c                      |   62 +
>   target/hexagon/genptr.h                      |   25 +
>   target/hexagon/genptr_helpers.h              | 1022 +++++++
>   target/hexagon/helper.h                      |   38 +
>   target/hexagon/helper_overrides.h            | 1850 ++++++++++++
>   target/hexagon/hex_arch_types.h              |   42 +
>   target/hexagon/hex_regs.h                    |   97 +
>   target/hexagon/iclass.c                      |  109 +
>   target/hexagon/iclass.h                      |   46 +
>   target/hexagon/imported/allext.idef          |   25 +
>   target/hexagon/imported/allext_macros.def    |   25 +
>   target/hexagon/imported/allextenc.def        |   20 +
>   target/hexagon/imported/allidefs.def         |   92 +
>   target/hexagon/imported/alu.idef             | 1335 +++++++++
>   target/hexagon/imported/branch.idef          |  344 +++
>   target/hexagon/imported/compare.idef         |  639 +++++
>   target/hexagon/imported/encode.def           |  126 +
>   target/hexagon/imported/encode_pp.def        | 2283 +++++++++++++++
>   target/hexagon/imported/encode_subinsn.def   |  150 +
>   target/hexagon/imported/float.idef           |  498 ++++
>   target/hexagon/imported/iclass.def           |   52 +
>   target/hexagon/imported/ldst.idef            |  421 +++
>   target/hexagon/imported/macros.def           | 3970 ++++++++++++++++++++++++++
>   target/hexagon/imported/mmvec/encode_ext.def |  830 ++++++
>   target/hexagon/imported/mmvec/ext.idef       | 2809 ++++++++++++++++++
>   target/hexagon/imported/mmvec/macros.def     | 1110 +++++++
>   target/hexagon/imported/mpy.idef             | 1269 ++++++++
>   target/hexagon/imported/shift.idef           | 1211 ++++++++
>   target/hexagon/imported/subinsns.idef        |  152 +
>   target/hexagon/imported/system.idef          |  302 ++
>   target/hexagon/insn.h                        |  149 +
>   target/hexagon/internal.h                    |   54 +
>   target/hexagon/macros.h                      | 1499 ++++++++++
>   target/hexagon/mmvec/decode_ext_mmvec.c      |  673 +++++
>   target/hexagon/mmvec/decode_ext_mmvec.h      |   24 +
>   target/hexagon/mmvec/macros.h                |  668 +++++
>   target/hexagon/mmvec/mmvec.h                 |   87 +
>   target/hexagon/mmvec/system_ext_mmvec.c      |  265 ++
>   target/hexagon/mmvec/system_ext_mmvec.h      |   38 +
>   target/hexagon/op_helper.c                   |  507 ++++
>   target/hexagon/opcodes.c                     |  223 ++
>   target/hexagon/opcodes.h                     |   67 +
>   target/hexagon/printinsn.c                   |   93 +
>   target/hexagon/printinsn.h                   |   26 +
>   target/hexagon/q6v_decode.c                  |  416 +++
>   target/hexagon/reg_fields.c                  |   28 +
>   target/hexagon/reg_fields.h                  |   40 +
>   target/hexagon/reg_fields_def.h              |  109 +
>   target/hexagon/regmap.h                      |   38 +
>   target/hexagon/translate.c                   |  906 ++++++
>   target/hexagon/translate.h                   |  112 +
>   tests/tcg/configure.sh                       |    4 +-
>   tests/tcg/hexagon/float_convs.ref            |  748 +++++
>   tests/tcg/hexagon/float_madds.ref            |  768 +++++
>   96 files changed, 35737 insertions(+), 2 deletions(-)

Please look at the file scripts/git.orderfile and if possible install it 
before your next version (please wait at least 1 week between version, 
for a so big series!). This script order files in patch in a way easier 
to review by mail.


