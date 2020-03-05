Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9886BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6726E20637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osTZE+Wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6726E20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tic-0002qO-JN
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tY4-000380-5e
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tY2-0007A8-16
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:40:35 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tY0-00076v-MW
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:40:33 -0500
Received: by mail-oi1-x243.google.com with SMTP id l12so6593251oil.9
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uqrF7yqAMbwz92BOwVaq6smzSWGbuVcVn8Zf/0+Yiao=;
 b=osTZE+WmoTbxfXIYEBst6acHOaf56qEr67NzJNHaU3/MwJdFudZ21/LMb+yvUyJzfK
 eQfwlwcaZByJ8gBP5Sx/u+w73d2wnlQna8kvZho5yXzN2aikIgWrZvWN3cRLFhjvqCoN
 fr8BUTFccqr2qu9lhXvPFrspnISzh6U/Y58wOMPCGkIVeU81KeVDCABcjE8lgp4JcH37
 OCLAE0HfdNeKRKm73sFdqWk6PcZqgtJHgOYEiFbNj/7FEUMSshJgI0GGhaOjiBl7bwb1
 iitc0Fw3OjtfJYE/CeD5qpkisgpP2Oi2qoP90kcE5puNVA+ZBVFKjU83wIPXqck8GLPs
 WyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uqrF7yqAMbwz92BOwVaq6smzSWGbuVcVn8Zf/0+Yiao=;
 b=QSkVnAdoTqvgE/Y5J9Ea+9OsYEYVrWCrpPlO2c1fvBqUiRdO8u5+PcEYnKNEbAnFLL
 Hg6dYMYTH3qcJlj845fg6Rdfs33NrZdtOBQ1ptbW6KH9RrzrybX1wOr2bjmd1fjPeofO
 d1kZLpQ8akBZm6Gnq+XH9/JrdukRmZ8hsYXHqHqxmKwQxigoNTJpwk+SN5iCvQYipoMV
 jwjk/uQWg0qX4DlaJk/Jcfl88QyTD/8ovPA9z7uld5BJj1nS9Wzqmts6gQ/2bz9jYtKR
 2u3vWrQK7lwC9ycS43A2b5+3VazN0doBsTrV600MXGt8Gglx2MSW3ZOr6I003jBa9PCT
 MngQ==
X-Gm-Message-State: ANhLgQ0sBmHfOkOf7BhJzj+1XRKLIJ4531990nLwo2Ac6tldRds57ABi
 AqJq/k8xbdDZ9BTHPCO554rVIuqh42uLaqXHuEpaYA==
X-Google-Smtp-Source: ADFU+vuQK7nk35vQJDuZObHA5SSeVLR1H2ZEdSd1MlWgW9mDUETvV6qgZsZTRM+9zwWMhCGcF26sS/mmYgR/eKN5Uug=
X-Received: by 2002:a54:478b:: with SMTP id o11mr1345121oic.146.1583426431560; 
 Thu, 05 Mar 2020 08:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20200305154142.63070-1-jingqi.liu@intel.com>
 <20200305161047.GB3627464@lpt>
In-Reply-To: <20200305161047.GB3627464@lpt>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2020 16:40:20 +0000
Message-ID: <CAFEAcA-OQncMrU_-DJJ9g5rEcrJvbhTOjOVs0YqO3NS_Y413OQ@mail.gmail.com>
Subject: Re: [PATCH] util: fix to get configuration macros in util/mmap-alloc.c
To: =?UTF-8?Q?J=C3=A1n_Tomko?= <jtomko@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Mar 2020 at 16:11, J=C3=A1n Tomko <jtomko@redhat.com> wrote:
>
> On a Thursday in 2020, Jingqi Liu wrote:
> >The CONFIG_LINUX symbol is always not defined in this file.
> >This fixes that "config-host.h" header file is not included
> >for getting macros.
> >
> >Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> >---
> > util/mmap-alloc.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> >diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> >index 27dcccd8ec..24c0e380f3 100644
> >--- a/util/mmap-alloc.c
> >+++ b/util/mmap-alloc.c
> >@@ -10,6 +10,8 @@
> >  * later.  See the COPYING file in the top-level directory.
> >  */
> >
> >+#include "config-host.h"
> >+
>
> According to CODING_STYLE.rst, qemu/osdep.h is the header file
> that should be included first, before all the other includes.
>
> So the minimal fix would be moving qemu/osdep.h up here.

Yes, osdep must always be first.

> > #ifdef CONFIG_LINUX
> > #include <linux/mman.h>
> > #else  /* !CONFIG_LINUX */

Do we really need this? osdep.h will pull in sys/mman.h
for you, which should define the MAP_* constants.

Also, you have no fallbmack for "I'm on Linux but the
system headers don't define MAP_SHARED_VALIDATE or
MAP_SYNC". Wouldn't it be better to just have
#ifndef MAP_SYNC
#define MAP_SYNC 0
#endif

etc ?

thanks
-- PMM

