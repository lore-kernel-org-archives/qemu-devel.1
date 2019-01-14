Received: from eggs.gnu.org ([209.51.188.92]:41109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1giyre-0001RR-G5
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1giyrc-0000Pa-Bs
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:49:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1giyrZ-0000L8-PM
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:48:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id m6so17322868oig.11
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 01:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20190111131836.107549-1-sgarzare@redhat.com>
	<20190111131836.107549-5-sgarzare@redhat.com>
	<20190111163421.GF14776@stefanha-x1.localdomain>
In-Reply-To: <20190111163421.GF14776@stefanha-x1.localdomain>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 14 Jan 2019 10:48:44 +0100
Message-ID: <CAGxU2F6AhAo4bKPS80spX8NRaDoBgOBsZ8fVPJ7g0h4b6PGLAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Maran Wilson <maran.wilson@oracle.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jan 11, 2019 at 5:34 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Fri, Jan 11, 2019 at 02:18:36PM +0100, Stefano Garzarella wrote:
> > Use pvh.bin option rom when we are booting an uncompressed
> > kernel using the x86/HVM direct boot ABI.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > Based-on: <1545422632-24444-5-git-send-email-liam.merwick@oracle.com>
> > ---
> >  hw/i386/pc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 06bce6a101..deab8a2816 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1005,6 +1005,10 @@ static void load_linux(PCMachineState *pcms,
> >              fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
> >                               header, sizeof(header));
> >
> > +            option_rom[nb_option_roms].bootindex = 0;
> > +            option_rom[nb_option_roms].name = "pvh.bin";
> > +            nb_option_roms++;
> > +
>
> xen_load_linux() has the following:
>
>   assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
>          !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
>          !strcmp(option_rom[i].name, "multiboot.bin"));
>
> I wonder if it needs to be updated for pvh.bin?

Yeah! I think we need to add pvh.bin on the assert in xen_load_linux().

Thanks for catching this,
Stefano
