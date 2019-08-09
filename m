Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA55FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739EE208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNZQh3Fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739EE208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw3vf-0007K0-Dx
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 08:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49636)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hw3vI-0006ip-4M
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hw3vH-0003qT-2Z
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:23:08 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hw3vG-0003qG-Rs
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:23:07 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so125832235otq.6
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 05:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XnQ0EWy0EGmfw+ddGM1IbHbrgzkPDZOIX46tCRB7Xpc=;
 b=iNZQh3FoyYRzIKo+taggnMCd7LO8gkyHaxSUm1xtEclXKyN3yyyxk0WCY6teImpLc3
 ZdJE1+iZB7qJrGk04HIEMeWsE7vx+G7ZCsBttlBCCOFmPSAjWLkLU+GpZfCR74/uJaqI
 WqwR5gEHwgefChgwuwaPzYNJ0qEzfbfB3X2PBs43vgpHAghn0rRqqhnCLXAC2TBiJeTo
 49lUQojkXeefpSlZG4X1Ewgmffx8MDNJXhqdJ9Ti9X4tIft6Z7eMIrEksIBufxWQtiuQ
 VqaIXwSfqjhUKSfgprVZgTM7zIhjL0wuZo87kbtRh4E+u4cWeXU1oIehR4IBau38OpwY
 LIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XnQ0EWy0EGmfw+ddGM1IbHbrgzkPDZOIX46tCRB7Xpc=;
 b=VsLsFPPFENAQ1KEeWprOpxQozresyD+3l5r6nERe1KyCdFtg+4gJmR9FaEaK+ZMXQJ
 r/RrMpPrY4CDsqTJsJug0ltB7xpgFYr7YNhuPQcaIyPbWjWD3UgAZpQLxNM7GGg+tCt1
 nOO6N8oaaEFX10vd57WdDQoacCgwHW4aO21Two8/VwSNQ45fzzl4kpADrFxQqPjhYZgz
 fa1UmZhsbDsEgUjpzlpgfEQNyJ0UvyKZEl4KgXBmFUOvWvYV6g29ngfbhZRHz7QwmC0o
 +jCwVarrpCNI5Kx7zZU/Yh/bKp0uwx3B9fXxmaQ8SLTz4JU/R0a+S80VpBrsfFKZynnH
 KWBQ==
X-Gm-Message-State: APjAAAW4S6vRBk2MR6sS+uB0pav+F8hgCuGrtjMMxc9W9HkWSmg5kD7I
 GT/DFpCD9I5JOG2jzyYky3AEQ6bFmVMYgOwEbUXXWg==
X-Google-Smtp-Source: APXvYqwXzFHUGttv+DSxUiwpBlGB0zTmVF4MegXqiLwUyoYb2i/4dvO64JITthpc31o3UFAfuULS1lvB4/X0GEhZD6I=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr16107510otj.97.1565353386007; 
 Fri, 09 Aug 2019 05:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <87r25vd5y1.fsf@dusky.pond.sub.org>
In-Reply-To: <87r25vd5y1.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Aug 2019 13:22:55 +0100
Message-ID: <CAFEAcA-3X0s-mxaD27HWQa7ysiEb6Uo-BD+Yxo0QhBV_yb9WLA@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] Does i386-linux-user build on an i686 host?
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Aug 2019 at 16:37, Markus Armbruster <armbru@redhat.com> wrote:
>
> Fails for me, but perhaps I'm doing it wrong:


> NOTE: cross-compilers enabled:  'cc'
> $ make
>   CC      i386-linux-user/linux-user/syscall.o
> /home/armbru/qemu/linux-user/ioctls.h:306:9: error: =E2=80=98SNDCTL_DSP_M=
APINBUF=E2=80=99 undeclared here (not in a function)
>    IOCTL(SNDCTL_DSP_MAPINBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffmem_desc=
)))
>          ^
> /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition of ma=
cro =E2=80=98IOCTL=E2=80=99
>      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
>                        ^
> /home/armbru/qemu/linux-user/ioctls.h:307:9: error: =E2=80=98SNDCTL_DSP_M=
APOUTBUF=E2=80=99 undeclared here (not in a function)
>    IOCTL(SNDCTL_DSP_MAPOUTBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffmem_des=
c)))
>          ^
> /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition of ma=
cro =E2=80=98IOCTL=E2=80=99
>      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
>                        ^
> /home/armbru/qemu/linux-user/ioctls.h:362:9: error: =E2=80=98SOUND_MIXER_=
ACCESS=E2=80=99 undeclared here (not in a function)
>    IOCTL(SOUND_MIXER_ACCESS, 0, TYPE_PTRVOID)
>          ^
> /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition of ma=
cro =E2=80=98IOCTL=E2=80=99
>      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
>                        ^

We expect these to be provided by the system's "linux/soundcard.h".
For my Debian system that's provided by the linux-libc-dev package,
but I imagine you have that installed or you wouldn't have got
this far in the configure/compile process...

thanks
-- PMM

