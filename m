Received: from eggs.gnu.org ([2001:4830:134:3::10]:58004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkaplans@redhat.com>) id 1eJjqT-00079F-NW
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkaplans@redhat.com>) id 1eJjqP-0005UV-N1
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:38:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkaplans@redhat.com>) id 1eJjqP-0005UH-Ei
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:38:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C7B280477
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 17:38:52 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 746E6600D1
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 17:38:52 +0000 (UTC)
Date: Tue, 28 Nov 2017 12:38:52 -0500 (EST)
From: Victor Kaplansky <vkaplans@redhat.com>
Message-ID: <1700185825.47104719.1511890732353.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171128181150-mutt-send-email-mst@kernel.org>
References: <20171128133123.17372-1-vkaplans@redhat.com>
	<20171128160420.GG2318@work-vm>
	<20171128181150-mutt-send-email-mst@kernel.org>
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>

> From: "Michael S. Tsirkin" <mst@redhat.com>
> To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: "Victor Kaplansky" <vkaplans@redhat.com>, qemu-devel@nongnu.org, "Maxime Coquelin" <maxime.coquelin@redhat.com>
> Sent: Tuesday, November 28, 2017 6:12:44 PM
> Subject: Re: [Qemu-devel] [PATCH] vhost-user spec: Clarify policy on setting log_base
> 
> On Tue, Nov 28, 2017 at 04:04:21PM +0000, Dr. David Alan Gilbert wrote:
> > * Victor Kaplansky (vkaplans@redhat.com) wrote:
> > > From: Victor Kaplansky <vkaplans@dell9020.localdomain>
> > > 
> > > If we allow qemu to change logging area after it was already established,
> > > it may require from the backend to acquire a lock on each access to
> > > the log_base, which has a potential quite a big performance hit.
> > > 
> > > Thus we would like to clarify in the spec, that qemu is not expected
> > > to resize or remap the logging area, and backend implementations
> > > can safely ignore subsequent requests to log_base modifications.
> > 
> > There's quite a bit of code in vhost to cope with changes in mappings
> > of regions; and there's already code in there to handle log size
> > changes:
> > 
> > static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t
> > size)
> > {
> >     struct vhost_log *log = vhost_log_get(size,
> >     vhost_dev_log_is_shared(dev));
> >     uint64_t log_base = (uintptr_t)log->log;
> >     int r;
> > 
> >     /* inform backend of log switching, this must be done before
> >        releasing the current log, to ensure no logging is lost */
> >     r = dev->vhost_ops->vhost_set_log_base(dev, log_base, log);
> > 
> > so when is a log resize legal?
> > 
> > Dave
> 
> Log base has nothing to do with log resize.
> 
> It supplies the physical address of the ring
> for dirty logging purposes.
> 

Right. Just for complete picture, it also supplies the address for
dirty logging of where descriptors can point, in other words for logging
whole guest's physical memory. It is why a single log_base is enough for
whole device, and there is no need to specify it for every ring separately.

Having said that, there is an obscure possibility to place the ring in
a memory different from guest's physical memory, but as far as I know there
is no backend that supports this now.

The introduction of this clarification to the vhost-user spec, either with
*must* or without it, will enable us to fix in DPDK several BZs open for qemu
and related to migration failure of MQ vhost-user.
