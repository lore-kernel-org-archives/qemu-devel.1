Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E8DC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213902173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUgZEOKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213902173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8luu-00060x-0V
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 09:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8luB-0005Ng-8g
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8lu9-0002Dq-Re
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:18:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8lu9-0002Cb-KR
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:18:45 -0500
Received: by mail-wr1-x442.google.com with SMTP id n7so4897505wrt.11
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 06:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3Z3xFnxh5R5BwsfWXMLVASRGndlhSRgMifovTn/CNd4=;
 b=eUgZEOKDiQJAqNigAAOUmLr2PUqZQ0M1pm0lN1gXPmdmPx4nhpcTwFb1SM2jILSruE
 6RDYYd3AQ/tNmUqQ/xFVXLD0HB43o82WZ9GKAD+MJEqivE+tDv03Rw2DDkXW0f9APLh0
 /HztSXein1wTcgmjTkJ57o3P8AUPVqsqkIlxVBAeBB36SNO6TPnDQjvJ32pC8fgKRvRW
 +kjpLiMRmIxJGt0rjffhX/O6If46Yei0BmoXutHbGWL3fdbk0E5/aikJHsmCe6QAIGQn
 3B+3pzR4iAtHlXDurpT6TcOF9/7ZVGYyZzTVax0D1E1rn7L/cn9XPf5PEOx6aA6b8EAa
 nXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3Z3xFnxh5R5BwsfWXMLVASRGndlhSRgMifovTn/CNd4=;
 b=jY9mq7+duiNnB+6ItQGKLJ6PZb3YQ8vH2ezSB/u5xk/JPKc+qz97rmaV/B37U18+Kx
 I9XtSSzYaRuKn+4i9L+oXf1jGkjGbE+rL6Wrj2fbveUEDfCFDDPmgaZ5CkVr3HxXW7Sq
 gMPeuoceCaXuRvFcFGSXmxDYMJc9qgNQyz/lZUZ9gefeK11F4CA1VEZUgrb66J+ebzui
 kYDJ5xlLdW67v5y6cMc1rhGJwDtrEFOkXbdqjtLVUM5es34fRiuY9KwEtQrnvsRqR1EI
 srHULiH0kcrH0Fys8ZjGd4X43qovYFsrWbsVpNHhpRG/6r6nV7HQJmU9d2fCBakk1iEo
 D3Sg==
X-Gm-Message-State: APjAAAUU9wqoqR82NZl06gsHImtKh0mL9tqmGBst6QZOmIc/hGP8opmg
 jh6gGxajB9orYlr3bcU3EVK5BA==
X-Google-Smtp-Source: APXvYqx2D0UN2UuXIlrtdL4aZ9NwSTCHVhiDO40ziYWyf4znaiKM8VhsIqcjp/e60q43bRqv1vV/6w==
X-Received: by 2002:adf:94a3:: with SMTP id 32mr24166854wrr.276.1583158724101; 
 Mon, 02 Mar 2020 06:18:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a184sm16420903wmf.29.2020.03.02.06.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 06:18:42 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 025961FF87;
 Mon,  2 Mar 2020 14:18:37 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-6-peter.maydell@linaro.org>
 <87wo83atnf.fsf@linaro.org>
 <CAFEAcA-WYXtkkCshv_eDV5Rj8ER4yfDmf5V=HaT-Jo5cSJr0vA@mail.gmail.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 05/33] qemu-doc: split qemu-doc.texi in multiple files
In-reply-to: <CAFEAcA-WYXtkkCshv_eDV5Rj8ER4yfDmf5V=HaT-Jo5cSJr0vA@mail.gmail.com>
Date: Mon, 02 Mar 2020 14:18:36 +0000
Message-ID: <87lfoi96wz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 2 Mar 2020 at 11:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > From: Paolo Bonzini <pbonzini@redhat.com>
>> >
>> > In order to facilitate the reorganization of qemu-doc.texi content,
>> > as well as the conversion to rST/Sphinx, split it in multiple .texi
>> > files that are included from docs/system.
>> >
>> > The "other devices" section is renamed to ivshmem and placed last.
>> >
>> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> > Message-id: 20200226113034.6741-6-pbonzini@redhat.com
>> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> > ---
>> >  Makefile                         |   16 +
>> >  docs/system/build-platforms.texi |   67 ++
>> >  docs/system/gdb.texi             |   71 ++
>>
>> The gdb test would be better served in docs/core if we could have
>> optional sections on invocation rendering depending on if it's built
>> with system emulation or linux-user docs. Is that something that's
>> already supported?
>
> No, for three reasons:
>
> (1) we build all the docs, always -- there's no concept
> of "skip some bits of docs if some configure feature was
> disabled"
>
> (2) there is no docs/core -- the subdirectories of docs/
> correspond to the "manuals" which we want to present to
> the user, like "Manual for system emulation users" and
> "Manual for user-mode users" and "Manual for the
> standalone tools"; a "core" manual wouldn't fit into this
> classification, and we already have slightly more manuals
> than I'm entirely comfortable with.

I wasn't clear. I don't want an additional document but I'd like to
include information on the gdbstub in both the system and linux-user
manuals. Another candidate for documentation which is common to both
would be the notes about TCG CPU emulation.

> (3) Sphinx's support for conditional documentation is
> not very good, as it is implemented at the "wrong"
> end of the pipeline (ie it's not like a preprocessor
> ifdef, but instead is just "suppress the output", so
> manual pieces inside a disabled ifdef still turn up
> in places like the index and table of contents). The
> best you can do is to mess around with the include
> directive, but if we do that too much then things get
> awkward to understand and maintain. (We do it a bit
> in this series to handle "manpage vs manual" stuff.)

In the case of the gdbstub the only real difference is the invocation
section (-s vs -g). I guess we could just reference both in the section.
It's not like the linux-user documents can't acknowledge the existence
of system emulation and visa-versa.

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

