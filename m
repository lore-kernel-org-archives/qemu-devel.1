Received: from eggs.gnu.org ([209.51.188.92]:60013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1r9O-0001AA-Ai
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:25:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1r9M-0005t5-A6
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:25:22 -0500
Date: Thu, 7 Mar 2019 12:25:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190307112505.GB5786@linux.fritz.box>
References: <1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20190306215633.GM6818@localhost.localdomain>
	<20190307084405.GB26350@byw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307084405.GB26350@byw>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tcmu: Introduce qemu-tcmu
 utility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Amar Tumballi <atumball@redhat.com>, Mike Christie <mchristi@redhat.com>, Prasanna Kalever <pkalever@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiubo Li <xiubli@redhat.com>, Fam Zheng <fam@euphon.net>, stefanha <stefanha@redhat.com>

Am 07.03.2019 um 09:44 hat Yaowei Bai geschrieben:
> Add Fam.
> 
> On Wed, Mar 06, 2019 at 10:56:33PM +0100, Kevin Wolf wrote:
> > Am 21.12.2018 um 11:16 hat Yaowei Bai geschrieben:
> > > This patch introduces a new utility, qemu-tcmu. Apart from the
> > > underlaying protocol it interacts with the world much like
> > > qemu-nbd. This patch bases on Fam's version.
> > > 
> > > Qemu-tcmu handles SCSI commands which are passed through userspace
> > > from kernel by LIO subsystem using TCMU protocol. Libtcmu is the
> > > library for processing TCMU protocol in userspace. With qemu-tcmu,
> > > we can export images/formats like qcow2, rbd, etc. that qemu supports
> > > using iSCSI protocol or loopback for remote or local access.
> > > 
> > > Currently qemu-tcmu implements several SCSI command helper functions
> > > to work. Our goal is to refactor and reuse SCSI code in scsi-disk.
> > > 
> > > Please refer to docs/tcmu.txt to use qemu-tcmu. We test it on CentOS
> > > 7.3.(Please use 3.10.0-514 or lower version kernel, there's one issuse
> > > in higher kernel version we're resolving.)
> > > 
> > > Cc: Mike Christie <mchristi@redhat.com>
> > > Cc: Amar Tumballi<atumball@redhat.com>
> > > Cc: Prasanna Kalever <pkalever@redhat.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> > > Signed-off-by: Xiubo Li <xiubli@redhat.com>
> > 
> > Sorry, with the email backlog after the Christmas break, this patch went
> > completely unnoticed on my side.
> > 
> > I'm not going to review the code in detail yet, because I think there
> > are a few very high level points that need to be addressed first:
> > 
> > * Patchew replied with a ton of coding style problems. This patch isn't
> >   mergable without these problems fixed.
> 
> These problems've been fixed in the V2 and it'll be sent out soon.
> Thanks.

Ok.

> > * The first priority should be adding an in-process iscsi target that
> >   can be managed with QMP, similar to the built-in NBD server.
> 
> Well, people used to manage iscsi targets through targetcli, a command
> line utility. Our intention is, with targetcli and qemu-tcmu, user can
> create/remove targets and backstores totally in just one place, so you
> don't need to create targets in targetcli and then turn to configure
> backstores in qemu-tcmu with QMP or command line, it's convenient.  So
> we decide to implement QMP in the future release but it's definitely
> in our plan.

I think QMP needs to come first to result in a clean design, because the
command line tool should only be a wrapper around the QMP code.

> > * The standalone tool should configure its block backend using -blockdev
> >   based code paths instead of duplicating legacy -drive code, which
> >   cannot provide advanced functionality.
> 
> OK, will turn into -blockdev based code paths. Thanks.
> 
> > 
> > * Even worse, you can't get the configuration from the iscsi initiator.
> >   This would be a security nightmare. Instead, the user needs to
> >   configure named exports either in QMP or on the command line for the
> >   tool and the initiator then connects to an export name.
> 
> So you mean we should configure exports through iscsi initiator? Sorry i
> don't understand the problems here, could you please explain more?

Sorry, I misunderstood. I thought cfgstr comes from the initiator, but
it really comes from the kernel target.

But anyway, I still think the change I had in mind is necessary. Maybe
you can see the difference best in an example. Your documentation says
to use this:

    # qemu-tcmu
    # targetcli /backstores/user:qemu create qemulun 1G @id=test@file=/root/test.file

I think it should work more like this:

    # qemu-tcmu -blockdev driver=file,filename=/root/test.file,node-name=my_file \
                -export my_export,node=my_file
    # targetcli /backstores/user:qemu create qemulun 1G my_export

In fact, something like this is probably required if we want to export
existing block nodes (that may be in use by a guest) from a running QEMU
instance. In this case, you don't want to open a new image file, but
export the already opened image file.

(Also, can we somehow get rid of the 1G in the command line? qemu-tcmu
knows how big the image is and can provide this value.)

> > * It should be considered if we can have a single standalone tool for
> >   all export mechanisms (NBD, TCMU, vhost-user, fuse, and whatever new
> >   ideas we will have in the future) that could have advanced
> >   functionality like a QMP monitor instead of adding a minimal
> >   specialised tool for each of them.
> 
> That's a great and exciting idea so we don't need one qemu-nbd, one
> qemu-tcmu, or more qemu-xxx at the same time, there's just one standalone
> tool to use, maybe we can even instead add a new 'export' subcommand to
> qemu-img for this purpose.

I wouldn't use qemu-img because it's a long-running daemon rather than
short specific operations as in other qemu-img subcommans. I think I'd
rather have a new binary qemu-blockd or something.

But these are details that we can decide when we have the functionality
available from QMP.

Kevin
