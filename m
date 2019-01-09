Received: from eggs.gnu.org ([209.51.188.92]:34876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ghGF8-0007Xv-KM
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ghGF6-0002Ea-KR
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:58:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ghGF4-0002CR-HU
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:58:06 -0500
Date: Wed, 9 Jan 2019 10:58:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190109105659-mutt-send-email-mst@kernel.org>
References: <20190109082902.32271-1-marcandre.lureau@redhat.com>
	<20190109094732-mutt-send-email-mst@kernel.org>
	<CAJ+F1CLKTS=TW4j52NgVDELw8DrBqMFrb04a6w-YkvkTE8dXHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLKTS=TW4j52NgVDELw8DrBqMFrb04a6w-YkvkTE8dXHg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v15 0/6] Add support for TPM Physical
 Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>

On Wed, Jan 09, 2019 at 06:58:04PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Wed, Jan 9, 2019 at 6:51 PM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> >
> > On Wed, Jan 09, 2019 at 12:28:56PM +0400, Marc-Andr=E9 Lureau wrote:
> > > Hi,
> > >
> > > The following patches implement the TPM Physical Presence Interface
> > > that allows a user to set a command via ACPI (sysfs entry in Linux)
> > > that, upon the next reboot, the firmware looks for and acts upon by
> > > sending sequences of commands to the TPM.
> > >
> > > A dedicated memory region is added to the TPM CRB & TIS devices, at
> > > address/size 0xFED45000/0x400. A new "etc/tpm/config" fw_cfg entry
> > > holds the location for that PPI region and some version details, to
> > > allow for future flexibility.
> > >
> > > With the associated edk2/ovmf firmware, the Windows HLK "PPI 1.3" t=
est
> > > now runs successfully.
> > >
> > > It is based on previous work from Stefan Berger ("[PATCH v2 0/4]
> > > Implement Physical Presence interface for TPM 1.2 and 2")
> > >
> > > The edk2 support is merged upstream.
> >
> > So it looks good to me overall.
> > Minor style comments.
> >
> > With or without:
> >
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Thanks Michael for the review!
>=20
> Would you take it in your next pull request?

Stefan acked so sure I can do it.

> Or may I send a pull req?
>=20
> For the minor style comments, I can either let you do that on commit,
> resend,

Resend is easiest for maintainers usually.

> or together with a pullreq.
>=20
> thanks
>=20
> >
> >
> > > v15:
> > > - fix crash on reset when PPI is disabled
> > >
> > > v14:
> > > - rebased, fixing conflicts after compat-props refactoring
> > > - fix build regression from v13 with --disable-tpm
> > >
> > > v13:
> > > - removed needless error handling in tpm_ppi_init()
> > > - splitted "add ACPI memory clear interface"
> > > - moved acpi build function in dedicated hw/acpi/tpm.c
> > > - added some function documentation in headers
> > > - various code cleanups suggested by Philippe
> > > - rebased
> > >
> > > Marc-Andr=E9 Lureau (3):
> > >   tpm: add a "ppi" boolean property
> > >   acpi: add ACPI memory clear interface
> > >   tpm: clear RAM when "memory overwrite" requested
> > >
> > > Stefan Berger (3):
> > >   tpm: allocate/map buffer for TPM Physical Presence interface
> > >   acpi: expose TPM/PPI configuration parameters to firmware via fw_=
cfg
> > >   acpi: build TPM Physical Presence interface
> > >
> > >  hw/tpm/tpm_ppi.h      |  46 +++++
> > >  include/hw/acpi/tpm.h |  21 ++
> > >  hw/acpi/tpm.c         | 448 ++++++++++++++++++++++++++++++++++++++=
++++
> > >  hw/core/machine.c     |   8 +
> > >  hw/i386/acpi-build.c  |  29 ++-
> > >  hw/tpm/tpm_crb.c      |  13 ++
> > >  hw/tpm/tpm_ppi.c      |  53 +++++
> > >  hw/tpm/tpm_tis.c      |  13 ++
> > >  stubs/tpm.c           |   5 +
> > >  docs/specs/tpm.txt    | 104 ++++++++++
> > >  hw/acpi/Makefile.objs |   1 +
> > >  hw/tpm/Makefile.objs  |   1 +
> > >  hw/tpm/trace-events   |   3 +
> > >  13 files changed, 743 insertions(+), 2 deletions(-)
> > >  create mode 100644 hw/tpm/tpm_ppi.h
> > >  create mode 100644 hw/acpi/tpm.c
> > >  create mode 100644 hw/tpm/tpm_ppi.c
> > >
> > > --
> > > 2.20.1.2.gb21ebb671b
> >
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
