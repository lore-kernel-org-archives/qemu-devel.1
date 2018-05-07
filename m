Received: from eggs.gnu.org ([2001:4830:134:3::10]:47146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFezV-0001jk-4q
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFezP-0008WI-4b
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:11:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47306 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFezP-0008W4-0J
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:11:35 -0400
Date: Mon, 7 May 2018 14:11:26 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180507121126.gjeufzppsc7qspgm@sirius.home.kraxel.org>
References: <20180507101013.32736-1-kraxel@redhat.com>
	<CAFEAcA-a74RLKXi=v7w-8v9h6A_QFSKeNxK64AvCYKxc_VN+uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-a74RLKXi=v7w-8v9h6A_QFSKeNxK64AvCYKxc_VN+uA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] vga: print friendly error message in case
 multiple vga devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> > +    if (global_vmstate) {
> > +        static int have_vga;
> > +        if (have_vga) {
> > +            error_report("only one vga device is supported");
> > +            exit(1);
> > +        }
> > +        have_vga = true;
> > +    }
> >      s->is_vbe_vmstate = 1;
> >      memory_region_init_ram_nomigrate(&s->vram, obj, "vga.vram", s->vram_size,
> >                             &error_fatal);
> > --
> > 2.9.3
> >
> 
> This seems like a bit of an irritating reason to refuse to
> allow multiple VGA devices though, since we could make
> them work by having the vmstate be not-global.

Multiple vga devices will also try to use the same isa vga
ports.  Seems that doesn't make qemu abort any more, which
used to happen in older versions.

> Which is
> exactly what it ought to be -- we're only defaulting to
> "use global" here for migration compatibility, I think.

Yes.

> Since multiple VGA devices didn't work before, there's
> no old configs we need to migrate from, and so I think
> we could just say "the second and subsequent VGA devices
> get non-global ram vmstate" ?

Yes, we could allow multiple vga devices that way.  But due
to the ioport resource conflict only one of the two (or more)
vga devices will work properly.

So I'm not sure allowing that configuration is actually an
improvement ...

I surely can update the commit message to also mention the
ioport conflict though.

cheers,
  Gerd
