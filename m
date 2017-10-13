Received: from eggs.gnu.org ([2001:4830:134:3::10]:41307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2w3g-0007gv-Ef
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2w3a-0007LP-J7
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:15:08 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:56392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e2w3a-0007KL-5B
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:15:02 -0400
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5A1A113ECBA
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 11:15:00 +0200 (CEST)
Date: Fri, 13 Oct 2017 11:14:50 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171013111450.0fe07f77@bahia.lan>
In-Reply-To: <20171013104622.2f0b4749.cohuck@redhat.com>
References: <150788370618.25736.8030708425923435364.stgit@bahia>
	<20171013104622.2f0b4749.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, 13 Oct 2017 10:46:22 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 13 Oct 2017 10:35:06 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
> > If a CPU selected with the "cpu" command is hot-unplugged then "info cpus"
> > causes QEMU to exit:
> >     
> > (qemu) device_del cpu1
> > (qemu) info cpus
> > qemu:qemu_cpu_kick_thread: No such process
> > 
> > I could verify that this happens with x86 and ppc, but I guess s390x is
> > also impacted.  
> 
> Not really, as s390x does not support cpu unplug.
> 

I must admit I didn't check. Thanks for telling me. :)

> > 
> > This series tries to fix the issue by using object_ref() and object_unref()
> > in the monitor code. For this to work on ppc, some preliminary work is
> > needed to let QOM handle the CPU object lifecycle.
> > 
> > Please comment.
> > 
> > --
> > Greg
> > 
> > ---
> > 
> > Greg Kurz (2):
> >       spapr_cpu_core: instantiate CPUs separately
> >       monitor: add proper reference counting of the current CPU
> > 
> > 
> >  hw/ppc/spapr.c                  |   10 +++-------
> >  hw/ppc/spapr_cpu_core.c         |   29 +++++++++--------------------
> >  include/hw/ppc/spapr_cpu_core.h |    2 +-
> >  monitor.c                       |   12 ++++++++++++
> >  4 files changed, 25 insertions(+), 28 deletions(-)
> >   
> 
