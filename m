Received: from eggs.gnu.org ([2001:4830:134:3::10]:36061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dxrwZ-00042R-Dv
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dxrwO-0005dD-Eb
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:50:47 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:52096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dxrwO-0005ci-6a
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:50:40 -0400
Received: by mail-oi0-x243.google.com with SMTP id n82so1185127oib.8
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 02:50:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506674157.3700.3.camel@intel.com>
References: <1506590409-28857-1-git-send-email-amarnath.valluri@intel.com>
	<1506590409-28857-9-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1C+u4ggH1feJTqzC5dZYfKG0=4H5ihBtDDgiX8UYowfbuA@mail.gmail.com>
	<1506674157.3700.3.camel@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 29 Sep 2017 11:50:37 +0200
Message-ID: <CAJ+F1CLiGiWfvTkBhXyx0+esQPWCTHYoo4aFnZ74AsLYERpPUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 8/8] tpm: Added support for TPM emulator
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Valluri, Amarnath" <amarnath.valluri@intel.com>
Cc: "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Fri, Sep 29, 2017 at 10:35 AM, Valluri, Amarnath
<amarnath.valluri@intel.com> wrote:
> On Thu, 2017-09-28 at 13:53 +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Thu, Sep 28, 2017 at 11:20 AM, Amarnath Valluri
>> <amarnath.valluri@intel.com> wrote:
>> >
>> > This change introduces a new TPM backend driver that can
>> > communicate with
>> > swtpm(software TPM emulator) using unix domain socket interface.
>> > QEMU talks to
>> > TPM emulator using QEMU's socket-based chardev backend device.
>> >
>> > Swtpm uses two Unix sockets for communications, one for plain TPM
>> > commands and
>> > responses, and one for out-of-band control messages. QEMU passes
>> > data socket to
>> > be used over the control channel.
>> >
>> > The swtpm and associated tools can be found here:
>> >     https://github.com/stefanberger/swtpm
>> >
>> > The swtpm's control channel protocol specification can be found
>> > here:
>> >     https://github.com/stefanberger/swtpm/wiki/Control-Channel-Spec
>> > ification
>> >
>> > Usage:
>> >     # setup TPM state directory
>> >     mkdir /tmp/mytpm
>> >     chown -R tss:root /tmp/mytpm
>> >     /usr/bin/swtpm_setup --tpm-state /tmp/mytpm --createek
>> >
>> >     # Ask qemu to use TPM emulator with given tpm state directory
>> >     qemu-system-x86_64 \
>> >         [...] \
>> >         -chardev socket,id=3Dchrtpm,path=3D/tmp/swtpm-sock \
>> >         -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
>> >         -device tpm-tis,tpmdev=3Dtpm0 \
>> >         [...]
>> >
>> > Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
>> > ---
>> >  configure             |  13 +-
>> >  hmp.c                 |   5 +
>> >  hw/tpm/Makefile.objs  |   1 +
>> >  hw/tpm/tpm_emulator.c | 599
>> > ++++++++++++++++++++++++++++++++++++++++++++++++++
>> >  hw/tpm/tpm_ioctl.h    | 246 +++++++++++++++++++++
>> >  qapi/tpm.json         |  21 +-
>> >  qemu-options.hx       |  22 +-
>> >  vl.c                  |   1 +
>> >  8 files changed, 901 insertions(+), 7 deletions(-)
>> >  create mode 100644 hw/tpm/tpm_emulator.c
>> >  create mode 100644 hw/tpm/tpm_ioctl.h
>> >
>> > diff --git a/configure b/configure
>> > index cb0f7ed..a1b956e 100755
>> > --- a/configure
>> > +++ b/configure
>> > @@ -3467,6 +3467,12 @@ else
>> >    tpm_passthrough=3Dno
>> >  fi
>> >
>> > +# TPM emulator is for all posix systems
>> > +if test "$mingw32" !=3D "yes"; then
>> > +  tpm_emulator=3D$tpm
>> > +else
>> > +  tpm_emulator=3Dno
>> > +fi
>> >  ##########################################
>> >  # attr probe
>> >
>> > @@ -5359,6 +5365,7 @@ echo "gcov enabled      $gcov"
>> >  echo "TPM support       $tpm"
>> >  echo "libssh2 support   $libssh2"
>> >  echo "TPM passthrough   $tpm_passthrough"
>> > +echo "TPM emulator      $tpm_emulator"
>> >  echo "QOM debugging     $qom_cast_debug"
>> >  echo "Live block migration $live_block_migration"
>> >  echo "lzo support       $lzo"
>> > @@ -5937,12 +5944,16 @@ if test "$live_block_migration" =3D "yes" ;
>> > then
>> >    echo "CONFIG_LIVE_BLOCK_MIGRATION=3Dy" >> $config_host_mak
>> >  fi
>> >
>> > -# TPM passthrough support?
>> >  if test "$tpm" =3D "yes"; then
>> >    echo 'CONFIG_TPM=3D$(CONFIG_SOFTMMU)' >> $config_host_mak
>> > +  # TPM passthrough support?
>> >    if test "$tpm_passthrough" =3D "yes"; then
>> >      echo "CONFIG_TPM_PASSTHROUGH=3Dy" >> $config_host_mak
>> >    fi
>> > +  # TPM emulator support?
>> > +  if test "$tpm_emulator" =3D "yes"; then
>> > +    echo "CONFIG_TPM_EMULATOR=3Dy" >> $config_host_mak
>> > +  fi
>> >  fi
>> >
>> >  echo "TRACE_BACKENDS=3D$trace_backends" >> $config_host_mak
>> > diff --git a/hmp.c b/hmp.c
>> > index 0fb2bc7..9cd8179 100644
>> > --- a/hmp.c
>> > +++ b/hmp.c
>> > @@ -994,6 +994,7 @@ void hmp_info_tpm(Monitor *mon, const QDict
>> > *qdict)
>> >      Error *err =3D NULL;
>> >      unsigned int c =3D 0;
>> >      TPMPassthroughOptions *tpo;
>> > +    TPMEmulatorOptions *teo;
>> >
>> >      info_list =3D qmp_query_tpm(&err);
>> >      if (err) {
>> > @@ -1023,6 +1024,10 @@ void hmp_info_tpm(Monitor *mon, const QDict
>> > *qdict)
>> >                             tpo->has_cancel_path ? ",cancel-path=3D"
>> > : "",
>> >                             tpo->has_cancel_path ? tpo->cancel_path
>> > : "");
>> >              break;
>> > +        case TPM_TYPE_OPTIONS_KIND_EMULATOR:
>> > +            teo =3D ti->options->u.emulator.data;
>> > +            monitor_printf(mon, ",chardev=3D%s", teo->chardev);
>> > +            break;
>> >          case TPM_TYPE_OPTIONS_KIND__MAX:
>> >              break;
>> >          }
>> > diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
>> > index 64cecc3..41f0b7a 100644
>> > --- a/hw/tpm/Makefile.objs
>> > +++ b/hw/tpm/Makefile.objs
>> > @@ -1,2 +1,3 @@
>> >  common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
>> >  common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
>> > tpm_util.o
>> > +common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o tpm_util.o
>> > diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
>> > new file mode 100644
>> > index 0000000..0065b0a
>> > --- /dev/null
>> > +++ b/hw/tpm/tpm_emulator.c
>> > @@ -0,0 +1,599 @@
>> > +/*
>> > + *  Emulator TPM driver
>> > + *
>> > + *  Copyright (c) 2017 Intel Corporation
>> > + *  Author: Amarnath Valluri <amarnath.valluri@intel.com>
>> > + *
>> > + *  Copyright (c) 2010 - 2013 IBM Corporation
>> > + *  Authors:
>> > + *    Stefan Berger <stefanb@us.ibm.com>
>> > + *
>> > + *  Copyright (C) 2011 IAIK, Graz University of Technology
>> > + *    Author: Andreas Niederl
>> > + *
>> > + * This library is free software; you can redistribute it and/or
>> > + * modify it under the terms of the GNU Lesser General Public
>> > + * License as published by the Free Software Foundation; either
>> > + * version 2 of the License, or (at your option) any later
>> > version.
>> > + *
>> > + * This library is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > GNU
>> > + * Lesser General Public License for more details.
>> > + *
>> > + * You should have received a copy of the GNU Lesser General
>> > Public
>> > + * License along with this library; if not, see <http://www.gnu.or
>> > g/licenses/>
>> > + *
>> > + */
>> > +
>> > +#include "qemu/osdep.h"
>> > +#include "qemu/error-report.h"
>> > +#include "qemu/sockets.h"
>> > +#include "io/channel-socket.h"
>> > +#include "sysemu/tpm_backend.h"
>> > +#include "tpm_int.h"
>> > +#include "hw/hw.h"
>> > +#include "hw/i386/pc.h"
>> > +#include "tpm_util.h"
>> > +#include "tpm_ioctl.h"
>> > +#include "migration/blocker.h"
>> > +#include "qapi/error.h"
>> > +#include "qapi/clone-visitor.h"
>> > +#include "chardev/char-fe.h"
>> > +
>> > +#include <fcntl.h>
>> > +#include <sys/types.h>
>> > +#include <sys/stat.h>
>> > +#include <stdio.h>
>> > +
>> > +#define DEBUG_TPM 0
>> > +
>> > +#define DPRINTF(fmt, ...) do { \
>> > +    if (DEBUG_TPM) { \
>> > +        fprintf(stderr, "tpm-emulator:"fmt"\n", ## __VA_ARGS__); \
>> > +    } \
>> > +} while (0)
>> > +
>> > +#define TYPE_TPM_EMULATOR "tpm-emulator"
>> > +#define TPM_EMULATOR(obj) \
>> > +    OBJECT_CHECK(TPMEmulator, (obj), TYPE_TPM_EMULATOR)
>> > +
>> > +#define TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps &
>> > (cap)) =3D=3D (cap))
>> > +
>> > +static const TPMDriverOps tpm_emulator_driver;
>> > +
>> > +/* data structures */
>> > +typedef struct TPMEmulator {
>> > +    TPMBackend parent;
>> > +
>> > +    TPMEmulatorOptions *options;
>> > +    CharBackend ctrl_chr;
>> > +    QIOChannel *data_ioc;
>> > +    TPMVersion tpm_version;
>> > +    ptm_cap caps; /* capabilities of the TPM */
>> > +    uint8_t cur_locty_number; /* last set locality */
>> > +    QemuMutex state_lock;
>> The mutex isnt doing much with this code, as there should be no
>> concurrent handle_request() (thread-pool has max-thread=3D1).
> Yes I agree, I can remove this mutex in this case.
>>
>> (I wonder if we could replace the thread-pool with a coroutine/bh
>> doing IO instead to avoid potential thread races... or just do IO in
>> the current context, like the ctrlcmd)
> Yes we should. Can we do it as a separate PR?. As it touches both the
> backends.
>

Absolutely, this is not directly related. We should try to get your
series merged first. I have a pending series with various tpm
cleanups, I may try to tackle that too.

Thanks


--=20
Marc-Andr=C3=A9 Lureau
