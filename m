Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1C1C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2BF207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMOiTDCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2BF207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKMl-00069E-JP
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBK0c-0000rb-JU
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBK0a-0006kI-Rf
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:35:42 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBK0a-0006jj-Ld
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:35:40 -0400
Received: by mail-ot1-x343.google.com with SMTP id 41so6331384oti.12
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hsqFRLpBy93mivCSo/eUCZKtV3MCQ+6ebiWHANuaSEo=;
 b=ZMOiTDCm5dYWcy7C8jeOAkUuuYQG6LPs44ookhdPapCEjUX5ALNHfOIvDGNSkajFi3
 WWA12419oL0VTzDo1IrqjL1VPPYQY7zEd4IxaqqKpIgY1j16PmOO377wyKaM9t0ymShx
 5/+U12Z31WuAuKjJm2O5Ew99mdMLn/IsjZtWrwgQybyn01/ofq9xGpA+tbrI/qC3KjKV
 OabDTzU1U5ksYGYYbnjBYvJkefbXiTiiK1aUApsnDxMPNV3KefAAkdbfz/a2pQO3TeuF
 yUM7Tom9UeGnlha8mrGuyyHbDVliODuI0sTRto6gLKvEKWNrWOqCN6P29ws4+eKmM1nJ
 A7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hsqFRLpBy93mivCSo/eUCZKtV3MCQ+6ebiWHANuaSEo=;
 b=Hx++lsLKMzsIdFSVG0tmu38e6Cg11z/bHSV1/CMjxmU6rk09+xrC/KaBOvvggukV4p
 uKbhtjJsl2u8D+vOrXnVt6gqdlt9Hf7EAEu9kKK4FEQZYBNp3D3IS6u90V5Pncz8hyGW
 /hYWJSZIv2+T52XwYqW7/kI/Y5AEGkEuhhsciiIs6duVLomV6GzKVtic1L+lNpCa9hUW
 Ua11rc99aOh7UKJCW9sCR7niR3cv/X4Roji36ok6aliujDBozzdvhmGIerEccvCFqebj
 y8u+gB6qioMn4kW/tmCvZ3Zw9xpNqfa8KZjWAmhmiYIJwSjqZwrmwY/Qe7ZvqJ6MrhDW
 fJ2w==
X-Gm-Message-State: APjAAAWjk4qnmmcVAiRWsgNDNGZWnDJUCX3GrcVa8FB/d4QjaBOyijXI
 kW+O77kEDz0QThDZS0YoKhl2DbNvlHBvOZNOvFZnYQ==
X-Google-Smtp-Source: APXvYqxYUBMRU0qeQlbchX1TkNCgGWD8R1DD4q0Um1VkTzUlLc8BRa51kYwZRvBYIHx1U9zWmD0/tzv6ZbLr5rNEtpg=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr11961713oti.135.1568990139451; 
 Fri, 20 Sep 2019 07:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190920141248.12887-1-philmd@redhat.com>
 <CAFEAcA981SOP7UqgXYcTt1s29TfiUwxWc9GoJd+m+BO4WHrz_g@mail.gmail.com>
 <f817b9a4-272e-c4c0-a4c4-5b5ebd7fd917@redhat.com>
In-Reply-To: <f817b9a4-272e-c4c0-a4c4-5b5ebd7fd917@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 15:35:28 +0100
Message-ID: <CAFEAcA9KAc4viUy1X6f=f9Xm=_+H_JDJh1+USOHyPG76v5f_jw@mail.gmail.com>
Subject: Re: [PATCH] memory: Replace DEBUG_UNASSIGNED printf calls by trace
 events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 at 15:29, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 9/20/19 4:19 PM, Peter Maydell wrote:
> > On Fri, 20 Sep 2019 at 15:12, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
> >>
> >> Now that the unassigned_access CPU hooks have been removed,
> >> the unassigned_mem_read/write functions are only used for
> >> debugging purpose.
> >> Simplify by converting them to in-place trace events.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> ---
> >> Based-on: <20190920125008.13604-1-peter.maydell@linaro.org>
> >> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04668.html
> >> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03705.html
> >>
> >> I first wrote:
> >>
> >>   These functions are declared using the CPUReadMemoryFunc/
> >>   CPUWriteMemoryFunc prototypes. Since it is confusing to
> >>   have such prototype only use for debugging, convert them
> >>   to in-place trace events.
> >>
> >> But it doesn't provide helpful information and is rather confusing.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> @@ -1437,7 +1418,8 @@ MemTxResult memory_region_dispatch_read(MemoryRe=
gion *mr,
> >>      MemTxResult r;
> >>
> >>      if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
> >> -        *pval =3D unassigned_mem_read(mr, addr, size);
> >> +        trace_memory_region_invalid_read(size, addr);
> >> +        *pval =3D 0; /* FIXME now this value shouldn't be accessed in=
 guest */
> >
> > This FIXME comment is not entirely correct.
> >
> > Unassigned memory will RAZ/WI and the 0 will be seen by:
> >  * guest CPUs which don't implement a do_transaction_failed hook
> >    (or which have a hook that doesn't always raise an exception)
>
> OK, I thought targets always had to implement do_transaction_failed.

No, and in fact most don't (only 8 out of 21 architectures have the hook).
In some cases that might be that nobody's got around to it; in other
cases if the RAZ/WI default and no guest CPU exception is what you want,
there's no real need to write a hook function.

> >> diff --git a/trace-events b/trace-events
> >> index 823a4ae64e..83dbeb4b46 100644
> >> --- a/trace-events
> >> +++ b/trace-events
> >> @@ -62,6 +62,8 @@ memory_region_tb_read(int cpu_index, uint64_t addr, =
uint64_t value, unsigned siz
> >>  memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, =
unsigned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> >>  memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr,=
 uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PR=
Ix64" size %u"
> >>  memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr=
, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"P=
RIx64" size %u"
> >> +memory_region_invalid_read(unsigned size, uint64_t addr) "invalid rea=
d size %u addr 0x%"PRIx64
> >> +memory_region_invalid_write(unsigned size, uint64_t addr, int fmt_wid=
th, uint64_t value) "invalid write size %u addr 0x%"PRIx64" value 0x%0*"PRI=
x64
> >
> > Do all our trace backends support format strings which use the
> > "dynamic format width specified via '*'" syntax ?
>
> I thought I read a comment about it between Eric/Stefan but I can't find
> it, maybe I dreamed it. (Cc'ed Eric).

If my grep is correct we currently use the syntax already in
gt64120_read, gt64120_write, pflash_io_read, pflash_io_write,
pflash_data_read and pflash_data_write trace events.

thanks
-- PMM

