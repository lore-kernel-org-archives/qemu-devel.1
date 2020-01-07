Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A84C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DAC20656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XASQL75o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DAC20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iotcq-0001Xo-QT
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 13:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iotak-0007kV-MV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iotai-0003Wd-9m
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:34 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iotai-0003TH-4L
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:32 -0500
Received: by mail-pf1-x441.google.com with SMTP id 2so257523pfg.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 10:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=alfB7Sh7np8t+qhn4btYu3UL6CIoMCLQeCh5Mx/68Dk=;
 b=XASQL75o3D50xj62XD9u01FSRJtyWA++jD7V5l/NN4BEefAQ+1ID/iONUZcOZZ02w1
 0DuQ/RncO1/HLguF/zeofdRK05DEXSw7pu6Ct0dyYeoTtT4awLsfNVKiDR19DOpDNIld
 r9I9slwE1tPyA1nJa/9YU0QlwOM9bSUjpzSi9veNM+BM8M6EBkXixaIiQEGBTmP06r47
 pY4QlkqbaFeJb1WlBuuIde6wTX3IDDaQSWhng7IouBetu8dfew3ginrS+NJ7mUUXEjZP
 IK99uSaCGDpO5gIoKqShoRLD2AFKehzIk/+aeBP0SE9OTA4tHnT0IIGIs4H+PK/Ivc/m
 3VFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=alfB7Sh7np8t+qhn4btYu3UL6CIoMCLQeCh5Mx/68Dk=;
 b=PHVdWOMF6sqR7xYhmPU9L3oy6F823oxxI2d49ojkfsPUnI/QLErscgr2GE5+3kfsi+
 XC5deIQTprNfiIlNG0KEKyvDbAd5YJGC4mDg1CehU+NOpoFvjU4IG3NdmuAPMYNmNU0U
 0xcmaTG9rjYB/UiBDP7JtYYUufTOg3ogpqe4Og3MSVgc116Dgm4Lc22YEx4SXMGOjuMn
 /b6Bfh244Vb+EAPoUNdzIEidMNZr9tPgAkujBQCcc8ciIIxnsH9IdLYnCag9mvAoEd4A
 V86zV6RikfnZ0fwjtb9QTF5ZrX71T5LidX5UZXzmwUQtlMp4vTcAiFYX69KEppOAtWDA
 JsAA==
X-Gm-Message-State: APjAAAUDCMyQ0a/tJQFIcewdppyrBXEvitGtP4BAqcKtPWSyhG4mbGoQ
 O/WRQGL1AuX5IulZ/JcjD5Pp9LTu9wc=
X-Google-Smtp-Source: APXvYqyLdYwgs5ll9Q/liSxIOnwZ2DzQny7gOoNCNFChhOoZXnXJbO9Lkx3Bpcy2pO1m1CiGWPRebg==
X-Received: by 2002:a65:4587:: with SMTP id o7mr776718pgq.303.1578421708312;
 Tue, 07 Jan 2020 10:28:28 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id y7sm230090pfb.139.2020.01.07.10.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 10:28:27 -0800 (PST)
Date: Tue, 07 Jan 2020 10:28:27 -0800 (PST)
X-Google-Original-Date: Tue, 07 Jan 2020 10:27:32 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 05/36] target/riscv: Add support for the new execption
 numbers
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <1d461d2c750cf9e5573294b82d874b3823817c7e.1575914822.git.alistair.francis@wdc.com>
References: <1d461d2c750cf9e5573294b82d874b3823817c7e.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-b045e9a9-8481-45ec-9561-e33606473513@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

On Mon, 09 Dec 2019 10:10:53 PST (-0800), Alistair Francis wrote:
> The v0.5 Hypervisor spec add new execption numbers, let's add support
> for those.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c        |  8 ++++++++
>  target/riscv/cpu_bits.h   | 35 +++++++++++++++++++----------------
>  target/riscv/cpu_helper.c |  7 +++++--
>  target/riscv/csr.c        |  7 +++++--
>  4 files changed, 37 insertions(+), 20 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e521ebe2e1..d23d2cba64 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -67,6 +67,14 @@ const char * const riscv_excp_names[] = {
>      "load_page_fault",
>      "reserved",
>      "store_page_fault"
> +    "reserved",
> +    "reserved",
> +    "reserved",
> +    "reserved",
> +    "guest_exec_page_fault",
> +    "guest_load_page_fault",
> +    "reserved",
> +    "guest_store_page_fault"
>  };
>
>  const char * const riscv_intr_names[] = {
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 25c0fb258d..9ce73c36de 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -488,22 +488,25 @@
>  #define DEFAULT_RSTVEC      0x1000
>
>  /* Exception causes */
> -#define EXCP_NONE                          -1 /* sentinel value */
> -#define RISCV_EXCP_INST_ADDR_MIS           0x0
> -#define RISCV_EXCP_INST_ACCESS_FAULT       0x1
> -#define RISCV_EXCP_ILLEGAL_INST            0x2
> -#define RISCV_EXCP_BREAKPOINT              0x3
> -#define RISCV_EXCP_LOAD_ADDR_MIS           0x4
> -#define RISCV_EXCP_LOAD_ACCESS_FAULT       0x5
> -#define RISCV_EXCP_STORE_AMO_ADDR_MIS      0x6
> -#define RISCV_EXCP_STORE_AMO_ACCESS_FAULT  0x7
> -#define RISCV_EXCP_U_ECALL                 0x8
> -#define RISCV_EXCP_S_ECALL                 0x9
> -#define RISCV_EXCP_H_ECALL                 0xa
> -#define RISCV_EXCP_M_ECALL                 0xb
> -#define RISCV_EXCP_INST_PAGE_FAULT         0xc /* since: priv-1.10.0 */
> -#define RISCV_EXCP_LOAD_PAGE_FAULT         0xd /* since: priv-1.10.0 */
> -#define RISCV_EXCP_STORE_PAGE_FAULT        0xf /* since: priv-1.10.0 */
> +#define EXCP_NONE                                -1 /* sentinel value */
> +#define RISCV_EXCP_INST_ADDR_MIS                 0x0
> +#define RISCV_EXCP_INST_ACCESS_FAULT             0x1
> +#define RISCV_EXCP_ILLEGAL_INST                  0x2
> +#define RISCV_EXCP_BREAKPOINT                    0x3
> +#define RISCV_EXCP_LOAD_ADDR_MIS                 0x4
> +#define RISCV_EXCP_LOAD_ACCESS_FAULT             0x5
> +#define RISCV_EXCP_STORE_AMO_ADDR_MIS            0x6
> +#define RISCV_EXCP_STORE_AMO_ACCESS_FAULT        0x7
> +#define RISCV_EXCP_U_ECALL                       0x8
> +#define RISCV_EXCP_S_ECALL                      0x9
> +#define RISCV_EXCP_VS_ECALL                      0xa
> +#define RISCV_EXCP_M_ECALL                       0xb
> +#define RISCV_EXCP_INST_PAGE_FAULT               0xc /* since: priv-1.10.0 */
> +#define RISCV_EXCP_LOAD_PAGE_FAULT               0xd /* since: priv-1.10.0 */
> +#define RISCV_EXCP_STORE_PAGE_FAULT              0xf /* since: priv-1.10.0 */
> +#define RISCV_EXCP_INST_GUEST_PAGE_FAULT         0x14
> +#define RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT       0x15
> +#define RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT  0x17
>
>  #define RISCV_EXCP_INT_FLAG                0x80000000
>  #define RISCV_EXCP_INT_MASK                0x7fffffff
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 0de3a468eb..c201919c54 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -526,7 +526,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      static const int ecall_cause_map[] = {
>          [PRV_U] = RISCV_EXCP_U_ECALL,
>          [PRV_S] = RISCV_EXCP_S_ECALL,
> -        [PRV_H] = RISCV_EXCP_H_ECALL,
> +        [PRV_H] = RISCV_EXCP_VS_ECALL,
>          [PRV_M] = RISCV_EXCP_M_ECALL
>      };
>
> @@ -542,6 +542,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          case RISCV_EXCP_INST_PAGE_FAULT:
>          case RISCV_EXCP_LOAD_PAGE_FAULT:
>          case RISCV_EXCP_STORE_PAGE_FAULT:
> +        case RISCV_EXCP_INST_GUEST_PAGE_FAULT:
> +        case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
> +        case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
>              tval = env->badaddr;
>              break;
>          default:
> @@ -554,7 +557,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          }
>      }
>
> -    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval, cause < 16 ?
> +    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval, cause < 23 ?
>          (async ? riscv_intr_names : riscv_excp_names)[cause] : "(unknown)");
>
>      if (env->priv <= PRV_S &&
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index da02f9f0b1..6a0a59edfd 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -242,11 +242,14 @@ static const target_ulong delegable_excps =
>      (1ULL << (RISCV_EXCP_STORE_AMO_ACCESS_FAULT)) |
>      (1ULL << (RISCV_EXCP_U_ECALL)) |
>      (1ULL << (RISCV_EXCP_S_ECALL)) |
> -    (1ULL << (RISCV_EXCP_H_ECALL)) |
> +    (1ULL << (RISCV_EXCP_VS_ECALL)) |
>      (1ULL << (RISCV_EXCP_M_ECALL)) |
>      (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) |
>      (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) |
> -    (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT));
> +    (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) |
> +    (1ULL << (RISCV_EXCP_INST_GUEST_PAGE_FAULT)) |
> +    (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) |
> +    (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT));
>  static const target_ulong sstatus_v1_9_mask = SSTATUS_SIE | SSTATUS_SPIE |
>      SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
>      SSTATUS_SUM | SSTATUS_SD;

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

