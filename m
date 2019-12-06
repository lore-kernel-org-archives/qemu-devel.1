Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85261C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1F32064B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIJ9bUT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1F32064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGxK-0005yP-6z
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1idFCs-00084F-VU
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1idFCr-00078L-Hj
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:07:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32515
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1idFCr-000774-D1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575644864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qz567u+yT0zr/JjZxIadcGbgOXDrC+WKg4YWe886KhU=;
 b=YIJ9bUT+bh/eIaIeDlzp7xW0Vz6WrBKW/HYZwYEiOaDkBxzirsF1ZYv0NmZnp/bL0LCKk4
 RoaPgAxy7p9Aetjxj1G3kmCC1DLHJzJzzlXUey2uYOic/oCCt+M84vfq4L9oJjMLzg3he+
 2W9xBZmzgnrMaStmyLXG5KnsJ6+6gMQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-4QKlO17dO-Cu4ib8rFODkw-1; Fri, 06 Dec 2019 10:07:43 -0500
Received: by mail-wr1-f71.google.com with SMTP id r2so3265520wrp.7
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Qz567u+yT0zr/JjZxIadcGbgOXDrC+WKg4YWe886KhU=;
 b=ETYARj6tnuBui6UjCHCqbo4FebyuR+eq3nNqh6b2/QF/prnt9yu25rjM4fAzrff2+Y
 kW44kD0t4haVF64khzJraYSzD9l7bWvhKpvp0N0AMTMIuTNTZPdxzGuv+iIVoCgbBWlT
 ESf+kDf8ATFPO4OyG2WicqIPhmUqKUMS3jADw8kdYpbO+aG6QcEagqeIPgTj82Lq+e7s
 Hs34mv62aNFVxFVmn+JFKNAwtuQ5+/UB0CZVaSiuFn9XeGlsYUvJ9TxM/ZR6DkKXl30s
 JmBHdCP1ViWmjb+u3w/6Gz0SeSQvQqysA9fYXUrjJ0oiRtYM5qnLKhZFDOp2tpPORetM
 h+nw==
X-Gm-Message-State: APjAAAX3vxP7+5Z1j2IBw+MyTJCro7z7adGl0mMhJeA1Pm7SuRyHd0Pr
 TFVxzowr3aRIo4w4APTHdrYoJwsuWuh27CgVxjvLdCLArLlzj/jmSaSiGk+nFd5LBGEquksr/+D
 BzB8JXort1fVzJ2/Jx4KOvrf6D0evpcg=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr15776043wro.195.1575644862599; 
 Fri, 06 Dec 2019 07:07:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFlctG0n9kz6LxMcc+G0A0JVVbU54duyIpOgYMN7rxp/im62E+b+36pq4vKuXRwwb93gqvqQ8mXgLdBh7PEp0=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr15776017wro.195.1575644862340; 
 Fri, 06 Dec 2019 07:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20191126223810.20180-1-philmd@redhat.com>
 <20191126223810.20180-2-philmd@redhat.com>
 <20191206144605.GB5020@dhcp-17-72.bos.redhat.com>
In-Reply-To: <20191206144605.GB5020@dhcp-17-72.bos.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 6 Dec 2019 16:07:31 +0100
Message-ID: <CAP+75-Ubm9qb5JvXHV2Etcb1ejhqhDUOm4z_N5Z_DN8LoFiPHg@mail.gmail.com>
Subject: Re: [PATCH-for-4.2? v2 1/2] tests/boot_linux_console: Fetch assets
 from Debian snapshot archives
To: Cleber Rosa <crosa@redhat.com>
X-MC-Unique: 4QKlO17dO-Cu4ib8rFODkw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 6, 2019 at 3:46 PM Cleber Rosa <crosa@redhat.com> wrote:
> On Tue, Nov 26, 2019 at 11:38:09PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > The kernel packaged was fetched from an unstable repository.
> > Use the stable snapshot archive instead.
> >
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> > v2:
> > - Rebased
> > - Dropped Alex's Tested-by tag, since commit 2ecde8b2fb got merged
> >   since and it changed the tested kernel version.
> > ---
> >  tests/acceptance/boot_linux_console.py | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> > index 7e41cebd47..752f776f68 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -479,7 +479,8 @@ class BootLinuxConsole(Test):
> >          :avocado: tags=3Darch:m68k
> >          :avocado: tags=3Dmachine:q800
> >          """
> > -        deb_url =3D ('http://ftp.ports.debian.org/debian-ports/pool-m6=
8k/main'
> > +        deb_url =3D ('https://snapshot.debian.org/archive/debian-ports=
'
> > +                   '/20191021T083923Z/pool-m68k/main'
> >                     '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k=
.udeb')
> >          deb_hash =3D '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
> >          try:
> > --
> > 2.21.0
> >
>
> Works great, sorry for not picking it up earlier.  Now with rc-4, I'll
> check with Peter if we can still have this on 4.2 and send a PR.

Nobody complained and this is not a critical bugfix, so I'd now defer
it, to not delay 5.0 any longer.

> Thanks!
> - Cleber.


