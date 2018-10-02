Received: from eggs.gnu.org ([2001:4830:134:3::10]:41556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7JtB-00023m-Mk
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7Jt8-0001CT-HJ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:34:57 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7Jt7-0001Br-HP
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:34:54 -0400
Received: by mail-yb1-f195.google.com with SMTP id h1-v6so684511ybm.4
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 05:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180927002416.1781-1-f4bug@amsat.org>
	<CAFEAcA-=9AkRsXL+EnQJHCqGRAHnJ06AiPdoK3c5J-cgH8MUDw@mail.gmail.com>
In-Reply-To: <CAFEAcA-=9AkRsXL+EnQJHCqGRAHnJ06AiPdoK3c5J-cgH8MUDw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 2 Oct 2018 14:34:40 +0200
Message-ID: <CAAdtpL6RJhySHMmhfp6V6iXzL_C6Fj9-XqYAhige2B1W6dD65w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix access_with_adjusted_size() on
 big-endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On Tue, Oct 2, 2018 at 2:19 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
> On 27 September 2018 at 01:24, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> > Hi,
> >
> > This series fix a bug I'v been hunting for a long time.
> >
> > With BE regions, if the guest used smaller access than the region
> > implementation, the shift value is negative, but since access_fn()
> > uses unsigned type for shift, it result in a huge positive value,
> > then accessors shift the value which eventually becomes 0.
> >
> > The fix is simply to use signed type for the shift, and shift to
> > the opposite direction for negative values.
>
> Series
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks for reviewing this.

> I guess we don't have very many devices that are BE and
> that allow the guest to access them with a smaller
> width than their implemented width...

Do you think is it worth using the '(un)likely()' macros?
