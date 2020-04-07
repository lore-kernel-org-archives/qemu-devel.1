Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAAFC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E1320731
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E1320731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmpi-0001yI-TO
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <schwab@suse.de>) id 1jLmpA-0001XX-VU
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <schwab@suse.de>) id 1jLmp9-0006Rb-Ny
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:55:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:35148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <schwab@suse.de>) id 1jLmp9-0006R4-IE
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:55:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B18FAABE9;
 Tue,  7 Apr 2020 11:55:21 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] linux-user: Use getcwd syscall directly
References: <mvmftdg8wxw.fsf@suse.de>
 <216610b1-0d0f-a50b-8997-bb6aa6e20abf@vivier.eu>
 <CAFEAcA_zbeBM7iFd10ut4UTYDifJ=SWjMD1KYOJgKX=4OQSkmw@mail.gmail.com>
X-Yow: An air of FRENCH FRIES permeates my nostrils!!
Date: Tue, 07 Apr 2020 13:55:21 +0200
In-Reply-To: <CAFEAcA_zbeBM7iFd10ut4UTYDifJ=SWjMD1KYOJgKX=4OQSkmw@mail.gmail.com>
 (Peter Maydell's message of "Tue, 7 Apr 2020 11:57:31 +0100")
Message-ID: <mvmblo38q8m.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
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
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Apr 07 2020, Peter Maydell wrote:

> On Tue, 7 Apr 2020 at 11:37, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 06/04/2020 =C3=A0 17:18, Andreas Schwab a =C3=A9crit :
>> > The glibc getcwd function returns different errors than the getcwd
>> > syscall, which triggers an assertion failure in the glibc getcwd fun=
ction
>> > when running under the emulation.
>
> What exactly are the differences in errors ?

It's ENAMETOOLONG vs. ERANGE.  When the syscall returns ENAMETOOLONG,
the glibc wrapper uses a fallback implementation that potentially
handles an unlimited path length, and returns with ERANGE if the
provided buffer is too small.  The qemu emulation cannot distinguish the
two cases, and thus always returns ERANGE.  This is unexpected by the
glibc wrapper.

Andreas.

--=20
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
"And now for something completely different."

