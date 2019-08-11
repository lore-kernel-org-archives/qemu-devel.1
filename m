Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A26C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECB02085B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aozxrl4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECB02085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwrVH-0004Ed-Nd
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 13:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59917)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hwrUj-0003Sn-Hu
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hwrUg-000179-Lj
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:19:01 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hwrUc-00012L-Qd; Sun, 11 Aug 2019 13:18:56 -0400
Received: by mail-lj1-x241.google.com with SMTP id r9so96342762ljg.5;
 Sun, 11 Aug 2019 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qlfsIV+m0GJS7PQYBM1mHKaxsiMIzfF2GLRdvNas8l4=;
 b=aozxrl4itttN13bV+Bzv57GWeMiPv6Mbo1waBQdY5hdLSbmLmCXvmznQuYwVXxX2k6
 ENVaT/kS4apCe6k3nSdOX7rbgkgnMCIbpi9AeF4EniVFC7aXnynDrBZRAo132ZP3QgPX
 2Y25JC/i+B1+kBJBkFZaV4v/dLn0fJPdPpvvbB2tSG0mfp/5TGr+9kEE0S3aJcDy9/1I
 SkNBgfcFLQKkxkK/gkkMP+WUuy1qFUYlz7vreF18I0lDSoQuESnevQheDA43n+GvFb8K
 0CCNBcXAZ+7pSNHRQLSs+lNtmfjtRA6YzpWi9fz17EqVeU8zBcg4GYWp6tybeEKR4jKf
 9hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qlfsIV+m0GJS7PQYBM1mHKaxsiMIzfF2GLRdvNas8l4=;
 b=QiwnLjgzqxyrHixRt4TZeWu/R3uKBJexzyHVlM5eAHbTJ9T/vhC5YgneUQ6+DydrR8
 tkzXZ+e8dWUTfbWtMHy5c6wdFQZx51qbNvLgHFybVLKzpAbqyfWjRHCG1dtGtk1dbIGV
 Ne9bzgU03SHmID1HO4S64SnM8pdis4SwTjgpMvz3Bh9j2542qrt6BFy11A9u57fm696o
 sVqpvJ7GwPLnYj12rSo5cUNcU1Zbd4cgQ9+suEv6ubOlmiA3UKGAGT11CsC6E/JrfcK8
 bdbiG9rolep9B36vAxd5T3tEeG+Ud8LGn4foMx1mQaErDy+nDYWJubUbK1r5tbx9XWM6
 1syw==
X-Gm-Message-State: APjAAAVRCI+FzON/fWG1je0c20L/1O7SMdrh4HkpJqanUM6rfLxgXt5J
 Dr/0Ln5can0GVOV/kYhMqoqTKOXIbi95Jr5iaHQ=
X-Google-Smtp-Source: APXvYqwCdFYSg4wLke74nP82m5A5UNMbkBZ8NlqUXiyJ+bQYgBCmODruZWB298QldvfJ2AG5/e/bNtIND4PN68YvISE=
X-Received: by 2002:a2e:9158:: with SMTP id q24mr17056535ljg.119.1565543931147; 
 Sun, 11 Aug 2019 10:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
 <1565510821-3927-26-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565510821-3927-26-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 11 Aug 2019 10:18:23 -0700
Message-ID: <CAKmqyKN7-h7ggJpwKXGQb9nmgLuFtfh07QvZ83bXto5QOoP4BA@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v3 25/28] riscv: hw: Remove not needed PLIC
 properties in device tree
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 11, 2019 at 1:18 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> This removes "reg-names" and "riscv,max-priority" properties of the
> PLIC node from device tree.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Jonathan Behrens <fintelia@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> Changes in v3: None
> Changes in v2:
> - keep the PLIC compatible string unchanged as OpenSBI uses that
>   for DT fix up
>
>  hw/riscv/sifive_u.c | 2 --
>  hw/riscv/virt.c     | 2 --
>  2 files changed, 4 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index b0026aa..8801ee2 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -238,8 +238,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[SIFIVE_U_PLIC].base,
>          0x0, memmap[SIFIVE_U_PLIC].size);
> -    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
> -    qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
>      qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
>      qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
>      plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 127f005..2f75195 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -244,8 +244,6 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[VIRT_PLIC].base,
>          0x0, memmap[VIRT_PLIC].size);
> -    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
> -    qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
>      qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", VIRTIO_NDEV);
>      qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
>      plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
> --
> 2.7.4
>
>

