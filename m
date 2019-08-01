Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90814C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 01:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5CC20B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 01:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnONfDgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5CC20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht0Hk-0005zi-AR
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 21:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39964)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1ht0HM-0005Xz-Ki
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 21:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1ht0HL-0001fx-Rl
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 21:53:16 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:44416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1ht0HL-0001fB-Lq; Wed, 31 Jul 2019 21:53:15 -0400
Received: by mail-ed1-x542.google.com with SMTP id k8so67518274edr.11;
 Wed, 31 Jul 2019 18:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kAuUUSgahp5qR1FSK0QzNmg9PlAhnc6gE73hIu7pHXA=;
 b=EnONfDgrNTVdzp/CqZoabbyf35bTj+OeL0Uwm7kt0jweBhmhTiett+vgp2/kqbNZtn
 sU5h6889N5WUiScphFcErXvAaw7LqeUKY4R9yUQfnPX3Wzw4K8bsGheI4V3WC00+Lpf8
 6aHSBBFH7kgAXRda26XludXce2FnQI1/wpfMolH5Y7YgN0o7TLR/gSDpm1AWQXG37o2Z
 wCJ1vcHj3RWIfkqVGS0jtpau5d0/PSYHjLEOy/sf5fO5DFbeCEAsQrWo6jcPQqrzoUHF
 wCVZw4ysGy6zOWwZ4umw6fq9H5Ooovb9ecHVXTCUG/Zz+/rWpw946jS+3bUZujERTS45
 uN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kAuUUSgahp5qR1FSK0QzNmg9PlAhnc6gE73hIu7pHXA=;
 b=cCjiLmP4wyhjnkMOIwNNtR3REI2yyEZ0khxGJJ/keU2pWaOX8tQBTdtk1vb8Sw6Kpt
 FAALVyADbaMfY63WUHT/4smMs92PNiyXg5mCN0cDbjXemFQn2Orlg2vf4HzkG7N8wfr5
 9Sc8a28JTn1zguI5r/smWmc0aIBuoSkrxkbDetY2gCiyAI3bZn1yOdNd7PVIWYLjXY19
 cKjljYqbt3F1rKKvVUDtWc49uH8FYIsTMJ7liG0Q+kg0Suvd5FiJfQbjfUzUxEJuTpXj
 3q55qHL9EI5Qx3yvRH17+BBS1v5JCfl+rGKVygN0Zseb+XbXcqhjCJxqCLxr8mjFOPXx
 7Reg==
X-Gm-Message-State: APjAAAUfwnPmFxhAGKRB7Ugg5rFmaf+gPAoynxsARqd9P1NFaDtoFJaZ
 jsHveHAlId/jDKbckMkaL5TfBotOsZZ3QcQPerM=
X-Google-Smtp-Source: APXvYqzGZqCraUn3bSmXvl68EZNyVsacvzTt7i2LBYyEnkd7PPhYlBvS0n0qCq/Mjl7T4ngeM7I0hdU91wAOJ111ClU=
X-Received: by 2002:a50:ad0c:: with SMTP id y12mr108423584edc.25.1564624394111; 
 Wed, 31 Jul 2019 18:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <1564577101-29020-1-git-send-email-bmeng.cn@gmail.com>
 <581a0284-c658-265f-1b0f-6f4be5406cee@linaro.org>
In-Reply-To: <581a0284-c658-265f-1b0f-6f4be5406cee@linaro.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 1 Aug 2019 09:53:03 +0800
Message-ID: <CAEUhbmVXC6GeHYFST514cLRJHQOo5ki=ZPG=OsLzV2YA0ChQgA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH] riscv: rv32: Root page table address can
 be larger than 32-bit
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
Cc: QEMU riscv <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>, QEMU devel <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

On Thu, Aug 1, 2019 at 1:35 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/31/19 5:45 AM, Bin Meng wrote:
> > -    target_ulong base;
> > +    hwaddr base;
> ...
> > -        target_ulong pte_addr = base + idx * ptesize;
> > +        hwaddr pte_addr = base + idx * ptesize;
>
> I believe that you either need
>
>     base + (hwaddr)idx * ptesize
>
> or change the type of idx to hwaddr above.
>
> Otherwise the multiply overflows before it gets promoted with the add.
>

I am not sure how (idx * ptesize) could overflow. It represents the
offset by a page table which is [0, 4096).

Regards,
Bin

