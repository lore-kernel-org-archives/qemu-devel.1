Received: from eggs.gnu.org ([209.51.188.92]:59692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghFJG-0003m4-S2
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghFJD-0000uN-PP
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:58:22 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ghFJD-0000rF-ID
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:58:19 -0500
Received: by mail-wm1-x342.google.com with SMTP id y139so7887471wmc.5
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 06:58:16 -0800 (PST)
MIME-Version: 1.0
References: <20190109082902.32271-1-marcandre.lureau@redhat.com>
	<20190109094732-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190109094732-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 9 Jan 2019 18:58:04 +0400
Message-ID: <CAJ+F1CLKTS=TW4j52NgVDELw8DrBqMFrb04a6w-YkvkTE8dXHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>

Hi

On Wed, Jan 9, 2019 at 6:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jan 09, 2019 at 12:28:56PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > The following patches implement the TPM Physical Presence Interface
> > that allows a user to set a command via ACPI (sysfs entry in Linux)
> > that, upon the next reboot, the firmware looks for and acts upon by
> > sending sequences of commands to the TPM.
> >
> > A dedicated memory region is added to the TPM CRB & TIS devices, at
> > address/size 0xFED45000/0x400. A new "etc/tpm/config" fw_cfg entry
> > holds the location for that PPI region and some version details, to
> > allow for future flexibility.
> >
> > With the associated edk2/ovmf firmware, the Windows HLK "PPI 1.3" test
> > now runs successfully.
> >
> > It is based on previous work from Stefan Berger ("[PATCH v2 0/4]
> > Implement Physical Presence interface for TPM 1.2 and 2")
> >
> > The edk2 support is merged upstream.
>
> So it looks good to me overall.
> Minor style comments.
>
> With or without:
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Thanks Michael for the review!

Would you take it in your next pull request? Or may I send a pull req?

For the minor style comments, I can either let you do that on commit,
resend, or together with a pullreq.

thanks

>
>
> > v15:
> > - fix crash on reset when PPI is disabled
> >
> > v14:
> > - rebased, fixing conflicts after compat-props refactoring
> > - fix build regression from v13 with --disable-tpm
> >
> > v13:
> > - removed needless error handling in tpm_ppi_init()
> > - splitted "add ACPI memory clear interface"
> > - moved acpi build function in dedicated hw/acpi/tpm.c
> > - added some function documentation in headers
> > - various code cleanups suggested by Philippe
> > - rebased
> >
> > Marc-Andr=C3=A9 Lureau (3):
> >   tpm: add a "ppi" boolean property
> >   acpi: add ACPI memory clear interface
> >   tpm: clear RAM when "memory overwrite" requested
> >
> > Stefan Berger (3):
> >   tpm: allocate/map buffer for TPM Physical Presence interface
> >   acpi: expose TPM/PPI configuration parameters to firmware via fw_cfg
> >   acpi: build TPM Physical Presence interface
> >
> >  hw/tpm/tpm_ppi.h      |  46 +++++
> >  include/hw/acpi/tpm.h |  21 ++
> >  hw/acpi/tpm.c         | 448 ++++++++++++++++++++++++++++++++++++++++++
> >  hw/core/machine.c     |   8 +
> >  hw/i386/acpi-build.c  |  29 ++-
> >  hw/tpm/tpm_crb.c      |  13 ++
> >  hw/tpm/tpm_ppi.c      |  53 +++++
> >  hw/tpm/tpm_tis.c      |  13 ++
> >  stubs/tpm.c           |   5 +
> >  docs/specs/tpm.txt    | 104 ++++++++++
> >  hw/acpi/Makefile.objs |   1 +
> >  hw/tpm/Makefile.objs  |   1 +
> >  hw/tpm/trace-events   |   3 +
> >  13 files changed, 743 insertions(+), 2 deletions(-)
> >  create mode 100644 hw/tpm/tpm_ppi.h
> >  create mode 100644 hw/acpi/tpm.c
> >  create mode 100644 hw/tpm/tpm_ppi.c
> >
> > --
> > 2.20.1.2.gb21ebb671b
>


--=20
Marc-Andr=C3=A9 Lureau
