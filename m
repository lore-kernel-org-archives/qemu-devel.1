Received: from eggs.gnu.org ([2001:4830:134:3::10]:58599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkaplans@redhat.com>) id 1eJmuU-0006Nr-SK
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkaplans@redhat.com>) id 1eJmuP-0000Zk-TN
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:55:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkaplans@redhat.com>) id 1eJmuP-0000ZF-Ky
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:55:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 830BC5F7AC
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 20:55:12 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 778D95FCA0
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 20:55:12 +0000 (UTC)
Date: Tue, 28 Nov 2017 15:55:12 -0500 (EST)
From: Victor Kaplansky <vkaplans@redhat.com>
Message-ID: <2120179840.47198762.1511902512131.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171128204444-mutt-send-email-mst@kernel.org>
References: <20171128133123.17372-1-vkaplans@redhat.com>
	<20171128195847-mutt-send-email-mst@kernel.org>
	<1297312453.47152666.1511894059661.JavaMail.zimbra@redhat.com>
	<20171128204444-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost-user spec: Clarify policy on setting
 log_base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>

> From: "Michael S. Tsirkin" <mst@redhat.com>
> To: "Victor Kaplansky" <vkaplans@redhat.com>
> Cc: qemu-devel@nongnu.org, "Maxime Coquelin" <maxime.coquelin@redhat.com>, "Jason Wang" <jasowang@redhat.com>
> Sent: Tuesday, November 28, 2017 8:45:43 PM
> Subject: Re: [PATCH] vhost-user spec: Clarify policy on setting log_base
> 
> On Tue, Nov 28, 2017 at 01:34:19PM -0500, Victor Kaplansky wrote:
> > > From: "Michael S. Tsirkin" <mst@redhat.com>
> > > To: "Victor Kaplansky" <vkaplans@redhat.com>
> > > Cc: qemu-devel@nongnu.org, "Maxime Coquelin"
> > > <maxime.coquelin@redhat.com>, "Jason Wang" <jasowang@redhat.com>
> > > Sent: Tuesday, November 28, 2017 8:06:52 PM
> > > Subject: Re: [PATCH] vhost-user spec: Clarify policy on setting log_base
> > > 
> > > On Tue, Nov 28, 2017 at 03:46:44PM +0200, Victor Kaplansky wrote:
> > > > From: Victor Kaplansky <vkaplans@dell9020.localdomain>
> > > > 
> > > > If we allow qemu to change logging area after it was already
> > > > established,
> > > > it may require from the backend to acquire a lock on each access to
> > > > the log_base, which has a potential quite a big performance hit.
> > > > 
> > > > Thus we would like to clarify in the spec, that qemu is not expected
> > > > to resize or remap the logging area, and backend implementations
> > > > can safely ignore subsequent requests to log_base modifications.
> > > > 
> > > > Signed-off-by: Victor Kaplansky <vkaplans@redhat.com>
> > > > Suggested-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > 
> > > I'm not sure we can do this.
> > > 
> > > 
> > > Log resizing as a result of memory hotplug might force
> > > log base changes.
> > 
> > I agree. Memory hotplug during live migration will cause a
> > bunch of problems not only to dirty page logging, but to a
> > regular backend function, because memory regions have to be
> > redefined before descriptors pointing to the new memory
> > arrive a backend. Which means, that in DPDK we must to
> > guard by some kind of synchronization mechanism all accesses
> > to guest2qemu memory translation. This will have an impact
> > on the backend performace even with light-weighted RCU.
> > 
> > So, I propose to handle memory hot plug by stopping rings,
> > then changing memory regions and log_base, and then re-enabling
> > rings.
> > 
> > What do you say?
> 
> Why not have backend do this internally when it gets
> the log_base message?
> 
> 
> > 
> > > 
> > > Backends need to use something like
> > > rcu to avoid need for locking.
> > > 
> > > Apropos I wonder whether it's a bug that vhost_dev_start
> > > calls vhost_set_log_base after starting rings.
> > 
> > In vhost-user backend before vhost_user_set_log_base is called for first
> > time, log_base is initialized to zero. Which causes backend (DPDK) to
> > skip logging. Thus theoretically setting log_base on an active ring,
> > may cause to skip single (very first) dirty logging. In the reality,
> > it has very small chances to happen, since sending the response from
> > the backend to qemu by a socket takes much longer then a time gap
> > between reading log_base variable and using it.
> 
> I suspect it's worth fixing though.
> 

Yes, this case maybe not worth to bother, but I'm thinking about all
other race conditions between the request handling thread and the data
path in DPDK, and my conclusion is that we will have to add some general
rcu guard between all requests and data path operations.
I'll send a patch to DPDK.

Anyway, it may be worth to clean up things in qemu as well and
avoid sending unnecessary requests to backend slave.

> 
> > 
> > > 
> > > Same question for the iotlb callback.
> > > 
> > > 
> > > 
> > > 
> > > > ---
> > > >  docs/interop/vhost-user.txt | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> > > > index 954771d0d8..7ab31e57ef 100644
> > > > --- a/docs/interop/vhost-user.txt
> > > > +++ b/docs/interop/vhost-user.txt
> > > > @@ -257,6 +257,12 @@ Where addr is the guest physical address.
> > > >  
> > > >  Use atomic operations, as the log may be concurrently manipulated.
> > > >  
> > > > +Note that master is not expected to issue more than one
> > > > VHOST_USER_SET_LOG_BASE
> > > > +request before the rings are fully stopped by the master. Thus no
> > > > modifications
> > > > +to log_base address are allowed before the rings are restated and the
> > > > client
> > > > +can ignore all subsequent VHOST_USER_SET_LOG_BASE requests after the
> > > > log_base
> > > > +address has been established.
> > > > +
> > > >  Note that when logging modifications to the used ring (when
> > > >  VHOST_VRING_F_LOG
> > > >  is set for this ring), log_guest_addr should be used to calculate the
> > > >  log
> > > >  offset: the write to first byte of the used ring is logged at this
> > > >  offset
> > > >  from
> > > > --
> > > > 2.14.2
> > > 
> 
