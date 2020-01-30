Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F87C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C631320707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C631320707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixDsc-0002XZ-1w
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 12:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ixDrn-0001pU-Br
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ixDrm-0006T6-5A
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:44:35 -0500
Received: from relay68.bu.edu ([128.197.228.73]:36032)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ixDrm-0006Sl-1r
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:44:34 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 00UHi12W013083
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 30 Jan 2020 12:44:03 -0500
Date: Thu, 30 Jan 2020 12:44:01 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v8 01/21] softmmu: split off vl.c:main() into main.c
Message-ID: <20200130174401.xgdzeq4we2cqry4a@mozz.bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-2-alxndr@bu.edu> <87y2tp7zlj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y2tp7zlj.fsf@linaro.org>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by relay68.bu.edu id
 00UHi12W013083
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x
X-Received-From: 128.197.228.73
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, qemu-devel@nongnu.org,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200130 1506, Alex Benn=C3=A9e wrote:
>=20
> Bulekov, Alexander <alxndr@bu.edu> writes:
>=20
> > A program might rely on functions implemented in vl.c, but implement =
its
> > own main(). By placing main into a separate source file, there are no
> > complaints about duplicate main()s when linking against vl.o. For
> > example, the virtual-device fuzzer uses a main() provided by libfuzze=
r,
> > and needs to perform some initialization before running the softmmu
> > initialization. Now, main simply calls three vl.c functions which
> > handle the guest initialization, main loop and cleanup.
> >
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> <snip>
> >  main.c                  | 53 +++++++++++++++++++++++++++++++++++++++=
++
> <snip>
> > --- a/Makefile.objs
> > +++ b/Makefile.objs
> > @@ -84,6 +84,8 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
> >  # qapi
> > =20
> >  common-obj-y +=3D qapi/
> > +
> > +softmmu-obj-y =3D main.o
> >  endif
> > =20
> <snip>
> > diff --git a/main.c b/main.c
> > new file mode 100644
> > index 0000000000..f10ceda541
> > --- /dev/null
> > +++ b/main.c
> > @@ -0,0 +1,53 @@
> > +/*
> > + * QEMU System Emulator
> > + *
> > + * Copyright (c) 2003-2008 Fabrice Bellard
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtai=
ning a copy
> > + * of this software and associated documentation files (the "Softwar=
e"), to deal
> > + * in the Software without restriction, including without limitation=
 the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and=
/or sell
> > + * copies of the Software, and to permit persons to whom the Softwar=
e is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be in=
cluded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, E=
XPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTA=
BILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT=
 SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, A=
RISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEA=
LINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu-common.h"
> > +#include "sysemu/sysemu.h"
> > +
> > +#ifdef CONFIG_SDL
> > +#if defined(__APPLE__) || defined(main)
> > +#include <SDL.h>
> > +int main(int argc, char **argv)
> > +{
> > +    return qemu_main(argc, argv, NULL);
> > +}
> > +#undef main
> > +#define main qemu_main
> > +#endif
> > +#endif /* CONFIG_SDL */
> > +
> > +#ifdef CONFIG_COCOA
> > +#undef main
> > +#define main qemu_main
> > +#endif /* CONFIG_COCOA */
> > +
> > +int main(int argc, char **argv, char **envp)
> > +{
> > +    qemu_init(argc, argv, envp);
> > +    qemu_main_loop();
> > +    qemu_cleanup();
> > +
> > +    return 0;
> > +}
> <snip>
>=20
> Can we put the main in a project appropriate sub-directory so it's on
> the same order as linux-user/main.c?
>=20
> I guess the new directory could be "softmmu" which matches the director=
y
> or "system" which matches the binary name. I'd lean towards the latter
> as softmmu is very specifically not this bit.
Will do - should vl.c move into this directory, as well?
-Alex

> --=20
> Alex Benn=C3=A9e

