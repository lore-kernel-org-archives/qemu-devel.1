Received: from eggs.gnu.org ([2001:4830:134:3::10]:44344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLWDW-0006VY-RR
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLWDR-0002TV-SM
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:57:50 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:35464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dLWDR-0002T3-LL
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:57:45 -0400
Received: by mail-lf0-x22c.google.com with SMTP id p189so11044237lfe.2
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 07:57:45 -0700 (PDT)
Date: Thu, 15 Jun 2017 16:57:42 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170615145742.GF4859@toto>
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
	<b690a50d-4ab3-830c-93a3-5f2b4b027448@greensocs.com>
	<CAFEAcA94RykH0U33F0aGEYRs_FXF_NNuwQAX_mOf4wVde0s9BQ@mail.gmail.com>
	<1db78209-e426-03b5-9a19-592da96adaee@greensocs.com>
	<CAFEAcA-pmVW-fnu6ZT=PeRcSf-U5UVsyYsJkzh2c_BFKDTU5kg@mail.gmail.com>
	<d0a7ebb7-9f3d-5b3c-692e-344f4a980c05@redhat.com>
	<CAFEAcA_BkOaRCs1tm2dv+mYZj4yaNTg7VhR2C-NAQGAhw1wazA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_BkOaRCs1tm2dv+mYZj4yaNTg7VhR2C-NAQGAhw1wazA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/10] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, KONRAD Frederic <fred.konrad@greensocs.com>

On Thu, Jun 15, 2017 at 03:40:40PM +0100, Peter Maydell wrote:
> On 14 June 2017 at 12:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > I think the various bindings and rates could be refreshed as devices are
> > migrated.  This assumes that the device migration order is okay
> > according to the clock tree, that is if you have three devices X/Y/Z and
> > five clocks a/b/c/d/e/f:
> >
> >   fixed-clock
> >     |     |
> >    X:a   X:b
> >     |     |    \
> >    Y:c   Y:d      Z:e
> >           |
> >          Z:f
> >
> > you could do this:
> >
> > - migrate X
> >   - retrieve the PLL ratios for a and b's bound clocks (if the ratio
> >     is variable, otherwise no need for this)
> >   - in the post_load callback, bind a and b to the fixed-clock
> >     (if the binding is variable, otherwise no need for this)
> > - migrate Y
> >   - retrieve the PLL ratio for d's bound clocks (if the ratio
> >     is variable, otherwise no need for this)
> >   - in the post_load callback, bind c and d to a and b respectively
> >     (if the binding is variable, otherwise no need for this)
> > - migrate Z
> >   - in the post_load callback, bind e and f to b and d respectively
> >     (if the binding is variable, otherwise no need for this)
> 
> Unfortunately we make no guarantees at all about migration order
> for devices as far as I'm aware, so devices have to cope regardless.


How does this work for interrupts/gpios?

Perhaps we would need a way to force all clock sources that don't
depend on input clocks to re-notify their clocks after migration
is complete but before we run the new guest?

That would propagate updates throughout the chain...

Cheers,
Edgar

> 
> (There's also the possibility of an oddball bit of hardware which
> has a clocktree with loops in it.)
