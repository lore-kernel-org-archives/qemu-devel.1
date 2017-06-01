Received: from eggs.gnu.org ([2001:4830:134:3::10]:57396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGQZR-0005MX-VW
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGQZO-0006Zg-2I
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:55:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGQZN-0006ZW-QG
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:55:22 -0400
Date: Thu, 1 Jun 2017 16:55:12 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170601165446-mutt-send-email-mst@kernel.org>
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
	<20170526142858.19931-4-maxime.coquelin@redhat.com>
	<20170530210905-mutt-send-email-mst@kernel.org>
	<1432592b-f0e2-fbf1-0479-03ba7e584b17@redhat.com>
	<5382c6fc-64e3-8db0-877c-2e9c2facc39f@redhat.com>
	<50c41a96-25dc-180a-11e0-b1207e6f7de9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c41a96-25dc-180a-11e0-b1207e6f7de9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] vhost: extend ring information
 update for IOTLB to all rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com

On Wed, May 31, 2017 at 05:20:21PM +0200, Maxime Coquelin wrote:
> Hi Michael,
> 
> On 05/30/2017 11:11 PM, Maxime Coquelin wrote:
> > 
> > 
> > On 05/30/2017 11:06 PM, Maxime Coquelin wrote:
> > > Hi Michael,
> > > 
> > > On 05/30/2017 08:12 PM, Michael S. Tsirkin wrote:
> > > > On Fri, May 26, 2017 at 04:28:55PM +0200, Maxime Coquelin wrote:
> > > > > Vhost-kernel backend need
> > > > 
> > > > needs
> > > > 
> > > > > to receive IOTLB entry for used ring
> > > > > information early, which is done by triggering a miss event on
> > > > > its address.
> > > > > 
> > > > > This patch extends this behaviour to all rings information, to be
> > > > > compatible with vhost-user backend design.
> > > > 
> > > > Why does vhost-user need it though?
> > > 
> > > For vhost-user, this simplifies the backend design because generally,
> > > the backend sends IOTLB miss requests from processing threads through
> > > the slave channel, and receives resulting IOTLB updates in vhost-user
> > > protocol thread.
> > > 
> > > The only exception is for these rings info, where IOTLB miss requests
> > > are sent from vhost-user protocol thread (in the SET_VRING_ENABLE
> > > request handler), so the resulting IOTLB update is only handled by
> > > the backend when the rings are enabled, which is too late.
> > > 
> > > It could be possible to overcome this issue, but I think it would
> > > make the design more complex or less efficient. I see several options:
> > > 
> > > 1. Change the IOTLB miss request so that the master sends the IOTLB
> > > update as reply, instead of the reply-ack. It would mean that IOTLB
> > > updates/invalidations would be sent either via the master channel or
> > > the slave channel. On QEMU side, it means diverging from kernel backend
> > > implementation. On backend side, it means having possibly multiple
> > > threads writing to the IOTLB cache.
> > > 
> > > 2. In vhost-user protocol thread, when handling SET_VRING_ENABLE, send
> > > IOTLB miss request without setting the reply-ack flag, and poll the
> > > vhost-user socket to read the resulting IOTLB update. The problem is
> > > that other requests could be pending in the socket's buffer, and so it
> > > would end-up nesting multiple requests handling.
> > > 
> > > 3. Don't interpret rings info in the vhost-user protocol thread, but
> > > only in the processing threads. The advantage is that it would address
> > > the remark you made on patch 6 that invalidates are not affecting ring
> > > info. The downside being the overhead induced by checking whether the
> > > ring info are valid every time it is being used. I haven't prototyped
> > > this solution, but I expected the performance regression to be a
> > > blocker.
> > > 
> > > 4. In SET_VRING_ENABLE, don't enable the ring if needed entries are
> > > not in IOTLB cache. Just send the IOTLB misses without reply-ack
> > > flag and postpone enable when handling IOTLB updates. It will be a
> > > little more complex solution than current one, but it may be the
> > > less impacting compared to the other 3 options.
> > > 
> > > 
> > > Thinking again, maybe trying solution would be worth the effort, and
> > 
> > s/solution/solution 4/
> > 
> > > could be extended also to disable the rings when receiving invalidates
> > > that affect rings info.
> > > 
> > > What do you think?
> 
> I have made some tests to see if solution 4 would work, and while it
> could work most of the times, it is really fragile as deadlock would
> happen if either slave or master sockets buffers are full. This is issue
> also impact solution 1 above.
> 
> Regards,
> Maxime

Pls try 3 above. I don't see why would a single conditional
branch be so expensive.
