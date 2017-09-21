Received: from eggs.gnu.org ([2001:4830:134:3::10]:51290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dv413-0005uJ-98
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dv410-00014R-Hm
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:07:53 -0400
Date: Thu, 21 Sep 2017 17:07:47 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170921160747.GI32364@stefanha-x1.localdomain>
References: <20170919102434.21147-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170919102434.21147-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/4] scsi,
 block: introduce persistent reservation managers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, Sep 19, 2017 at 12:24:30PM +0200, Paolo Bonzini wrote:
> SCSI persistent Reservations allow restricting access to block devices
> to specific initiators in a shared storage setup.  When implementing
> clustering of virtual machines, it is a common requirement for virtual
> machines to send persistent reservation SCSI commands.  However,
> the operating system restricts sending these commands to unprivileged
> programs because incorrect usage can disrupt regular operation of the
> storage fabric.
> 
> With these patches, the scsi-block and scsi-generic SCSI passthrough
> devices learn to delegate the implementation of persistent reservations to
> a separate object, the "persistent reservation manager".  The persistent
> reservation manager talks to a separate privileged program, with a very
> simple protocol based on SCM_RIGHTS.  In addition to invoking PERSISTENT
> RESERVATION OUT and PERSISTENT RESERVATION IN commands, the privileged
> component can also use libmpathpersist so that persistent reservations
> are applied to all paths in a multipath setting.
> 
> Patch 1 defines the abstract QOM class and plugs it into block/file-posix.c.
> 
> Patch 2 and 3 introduce the privileged helper program, while patch 4
> defines the concrete QOM class that talks to it.
> 
> Paolo
> 
> v1->v2: removed scsi/ patches which were all reviewed
>         removed man page (requires .texi while I used .rst for docs)
>         qio_channel_read/write_all also went in independently
>         fix installation of qemu-pr-helper man page
>         fixes to documentation
>         added BSD license to protocol header
>         added handling of residual (buffer underrun)
>         fixed closing of file descriptors on error
>         block PERSISTENT RESERVE OUT for read-only file descriptors
>         do not use g_assert
>         use EXIT_SUCCESS/EXIT_FAILURE consistently
>         moved all CONFIG_MPATH usage to the right patch
>         drop CAP_SYS_ADMIN if multipath not compiled in
>         simplify buffer size handling in multipath PERSISTENT RESERVE IN
>         block REGISTER AND MOVE operation for multipath PERSISTENT RESERVE OUT
>         fixed transport id handling in multipath PERSISTENT RESERVE OUT
>         fixed string property double-free in pr-manager-helper
>         fixed/cleaned up error handling in pr-manager-helper
>         
> Paolo Bonzini (9):
>   scsi, file-posix: add support for persistent reservation management
>   scsi: build qemu-pr-helper
>   scsi: add multipath support to qemu-pr-helper
>   scsi: add persistent reservation manager using qemu-pr-helper
> 
>  Makefile                   |   14 +-
>  configure                  |   59 ++-
>  docs/interop/pr-helper.rst |   83 ++++
>  docs/pr-manager.rst        |   60 +++
>  include/scsi/utils.h       |    4 +
>  scsi/Makefile.objs         |    2 +-
>  scsi/pr-helper.h           |   41 ++
>  scsi/pr-manager-helper.c   |  302 +++++++++++++
>  scsi/qemu-pr-helper.c      | 1038 ++++++++++++++++++++++++++++++++++++++++++++
>  scsi/utils.c               |   10 +
>  10 files changed, 1607 insertions(+), 6 deletions(-)
> 
> -- 
> 2.13.5
> 
> 

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
