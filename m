Received: from eggs.gnu.org ([209.51.188.92]:55451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1FB-00051C-An
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1F9-00037f-AW
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:57:53 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1F7-00034K-7K
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:57:49 -0500
Received: by mail-oi1-x244.google.com with SMTP id i6so18328982oia.6
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:57:38 -0800 (PST)
MIME-Version: 1.0
References: <20190122181822.1505-1-peter.maydell@linaro.org>
	<20190122181822.1505-3-peter.maydell@linaro.org>
	<20190122185515.GD13143@redhat.com>
In-Reply-To: <20190122185515.GD13143@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 18:57:26 +0000
Message-ID: <CAFEAcA_owgokutFTsmF0u6ujZQYU55kTToOOwH1yfe7ChXUm2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] slirp: Don't mark struct ipq or struct
 ipasfrag as packed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On Tue, 22 Jan 2019 at 18:55, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Jan 22, 2019 at 06:18:22PM +0000, Peter Maydell wrote:
> > There is no reason to mark the struct ipq and struct ipasfrag as
> > packed: they are naturally aligned anyway, and are not representing
> > any on-the-wire packet format.  Indeed they vary in size depending on
> > the size of pointers on the host system, because the 'struct qlink'
> > members include 'void *' fields.
> >
> > Dropping the 'packed' annotation fixes clang -Waddress-of-packed-member
> > warnings and probably lets the compiler generate better code too.
> >
> > The only thing we do care about in the layout of the struct is
> > that the frag_link matches up with the ipf_link of the struct
> > ipasfrag, as documented in the comment on that struct; assert
> > at build time that this is the case.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  slirp/ip.h | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/slirp/ip.h b/slirp/ip.h
> > index 243b6c8b249..20614f3b53e 100644
> > --- a/slirp/ip.h
> > +++ b/slirp/ip.h
>
> Just here there's a misleading comment
>
>   * size 28 bytes
>
> that should be purged

I noticed that one but left it alone on the basis that I
wasn't sure what to replace it with, and as it is it
provides the useful information of "somebody at some point
thought the size of this struct mattered but they were
badly confused, so tread with caution" :-)

thanks
-- PMM
