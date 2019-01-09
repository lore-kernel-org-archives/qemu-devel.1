Received: from eggs.gnu.org ([209.51.188.92]:37042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghGKU-0002oF-2q
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghGKR-00055I-RW
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:03:41 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghGKR-0004z5-LE
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:03:39 -0500
Received: by mail-ot1-x344.google.com with SMTP id t5so7135835otk.1
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 08:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20190103094211.28473-1-geert+renesas@glider.be>
	<acd10959-a781-d3bf-dc67-bda878740ec9@redhat.com>
In-Reply-To: <acd10959-a781-d3bf-dc67-bda878740ec9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Jan 2019 16:03:12 +0000
Message-ID: <CAFEAcA9jk1ocW8h33-f9mRM52mT96o+bviaRe6MRErkyxBtqYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH QEMU v5] hw/arm/sysbus-fdt: Add support for
 instantiating generic devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Alex Williamson <alex.williamson@redhat.com>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Wed, 9 Jan 2019 at 15:55, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Geert,
>
> On 1/3/19 10:42 AM, Geert Uytterhoeven wrote:
> > Add a fallback for instantiating generic devices without a type-specific
> > or compatible-specific instantiation method.  This will be used when no
> > other match is found.
> >
> > Generic device instantiation avoids having to write device-specific
> > instantiation methods for each and every "simple" device using only a
> > set of generic properties.  Devices that need more specialized handling
> > can still provide their own instantiation methods.

> > +    /* Ignoring the following may or may not work, hence the warning */
> > +    { "gpio-ranges",     PROP_WARN },   /* no support for pinctrl yet */
> > +    { "dmas",            PROP_WARN },   /* no support for external DMACs yet */
> I would be tempted to simply reject things that may not work.

More generally, this whole feature seems to be "allow things that
might not work", isn't it? Otherwise we could just have explicit
whitelists for the devices we want to allow passthrough of and
that we've tested to work.

I have to say I'm not really very enthusiastic about
enhancing this to allow random device passthrough,
because it encourages further use of this. If people
want hardware that can be passed through they should
put it behind a bus that can be probed and can go
behind an IOMMU, ie pci or some equivalent. That
is a supportable hardware mechanism. All this
machinery feels very heath-robinson...

thanks
-- PMM
