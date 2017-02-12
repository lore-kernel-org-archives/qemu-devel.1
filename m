Received: from eggs.gnu.org ([2001:4830:134:3::10]:56619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renzo@cs.unibo.it>) id 1ccocK-0008GK-9Z
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 02:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <renzo@cs.unibo.it>) id 1ccocF-0003MG-Dg
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 02:30:40 -0500
Received: from mail.virtlab.unibo.it ([130.136.161.50]:53263)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renzo@cs.unibo.it>) id 1ccocF-0003Jc-6A
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 02:30:35 -0500
Date: Sun, 12 Feb 2017 08:30:19 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
Message-ID: <20170212073019.GA25566@cs.unibo.it>
References: <CAJSP0QWT14J-cqwLqPCr0iC95pSLaiZJgPkqr1VBU=pqYF6kqQ@mail.gmail.com>
	<20170208221050.GP2955@var.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170208221050.GP2955@var.home>
Subject: Re: [Qemu-devel] libslirp and QEMU slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, virtualsquare@cs.unibo.it, thuth@redhat.com, jasowang@redhat.com, Jan Kiszka <jan.kiszka@web.de>, peter.maydell@linaro.org, qemu-devel <qemu-devel@nongnu.org>

Hi,

On Wed, Feb 08, 2017 at 11:10:50PM +0100, Samuel Thibault wrote:
> Hello,
> 
> Stefan Hajnoczi, on Mon 06 Feb 2017 11:55:05 +0000, wrote:
> > I'm proposing this topic for discussion because there might be common
> > ground for Samuel from QEMU and the VDE folks to collaborate.
> > 
> > Samuel: Should QEMU join forces with libslirp?
> 
> Well, there are not that many forces from the QEMU side :)
Neither on VDE side ;-) but many ants can move mountains...
> 
> - we are using timers for icmp announcements
> - qemu needs to be able to save/restore state, with compatibility with
> previous versions

libslirp is using qemu's slirp code. 
If you try a diff between your "slirp" directory and libslirp's "src" directory
you'll find that there are only 3 lines added:
(at the date of the code extraction, e.g. qemu git's tag 1f8b56e7cebc71d80aec27a4760024b56acc957a)

In slirp.h:
#include <qemu2libslirp.h>

Which includes stubs and specific implementations to give slirp all the stuff
provided by qemu's core or other libraries used by qemu.

In tcp_subr.c:
400a401,403
>       if ((ret = unixtcp_fconnect(so, af)) >= 0)
>               return ret;

which adds a nice feature that IMHO would be useful in qemu, too.
unixtcp_fconnect creates a TCP to AF_UNIX socket redirection.
The VM running on qemu (or in VDE a VM connected to the virtual net)
can redirect a default route port (say 10.0.2.2:6000) to a UNIX socket
(say /tmp/.X11-unix/0). In this example X clients using the X display 10.0.2.2:0 
can appear on the X server of the host.

Timers have been reimplemented using the qemu's API.
save/restore are dummy stubs in libslirp. Qemu's code is still there but it is not used
by libslirp.

In this way we can inherit all bugfixes and new feature from Qemu at almost no cost.

It would be a nice project to create a common codebase for libslirp.
The project sould be interesting for other VM projects (virtualbox-OSE?) and
maybe many others. We could collect several ants...

Libslirp/QEMU integration is not so difficult.
As a first step:
* Qemu could add the UNIX socket redirect feature, or at least a unixtcp_fconnect dummy function
returning -1 (#ifndef LIBSLIRP)
* #include <qemu2libslirp.h>
could be added in slirp.h (inside an #ifdef LIBSLIRP).
In this way we could share exactly the same codebase.

One further step:
* discuss how to reduce/eliminate qemu-specific dependence
* create an API for save/restore

These are only my two (euro)cents.

ciao
	renzo
