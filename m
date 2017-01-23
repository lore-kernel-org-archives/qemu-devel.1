Received: from eggs.gnu.org ([2001:4830:134:3::10]:37570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVfDw-0005l8-Dv
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVfDs-0008Us-8S
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:03:56 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:5842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVfDr-0008UU-PZ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:03:52 -0500
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Date: Mon, 23 Jan 2017 14:02:33 +0000
Message-ID: <48B294AA6E8CDE42B0CA548318C1256301A3DF5F@lhreml501-mbb>
References: <1485163195-17547-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<20170123104713.2f11dcdc@bahia.lan>
	<2b19c43b-377b-5fea-7546-57381b364992@huawei.com>
	<20170123112749.1b23146c@bahia.lan>
In-Reply-To: <20170123112749.1b23146c@bahia.lan>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH V1] throttle:Removed duplicate throtlle
 code from block and 9p files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



-----Original Message-----
From: Greg Kurz [mailto:groug@kaod.org]=20
Sent: Monday, January 23, 2017 11:28 AM
To: Pradeep Jagadeesh
Cc: Pradeep Jagadeesh; Alberto Garcia; qemu-devel@nongnu.org
Subject: Re: [PATCH V1] throttle:Removed duplicate throtlle code from block=
 and 9p files

On Mon, 23 Jan 2017 10:58:19 +0100
Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> wrote:

> On 1/23/2017 10:47 AM, Greg Kurz wrote:
> > On Mon, 23 Jan 2017 04:19:55 -0500
> > Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:
> > =20
> >> This will allow other subsystems (i.e. fsdev) to implement=20
> >> throttling without duplicating the command line options.
> >>
> >> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> >> ---
> >
> > This patch depends on your other patch "[PATCH V12] fsdev: add IO=20
> > throttle support to fsdev devices", which I haven't reviewed yet=20
> > BTW. Both patches should really be sent in a single series.
> OK
> >
> > Please do the following:
> > - fix the changelog in the other patch
> > - write a cover letter to provide some context on this feature: why is =
it
> >   needed ? why the QMP part has been left aside ? what are the remainin=
g
> >   efforts to make that feature fully implemented and useful ? =20
> This cover letter should be part of the .patch file right?

No. It is a separate mail with some introductory text to describe what the =
series tries to achieve and any other interesting details, such as usage ex=
amples, limitations, remaining work to be done... etc... It is usually refe=
rred to as PATCH 0/N.

See https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg01255.html for=
 a typical example.

[Pradeep Jagadeesh] Ok thanks, for the clarification.
So, now in new e-mail I do not need to send the whole .patch file right?
Just the diff what it has in the beginning.
I am asking this because, so far I used to sent through git send-email.
This is my first patch please bare with my silly questions!:)

> > - post the cover+both patches with a v13 prefix
> For both patches with V13?
>=20

Yes. The version is more a series attribute: V13 introduces a second patch =
to remove duplicate lines and fixes the changelog of the first patch.

[Pradeep Jagadeesh] Ok

-Pradeep

> -Pradeep
>=20
>=20
> >
> > Cheers.
> >
> > --
> > Greg
> > =20
> >>  blockdev.c                      | 80 ++------------------------------=
---
> >>  fsdev/qemu-fsdev-opts.c         | 80 ++------------------------------=
---
> >>  include/qemu/throttle-options.h | 93=20
> >> +++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 101 insertions(+), 152 deletions(-)  create mode=20
> >> 100644 include/qemu/throttle-options.h
> >>
> >> There is some code duplication around the command line options.=20
> >> This patch is a first proposal to reduce the duplication.
> >>
> >> diff --git a/blockdev.c b/blockdev.c index 245e1e1..1da6b7e 100644
> >> --- a/blockdev.c
> >> +++ b/blockdev.c
> >> @@ -52,6 +52,7 @@
> >>  #include "sysemu/arch_init.h"
> >>  #include "qemu/cutils.h"
> >>  #include "qemu/help_option.h"
> >> +#include "qemu/throttle-options.h"
> >>
> >>  static QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =3D
> >>      QTAILQ_HEAD_INITIALIZER(monitor_bdrv_states);
> >> @@ -4000,82 +4001,9 @@ QemuOptsList qemu_common_drive_opts =3D {
> >>              .type =3D QEMU_OPT_BOOL,
> >>              .help =3D "open drive file as read-only",
> >>          },{
> >> -            .name =3D "throttling.iops-total",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "limit total I/O operations per second",
> >> -        },{
> >> -            .name =3D "throttling.iops-read",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "limit read operations per second",
> >> -        },{
> >> -            .name =3D "throttling.iops-write",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "limit write operations per second",
> >> -        },{
> >> -            .name =3D "throttling.bps-total",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "limit total bytes per second",
> >> -        },{
> >> -            .name =3D "throttling.bps-read",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "limit read bytes per second",
> >> -        },{
> >> -            .name =3D "throttling.bps-write",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "limit write bytes per second",
> >> -        },{
> >> -            .name =3D "throttling.iops-total-max",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "I/O operations burst",
> >> -        },{
> >> -            .name =3D "throttling.iops-read-max",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "I/O operations read burst",
> >> -        },{
> >> -            .name =3D "throttling.iops-write-max",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "I/O operations write burst",
> >> -        },{
> >> -            .name =3D "throttling.bps-total-max",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "total bytes burst",
> >> -        },{
> >> -            .name =3D "throttling.bps-read-max",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "total bytes read burst",
> >> -        },{
> >> -            .name =3D "throttling.bps-write-max",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "total bytes write burst",
> >> -        },{
> >> -            .name =3D "throttling.iops-total-max-length",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "length of the iops-total-max burst period, in =
seconds",
> >> -        },{
> >> -            .name =3D "throttling.iops-read-max-length",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "length of the iops-read-max burst period, in s=
econds",
> >> -        },{
> >> -            .name =3D "throttling.iops-write-max-length",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "length of the iops-write-max burst period, in =
seconds",
> >> -        },{
> >> -            .name =3D "throttling.bps-total-max-length",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "length of the bps-total-max burst period, in s=
econds",
> >> -        },{
> >> -            .name =3D "throttling.bps-read-max-length",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "length of the bps-read-max burst period, in se=
conds",
> >> -        },{
> >> -            .name =3D "throttling.bps-write-max-length",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "length of the bps-write-max burst period, in s=
econds",
> >> -        },{
> >> -            .name =3D "throttling.iops-size",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "when limiting by iops max size of an I/O in by=
tes",
> >> -        },{
> >> +        },
> >> +           THROTTLE_OPTS
> >> +        {
> >>              .name =3D "throttling.group",
> >>              .type =3D QEMU_OPT_STRING,
> >>              .help =3D "name of the block throttling group", diff=20
> >> --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c index=20
> >> 385423f0..13597a3 100644
> >> --- a/fsdev/qemu-fsdev-opts.c
> >> +++ b/fsdev/qemu-fsdev-opts.c
> >> @@ -9,6 +9,7 @@
> >>  #include "qemu/config-file.h"
> >>  #include "qemu/option.h"
> >>  #include "qemu/module.h"
> >> +#include "qemu/throttle-options.h"
> >>
> >>  static QemuOptsList qemu_fsdev_opts =3D {
> >>      .name =3D "fsdev",
> >> @@ -37,83 +38,10 @@ static QemuOptsList qemu_fsdev_opts =3D {
> >>          }, {
> >>              .name =3D "sock_fd",
> >>              .type =3D QEMU_OPT_NUMBER,
> >> -        }, {
> >> -            .name =3D "throttling.iops-total",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "limit total I/O operations per second",
> >> -        }, {
> >> -            .name =3D "throttling.iops-read",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "limit read operations per second",
> >> -        }, {
> >> -            .name =3D "throttling.iops-write",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "limit write operations per second",
> >> -        }, {
> >> -            .name =3D "throttling.bps-total",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "limit total bytes per second",
> >> -        }, {
> >> -            .name =3D "throttling.bps-read",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "limit read bytes per second",
> >> -        }, {
> >> -            .name =3D "throttling.bps-write",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "limit write bytes per second",
> >> -        }, {
> >> -            .name =3D "throttling.iops-total-max",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "I/O operations burst",
> >> -        }, {
> >> -            .name =3D "throttling.iops-read-max",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "I/O operations read burst",
> >> -        }, {
> >> -            .name =3D "throttling.iops-write-max",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "I/O operations write burst",
> >> -        }, {
> >> -            .name =3D "throttling.bps-total-max",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "total bytes burst",
> >> -        }, {
> >> -            .name =3D "throttling.bps-read-max",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "total bytes read burst",
> >> -        }, {
> >> -            .name =3D "throttling.bps-write-max",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "total bytes write burst",
> >> -        }, {
> >> -            .name =3D "throttling.iops-total-max-length",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "length of the iops-total-max burst period, in =
seconds",
> >> -        }, {
> >> -            .name =3D "throttling.iops-read-max-length",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "length of the iops-read-max burst period, in s=
econds",
> >> -        }, {
> >> -            .name =3D "throttling.iops-write-max-length",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "length of the iops-write-max burst period, in =
seconds",
> >> -        }, {
> >> -            .name =3D "throttling.bps-total-max-length",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "length of the bps-total-max burst period, in s=
econds",
> >> -        }, {
> >> -            .name =3D "throttling.bps-read-max-length",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "length of the bps-read-max burst period, in se=
conds",
> >> -        }, {
> >> -            .name =3D "throttling.bps-write-max-length",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "length of the bps-write-max burst period, in s=
econds",
> >> -        }, {
> >> -            .name =3D "throttling.iops-size",
> >> -            .type =3D QEMU_OPT_NUMBER,
> >> -            .help =3D "when limiting by iops max size of an I/O in by=
tes",
> >>          },
> >> +
> >> +        THROTTLE_OPTS
> >> +
> >>          { /*End of list */ }
> >>      },
> >>  };
> >> diff --git a/include/qemu/throttle-options.h=20
> >> b/include/qemu/throttle-options.h new file mode 100644 index=20
> >> 0000000..a2fb817
> >> --- /dev/null
> >> +++ b/include/qemu/throttle-options.h
> >> @@ -0,0 +1,93 @@
> >> +/*
> >> + * QEMU throttling command line options
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2=20
> >> +or
> >> + * (at your option) any later version.
> >> + *
> >> + * See the COPYING file in the top-level directory for details.
> >> + *
> >> + */
> >> +
> >> +#ifndef THROTTLE_OPTIONS_H
> >> +#define THROTTLE_OPTIONS_H
> >> +
> >> +#define THROTTLE_OPTS \
> >> +        { \
> >> +            .name =3D "throttling.iops-total",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "limit total I/O operations per second",\
> >> +        },{ \
> >> +            .name =3D "throttling.iops-read",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "limit read operations per second",\
> >> +        },{ \
> >> +            .name =3D "throttling.iops-write",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "limit write operations per second",\
> >> +        },{ \
> >> +            .name =3D "throttling.bps-total",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "limit total bytes per second",\
> >> +        },{ \
> >> +            .name =3D "throttling.bps-read",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "limit read bytes per second",\
> >> +        },{ \
> >> +            .name =3D "throttling.bps-write",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "limit write bytes per second",\
> >> +        },{ \
> >> +            .name =3D "throttling.iops-total-max",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "I/O operations burst",\
> >> +        },{ \
> >> +            .name =3D "throttling.iops-read-max",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "I/O operations read burst",\
> >> +        },{ \
> >> +            .name =3D "throttling.iops-write-max",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "I/O operations write burst",\
> >> +        },{ \
> >> +            .name =3D "throttling.bps-total-max",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "total bytes burst",\
> >> +        },{ \
> >> +            .name =3D "throttling.bps-read-max",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "total bytes read burst",\
> >> +        },{ \
> >> +            .name =3D "throttling.bps-write-max",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "total bytes write burst",\
> >> +        },{ \
> >> +            .name =3D "throttling.iops-total-max-length",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "length of the iops-total-max burst period, in =
seconds",\
> >> +        },{ \
> >> +            .name =3D "throttling.iops-read-max-length",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "length of the iops-read-max burst period, in s=
econds",\
> >> +        },{ \
> >> +            .name =3D "throttling.iops-write-max-length",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "length of the iops-write-max burst period, in =
seconds",\
> >> +        },{ \
> >> +            .name =3D "throttling.bps-total-max-length",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "length of the bps-total-max burst period, in s=
econds",\
> >> +        },{ \
> >> +            .name =3D "throttling.bps-read-max-length",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "length of the bps-read-max burst period, in se=
conds",\
> >> +        },{ \
> >> +            .name =3D "throttling.bps-write-max-length",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "length of the bps-write-max burst period, in s=
econds",\
> >> +        },{ \
> >> +            .name =3D "throttling.iops-size",\
> >> +            .type =3D QEMU_OPT_NUMBER,\
> >> +            .help =3D "when limiting by iops max size of an I/O in by=
tes",\
> >> +        },
> >> +
> >> +#endif
> > =20
>=20
