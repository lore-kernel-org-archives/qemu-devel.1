Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68E8C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DAB2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xdJZ5sH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DAB2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIx01-00079S-Ox
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jIwyC-000542-LB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jIwyB-0003Uz-Er
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:09:00 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jIwyB-0003UG-9d
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:08:59 -0400
Received: by mail-ot1-x343.google.com with SMTP id f52so18606327otf.8
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/xGe4A7R67Wmz8kv/G0zPCGiuBF2poIsy43Iq3FnPoo=;
 b=xdJZ5sH/RstNuojf3Rd2wZTk1HJKMU4FxXZZ1Jzfdw/XYroV6LQyPnwXUZ1c5zJtAt
 aPH+EEsG34oHF4LTCiX/8H1pt06ej3hb04KANAgJNpLTEQ+BTjE5xhhBUycHh6bF7D35
 u75MhQ4ha66oBu/LxcCLQFpB9XHWrW2UaZ5c1weAl5DPfdShYMZD3xc83UaNZp0ADJOS
 WtjSySI/bDs7W6LGaX1Ae2PieqRVisbkAHZMIeszYgcPxXCO/WahPvSjzI5rRigh7lAn
 WCyemhVMWBxFJsjFheIdqr00pEPPnb8z4z0qspPp8RERlcKB6SH5uh8OPj9c3bInbatF
 ZUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/xGe4A7R67Wmz8kv/G0zPCGiuBF2poIsy43Iq3FnPoo=;
 b=CJw+lTvrbK5+lR/xAsbcr0iSDSCJghGmqGHO41mYN6NDslFqZrj72pd1vEgEuT+J0Q
 a8587DKPW1eJ83/OtLCN8QsCRwZ3o9NhZ8iG1a4aTvyR5EF7el9UbJSGPQV6FdTWXPG5
 GvMOSi7MI2Mgu3lgIuIV48hNUFSZZs0lN4mZHokQXABxnpz8/o++I/4Nsf9aYlVKm3kY
 no4IUDGjlMPUd7llxaqIuiIz6ihcavu4lQrhpPzdpCgc5LLp8JS8HffyKUhaXjqPD92k
 nYxmsxTU6WT9dS1w3QIieBwQJSxiv33N+07GtzwxD6wf/7mwmtit3F0aGh4qh1FaOUvY
 ZJDQ==
X-Gm-Message-State: ANhLgQ3iojMcAtdZHDHsXmC339TNX3fb6ZwYukZLcZlFuNzwdmQ/iSos
 uAUeQoQOw709MNIlKem4GucGDZYWCPzstoixxMcQmw==
X-Google-Smtp-Source: ADFU+vuCFx3IsJLKxIWpaW+VGn5T5uAQOKG+LQoRyo49HqLYyc7+gJoPMx/si7vXbN1Ql365UoQ6UnL+MQL5Vd6dwFE=
X-Received: by 2002:a4a:2a09:: with SMTP id k9mr4907136oof.64.1585584536998;
 Mon, 30 Mar 2020 09:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153016.2959-1-f4bug@amsat.org>
In-Reply-To: <20200330153016.2959-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2020 17:08:45 +0100
Message-ID: <CAFEAcA8i1W7ss2hQjaFbVHXzqhV81M8U4Fkaj_Te5JK8JO8+mg@mail.gmail.com>
Subject: Re: [PATCH-for-5.0] gdbstub: Use correct address space with
 Qqemu.PhyMemMode packet
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Jon Doron <arilou@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Mar 2020 at 16:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Since commit 3f940dc98, we added support for vAttach packet
> to select a particular thread/cpu/core. However when using
> the GDB physical memory mode, it is not clear which CPU
> address space is used.
> Since the CPU address space is stored in CPUState::as, use
> address_space_rw() instead of cpu_physical_memory_rw().
>
> Fixes: ab4752ec8d9
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  gdbstub.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 013fb1ac0f..3baaef50e3 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -69,11 +69,8 @@ static inline int target_memory_rw_debug(CPUState *cpu=
, target_ulong addr,
>
>  #ifndef CONFIG_USER_ONLY
>      if (phy_memory_mode) {
> -        if (is_write) {
> -            cpu_physical_memory_write(addr, buf, len);
> -        } else {
> -            cpu_physical_memory_read(addr, buf, len);
> -        }
> +        address_space_rw(cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> +                         buf, len, is_write);
>          return 0;

There's an argument here for using
   int asidx =3D cpu_asidx_from_attrs(cpu, MEMTXATTRS_UNSPECIFIED);
   AddressSpace *as =3D cpu_get_address_space(cpu, asidx);

though it will effectively boil down to the same thing in the end
as there's no way for the gdbstub to specify whether it wanted
eg the Arm secure or non-secure physical address space.

thanks
-- PMM

