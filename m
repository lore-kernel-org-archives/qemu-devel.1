Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CF5C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 18:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA26208DB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 18:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cK85qlzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA26208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUarB-0005Jp-Su
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 14:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1jUaqN-0004EC-9y
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <josemartins90@gmail.com>) id 1jUaqM-0002v3-Tg
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:57:03 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1jUaqL-0002pp-Az; Fri, 01 May 2020 14:57:01 -0400
Received: by mail-io1-xd43.google.com with SMTP id z2so5780302iol.11;
 Fri, 01 May 2020 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sU5uH15MdvMu+SnhYfxfwwijaJdjT9gBVaZU8wBtNfg=;
 b=cK85qlzc9AE/O5FU9zzrT9xXJCOliRYLkr+uHopXN+vSiEv/4T/3aSl+Q1adQ6auRO
 ts1DpcZmpanqq1GRH0C2JYBP6Yzbb5ZuCQIxpyX936YO/HkiI1etIup3US+9krjJxL8x
 95w4GZ3/Ppzpyj7bR1slYcQTLC1wH8qWaGH5k1YFksxeDCcT0w8RwjTJzslQjhFqfEkQ
 XNHV/ayL9c3xhnYzC6ebV/2YSkCckQPRY+XO3IOCMbuganqs09xujfIxF80aEQWvNZML
 tQOiWpAA6LN4AhbMOlrab8WA09xMMCpBW6ajYtKyg075h9HK+9GX9wvs9/pPYu5DV1nH
 1VsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sU5uH15MdvMu+SnhYfxfwwijaJdjT9gBVaZU8wBtNfg=;
 b=VyhliYkGQHCNmRz39Z6Qr6mN/uJajtDN9k2+MwaUtXstCQ88A+BYpGN1EOfI+iTbgu
 yKuBfNuRtk80q1UQ7mCJEeT9u+AsPPz99h2Wofr9udYBXYP+Zh+JS3kNtCuV+vMETBdv
 F9Qrbt5+p0RqEBgCPjesKwGCTayBSyScEzO31r1Tz2/2rJc1nVQE5NGt3gmRDTPaMTe3
 iFlBaWMgZC5pBK1OLBFbYB4WDt4zIeEZA3WO8vX076aC6N7RC8kS22tjLDnzW+8VIZM5
 QxsiOkQMtt6zZ3GWPJm2xsht1h4adZkenBWihFue+nbpRZODrQEZ1QF43IpXcao8QHgy
 Up5Q==
X-Gm-Message-State: AGi0PuaKVeTu7kGXzuf3fHTISKI2/2DIM0IJHmGL1uiSqrZYp96Rj5tH
 AJjijXqLJV+8dOM/S0HCqI/ZR8ZU9qJPRg4wdyc=
X-Google-Smtp-Source: APiQypIP8+MJmD4JgAiOUYgeej7d4iUHUoWqxpGWm8PR+wT27Wr1r0nanof8jtUWD8mMGYe11YMmhJPSCE/PDsMaJm8=
X-Received: by 2002:a5e:9703:: with SMTP id w3mr5220346ioj.111.1588359419774; 
 Fri, 01 May 2020 11:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAC41xo2O1k+cn7EO3Zu3U70qefFwGa5B1iNRNgRwLk7SGX=-Aw@mail.gmail.com>
 <CAKmqyKPDzusVqzCFwCJ+2gY0qchguhR57zHNkE-0MTeffKs_OA@mail.gmail.com>
 <CAC41xo3qeQZ+i8XoQq3j80_JDEoL2yMA__arpmE+GXyjX4c1sg@mail.gmail.com>
 <CAKmqyKPJ6QqUULrDj9NX_bLdnjsjzPOGcCBH5q23fG=ScT_NzA@mail.gmail.com>
 <CAC41xo32aWNZteKP-95AtFXQo3w_Ey-7MA0-dL_uJmEMScAuhg@mail.gmail.com>
 <CAKmqyKOnpJQUHVnzGVBjPkib-Z1vfdWqLx1HmfbGascFFG4DVQ@mail.gmail.com>
 <CAC41xo2-knUMRVALdftzu4cNz5u5UmBf1aK=mAt9YKzvOcCjpg@mail.gmail.com>
In-Reply-To: <CAC41xo2-knUMRVALdftzu4cNz5u5UmBf1aK=mAt9YKzvOcCjpg@mail.gmail.com>
From: Jose Martins <josemartins90@gmail.com>
Date: Fri, 1 May 2020 19:56:48 +0100
Message-ID: <CAC41xo0BMA93jv_aqzmuaB553kxM8zCZms1M89uybxyhdjxiXg@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: fix VS interrupts forwarding to HS
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=josemartins90@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d43
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

Reached out to Andrew Waterman. This was his response:

"I think the encoding of the privileged modes is a red herring.  HS is
inherently more privileged than VS, since it controls memory
protection and interrupt delegation for VS.
Certainly the intent is that HS-mode interrupts are always enabled
while executing in VS-mode.  Otherwise, badly behaved VS-mode software
could starve HS-mode of interrupts."

So my assumption was correct.

Jose

On Thu, 30 Apr 2020 at 22:47, Jose Martins <josemartins90@gmail.com> wrote:
>
> > I'm not sure HS is a higher privilege mode.
> >
> > HS is privilege encoding 1, which is the same as VS (VU is obviously lower).
>
> I just checked the spec and it doesn't actually, explicitly state that
> HS is a higher-privilege mode than VS. I thought this was something
> implicit, but you might be right. I'll try to reach out to the spec
> authors to clarify this.
>
> Jose

