Received: from eggs.gnu.org ([209.51.188.92]:43151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1h1oGm-0003Jd-JC
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1h1oGl-0004Mw-JU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:20:48 -0500
Date: Thu, 7 Mar 2019 16:20:18 +0800
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Message-ID: <20190307082018.GA26350@byw>
Reply-To: baiyaowei@cmss.chinamobile.com
References: <1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20190306215633.GM6818@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306215633.GM6818@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Amar Tumballi <atumball@redhat.com>, Mike Christie <mchristi@redhat.com>, Prasanna Kalever <pkalever@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiubo Li <xiubli@redhat.com>, Fam Zheng <fam@euphoh.net>, stefanha <stefanha@redhat.com>

On Wed, Mar 06, 2019 at 10:56:33PM +0100, Kevin Wolf wrote:
> Am 21.12.2018 um 11:16 hat Yaowei Bai geschrieben:
> > This patch introduces a new utility, qemu-tcmu. Apart from the
> > underlaying protocol it interacts with the world much like
> > qemu-nbd. This patch bases on Fam's version.
> > 
> > Qemu-tcmu handles SCSI commands which are passed through userspace
> > from kernel by LIO subsystem using TCMU protocol. Libtcmu is the
> > library for processing TCMU protocol in userspace. With qemu-tcmu,
> > we can export images/formats like qcow2, rbd, etc. that qemu supports
> > using iSCSI protocol or loopback for remote or local access.
> > 
> > Currently qemu-tcmu implements several SCSI command helper functions
> > to work. Our goal is to refactor and reuse SCSI code in scsi-disk.
> > 
> > Please refer to docs/tcmu.txt to use qemu-tcmu. We test it on CentOS
> > 7.3.(Please use 3.10.0-514 or lower version kernel, there's one issuse
> > in higher kernel version we're resolving.)
> > 
> > Cc: Mike Christie <mchristi@redhat.com>
> > Cc: Amar Tumballi<atumball@redhat.com>
> > Cc: Prasanna Kalever <pkalever@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> > Signed-off-by: Xiubo Li <xiubli@redhat.com>
> 
> Sorry, with the email backlog after the Christmas break, this patch went
> completely unnoticed on my side.
> 
> I'm not going to review the code in detail yet, because I think there
> are a few very high level points that need to be addressed first:
> 
> * Patchew replied with a ton of coding style problems. This patch isn't
>   mergable without these problems fixed.

These problems've been fixed in the V2 and it'll be sent out soon.
Thanks.

> 
> * The first priority should be adding an in-process iscsi target that
>   can be managed with QMP, similar to the built-in NBD server.

Well, people used to manage iscsi targets through targetcli, a command
line utility. Our intention is, with targetcli and qemu-tcmu, user can
create/remove targets and backstores totally in just one place, so you
don't need to create targets in targetcli and then turn to configure
backstores in qemu-tcmu with QMP or command line, it's convenient. So
we decide to implement QMP in the future release but it's definitely
in our plan.

> 
> * The standalone tool should configure its block backend using -blockdev
>   based code paths instead of duplicating legacy -drive code, which
>   cannot provide advanced functionality.

OK, will turn into -blockdev based code paths. Thanks.

> 
> * Even worse, you can't get the configuration from the iscsi initiator.
>   This would be a security nightmare. Instead, the user needs to
>   configure named exports either in QMP or on the command line for the
>   tool and the initiator then connects to an export name.

So you mean we should configure exports through iscsi initiator? Sorry i
don't understand the problems here, could you please explain more?

> 
> * It should be considered if we can have a single standalone tool for
>   all export mechanisms (NBD, TCMU, vhost-user, fuse, and whatever new
>   ideas we will have in the future) that could have advanced
>   functionality like a QMP monitor instead of adding a minimal
>   specialised tool for each of them.

That's a great and exciting idea so we don't need one qemu-nbd, one
qemu-tcmu, or more qemu-xxx at the same time, there's just one standalone
tool to use, maybe we can even instead add a new 'export' subcommand to
qemu-img for this purpose.

> 
> Kevin
