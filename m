Received: from eggs.gnu.org ([209.51.188.92]:52412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwneP-0007sh-Vm
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwnd2-0000Ss-Hm
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:39:06 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwnd0-0000Lf-Ks
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 07:39:04 -0500
Received: by mail-ot1-x344.google.com with SMTP id 98so44848156oty.1
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 04:38:50 -0800 (PST)
MIME-Version: 1.0
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-3-armbru@redhat.com>
	<2340eb1c-d8d8-3d92-bbb5-b541bb44dcba@redhat.com>
	<CAFEAcA9Pe3D=7r+3csriAZO8gkVkwypOBncZzkYTOCAujpKOsA@mail.gmail.com>
	<875ztfuc0j.fsf@dusky.pond.sub.org> <87sgwh5wef.fsf@dusky.pond.sub.org>
	<CAFEAcA8gHp-VD05x9Q1V3_K29wsMeZD1SdM+PDteOXcAE3QHwg@mail.gmail.com>
	<83b8edf2-8a4b-3d1b-bdde-63738ffb6479@redhat.com>
In-Reply-To: <83b8edf2-8a4b-3d1b-bdde-63738ffb6479@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 12:38:38 +0000
Message-ID: <CAFEAcA_AnnNY9FcP0KOSy0VfobH3pMZkW-=qRy=MCQdC53yXQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/10] pflash: Macro PFLASH_BUG() is used
 just once, expand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>

On Thu, 21 Feb 2019 at 12:07, Laszlo Ersek <lersek@redhat.com> wrote:
> since we're talking "reset_flash", I'll note that there is no actual
> reset handler for cfi.pflash01. I found out recently, via:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1678713

Yes; this isn't uncommon for some of the really old
device models. It should definitely have one added.

You are correct also that the timer in the pflash_cfi01
model is dead code -- it has always been so, since the
device was added in 2007. The reason it is there is that
pflash_cfi01 was created as a copy-and-hack of the
cfi02 device. In cfi02 we do use the timer, as a way
of simulating "make full-chip and sector erases take a
guest-visible amount of time rather than completing
instantaneously". cfi01 doesn't do that (and I think
may not implement anything other than block erase),
but the timer initialization code was left in rather
than being deleted as part of the copy-and-hack.

thanks
-- PMM
