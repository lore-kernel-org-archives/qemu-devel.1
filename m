Received: from eggs.gnu.org ([2001:4830:134:3::10]:36370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePpq0-0003Ia-Gx
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePppv-0007oP-DR
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:15:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePppv-0007mL-0R
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:15:35 -0500
Date: Fri, 15 Dec 2017 13:15:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171215131521.GC14126@work-vm>
References: <20171213180807.7066-1-dgilbert@redhat.com>
	<20171213180807.7066-4-dgilbert@redhat.com>
	<20171214161524.495caede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171214161524.495caede@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/6] vhost: Add temporary memory
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Wed, 13 Dec 2017 18:08:04 +0000
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Add a 2nd 'vhost_memory' structure that will be used to build
> > the new version as the listener iterates over the address space.
> I'd suggest to add temporary 'mem_sections' instead and
> create/use/free temporary 'vhost_memory' structure at commit time,
> (1 less duplicated data set to keep in memory)

I don't see how this leads to less duplication;  I still end up with
one set of temporary structures, and the sections use Int128 which
is a pain to work with in the comparison/merging code.

Dave

> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hw/virtio/vhost.c         | 3 +++
> >  include/hw/virtio/vhost.h | 1 +
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index c7ce7baf9b..4523f45587 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -632,6 +632,8 @@ static void vhost_begin(MemoryListener *listener)
> >                                           memory_listener);
> >      dev->mem_changed_end_addr = 0;
> >      dev->mem_changed_start_addr = -1;
> > +
> > +    dev->tmp_mem = g_malloc0(offsetof(struct vhost_memory, regions));
> >  }
> >  
> >  static void vhost_commit(MemoryListener *listener)
> > @@ -641,6 +643,7 @@ static void vhost_commit(MemoryListener *listener)
> >      uint64_t log_size;
> >      int r;
> >  
> > +    g_free(dev->tmp_mem);
> >      if (!dev->memory_changed) {
> >          return;
> >      }
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 467dc7794b..41f9e569be 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -70,6 +70,7 @@ struct vhost_dev {
> >      bool memory_changed;
> >      hwaddr mem_changed_start_addr;
> >      hwaddr mem_changed_end_addr;
> > +    struct vhost_memory *tmp_mem;
> >      const VhostOps *vhost_ops;
> >      void *opaque;
> >      struct vhost_log *log;
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
