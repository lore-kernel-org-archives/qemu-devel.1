Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4973AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CBCA21883
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS6IxQ/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBCA21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Ckr-0007ZC-85
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 13:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i5CkC-00078E-HR
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i5CkB-0003QA-1D
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:37:28 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i5CkA-0003Mx-RX
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:37:26 -0400
Received: by mail-ot1-x343.google.com with SMTP id r20so17629892ota.5
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eLkeQgsM6FmsN4Rg461h9QdeQSukjgpK+685V2pMEoE=;
 b=QS6IxQ/Qzx/I2097kT7ZqFEPN9FGBuAufll4J2aVH4+PhrlIOzlqvUNK3NA3miLVxJ
 kZ8fCJj7mSnjGwRaC3tgFCcK/KsiVE9vHcDcwMLY7AiKgXI9jt9++Dnb0bfexYRQP1p+
 YAdn8611veTJvobacR3CwFzKWRZWCkVS+3z0pTonQUWSU9C0v/ao7yaAeTqXtubXFkIk
 6F2FEm9pFh9yCIC9i6DB8wOBbZWdmECGgM/efRSDCsopUpwkTmOmI+chbBZVoTCg5yyc
 5AAYv3wwMELp0OacR/xuYhgLQ4zRL6cXn4ZhVbftuot7k5DbVc4nzQq5LNgsgW9b8e7V
 U+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eLkeQgsM6FmsN4Rg461h9QdeQSukjgpK+685V2pMEoE=;
 b=Gsq1OJc//tqPYtY+t3aqbMUtubIcK7vvHMgGwxb60SV6Ab0eWcUA9/M30ax6DLzTTB
 7ykMOe5T85ej8dkzCPNy3QF77HtsGVPQAwMf1lTaiBhdZxM6zjU/VEzO0wsrd+S7zMy8
 vZWnBRzHzUF18iCQVb/zSzgIEEBnWWOUPBAYVqhQKIYnohNfC3gw+6f7xWjzEPd+Y2I0
 3EEWzAmA4o6imneQqLk5ce9mXGz2nnxAu8ifHQ5A/Pci9ZIJcJ7Cf8kVb7U/uZMmqduN
 CMjhslx0811v7cm0qKTyJ8MUkrG6wkuG3mLTZzGeZ+TL9GSwhAb3E+jJ6O/Wo9msNMIg
 mQ0w==
X-Gm-Message-State: APjAAAX+hA1Jz2uSBykL1QinLXBJoq9DDI6ZAN4ypZPArHdePI852mev
 wtUTJv+ciu42mMQdWSAxkGr5bihPO5x2iEZAZjM=
X-Google-Smtp-Source: APXvYqykRgNyRFAUYo+XsBJvJUqI8N4cijD5nSx0da07EohJ4302wY4Rd25pv2eSsQIGDD7ZS2koPP5LNphSGELsBaQ=
X-Received: by 2002:a05:6830:4d6:: with SMTP id
 s22mr30442724otd.295.1567532245255; 
 Tue, 03 Sep 2019 10:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <5746cc58-c132-ef29-6ff4-da07c6086dac@ilande.co.uk>
 <3fe632b7-e83c-9b26-9338-1d7a9c881e0d@linaro.org>
 <CABLmASFUnBnn2DZidKFAiaMb7gExYttgvEv12uce9EPi6NL9Qw@mail.gmail.com>
 <f1eeb1de-a6e7-bb83-3501-705382da4b14@ilande.co.uk>
In-Reply-To: <f1eeb1de-a6e7-bb83-3501-705382da4b14@ilande.co.uk>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 3 Sep 2019 19:37:14 +0200
Message-ID: <CAL1e-=gtgzRHzZyX9r69_zB5-v-ThYeuxBameoF12TBs59M95w@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 00/16] tcg/ppc: Add vector opcodes
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 3, 2019 at 7:05 PM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> On 01/07/2019 19:34, Howard Spoelstra wrote:
>
> > On Mon, Jul 1, 2019 at 12:30 PM Richard Henderson <
> > richard.henderson@linaro.org> wrote:
> >
> >> On 6/30/19 7:58 PM, Mark Cave-Ayland wrote:
> >>> I don't have space for a full set of images on the G4, however I've
> >> tried boot tests
> >>> on installer CDs for MacOS 9, OS X 10.2, Linux and HelenOS and it looks
> >> good here.
> >>>
> >>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> [PPC32]
> >>
> >> Thanks!
> >>
> >> Hi
> >
> > I just compiled the v6 set applied to current master on my G5, Ubuntu 16.
> > command line:
> > ./qemu-system-ppc -L pc-bios -boot c m 512 -M mac99,via=pmu \
> > -netdev user,id=net1 -device sungem,netdev=net1 \
> > -drive file=10.3.img,format=raw,media=disk \
> >
> > With no specific cpu set, Mac OS 9.2 hard disk image and 9.2 iso do not
> get
> > to the desktop, they just hang while still in the openbios window. They
> > need -cpu G4 on the command line to get to the desktop.
> >
> > OSX 10.3 installed image boots to desktop.
> > OSX 10.3 iso boots to installer
> > OSX 10.4 installed image boots to desktop.
> > OSX 10.4 iso boot to installer
> > OSX 10.5 installed image boots to desktop.
> > OSX 10.5 iso boots to installer
> >
> > So there seems to be a difference between hosts: If ran on a G4 host
> there
> > is no need to add -cpu G4 to run Mac OS 9.x, while there is when ran on a
> > G5 host.
>
> Are there any outstanding issues with this patchset now, or is it ready to
> be merged?
> I'm really looking forward to seeing the improved performance when testing
> QEMU on my
> Mac Mini :)
>
>
Howard pointed to some illogical quirks of command line:

> If ran on a G4 host there is no need to add -cpu G4 to run Mac OS 9.x,
> while there is when ran on a G5 host.

I am not sure if Howard says that this is a consequence of this series
though.

Overall, I think this is a very good series - however, I had a number of
minor
objections to multiple patches, that don't affect (or affect in a minimal
way)
provided functionality - those objections are not addressed, nor properly
discussed - but I do think they should be addressed in order to get the
series
in a better shape before upstreaming.

Thanks,
Aleksandar


> ATB,
>
> Mark.
>
>
