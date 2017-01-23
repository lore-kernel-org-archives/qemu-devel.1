Received: from eggs.gnu.org ([2001:4830:134:3::10]:45629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cVbr0-00014q-RB
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cVbqv-0005WE-P1
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:28:02 -0500
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:41380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cVbqv-0005V5-FF
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:27:57 -0500
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 588D31122E
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:27:54 +0100 (CET)
Date: Mon, 23 Jan 2017 11:27:49 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170123112749.1b23146c@bahia.lan>
In-Reply-To: <2b19c43b-377b-5fea-7546-57381b364992@huawei.com>
References: <1485163195-17547-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<20170123104713.2f11dcdc@bahia.lan>
	<2b19c43b-377b-5fea-7546-57381b364992@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

On Mon, 23 Jan 2017 10:58:19 +0100
Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> wrote:

> On 1/23/2017 10:47 AM, Greg Kurz wrote:
> > On Mon, 23 Jan 2017 04:19:55 -0500
> > Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:
> >  
> >> This will allow other subsystems (i.e. fsdev) to implement throttling
> >> without duplicating the command line options.
> >>
> >> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> >> ---  
> >
> > This patch depends on your other patch "[PATCH V12] fsdev: add IO throttle
> > support to fsdev devices", which I haven't reviewed yet BTW. Both patches
> > should really be sent in a single series.  
> OK
> >
> > Please do the following:
> > - fix the changelog in the other patch
> > - write a cover letter to provide some context on this feature: why is it
> >   needed ? why the QMP part has been left aside ? what are the remaining
> >   efforts to make that feature fully implemented and useful ?  
> This cover letter should be part of the .patch file right?

No. It is a separate mail with some introductory text to describe what
the series tries to achieve and any other interesting details, such as
usage examples, limitations, remaining work to be done... etc... It is
usually referred to as PATCH 0/N.

See https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg01255.html for
a typical example.

> > - post the cover+both patches with a v13 prefix  
> For both patches with V13?
> 

Yes. The version is more a series attribute: V13 introduces a second
patch to remove duplicate lines and fixes the changelog of the first
patch.

> -Pradeep
> 
> 
> >
> > Cheers.
> >
> > --
> > Greg
> >  
> >>  blockdev.c                      | 80 ++---------------------------------
> >>  fsdev/qemu-fsdev-opts.c         | 80 ++---------------------------------
> >>  include/qemu/throttle-options.h | 93 +++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 101 insertions(+), 152 deletions(-)
> >>  create mode 100644 include/qemu/throttle-options.h
> >>
> >> There is some code duplication around the command line options. This patch
> >> is a first proposal to reduce the duplication.
> >>
> >> diff --git a/blockdev.c b/blockdev.c
> >> index 245e1e1..1da6b7e 100644
> >> --- a/blockdev.c
> >> +++ b/blockdev.c
> >> @@ -52,6 +52,7 @@
> >>  #include "sysemu/arch_init.h"
> >>  #include "qemu/cutils.h"
> >>  #include "qemu/help_option.h"
> >> +#include "qemu/throttle-options.h"
> >>
> >>  static QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =
> >>      QTAILQ_HEAD_INITIALIZER(monitor_bdrv_states);
> >> @@ -4000,82 +4001,9 @@ QemuOptsList qemu_common_drive_opts = {
> >>              .type = QEMU_OPT_BOOL,
> >>              .help = "open drive file as read-only",
> >>          },{
> >> -            .name = "throttling.iops-total",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "limit total I/O operations per second",
> >> -        },{
> >> -            .name = "throttling.iops-read",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "limit read operations per second",
> >> -        },{
> >> -            .name = "throttling.iops-write",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "limit write operations per second",
> >> -        },{
> >> -            .name = "throttling.bps-total",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "limit total bytes per second",
> >> -        },{
> >> -            .name = "throttling.bps-read",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "limit read bytes per second",
> >> -        },{
> >> -            .name = "throttling.bps-write",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "limit write bytes per second",
> >> -        },{
> >> -            .name = "throttling.iops-total-max",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "I/O operations burst",
> >> -        },{
> >> -            .name = "throttling.iops-read-max",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "I/O operations read burst",
> >> -        },{
> >> -            .name = "throttling.iops-write-max",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "I/O operations write burst",
> >> -        },{
> >> -            .name = "throttling.bps-total-max",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "total bytes burst",
> >> -        },{
> >> -            .name = "throttling.bps-read-max",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "total bytes read burst",
> >> -        },{
> >> -            .name = "throttling.bps-write-max",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "total bytes write burst",
> >> -        },{
> >> -            .name = "throttling.iops-total-max-length",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "length of the iops-total-max burst period, in seconds",
> >> -        },{
> >> -            .name = "throttling.iops-read-max-length",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "length of the iops-read-max burst period, in seconds",
> >> -        },{
> >> -            .name = "throttling.iops-write-max-length",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "length of the iops-write-max burst period, in seconds",
> >> -        },{
> >> -            .name = "throttling.bps-total-max-length",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "length of the bps-total-max burst period, in seconds",
> >> -        },{
> >> -            .name = "throttling.bps-read-max-length",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "length of the bps-read-max burst period, in seconds",
> >> -        },{
> >> -            .name = "throttling.bps-write-max-length",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "length of the bps-write-max burst period, in seconds",
> >> -        },{
> >> -            .name = "throttling.iops-size",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "when limiting by iops max size of an I/O in bytes",
> >> -        },{
> >> +        },
> >> +           THROTTLE_OPTS
> >> +        {
> >>              .name = "throttling.group",
> >>              .type = QEMU_OPT_STRING,
> >>              .help = "name of the block throttling group",
> >> diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
> >> index 385423f0..13597a3 100644
> >> --- a/fsdev/qemu-fsdev-opts.c
> >> +++ b/fsdev/qemu-fsdev-opts.c
> >> @@ -9,6 +9,7 @@
> >>  #include "qemu/config-file.h"
> >>  #include "qemu/option.h"
> >>  #include "qemu/module.h"
> >> +#include "qemu/throttle-options.h"
> >>
> >>  static QemuOptsList qemu_fsdev_opts = {
> >>      .name = "fsdev",
> >> @@ -37,83 +38,10 @@ static QemuOptsList qemu_fsdev_opts = {
> >>          }, {
> >>              .name = "sock_fd",
> >>              .type = QEMU_OPT_NUMBER,
> >> -        }, {
> >> -            .name = "throttling.iops-total",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "limit total I/O operations per second",
> >> -        }, {
> >> -            .name = "throttling.iops-read",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "limit read operations per second",
> >> -        }, {
> >> -            .name = "throttling.iops-write",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "limit write operations per second",
> >> -        }, {
> >> -            .name = "throttling.bps-total",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "limit total bytes per second",
> >> -        }, {
> >> -            .name = "throttling.bps-read",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "limit read bytes per second",
> >> -        }, {
> >> -            .name = "throttling.bps-write",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "limit write bytes per second",
> >> -        }, {
> >> -            .name = "throttling.iops-total-max",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "I/O operations burst",
> >> -        }, {
> >> -            .name = "throttling.iops-read-max",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "I/O operations read burst",
> >> -        }, {
> >> -            .name = "throttling.iops-write-max",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "I/O operations write burst",
> >> -        }, {
> >> -            .name = "throttling.bps-total-max",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "total bytes burst",
> >> -        }, {
> >> -            .name = "throttling.bps-read-max",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "total bytes read burst",
> >> -        }, {
> >> -            .name = "throttling.bps-write-max",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "total bytes write burst",
> >> -        }, {
> >> -            .name = "throttling.iops-total-max-length",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "length of the iops-total-max burst period, in seconds",
> >> -        }, {
> >> -            .name = "throttling.iops-read-max-length",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "length of the iops-read-max burst period, in seconds",
> >> -        }, {
> >> -            .name = "throttling.iops-write-max-length",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "length of the iops-write-max burst period, in seconds",
> >> -        }, {
> >> -            .name = "throttling.bps-total-max-length",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "length of the bps-total-max burst period, in seconds",
> >> -        }, {
> >> -            .name = "throttling.bps-read-max-length",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "length of the bps-read-max burst period, in seconds",
> >> -        }, {
> >> -            .name = "throttling.bps-write-max-length",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "length of the bps-write-max burst period, in seconds",
> >> -        }, {
> >> -            .name = "throttling.iops-size",
> >> -            .type = QEMU_OPT_NUMBER,
> >> -            .help = "when limiting by iops max size of an I/O in bytes",
> >>          },
> >> +
> >> +        THROTTLE_OPTS
> >> +
> >>          { /*End of list */ }
> >>      },
> >>  };
> >> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
> >> new file mode 100644
> >> index 0000000..a2fb817
> >> --- /dev/null
> >> +++ b/include/qemu/throttle-options.h
> >> @@ -0,0 +1,93 @@
> >> +/*
> >> + * QEMU throttling command line options
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2 or
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
> >> +            .name = "throttling.iops-total",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "limit total I/O operations per second",\
> >> +        },{ \
> >> +            .name = "throttling.iops-read",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "limit read operations per second",\
> >> +        },{ \
> >> +            .name = "throttling.iops-write",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "limit write operations per second",\
> >> +        },{ \
> >> +            .name = "throttling.bps-total",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "limit total bytes per second",\
> >> +        },{ \
> >> +            .name = "throttling.bps-read",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "limit read bytes per second",\
> >> +        },{ \
> >> +            .name = "throttling.bps-write",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "limit write bytes per second",\
> >> +        },{ \
> >> +            .name = "throttling.iops-total-max",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "I/O operations burst",\
> >> +        },{ \
> >> +            .name = "throttling.iops-read-max",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "I/O operations read burst",\
> >> +        },{ \
> >> +            .name = "throttling.iops-write-max",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "I/O operations write burst",\
> >> +        },{ \
> >> +            .name = "throttling.bps-total-max",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "total bytes burst",\
> >> +        },{ \
> >> +            .name = "throttling.bps-read-max",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "total bytes read burst",\
> >> +        },{ \
> >> +            .name = "throttling.bps-write-max",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "total bytes write burst",\
> >> +        },{ \
> >> +            .name = "throttling.iops-total-max-length",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "length of the iops-total-max burst period, in seconds",\
> >> +        },{ \
> >> +            .name = "throttling.iops-read-max-length",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "length of the iops-read-max burst period, in seconds",\
> >> +        },{ \
> >> +            .name = "throttling.iops-write-max-length",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "length of the iops-write-max burst period, in seconds",\
> >> +        },{ \
> >> +            .name = "throttling.bps-total-max-length",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "length of the bps-total-max burst period, in seconds",\
> >> +        },{ \
> >> +            .name = "throttling.bps-read-max-length",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "length of the bps-read-max burst period, in seconds",\
> >> +        },{ \
> >> +            .name = "throttling.bps-write-max-length",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "length of the bps-write-max burst period, in seconds",\
> >> +        },{ \
> >> +            .name = "throttling.iops-size",\
> >> +            .type = QEMU_OPT_NUMBER,\
> >> +            .help = "when limiting by iops max size of an I/O in bytes",\
> >> +        },
> >> +
> >> +#endif  
> >  
> 
