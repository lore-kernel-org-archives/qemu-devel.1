Received: from eggs.gnu.org ([2001:4830:134:3::10]:34562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1camTW-00024W-VA
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1camTV-0004dR-Tw
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:49:11 -0500
Date: Mon, 6 Feb 2017 09:49:03 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170206094903.7fe64817@t450s.home>
In-Reply-To: <5f0bafdc-6bb8-d936-e38c-5be92c46efc6@redhat.com>
References: <1485880595-16376-1-git-send-email-thuth@redhat.com>
	<20170131103044.66316989@t450s.home>
	<5f0bafdc-6bb8-d936-e38c-5be92c46efc6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/vfio: Add CONFIG switches for
 calxeda-xgmac and amd-xgbe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org

On Tue, 31 Jan 2017 19:51:02 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 31.01.2017 18:30, Alex Williamson wrote:
> > On Tue, 31 Jan 2017 17:36:35 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> Both devices seem to be specific to the ARM platform. It's confusing
> >> for the users if they show up on other target architectures, too
> >> (e.g. when the user runs QEMU with "-device ?" to get a list of
> >> supported devices). Thus let's introduce proper configuration switches
> >> so that the devices are only compiled and included when they are
> >> really required.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  default-configs/arm-softmmu.mak | 2 ++
> >>  hw/vfio/Makefile.objs           | 4 ++--
> >>  2 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> >> index 6de3e16..a78be51 100644
> >> --- a/default-configs/arm-softmmu.mak
> >> +++ b/default-configs/arm-softmmu.mak
> >> @@ -94,6 +94,8 @@ CONFIG_VERSATILE_PCI=y
> >>  CONFIG_VERSATILE_I2C=y
> >>  
> >>  CONFIG_PCI_GENERIC=y
> >> +CONFIG_VFIO_XGMAC=y
> >> +CONFIG_VFIO_AMD_XGBE=y
> >>  
> >>  CONFIG_SDHCI=y
> >>  CONFIG_INTEGRATOR_DEBUG=y
> >> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> >> index c25e32b..05e7fbb 100644
> >> --- a/hw/vfio/Makefile.objs
> >> +++ b/hw/vfio/Makefile.objs
> >> @@ -2,7 +2,7 @@ ifeq ($(CONFIG_LINUX), y)
> >>  obj-$(CONFIG_SOFTMMU) += common.o
> >>  obj-$(CONFIG_PCI) += pci.o pci-quirks.o
> >>  obj-$(CONFIG_SOFTMMU) += platform.o
> >> -obj-$(CONFIG_SOFTMMU) += calxeda-xgmac.o
> >> -obj-$(CONFIG_SOFTMMU) += amd-xgbe.o
> >> +obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
> >> +obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
> >>  obj-$(CONFIG_SOFTMMU) += spapr.o
> >>  endif  
> > 
> > I can't say that I fully agree that this is a good idea.  How many
> > users are actually confused by this, versus the benefit of ensuring
> > that it builds across all architectures?  
> 
> Why do you want this to be build on all architectures? The devices are
> only available on ARM as far as I know, so I can't see any real use for
> this. And it slows down compilation time, too, if we compile it
> everywhere (well, a little bit at least ;-)).
> 
> > Do we want to make platform also specific to ARM  
> 
> I did not notice that one yet, since it does not show up in the "-device
> ?" help text (it's apparently an abstract device), so it also does not
> really bother me.
> But if I remove the device from the build, I get a funny error when I
> try to view the device help text:
> 
> $ qemu-system-tricore -device ?
> **
> ERROR:/home/thuth/devel/qemu/qom/object.c:168:type_get_parent: assertion
> failed: (type->parent_type != NULL)
> Aborted (core dumped)
> 
> So I guess we should rather keep that one for now.
> 
> > and spapr specific to ppc64?  
> 
> I already tried that (with the already existing CONFIG_PSERIES), but the
> code in common.c depends on the code in spapr.c, so it can't be removed
> without reworking the code quite a bit. But spapr.c also does not really
> bug me, since it does not register a type that shows up in the "-device
> ?" help text, so I think it is not worth the effort here.

Ok, I guess my only real objection is that I need to build multiple
targets in order to compile test all of vfio rather than getting that
for free with only building x86_64 for development and only building the
full target list prior to a submitting a pull request.  It's a bit
selfish to impose those extra files on other targets for time and space
reasons, so I guess I don't have any substantive objection to this.
I'll queue it for my next pull request.  Thanks,

Alex
