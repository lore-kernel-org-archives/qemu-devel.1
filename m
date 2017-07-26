Received: from eggs.gnu.org ([2001:4830:134:3::10]:47295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1daNiO-0003tx-5M
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1daNiN-0005eq-5M
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:55:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1daNiM-0005dJ-SL
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:55:07 -0400
Date: Wed, 26 Jul 2017 15:54:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170726145455.GA8648@work-vm>
References: <1500367747-8992-1-git-send-email-amarnath.valluri@intel.com>
	<1500367747-8992-9-git-send-email-amarnath.valluri@intel.com>
	<5a3a8c55-6306-9055-2aa1-6d1cb1242e93@linux.vnet.ibm.com>
	<1501040961.8796.11.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1501040961.8796.11.camel@intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Amarnath Valluri (amarnath.valluri@intel.com) wrote:
> On Tue, 2017-07-25 at 20:18 -0400, Stefan Berger wrote:
> > On 07/18/2017 04:49 AM, Amarnath Valluri wrote:
> > > diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> > > index 64cecc3..41f0b7a 100644
> > > --- a/hw/tpm/Makefile.objs
> > > +++ b/hw/tpm/Makefile.objs
> > > @@ -1,2 +1,3 @@
> > >   common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
> > >   common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o tpm_u=
til.o
> > > +common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o tpm_util.o
> > > diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> > > new file mode 100644
> > > index 0000000..c90914c
> > > --- /dev/null
> > > +++ b/hw/tpm/tpm_emulator.c
> > > @@ -0,0 +1,973 @@
> > > +/*
> > > + *  emulator TPM driver
> > > + *
> > > + *  Copyright (c) 2017 Intel Corporation
> > > + *  Author: Amarnath Valluri <amarnath.valluri@intel.com>
> > > + *
> > > + *  Copyright (c) 2010 - 2013 IBM Corporation
> > > + *  Authors:
> > > + *    Stefan Berger <stefanb@us.ibm.com>
> > > + *
> > > + *  Copyright (C) 2011 IAIK, Graz University of Technology
> > > + *    Author: Andreas Niederl
> > > + *
> > > + * This library is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU Lesser General Public
> > > + * License as published by the Free Software Foundation; either
> > > + * version 2 of the License, or (at your option) any later version=
.
> > > + *
> > > + * This library is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the G=
NU
> > > + * Lesser General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU Lesser General Publi=
c
> > > + * License along with this library; if not, see <http://www.gnu.or=
g/licenses/>
> > > + *
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qemu/error-report.h"
> > > +#include "qemu/sockets.h"
> > > +#include "io/channel-socket.h"
> > > +#include "sysemu/tpm_backend.h"
> > > +#include "tpm_int.h"
> > > +#include "hw/hw.h"
> > > +#include "hw/i386/pc.h"
> > > +#include "tpm_util.h"
> > > +#include "tpm_ioctl.h"
> > > +#include "migration/migration.h"
> > > +#include "qapi/error.h"
> > > +
> > > +#include <fcntl.h>
> > > +#include <sys/types.h>
> > > +#include <sys/stat.h>
> > > +#include <stdio.h>
> > > +
> > > +#define DEBUG_TPM 0
> > > +
> > > +#define DPRINT(fmt, ...) do { \
> > > +    if (DEBUG_TPM) { \
> > > +        fprintf(stderr, fmt, ## __VA_ARGS__); \
> > > +    } \
> > > +} while (0);
> > > +
> > > +#define DPRINTF(fmt, ...) DPRINT("tpm-emulator: "fmt"\n", __VA_ARG=
S__)
> > > +
> > > +#define TYPE_TPM_EMULATOR "tpm-emulator"
> > > +#define TPM_EMULATOR(obj) \
> > > +    OBJECT_CHECK(TPMEmulator, (obj), TYPE_TPM_EMULATOR)
> > > +
> > > +static const TPMDriverOps tpm_emulator_driver;
> > > +
> > > +/* data structures */
> > > +typedef struct TPMEmulator {
> > > +    TPMBackend parent;
> > > +
> > > +    TPMEmulatorOptions *ops;
> > > +    QIOChannel *data_ioc;
> > > +    QIOChannel *ctrl_ioc;
> > > +    bool op_executing;
> > > +    bool op_canceled;
> > > +    bool child_running;
> > > +    TPMVersion tpm_version;
> > > +    ptm_cap caps; /* capabilities of the TPM */
> > > +    uint8_t cur_locty_number; /* last set locality */
> > > +    QemuMutex state_lock;
> > > +    Error *migration_blocker;
> > > +} TPMEmulator;
> > > +
> > > +#define TPM_DEFAULT_EMULATOR "swtpm"
> > > +#define TPM_DEFAULT_LOGLEVEL 5
> > > +#define TPM_EMULATOR_PIDFILE "/tmp/qemu-tpm.pid"
> >=20
> > swtpm will write this file and remove it when it terminates. You may =
run=20
> > into concurrency problems as well. I would extend this name with the =
pid=20
> > of the QEMU process starting swtpm.
> Stefan, there was some issue in my reabasing and sent wrong version of
> patchset, but i made all the changes you suggested including the pid
> file.
>=20
> But i did not sent the next version as Marc-Andr=E9 Lureau objected the
> the idea of spawning swtpm from Qemu. I started exploring his suggestio=
n
> of 'chardev'.
>=20
> I feel like we are back to square one :).

I agree with Marc-Andre that it's best not to spawn it from qemu; the
way we do pretty much all other external tools is to get something else
to start them up and wire them back in with a chardev.

Dave

> - Amarnath
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
