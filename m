Received: from eggs.gnu.org ([2001:4830:134:3::10]:42616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfKq1-0003RG-PJ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfKpy-0003yC-OS
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:51:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dfKpy-0003xw-Em
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:51:26 -0400
Date: Wed, 9 Aug 2017 08:51:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170809085113.6d1ef8d4.cohuck@redhat.com>
In-Reply-To: <3988876c-6699-3da9-cdd4-bd3729a693ff@redhat.com>
References: <20170808153827.427-1-cohuck@redhat.com>
	<20170808182623.45e88fd6@bahia.lan>
	<3988876c-6699-3da9-cdd4-bd3729a693ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, aneesh.kumar@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org

On Wed, 9 Aug 2017 07:12:51 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 08.08.2017 18:26, Greg Kurz wrote:
> > On Tue,  8 Aug 2017 17:38:27 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> >> Nothing in fsdev/ or hw/9pfs/ depends on pci; it should rather depend
> >> on CONFIG_VIRTFS and on the presence of an appropriate virtio transport
> >> device.
> >>
> >> Let's introduce CONFIG_VIRTIO_CCW to cover s390x and check for
> >> CONFIG_VIRTFS && (CONFIG_VIRTIO_PCI || CONFIG_VIRTIO_CCW).
> >>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> ---
> >>
> >> This is the alternative approach to "9pfs: fix and simplify dependencies".
> >> Uglier; but probably not broken...
> >>  
> > 
> > Yikes. I don't know why yet but this doesn't work for PCI-less targets
> > like cris-softmmu...
> > 
> >   LINK    cris-softmmu/qemu-system-cris
> > vl.o: In function `fsdev_init_func':
> > vl.c:2360: undefined reference to `qemu_fsdev_add'

Hmpf. Added cris to my buildlist...

> >   
> >> ---
> >>  default-configs/s390x-softmmu.mak | 1 +
> >>  fsdev/Makefile.objs               | 9 +++------
> >>  hw/Makefile.objs                  | 2 +-
> >>  3 files changed, 5 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
> >> index 51191b77df..e4c5236ceb 100644
> >> --- a/default-configs/s390x-softmmu.mak
> >> +++ b/default-configs/s390x-softmmu.mak
> >> @@ -8,3 +8,4 @@ CONFIG_S390_FLIC=y
> >>  CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
> >>  CONFIG_VFIO_CCW=$(CONFIG_LINUX)
> >>  CONFIG_WDT_DIAG288=y
> >> +CONFIG_VIRTIO_CCW=y
> >> diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
> >> index 659df6e187..10d8caa291 100644
> >> --- a/fsdev/Makefile.objs
> >> +++ b/fsdev/Makefile.objs
> >> @@ -1,10 +1,7 @@
> >> -ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
> >>  # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
> >> -# only pull in the actual virtio-9p device if we also enabled virtio.
> >> -common-obj-y = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
> >> -else
> >> -common-obj-y = qemu-fsdev-dummy.o
> >> -endif
> >> +# only pull in the actual virtio-9p device if we also enabled a virtio backend.
> >> +common-obj-$(call land, $(CONFIG_VIRTFS),$(call lor, $(CONFIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW)))= qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
> >> +common-obj-$(call lnot, $(call land, $(CONFIG_VIRTFS),$(call lor, $(CONFIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW)))) = qemu-fsdev-dummy.o
> >>  common-obj-y += qemu-fsdev-opts.o qemu-fsdev-throttle.o
> >>  
> >>  # Toplevel always builds this; targets without virtio will put it in
> >> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> >> index a2c61f6b09..10942fe0b4 100644
> >> --- a/hw/Makefile.objs
> >> +++ b/hw/Makefile.objs
> >> @@ -1,4 +1,4 @@
> >> -devices-dirs-$(call land, $(CONFIG_VIRTIO),$(call land,$(CONFIG_VIRTFS),$(CONFIG_PCI))) += 9pfs/
> >> +devices-dirs-$(call land, $(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW))) += 9pfs/
> >>  devices-dirs-$(CONFIG_SOFTMMU) += acpi/
> >>  devices-dirs-$(CONFIG_SOFTMMU) += adc/
> >>  devices-dirs-$(CONFIG_SOFTMMU) += audio/  
> 
> I think the problem are the white spaces after a ",". For example for
> the following test code in a makefile:
> 
> 	@echo test1: $(call lnot, n)
> 	@echo test2: $(call lnot,n)
> 
> I get the following output:
> 
>  test1: n
>  test2: y
> 
> Hope that helps,
>  Thomas
> 

Yeah, my fingers are trained to type a blank after a comma... currently
testing an updated patch.
