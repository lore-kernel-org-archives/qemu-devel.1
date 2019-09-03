Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAB1C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 19:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60602077B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 19:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="IhIPxQCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60602077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5EMI-0004z9-QG
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 15:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1i5ELU-0004Mu-7A
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1i5ELR-0006nF-Iu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:20:03 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1i5ELR-0006kn-6m
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:20:01 -0400
Received: by mail-pf1-x443.google.com with SMTP id y22so5772470pfr.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sysw8fLW7DDzf8fLwB6YRF/GnYmMtVevh6+tL8Ke2hk=;
 b=IhIPxQCFuTu9piGLEgLUeCWr2Ef77yvGAdeATb3j3RLDDEHTStO2/wqqGZxWfcVh+o
 GmvIw25fQSLDqj6wdvb5tnguEStLa8UB+GZgaMSUg23AsgmnScjckw8X5MU0CNhO985H
 Cpycw3zTkSZ0S9ZyDESFMzfUmjVQsjn5yVoUM5IhXEp3J0Dm4Ew6kwJa5Zy43nE9h+Le
 HSUMLPZiDtT6FgE3HINYo2E/Twf1p9dxoP+N0aZ5ncoBy1b3+jxTV6eWhGEsJsnEQeJ9
 7kNiDg8Aeqi59Ov0BUnoHdOQ5e3f/Ak4P4AoOOFBzmamNLk/i2z+gxOdvCrQ+byWt7Ly
 kXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sysw8fLW7DDzf8fLwB6YRF/GnYmMtVevh6+tL8Ke2hk=;
 b=tfyIQrRpzmnpRQzIWjbTwHo49WB9BjO+06bi7C/EkMRRd/6lrSHHI1MJONYn55/Jtq
 5vQMFYetTE+0/wZUg/2Nn7FAOG20UVT/2OXdYrQSv3BQVg3guqtAr6YTHZAe5O323GyD
 SYzhG1EuzpGcJe/LRhClU1P4g7UAwEC5bnxpm0MOZHYKziUpa1O76vgTftiUBJfvwK/X
 mZzPzMcFQN0z+TVfkvDEU/Cgx11b5/dWT0V/Gqy2ecRlXDXGYeegSzZ+NaO41d0JG792
 2AtqfxuPMJtp3F6LI7nNXujkLTduchAJnWxb6NtIuI0rmr1dLrwG/Dl5FoXYe06Jnhab
 IBpQ==
X-Gm-Message-State: APjAAAW8r6FCwBuL69K2PdVuUoR5KQdIqZIo7u0ZgnD1vQoyq/0O+04u
 MSWIpYY8WK0TbCCu8FH4xzwkhHq0aYv7v7wS3fVQgA==
X-Google-Smtp-Source: APXvYqwIA3pjt0E5ISpUXzGewIHPzUDf9yvXQ157wIlrjVeGAuGMxltCDPnzPUCsxXX6uREPjTBDSkugwprkDr5OGFg=
X-Received: by 2002:a65:6795:: with SMTP id e21mr21181374pgr.428.1567538396921; 
 Tue, 03 Sep 2019 12:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190816233422.16715-1-jkz@google.com>
 <5b4df64c-40e4-70cd-753e-f52e2b547c18@vivier.eu>
In-Reply-To: <5b4df64c-40e4-70cd-753e-f52e2b547c18@vivier.eu>
Date: Tue, 3 Sep 2019 12:19:45 -0700
Message-ID: <CADgy-2tzD0FVXbKtadSL1JuMWW_TEzFP2ZD0hzA4PUnxh1Xz0g@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] linux-user: Support gdb 'qOffsets' query
 for ELF
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
From: Josh Kunz via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Josh Kunz <jkz@google.com>
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The `Data` and `Code` flags in `qOffsets` are actually section offsets
rather than segment offsets. GDB relocates the symbols in those sections
relative to their location in the binary. So we have to use `load_bias`.

See here for a more detailed description:
https://sourceware.org/gdb/onlinedocs/gdb/General-Query-Packets.html#Genera=
l-Query-Packets

On Mon, Aug 26, 2019 at 1:29 AM Laurent Vivier <laurent@vivier.eu> wrote:

> Le 17/08/2019 =C3=A0 01:34, Josh Kunz via Qemu-devel a =C3=A9crit :
> > This is needed to support debugging PIE ELF binaries running under QEMU
> > user mode. Currently, `code_offset` and `data_offset` remain unset for
> > all ELF binaries, so GDB is unable to correctly locate the position of
> > the binary's text and data.
> >
> > The fields `code_offset`, and `data_offset` were originally added way
> > back in 2006 to support debugging of bFMT executables (978efd6aac6),
> > and support was just never added for ELF. Since non-PIE binaries are
> > loaded at exactly the address specified in the binary, GDB does not nee=
d
> > to relocate any symbols, so the buggy behavior is not normally observed=
.
> >
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1528239
> > Signed-off-by: Josh Kunz <jkz@google.com>
> > ---
> >  linux-user/elfload.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> As it seems they are text and data segment offsets, why it's not based
> on info->start_code and info->start_data?
>
> Thanks,
> Laurent
>
