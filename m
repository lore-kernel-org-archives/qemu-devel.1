Received: from eggs.gnu.org ([2001:4830:134:3::10]:47846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnrnh-0000Jt-6n
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cnrnc-0004LB-HC
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:08:05 -0400
Received: from mail.kernel.org ([198.145.29.136]:47938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cnrnc-0004Ik-7Z
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:08:00 -0400
Date: Tue, 14 Mar 2017 12:07:55 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1b077b13-2464-224a-3942-db0015951c32@redhat.com>
Message-ID: <alpine.DEB.2.10.1703141201300.4807@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
	<1b077b13-2464-224a-3942-db0015951c32@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 1/9] configure: change
 CONFIG_XEN_BACKEND to be a target property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, groug@kaod.org, Stefano Stabellini <stefano@aporeto.com>, peter.maydell@linaro.org, rth@twiddle.net, stefanha@redhat.com

On Tue, 14 Mar 2017, Paolo Bonzini wrote:
> On 14/03/2017 00:55, Stefano Stabellini wrote:
> > CONFIG_XEN_BACKEND is currently set when the host supports Xen,
> > regardless of the chosen targets. As a consequence, Xen backends can be
> > enabled even on targets that don't support Xen.
> > 
> > Fix the issue by setting CONFIG_XEN_BACKEND only for targets that
> > support Xen.
> > 
> > Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> > CC: groug@kaod.org
> > CC: groug@kaod.org
> > CC: pbonzini@redhat.com
> > CC: peter.maydell@linaro.org
> > CC: rth@twiddle.net
> > CC: stefanha@redhat.com
> > ---
> >  configure | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/configure b/configure
> > index 6c21975..6d8f752 100755
> > --- a/configure
> > +++ b/configure
> > @@ -5442,7 +5442,6 @@ if test "$virglrenderer" = "yes" ; then
> >    echo "VIRGL_LIBS=$virgl_libs" >> $config_host_mak
> >  fi
> >  if test "$xen" = "yes" ; then
> > -  echo "CONFIG_XEN_BACKEND=y" >> $config_host_mak
> >    echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=$xen_ctrl_version" >> $config_host_mak
> >    if test "$xen_pv_domain_build" = "yes" ; then
> >      echo "CONFIG_XEN_PV_DOMAIN_BUILD=y" >> $config_host_mak
> > @@ -6028,6 +6027,7 @@ case "$target_name" in
> >    i386|x86_64)
> >      if test "$xen" = "yes" -a "$target_softmmu" = "yes" ; then
> >        echo "CONFIG_XEN=y" >> $config_target_mak
> > +      echo "CONFIG_XEN_BACKEND=y" >> $config_target_mak
> >        if test "$xen_pci_passthrough" = yes; then
> >          echo "CONFIG_XEN_PCI_PASSTHROUGH=y" >> "$config_target_mak"
> >        fi
> > 
> 
> This messes up a bit the way xen_nic.o and friends are compiled, I
> think, because they are common-obj-y but they are only found when
> compiling in the target subdirectories.  So you end up building
> x86_64-softmmu/../hw/net/xen_nic.o
> 
> If you're unlucky, I believe this can lead to a link failure where a
> target is building xen_nic.o, while the other tries to link to a
> partially written object file.
> 
> I think the files should be changed from
> common-obj-$(CONFIG_XEN_BACKEND) to common-obj-$(CONFIG_XEN).
>
> The Makefile.objs change ensures that Xen backends are not enabled on
> targets that support Xen.

Actually I thought about doing that instead of the configure change. It
makes sense to me.


> Then you add to Makefile:
> 
>  CONFIG_SOFTMMU := $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
>  CONFIG_USER_ONLY := $(if $(filter %-user,$(TARGET_DIRS)),y)
> +CONFIG_XEN := $(CONFIG_XEN_BACKEND)
>  CONFIG_ALL=y
>  -include config-all-devices.mak
>  -include config-all-disas.mak
> 
> The Makefile change ensures that they are built before descending in the
> target-specific directories.

But I don't understand this. Please correct me if I am wrong, but this
change looks like it would end up setting CONFIG_XEN every time that
CONFIG_XEN_BACKEND is set. Without the configure change at the top, it
would end up setting CONFIG_XEN whenever the host supports Xen, even for
non-x86 and non-ARM targets. What am I missing?
