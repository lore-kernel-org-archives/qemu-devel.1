Received: from eggs.gnu.org ([2001:4830:134:3::10]:54262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dcRXY-0004RA-3y
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dcRXU-0001OB-TT
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:24:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dcRXU-0001NV-Nu
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:24:24 -0400
Date: Tue, 1 Aug 2017 09:24:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170801092420.5217bd85@gondolin>
In-Reply-To: <20170801022910.GF12259@bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-4-bjsdjshi@linux.vnet.ibm.com>
	<20170727135910.27d9e42e@gondolin>
	<20170731035137.GB21572@bjsdjshi@linux.vnet.ibm.com>
	<20170731131302.5bb2198c@gondolin>
	<20170801022910.GF12259@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x/css: generate channel path
 initialized CRW for channel path hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, rth@twiddle.net

On Tue, 1 Aug 2017 10:29:10 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2017-07-31 13:13:02 +0200]:
> 
> > On Mon, 31 Jul 2017 11:51:37 +0800
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> > > When defining a vfio-ccw device, since the real subchannel implicitly
> > > indicates the chps it bound to, we grasp the CHPIDs from sysfs (or, with
> > > my current work, we could even retrieve these information from a new
> > > added MMIO region). In this case, defining some channel path devices
> > > separately does not make sense to me.  
> > 
> > We might want to pass only a subset of the channel paths to guest. This
> > can only work if we can define individual chp objects.  
> Why would we want this?

For example, if you know that a reconfiguration is coming on soon, you
can just exclude the paths that will go away anyway and the guest will
never know about them. Or for preferred pathing, although that one
fortunately seems to have died out.

Not very strong reasons to spend time on this, though.

> 
> We can add, for example, a "chpids" parameter for the "vfio-ccw" device
> to limit its chpids to a subset that we want it to have? E.g.:
> 
> For this mdev:
> MDEV                                  Subchan.  PIM PAM POM  CHPIDs
> ------------------------------------------------------------------------------
> 6dfd3ec5-e8b3-4e18-a6fe-57bc9eceb920  0.0.013f  f0  f0  ff   42434445 00000000
> 
> We could use this command line:
> -device vfio-ccw,sysfsdev=$MDEV_CCW013f,devno=0.0.1234,chpids=4245000000000000
>                                                               ^^^^

Yes, that would work, should we want that. We can probably do without for now.
