Received: from eggs.gnu.org ([209.51.188.92]:54065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmGWr-0001p4-Ty
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmGWr-0007HI-5x
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:09 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmGWq-0007GP-W1
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:09 -0500
Received: by mail-oi1-x244.google.com with SMTP id y23so1479782oia.4
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 03:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20190123080005.31078-1-kraxel@redhat.com>
	<20190123080005.31078-5-kraxel@redhat.com>
	<484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
	<20190123093657.GC27270@redhat.com>
	<d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
	<20190123101238.GD27270@redhat.com>
	<379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
	<CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
	<52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
In-Reply-To: <52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Jan 2019 11:16:56 +0000
Message-ID: <CAFEAcA9tD+AaTMDgUXO-XAfw8ftsip2n6Ew=GwVbPgMFzo01-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Brad Smith <brad@comstyle.com>

On Wed, 23 Jan 2019 at 11:09, Kamil Rytarowski <n54@gmx.com> wrote:
>
> On 23.01.2019 11:59, Peter Maydell wrote:
> > On Wed, 23 Jan 2019 at 10:37, Kamil Rytarowski <n54@gmx.com> wrote:
> >> OSS is the portable UNIX audio backend. We could point some flaws in it,
> >> but it's a good enough for portable UNIX applications. The question is
> >> what UNIX-like desktop OS does not implement it or removed it.
> >
> > If your desktop's native audio API is pulse, like Linux's often
> > is, then you want to use pulse directly, because the compat layers
> > are (or were last time I looked) not great, and typically add
> > in an extra thread and an extra layer of buffering, which means
> > more latency or more audio dropouts or both.

> Pulseaudio uses OSS backend on NetBSD anyway and we keep an in-kernel
> mixer. So it adds nothing except additional intermediate layer.

Yes, exactly -- if your native API is OSS, we should be using that.
It's the compat layers that are problematic, so we can't just use
a single portable API on all platforms.

> For non-professional audio purposes OSS is good enough for such
> applications.

QEMU has to care about the buffering that compat layers add,
because guest programs tend to work on the assumption that they're
talking directly to the hardware and extra buffering trips them up.

thanks
-- PMM
