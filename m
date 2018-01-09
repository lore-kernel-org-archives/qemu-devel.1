Received: from eggs.gnu.org ([2001:4830:134:3::10]:46371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eYwEL-0000Sq-44
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eYwEI-0001OU-2x
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:54:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eYwEH-0001Np-Sa
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:54:21 -0500
Date: Tue, 9 Jan 2018 15:54:16 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180109155415.GD2709@work-vm>
References: <20171218201340.27583-1-dgilbert@redhat.com>
	<20171218201340.27583-7-dgilbert@redhat.com>
	<20171222201439.139e4010@igors-macbook-pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171222201439.139e4010@igors-macbook-pro.local>
Subject: Re: [Qemu-devel] [PATCH v5 6/7] vhost: Clean out old
 vhost_set_memory and friends
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
> On Mon, 18 Dec 2017 20:13:39 +0000
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Remove the old update mechanism, vhost_set_memory, and the functions
> > and flags it used.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> [...]
> 
> > -
> > -static void vhost_set_memory(MemoryListener *listener,
> > -                             MemoryRegionSection *section,
> > -                             bool add)
> > -{
> [...]
> 
> > -    used_memslots = dev->mem->nregions;
> lost sheep?

Yes, I've moved that into the previous patch, ( vhost: Regenerate region
list from changed sections list ) so it now has:

...
    dev->mem = g_realloc(dev->mem, regions_size);
    dev->mem->nregions = dev->n_mem_sections;
    used_memslots = dev->mem->nregions;
    for (i = 0; i < dev->n_mem_sections; i++) {
...

> pls,
> see "[PATCH v2 0/2] vhost: two fixes" to get vague idea how used_memslots is used

Yes, that series does make it better because what confused me about the
current use of used_memslots is it seems obviously unsafe for multiple
devices.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
