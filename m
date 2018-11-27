Received: from eggs.gnu.org ([2001:4830:134:3::10]:34175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gRaMZ-0002SZ-Lh
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gRaMY-0000sg-IZ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:13:03 -0500
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:38720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gRaMY-0000sI-CH
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:13:02 -0500
Received: by mail-it1-x141.google.com with SMTP id h65so32911275ith.3
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 02:13:02 -0800 (PST)
MIME-Version: 1.0
References: <1542868372-2602-1-git-send-email-liq3ea@gmail.com>
	<1542868372-2602-2-git-send-email-liq3ea@gmail.com>
	<87y39fuht5.fsf@dusky.pond.sub.org>
In-Reply-To: <87y39fuht5.fsf@dusky.pond.sub.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 27 Nov 2018 18:12:25 +0800
Message-ID: <CAKXe6SJSf8xuG+2NaD+3q7oPNfwLff1qzWZFUO73tOg_9kxVog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: pc: use TYPE_XXX instead of
 constant strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Qemu Developers <qemu-devel@nongnu.org>

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:59=E5=86=99=E9=81=93=EF=BC=
=9A

> Li Qiang <liq3ea@gmail.com> writes:
>
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  hw/i386/pc.c         | 9 +++------
> >  hw/sparc64/sun4u.c   | 2 +-
> >  include/hw/i386/pc.h | 7 +++++++
> >  3 files changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index f095725dba..5d3fd86b83 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -502,9 +502,6 @@ void pc_cmos_init(PCMachineState *pcms,
> >      qemu_register_reset(pc_cmos_init_late, &arg);
> >  }
> >
> > -#define TYPE_PORT92 "port92"
> > -#define PORT92(obj) OBJECT_CHECK(Port92State, (obj), TYPE_PORT92)
> > -
> >  /* port 92 stuff: could be split off */
> >  typedef struct Port92State {
> >      ISADevice parent_obj;
> > @@ -1543,10 +1540,10 @@ static void pc_superio_init(ISABus *isa_bus,
> bool create_fdctrl, bool no_vmport)
> >          fdctrl_init_isa(isa_bus, fd);
> >      }
> >
> > -    i8042 =3D isa_create_simple(isa_bus, "i8042");
> > +    i8042 =3D isa_create_simple(isa_bus, TYPE_I8042);
> >      if (!no_vmport) {
> >          vmport_init(isa_bus);
> > -        vmmouse =3D isa_try_create(isa_bus, "vmmouse");
> > +        vmmouse =3D isa_try_create(isa_bus, TYPE_VMMOUSE);
> >      } else {
> >          vmmouse =3D NULL;
> >      }
> > @@ -1555,7 +1552,7 @@ static void pc_superio_init(ISABus *isa_bus, bool
> create_fdctrl, bool no_vmport)
> >          qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
> >          qdev_init_nofail(dev);
> >      }
> > -    port92 =3D isa_create_simple(isa_bus, "port92");
> > +    port92 =3D isa_create_simple(isa_bus, TYPE_PORT92);
> >
> >      a20_line =3D qemu_allocate_irqs(handle_a20_line_change, first_cpu,=
 2);
> >      i8042_setup_a20_line(i8042, a20_line[0]);
> > diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> > index f76b19e4e9..c49a416b95 100644
> > --- a/hw/sparc64/sun4u.c
> > +++ b/hw/sparc64/sun4u.c
> > @@ -305,7 +305,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error
> **errp)
> >      parallel_hds_isa_init(s->isa_bus, MAX_PARALLEL_PORTS);
> >
> >      /* Keyboard */
> > -    isa_create_simple(s->isa_bus, "i8042");
> > +    isa_create_simple(s->isa_bus, TYPE_I8042);
> >
> >      /* Floppy */
> >      for (i =3D 0; i < MAX_FD; i++) {
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index 136fe497b6..29db770d86 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -169,6 +169,13 @@ void gsi_handler(void *opaque, int n, int level);
> >  #define TYPE_VMPORT "vmport"
> >  typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
> >
> > +#define TYPE_PORT92 "port92"
> > +#define PORT92(obj) OBJECT_CHECK(Port92State, (obj), TYPE_PORT92)
>
> Why move these to the header?  They're used only in hw/i386/pc.c.
>
> > +
> > +/* vmmouse.c */
> > +#define TYPE_VMMOUSE "vmmouse"
> > +#define VMMOUSE(obj) OBJECT_CHECK(VMMouseState, (obj), TYPE_VMMOUSE)
> > +
>
> Likewise, why define these in the header?
>
>
Hello Markus,

Thanks for your review.
Seems there is an error.  I have made a new revision just touch the
necessary code.
A new revision has been sent out.

Thanks,
Li Qiang


> TYPE_VMMOUSE is used just once, in hw/i386/pc.c.  VMMOUSE() isn't used
> at all.  I'm okay with adding macros anyway, for consistency.
>
> >  static inline void vmport_init(ISABus *bus)
> >  {
> >      isa_create_simple(bus, TYPE_VMPORT);
>
