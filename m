Received: from eggs.gnu.org ([2001:4830:134:3::10]:38438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dv0EH-0000gE-J2
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dv0EB-0007Uq-IO
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:05:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dv0EB-0007UF-BJ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:05:11 -0400
Date: Thu, 21 Sep 2017 14:05:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170921140506.42c5f7f6.cohuck@redhat.com>
In-Reply-To: <efa7f105-78c4-1ec0-dcf5-9b97678cd7e5@linux.vnet.ibm.com>
References: <20170920172314.102710-1-pasic@linux.vnet.ibm.com>
	<20170920172314.102710-2-pasic@linux.vnet.ibm.com>
	<20170921111552.41167e80.cohuck@redhat.com>
	<efa7f105-78c4-1ec0-dcf5-9b97678cd7e5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/3270: IDA support for 3270 via
 CcwDataStream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On Thu, 21 Sep 2017 13:22:44 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/21/2017 11:15 AM, Cornelia Huck wrote:
> >> +static inline CcwDataStream *get_cds(Terminal3270 *t)
> >> +{
> >> +    return &(CCW_DEVICE(&t->cdev)->sch->cds);
> >> +}
> >> +
> >> +static int read_payload_3270(EmulatedCcw3270Device *dev)
> >>  {
> >>      Terminal3270 *t = TERMINAL_3270(dev);
> >>      int len;
> >>  
> >> -    len = MIN(count, t->in_len);
> >> -    cpu_physical_memory_write(cda, t->inv, len);
> >> +    len = MIN(ccw_dstream_avail(get_cds(t)), t->in_len);
> >> +    ccw_dstream_write_buf(get_cds(t), t->inv, len);  
> > CCW_DEVICE() as called by get_cds() goes through qom, which implies a
> > bit of overhead. Not sure if it makes sense to cache it in this
> > function so you don't go through it multiple times. (Dito for the other
> > callback.)
> >   
> 
> I've cargo-culted this way of getting CCW_DEVICE(&t->cdev) to the CcwDevice
> form terminal_read (the pattern used at multiple places in the file). As
> far as I can tell, the overhead basically depends on CONFIG_QOM_CAST_DEBUG.
> 
> I have no idea what do we have in production, but my guess is, that
> ONFIG_QOM_CAST_DEBUG makes only sense for development and testing
> (especially if proper test coverage is assumed).
> Can you enlighten me?
> 
> CCW_DEVICE() may contain a run-time check (depending on CONFIG_QOM_CAST_DEBUG),
> we however can make sure things are OK at compile time. This brings
> me to the next question. Does it even make sense to use OBJECT_CHECK based
> constructs when going from specific to general (we don't actually need a
> cast here)? Obviously, for the other direction we really need a cast, so doing
> a run-time check there does indeed provide added value.

The basic rule seems to be "use a qom cast, unless you are on a fast
path" - even though qom debug makes the most sense while developing.

But let's not turn that into a big discussion: It's probably not really
worth optimizing here.
