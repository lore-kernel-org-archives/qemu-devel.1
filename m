Received: from eggs.gnu.org ([2001:4830:134:3::10]:57275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfN3u-00005C-DO
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfN3r-0004Ah-4r
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:13:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dfN3q-0004AH-VH
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:13:55 -0400
Date: Wed, 9 Aug 2017 11:13:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170809111346.5ffee11e.cohuck@redhat.com>
In-Reply-To: <5e015c3e-7973-f397-cc1e-fee190292616@redhat.com>
References: <20170809071718.17924-1-cohuck@redhat.com>
	<f384f920-9d51-4663-f7e7-95c8b13044f4@redhat.com>
	<20170809102737.18436fb4.cohuck@redhat.com>
	<5e015c3e-7973-f397-cc1e-fee190292616@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org, borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org

On Wed, 9 Aug 2017 11:07:38 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 09.08.2017 10:27, Cornelia Huck wrote:
> > On Wed, 9 Aug 2017 10:23:04 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> On 09.08.2017 09:17, Cornelia Huck wrote:  
> >>> Nothing in fsdev/ or hw/9pfs/ depends on pci; it should rather depend
> >>> on CONFIG_VIRTFS and on the presence of an appropriate virtio transport
> >>> device.
> >>>
> >>> Let's introduce CONFIG_VIRTIO_CCW to cover s390x and check for
> >>> CONFIG_VIRTFS && (CONFIG_VIRTIO_PCI || CONFIG_VIRTIO_CCW).
> >>>
> >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >>> ---
> >>>
> >>> Changes v1->v2: drop extraneous spaces, fix build on cris
> >>>
> >>> ---
> >>>  default-configs/s390x-softmmu.mak | 1 +
> >>>  fsdev/Makefile.objs               | 9 +++------
> >>>  hw/Makefile.objs                  | 2 +-
> >>>  3 files changed, 5 insertions(+), 7 deletions(-)  
> [...]
> >>
> >> Patch should be fine now, I think...
> >>
> >> But thinking about this again, I wonder whether it would be enough to
> >> simply check for CONFIG_VIRTIO=y here instead. CONFIG_VIRTIO=y should be
> >> sufficient to assert that there is also at least one kind of virtio
> >> transport available, right?
> >> Otherwise this will look really horrible as soon as somebody also tries
> >> to add support for virtio-mmio here later ;-)  
> > 
> > Do all virtio transports have support for 9p, though? I thought it was
> > only virtio-pci and virtio-ccw...  
> 
> While virtio-pci and virtio-ccw seem to require separate dedicated
> devices (e.g. virtio-9p-pci and virtio-9p-ccw) for everything,
> virtio-mmio seems to work different. As far as I can see, there are no
> dedicated virtio-xxx-mmio devices in the code at all. According to
> https://www.redhat.com/archives/libvir-list/2013-August/msg00009.html
> you simply have to use virtio-xxx-device here instead. And a
> virtio-9p-device is available. So theoretically, the 9p code should work
> with virtio-mmio, too, or is there a problem that I did not see yet?
> 
> Anyway, we likely should not blindly enable this, so unless somebody has
> a setup to test it, we should go with your current patch instead, I think.

Yes, I'd prefer if somebody with a virtio-mmio setup could chime in.

Given the current Makefiles, this cannot have worked for !pci anyway...
