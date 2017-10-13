Received: from eggs.gnu.org ([2001:4830:134:3::10]:32917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2vc1-0001QZ-B4
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2vbw-00018q-Fn
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:46:33 -0400
Date: Fri, 13 Oct 2017 10:46:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171013104622.2f0b4749.cohuck@redhat.com>
In-Reply-To: <150788370618.25736.8030708425923435364.stgit@bahia>
References: <150788370618.25736.8030708425923435364.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] monitor: increase the refcount of the
 current CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, 13 Oct 2017 10:35:06 +0200
Greg Kurz <groug@kaod.org> wrote:

> If a CPU selected with the "cpu" command is hot-unplugged then "info cpus"
> causes QEMU to exit:
>     
> (qemu) device_del cpu1
> (qemu) info cpus
> qemu:qemu_cpu_kick_thread: No such process
> 
> I could verify that this happens with x86 and ppc, but I guess s390x is
> also impacted.

Not really, as s390x does not support cpu unplug.

> 
> This series tries to fix the issue by using object_ref() and object_unref()
> in the monitor code. For this to work on ppc, some preliminary work is
> needed to let QOM handle the CPU object lifecycle.
> 
> Please comment.
> 
> --
> Greg
> 
> ---
> 
> Greg Kurz (2):
>       spapr_cpu_core: instantiate CPUs separately
>       monitor: add proper reference counting of the current CPU
> 
> 
>  hw/ppc/spapr.c                  |   10 +++-------
>  hw/ppc/spapr_cpu_core.c         |   29 +++++++++--------------------
>  include/hw/ppc/spapr_cpu_core.h |    2 +-
>  monitor.c                       |   12 ++++++++++++
>  4 files changed, 25 insertions(+), 28 deletions(-)
> 
