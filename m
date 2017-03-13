Received: from eggs.gnu.org ([2001:4830:134:3::10]:38050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnZMK-0003Dh-Pr
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnZMH-0003rW-K5
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:26:36 -0400
Received: from mail.kernel.org ([198.145.29.136]:43216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cnZMH-0003py-AY
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 19:26:33 -0400
Date: Mon, 13 Mar 2017 16:26:28 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170310104828.78604daf@bahia>
Message-ID: <alpine.DEB.2.10.1703131550270.21520@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703061807431.17906@sstabellini-ThinkPad-X260>
	<1488852768-8935-1-git-send-email-sstabellini@kernel.org>
	<1488852768-8935-3-git-send-email-sstabellini@kernel.org>
	<20170309185426.3506a17b@bahia> <20170310104828.78604daf@bahia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 3/8] xen/9pfs: introduce Xen 9pfs backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, anthony.perard@citrix.com, xen-devel@lists.xenproject.org

On Fri, 10 Mar 2017, Greg Kurz wrote:
> On Thu, 9 Mar 2017 18:54:26 +0100
> Greg Kurz <groug@kaod.org> wrote:
> 
> > On Mon,  6 Mar 2017 18:12:43 -0800
> > Stefano Stabellini <sstabellini@kernel.org> wrote:
> > 
> > > Introduce the Xen 9pfs backend: add struct XenDevOps to register as a
> > > Xen backend and add struct V9fsTransport to register as v9fs transport.
> > > 
> > > All functions are empty stubs for now.
> > > 
> > > Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> > > CC: anthony.perard@citrix.com
> > > CC: jgross@suse.com
> > > CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > > CC: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/9pfs/xen-9p-backend.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 96 insertions(+)
> > >  create mode 100644 hw/9pfs/xen-9p-backend.c
> > > 
> > > diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> > > new file mode 100644
> > > index 0000000..924fb64
> > > --- /dev/null
> > > +++ b/hw/9pfs/xen-9p-backend.c
> > > @@ -0,0 +1,96 @@
> > > +/*
> > > + * Xen 9p backend
> > > + *
> > > + * Copyright Aporeto 2017
> > > + *
> > > + * Authors:
> > > + *  Stefano Stabellini <stefano@aporeto.com>
> > > + *
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +
> > > +#include "hw/hw.h"
> > > +#include "hw/9pfs/9p.h"
> > > +#include "hw/xen/xen_backend.h"
> > > +#include "xen_9pfs.h"
> > > +#include "qemu/config-file.h"
> > > +#include "fsdev/qemu-fsdev.h"
> > > +
> > > +struct Xen9pfsDev {
> > > +    struct XenDevice xendev;  /* must be first */
> > > +};  
> > 
> > According to HACKING, this should be:
> > 
> > typedef struct Xen9pfsDev {
> >     struct XenDevice xendev;  /* must be first */
> > } Xen9pfsDev;
> > 
> > and...
> > 
> > > +
> > > +static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
> > > +                                     size_t offset,
> > > +                                     const char *fmt,
> > > +                                     va_list ap)
> > > +{
> > > +    return 0;
> > > +}
> > > +
> > > +static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
> > > +                                       size_t offset,
> > > +                                       const char *fmt,
> > > +                                       va_list ap)
> > > +{
> > > +    return 0;
> > > +}
> > > +
> > > +static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
> > > +                                           struct iovec **piov,
> > > +                                           unsigned int *pniov)
> > > +{
> > > +}
> > > +
> > > +static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
> > > +                                          struct iovec **piov,
> > > +                                          unsigned int *pniov,
> > > +                                          size_t size)
> > > +{
> > > +}
> > > +
> > > +static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
> > > +{
> > > +}
> > > +
> > > +static const struct V9fsTransport xen_9p_transport = {
> > > +    .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
> > > +    .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
> > > +    .init_in_iov_from_pdu = xen_9pfs_init_in_iov_from_pdu,
> > > +    .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
> > > +    .push_and_notify = xen_9pfs_push_and_notify,
> > > +};
> > > +
> > > +static int xen_9pfs_init(struct XenDevice *xendev)
> > > +{
> > > +    return 0;
> > > +}
> > > +
> > > +static int xen_9pfs_free(struct XenDevice *xendev)
> > > +{
> > > +    return -1;
> > > +}
> > > +
> > > +static int xen_9pfs_connect(struct XenDevice *xendev)
> > > +{
> > > +    return 0;
> > > +}
> > > +
> > > +static void xen_9pfs_alloc(struct XenDevice *xendev)
> > > +{
> > > +}
> > > +
> > > +static void xen_9pfs_disconnect(struct XenDevice *xendev)
> > > +{
> > > +}
> > > +
> > > +struct XenDevOps xen_9pfs_ops = {
> > > +    .size       = sizeof(struct Xen9pfsDev),  
> > 
> > ... s/struct //
> > 
> > > +    .flags      = DEVOPS_FLAG_NEED_GNTDEV,
> > > +    .alloc      = xen_9pfs_alloc,
> > > +    .init       = xen_9pfs_init,
> > > +    .initialise    = xen_9pfs_connect,
> > > +    .disconnect = xen_9pfs_disconnect,
> > > +    .free       = xen_9pfs_free,
> > > +};  
> > 
> > With the above comments addressed:
> > 
> > Reviewed-by: Greg Kurz <groug@kaod.org>

Thank you for the quick review and useful comments. I'll address them in
the next version of the series.


> Hmm... there's still a problem actually. This patch breaks build for some
> targets with '--enable-xen --enable-virtfs':
> 
>   LINK    cris-softmmu/qemu-system-cris
> ../hw/xen/xen_backend.o: In function `xen_be_register_common':
> /home/greg/Work/qemu/qemu-9p/hw/xen/xen_backend.c:588: undefined reference to `xen_9pfs_ops'

I could reproduce the problem


> This happens because only targets that support virtio and PCI pull the
> 9pfs/fsdev object files. This is an effort to have smaller QEMU binaries,
> based on the historical dependency of 9pfs on virtio. This patch breaks
> this assumption if CONFIG_XEN_BACKEND is defined but the target doesn't
> define CONFIG_VIRTIO and CONFIG_PCI.
> 
> Since 9pfs can now be used with another transport, I guess that the
> dependency on virtio and PCI isn't right anymore. The new condition
> for targets to support 9pfs should rather be something like:
> 
> CONFIG_VIRTFS == y && CONFIG_SOFTMMU == y && (CONFIG_VIRTIO == y || CONFIG_XEN_BACKEND == y)
> 
> This would cause all targets to pull the 9pfs/fsdev object files though.
> 
> So I have a question: do all targets need to support the Xen backend, really ?

Not really: Xen is only supported on x86 and ARM platforms today.
Typically, Xen is only enabled in QEMU for i386 or x86_64 softmmu
targets, even when used in an ARM context (long story short: the Xen PV
machine is arch-agnostic, but the QEMU build doesn't support that, so we
tied it to x86 just because we had to pick one).

In fact, I think the issue is that CONFIG_XEN_BACKEND is set wrongly by
the configure script. It's not an host property, but a target property
like CONFIG_XEN. We need:

diff --git a/configure b/configure
index 6c21975..6d8f752 100755
--- a/configure
+++ b/configure
@@ -5442,7 +5442,6 @@ if test "$virglrenderer" = "yes" ; then
   echo "VIRGL_LIBS=$virgl_libs" >> $config_host_mak
 fi
 if test "$xen" = "yes" ; then
-  echo "CONFIG_XEN_BACKEND=y" >> $config_host_mak
   echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=$xen_ctrl_version" >> $config_host_mak
   if test "$xen_pv_domain_build" = "yes" ; then
     echo "CONFIG_XEN_PV_DOMAIN_BUILD=y" >> $config_host_mak
@@ -6028,6 +6027,7 @@ case "$target_name" in
   i386|x86_64)
     if test "$xen" = "yes" -a "$target_softmmu" = "yes" ; then
       echo "CONFIG_XEN=y" >> $config_target_mak
+      echo "CONFIG_XEN_BACKEND=y" >> $config_target_mak
       if test "$xen_pci_passthrough" = yes; then
         echo "CONFIG_XEN_PCI_PASSTHROUGH=y" >> "$config_target_mak"
       fi

With this change, and the other change you suggested:

  common-obj-$(CONFIG_XEN_BACKEND) += xen-9p-backend.o

I couldn't see any build issues.
