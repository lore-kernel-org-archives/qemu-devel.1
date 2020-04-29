Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650BBC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30988208E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdhS+6Wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30988208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrql-0000QE-CD
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTroQ-0005XP-Mi
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTroQ-0002i2-6f
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:52:02 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:44664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jTroO-0002h2-9N; Wed, 29 Apr 2020 14:52:00 -0400
Received: by mail-il1-x141.google.com with SMTP id s10so3449023iln.11;
 Wed, 29 Apr 2020 11:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IsBLFWc6fdYBfIh5gE4fLMG8y9tfNXkYmnIVynU01FY=;
 b=DdhS+6WtTnftHsy/F/mhAimFsoq9r8rSmgxkxwm7MxIDA31MvCmVVe3u5DfOQRs36y
 UbdWuRkYyeeep72DlFT8sREMmjCjs//4aRt/g9e9Fs35zPYRlCr6YNJ+e9orafiOwm/3
 lwVZWzgA4Yjkm6ZvU4MAI5L8NFi1Ish7iWFdfwI5DwDq4w4hyrOXMNLV1sYkV77LyWdu
 qa2XcDfgTMkPcIUwRy8NG0mmHILG95FPsn+vJVfOzr2MCc2PTY6jLrlm5TFeiiriJq/Z
 HfJ02adxftXwvyoV9W3QjIonU1g4IKDrJSa9cZs+NJXTwd6al7DEhhUoihDS00bdYU5/
 GdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IsBLFWc6fdYBfIh5gE4fLMG8y9tfNXkYmnIVynU01FY=;
 b=hpfYACv3AsXPsoUt53e/lkf0ZoQF7Xd8fI61EKKGqVhqJfL6LxG42+igcxO7DOiwY9
 5uE+V6/YRT0qrCKpDAb4nG5QU4OU7QE96RjKmkF7APhfiltMxLBFe74Fms9N3el+/kX3
 oXGzO1ajzYGunzLe1WonwKzvhZEnpfKjHRMdonFWAEPUAu/vq8472if/+aeJE4Swjidw
 bl4Kuyjtix1QjpF+tZxpIConw+UFPTwXeeVVrSkAKaSNPNq8sv1dKrfuGbqBcWUvgcbp
 B8Oy+As9/pOIBkM3KBAh7LsUcZ0ihGO2x+dyerAmBdgGHDXRUoOO91+4qaBOBOwkjbZe
 cJIw==
X-Gm-Message-State: AGi0Puadn4c+lFWpsNKrbA2M28lImVrLxYZusXWw4zvjUpHJ3LkPqL71
 0OYEGzUbFfuaW+q2YWQKtXtlU2s1wFSUMWI2OpQ=
X-Google-Smtp-Source: APiQypLwVrvR+WvgigohLXSLZNiIxNYJGw7lK7o4zFozQ+AT0n5X1mi+ooyWlTfN3FoWyH8JMk6/6W/gGRFm4l1w0iU=
X-Received: by 2002:a92:d0c6:: with SMTP id y6mr34619061ila.227.1588186317519; 
 Wed, 29 Apr 2020 11:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAC41xo2O1k+cn7EO3Zu3U70qefFwGa5B1iNRNgRwLk7SGX=-Aw@mail.gmail.com>
 <CAKmqyKPDzusVqzCFwCJ+2gY0qchguhR57zHNkE-0MTeffKs_OA@mail.gmail.com>
 <CAC41xo3qeQZ+i8XoQq3j80_JDEoL2yMA__arpmE+GXyjX4c1sg@mail.gmail.com>
In-Reply-To: <CAC41xo3qeQZ+i8XoQq3j80_JDEoL2yMA__arpmE+GXyjX4c1sg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Apr 2020 11:43:18 -0700
Message-ID: <CAKmqyKPJ6QqUULrDj9NX_bLdnjsjzPOGcCBH5q23fG=ScT_NzA@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: fix VS interrupts forwarding to HS
To: Jose Martins <josemartins90@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 On Wed, Apr 29, 2020 at 9:07 AM Jose Martins <josemartins90@gmail.com> wrote:
>
> > If the Hypervisor sets the V* interrupts why does it then want to
> > receive the interrupt itself?
>
> I don't think this is a question of whether there is a use case for it
> or not (I agree with you, of the top of my head I don't see why would
> you forward v* interrupts to the hypervisor). However,  from what I
> can understand,  the spec allows for it. If you don't set the
> corresponding bits in hideleg, v* interrupts should be forwarded to HS
> (as I said, they are guaranteed not to be forwarded to m mode because
> these bits must be hardwired in mideleg). Otherwise, there would be no
> purpose for the hideleg register, as v* interrupts bits are the only
> ones that can be written in it (am I missing something?).

I think you are right.

"Among bits 15:0 of hideleg, only bits 10, 6, and 2 (corresponding to
the standard VS-level interrupts) shall be writable, and the others
shall be hardwired to zero."

Which means that it only controls the V* interrupts.

>
> > Isn't hs_sie only ever accessed if riscv_cpu_virt_enabled(env)?
> > Doesn't this just set hs_sie to always be 1?
>
> I don't understand if you don't agree that hs_sie should be always set
> when riscv_cpu_virt_enabled(env), or if you agree with it and don't
> see the need for the hs_sie variable at all. If it is the latter, I
> agree with you. So the patch would become:

Currently hs_sie is set:
 - When we are in U-Mode
 - If we are in S-Mode and hs_mstatus_sie is true

Then hs_sie is only accessed if virtulisation is enabled.

Your change just made it true for whenever virtulisation is enabled
(in which case we don't need it).

>
> Signed-off-by: Jose Martins <josemartins90@gmail.com>
> ---
>  target/riscv/cpu_helper.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d3ba9efb02..a85eadb4fb 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -41,10 +41,8 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>
>      target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
>      target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
> -    target_ulong hs_mstatus_sie = get_field(env->mstatus_hs, MSTATUS_SIE);
>
> -    target_ulong pending = env->mip & env->mie &
> -                               ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
> +    target_ulong pending = env->mip & env->mie;

This looks good

>      target_ulong vspending = (env->mip & env->mie &
>                                (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP));
>
> @@ -52,11 +50,9 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>                            (env->priv == PRV_M && mstatus_mie);
>      target_ulong sie    = env->priv < PRV_S ||
>                            (env->priv == PRV_S && mstatus_sie);
> -    target_ulong hs_sie = env->priv < PRV_S ||
> -                          (env->priv == PRV_S && hs_mstatus_sie);
>
>      if (riscv_cpu_virt_enabled(env)) {
> -        target_ulong pending_hs_irq = pending & -hs_sie;
> +        target_ulong pending_hs_irq = pending & ~env->hideleg;

I don't see why we don't need to check the HS version of MSTATUS_SIE.
I think hs_sie should stay shouldn't it?

Alistair

>
>          if (pending_hs_irq) {
>              riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
> --
> 2.17.1
>
> Jose

