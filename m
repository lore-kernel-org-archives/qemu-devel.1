Received: from eggs.gnu.org ([209.51.188.92]:40637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmyqr-0005pr-G5
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmyqq-00035t-HH
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:36:45 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmyqq-00031E-AO
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:36:44 -0500
Received: by mail-ot1-x342.google.com with SMTP id s13so8100050otq.4
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20190123212234.32068-1-stefanha@redhat.com>
	<20190123212234.32068-3-stefanha@redhat.com>
	<f58f9085-c895-1fa5-9fae-afe4ac8de39a@redhat.com>
	<20190125102842.GB28305@stefanha-x1.localdomain>
In-Reply-To: <20190125102842.GB28305@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 10:36:17 +0000
Message-ID: <CAFEAcA-Dy0B-qCdojx9j49vF_p7OcAyQAiXYMv-_EZq7CCgT1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/5] pflash: flush rom device memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Julia Suvorova <jusual@mail.ru>, Richard Henderson <rth@twiddle.net>

On Fri, 25 Jan 2019 at 10:28, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Thu, Jan 24, 2019 at 12:11:55PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > The device realize() is also executed before the guest is started, is
> > this call really necessary?
>
> My rationale was that machine init only happens before the guest is
> started while ->realize() is called by hotplug too.

Yes, but before realize the flash memory can't actually be
visible to the guest, so there's no need to invalidate anything.

> That said, can pflash devices be hotplugged?

I guess you could have one inside a hotplugged device in theory;
they can't be directly hotpluggged. (I bet that in practice
there are leaks though if you did do that, and we don't have
any devices that do so today.)

> If you guys prefer not flushing from pflash ->realize() then I'll drop
> it.

I think it makes more sense not to do a flush in the realize method.

thanks
-- PMM
