Received: from eggs.gnu.org ([209.51.188.92]:34114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghHeE-0005xP-7q
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghHeD-0000u3-3R
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:28:10 -0500
Date: Wed, 9 Jan 2019 17:28:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190109172801.GB3998@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
	<1547051976-13982-2-git-send-email-thuth@redhat.com>
	<3316bf08-36c0-c3ce-4e4f-8244276c58d3@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3316bf08-36c0-c3ce-4e4f-8244276c58d3@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] include/hw/ppc: Fix
 compilation with clang -std=gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On Wed, Jan 09, 2019 at 06:13:01PM +0100, C=C3=A9dric Le Goater wrote:
> On 1/9/19 5:39 PM, Thomas Huth wrote:
> > When compiling with Clang and -std=3Dgnu99, I get the following error=
s:
> >=20
> >   CC      ppc64-softmmu/hw/intc/xics_spapr.o
> > In file included from hw/intc/xics_spapr.c:34:
> > include/hw/ppc/xics.h:46:25: error: redefinition of typedef 'ICSState=
' is a C11 feature
> >       [-Werror,-Wtypedef-redefinition]
> > typedef struct ICSState ICSState;
> >                         ^
> > include/hw/ppc/spapr.h:18:25: note: previous definition is here
> > typedef struct ICSState ICSState;
> >                         ^
> > In file included from hw/intc/xics_spapr.c:34:
> > include/hw/ppc/xics.h:203:34: error: redefinition of typedef 'sPAPRMa=
chineState' is a C11 feature
> >       [-Werror,-Wtypedef-redefinition]
> > typedef struct sPAPRMachineState sPAPRMachineState;
> >                                  ^
> > include/hw/ppc/spapr_irq.h:25:34: note: previous definition is here
> > typedef struct sPAPRMachineState sPAPRMachineState;
> >                                  ^
> >   CC      ppc64-softmmu/hw/intc/spapr_xive.o
> > In file included from hw/intc/spapr_xive.c:19:
> > include/hw/ppc/spapr_xive.h:38:3: error: redefinition of typedef 'sPA=
PRXive' is a C11 feature
> >       [-Werror,-Wtypedef-redefinition]
> > } sPAPRXive;
> >   ^
> > include/hw/ppc/spapr.h:20:26: note: previous definition is here
> > typedef struct sPAPRXive sPAPRXive;
> >                          ^
> > In file included from hw/intc/spapr_xive.c:19:
> > include/hw/ppc/spapr_xive.h:45:34: error: redefinition of typedef 'sP=
APRMachineState' is a C11 feature
> >       [-Werror,-Wtypedef-redefinition]
> > typedef struct sPAPRMachineState sPAPRMachineState;
> >                                  ^
> > include/hw/ppc/spapr_irq.h:25:34: note: previous definition is here
> > typedef struct sPAPRMachineState sPAPRMachineState;
> >                                  ^
> >   CC      ppc64-softmmu/hw/char/spapr_vty.o
> > In file included from hw/char/spapr_vty.c:8:
> > In file included from include/hw/ppc/spapr.h:12:
> > include/hw/ppc/spapr_xive.h:45:34: error: redefinition of typedef 'sP=
APRMachineState' is a C11 feature
> >       [-Werror,-Wtypedef-redefinition]
> > typedef struct sPAPRMachineState sPAPRMachineState;
> >                                  ^
> > include/hw/ppc/spapr_irq.h:25:34: note: previous definition is here
> > typedef struct sPAPRMachineState sPAPRMachineState;
> >                                  ^
> >=20
> > Since we're going to make -std=3Dgnu99 mandatory, fix these issues
> > by including the right header files indead of typedeffing stuff twice=
.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  include/hw/ppc/spapr.h      | 4 ++--
> >  include/hw/ppc/spapr_xive.h | 2 +-
> >  include/hw/ppc/xics.h       | 4 ++--
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 2c77a8b..6a5ae4f 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -8,6 +8,8 @@
> >  #include "hw/mem/pc-dimm.h"
> >  #include "hw/ppc/spapr_ovec.h"
> >  #include "hw/ppc/spapr_irq.h"
> > +#include "hw/ppc/xics.h"
> > +#include "hw/ppc/spapr_xive.h"
> > =20
> >  struct VIOsPAPRBus;
> >  struct sPAPRPHBState;
> > @@ -15,8 +17,6 @@ struct sPAPRNVRAM;
> >  typedef struct sPAPREventLogEntry sPAPREventLogEntry;
> >  typedef struct sPAPREventSource sPAPREventSource;
> >  typedef struct sPAPRPendingHPT sPAPRPendingHPT;
> > -typedef struct ICSState ICSState;
> > -typedef struct sPAPRXive sPAPRXive;
> > =20
> >  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
> >  #define SPAPR_ENTRY_POINT       0x100
> > diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.=
h
> > index 728735d..aff4366 100644
> > --- a/include/hw/ppc/spapr_xive.h
> > +++ b/include/hw/ppc/spapr_xive.h
> > @@ -42,7 +42,7 @@ bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t =
lisn);
> >  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
> >  qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn);
> > =20
> > -typedef struct sPAPRMachineState sPAPRMachineState;
> > +#include "hw/ppc/spapr.h"  /* for sPAPRMachineState */
>=20
> so both files include each other, how nice ...

If the header files are mutually dependent it makes me wonder what the
point of having them split up is ?

Feels like either they need to be merged, or they need to be split up
and refactored even more to remove the mutual dependancy.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
