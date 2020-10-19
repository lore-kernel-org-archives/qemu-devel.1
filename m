Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9101AC43457
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A162240C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="ZiWePPVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A162240C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUeRl-0007AW-NF
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1kUePY-0005pa-LI
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:17:52 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1kUePV-0008J5-S6
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:17:52 -0400
Received: by mail-pg1-x541.google.com with SMTP id n9so903199pgt.8
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 16:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=YY1ILRmp4M0hCxPMW/WaBWUi+yH9DPtZryBGXuQw434=;
 b=ZiWePPViBta4F/gHgCHyYbtejUtpgHmBLpKQrgi7zaW6OJB9LbDFPWwV7j+k26oB8L
 KVgpOJNkEBekff9z0HDkZQJm3CDjlD2ppNDi9sDumzwco0vHzwyCXxIFfTVAuPULAEcS
 +sZGvsz9bExJq+SRhLoIAnq4TIHPf1ssvAS+dZ6CP4Ix6JU2xfm0oyAqzBKYiQ8T4RLQ
 S6wwUjm97+TH8ulMBqiaYSga4bb67UqoMLx7ncmx1P0XW+n9TXuCRwRG2peoEWMV5RTO
 0k2O/tORcXwqG/aLcFJbULrKcMGz0ZLbGC2BPyUYXhJN6JbIR/CmyoLMWviF3b5A2u34
 D0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=YY1ILRmp4M0hCxPMW/WaBWUi+yH9DPtZryBGXuQw434=;
 b=naRyoP2PZmQ/FAt8b/P8z8EBPcLbkgPZZG3Eqn4+7elgAG+WYa8VU/q6LFQ7smWFs+
 Ipvg4AUXcPqLVNYvn1Ezw8dhWSVv1HSwD/dAcKkKJQ4v8iVnxv7LbsVeNF1AIQ5M2U9J
 FluTdoxgxsvyJim7g55whbyZTPO80DjHwTNBR1icud6ChyQ3UjhPbvuHWe3czm5kQBpD
 aIlNmewz38Ie2h+d0Np1IyINPr7Lcol+GrZQsTDtj7+v2CaDUKalnnqT3+JSi143XDZt
 DLiyJLWrqKwNWVfzxAah/qByjpbNdoWisQJT6vqmiJ85d9HWgI8Zjis+K+28jvmqBCed
 xcuA==
X-Gm-Message-State: AOAM532DU0awo8WZ2adHYqU0UmQ1vpmXHg/5/kKhcahciIHmH51DcEVQ
 wwhSRbYtpcgBbNGhLJWtgrF5qJ3o0DSXoQ==
X-Google-Smtp-Source: ABdhPJyWQO85h+d9rrcdUco9yIrRbS/VHiWXc6Wosr3ULx2DI9YL4Z8Q1BV1RNXKKXgq74xJtTLGZw==
X-Received: by 2002:a63:df51:: with SMTP id h17mr153984pgj.273.1603149468211; 
 Mon, 19 Oct 2020 16:17:48 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id t17sm46959pjs.39.2020.10.19.16.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 16:17:47 -0700 (PDT)
Date: Mon, 19 Oct 2020 16:17:47 -0700 (PDT)
X-Google-Original-Date: Mon, 19 Oct 2020 14:39:39 PDT (-0700)
Subject: Re: [PATCH v2 2/4] hw/riscv: Return the end address of the loaded
 firmware
In-Reply-To: <558cf67162342d65a23262248b040563716628b2.1602634524.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-4386819f-6eeb-434a-94ec-f4304f0be5bf@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=palmer@dabbelt.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, bmeng.cn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 13 Oct 2020 17:17:28 PDT (-0700), Alistair Francis wrote:
> Instead of returning the unused entry address from riscv_load_firmware()
> instead return the end address. Also return the end address from
> riscv_find_and_load_firmware().
>
> This tells the caller if a firmware was loaded and how big it is. This
> can be used to determine the load address of the next image (usually the
> kernel).
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/hw/riscv/boot.h |  8 ++++----
>  hw/riscv/boot.c         | 28 +++++++++++++++++-----------
>  2 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 451338780a..0acbd8aa6e 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -23,10 +23,10 @@
>  #include "exec/cpu-defs.h"
>  #include "hw/loader.h"
>
> -void riscv_find_and_load_firmware(MachineState *machine,
> -                                  const char *default_machine_firmware,
> -                                  hwaddr firmware_load_addr,
> -                                  symbol_fn_t sym_cb);
> +target_ulong riscv_find_and_load_firmware(MachineState *machine,
> +                                          const char *default_machine_firmware,
> +                                          hwaddr firmware_load_addr,
> +                                          symbol_fn_t sym_cb);
>  char *riscv_find_firmware(const char *firmware_filename);
>  target_ulong riscv_load_firmware(const char *firmware_filename,
>                                   hwaddr firmware_load_addr,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 21adaae56e..fa699308a0 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -40,12 +40,13 @@
>  #define fw_dynamic_info_data(__val)     cpu_to_le64(__val)
>  #endif
>
> -void riscv_find_and_load_firmware(MachineState *machine,
> -                                  const char *default_machine_firmware,
> -                                  hwaddr firmware_load_addr,
> -                                  symbol_fn_t sym_cb)
> +target_ulong riscv_find_and_load_firmware(MachineState *machine,
> +                                          const char *default_machine_firmware,
> +                                          hwaddr firmware_load_addr,
> +                                          symbol_fn_t sym_cb)
>  {
>      char *firmware_filename = NULL;
> +    target_ulong firmware_end_addr = firmware_load_addr;
>
>      if ((!machine->firmware) || (!strcmp(machine->firmware, "default"))) {
>          /*
> @@ -60,9 +61,12 @@ void riscv_find_and_load_firmware(MachineState *machine,
>
>      if (firmware_filename) {
>          /* If not "none" load the firmware */
> -        riscv_load_firmware(firmware_filename, firmware_load_addr, sym_cb);
> +        firmware_end_addr = riscv_load_firmware(firmware_filename,
> +                                                firmware_load_addr, sym_cb);
>          g_free(firmware_filename);
>      }
> +
> +    return firmware_end_addr;
>  }
>
>  char *riscv_find_firmware(const char *firmware_filename)
> @@ -91,17 +95,19 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
>                                   hwaddr firmware_load_addr,
>                                   symbol_fn_t sym_cb)
>  {
> -    uint64_t firmware_entry;
> +    uint64_t firmware_entry, firmware_size, firmware_end;
>
>      if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
> -                         &firmware_entry, NULL, NULL, NULL,
> +                         &firmware_entry, NULL, &firmware_end, NULL,
>                           0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
> -        return firmware_entry;
> +        return firmware_end;
>      }
>
> -    if (load_image_targphys_as(firmware_filename, firmware_load_addr,
> -                               ram_size, NULL) > 0) {
> -        return firmware_load_addr;
> +    firmware_size = load_image_targphys_as(firmware_filename,
> +                                           firmware_load_addr, ram_size, NULL);
> +
> +    if (firmware_size > 0) {
> +        return firmware_load_addr + firmware_size;
>      }
>
>      error_report("could not load firmware '%s'", firmware_filename);

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

