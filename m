Received: from eggs.gnu.org ([2001:4830:134:3::10]:39120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fj2Bv-0000bO-9O
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fj2Bs-0004Rw-5Y
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:49:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48958 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fj2Bs-0004RN-10
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:49:52 -0400
Date: Fri, 27 Jul 2018 13:49:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180727124946.GF17836@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1531468107-1579-1-git-send-email-felix.yzg@gmail.com>
	<20180727101826.GA28555@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180727101826.GA28555@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 1/1] util/thread-pool: add parameter to
 limit maximum threads in thread pool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: FelixYao <felix.yzg@gmail.com>, kwolf@redhat.com, yaozhenguo@jd.com, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

On Fri, Jul 27, 2018 at 11:18:26AM +0100, Stefan Hajnoczi wrote:
> On Fri, Jul 13, 2018 at 03:48:27PM +0800, FelixYao wrote:
> > Hi all:
> > 
> > Max threads in thread pool is fixed at 64 before which is not
> > propriate in some situations. For public cloud environment,
> > there are lots of VMs in one host machine. We should limit the worker thread
> > numbers for each machine alone based on its ability to prevent impacting
> > each other. Although we can use iotune to limit bandwidth or IOPS of block
> > device. That is not enough. Lots of worker threads still impact other VMs.
> > I think the ability to limit maximum threads in thread pool is necessary.
> > 
> > What's your opinion about this patch? please review it.
> 
> I haven't seen any discussion so here are some thoughts:
> 
> It sounds like you are trying to control I/O resources so that guests do
> not affect each other.  The threads are an implementation detail and not
> the root of the problem.
> 
> For example, if you use -drive aio=native then reads and writes will not
> use the thread pool and you will setting the thread pool size won't
> solve the problem.
> 
> Have you tried QEMU's I/O throttling feature?  You can set bandwidth
> (bps) and IOPS limits, including bursts if you wish to allow temporary
> spikes.  The basic parameters are -drive bps=BYTES_PER_SECOND,iops=IOPS.
> See the QEMU or libvirt documentation for details.

Correct me if I'm wrong, but would using the iothreads feature already
enable us to put a cap on the number of threads used for I/o operations,
but assigning dedicated threads to each device ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
