Received: from eggs.gnu.org ([2001:4830:134:3::10]:43333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=228f1c8ea=Paul.Durrant@citrix.com>)
	id 1cjkbm-0002by-Bj
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=228f1c8ea=Paul.Durrant@citrix.com>)
	id 1cjkbj-0000JF-7E
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:38:46 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:9143
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=228f1c8ea=Paul.Durrant@citrix.com>)
	id 1cjkbi-0000Iv-RX
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:38:43 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 3 Mar 2017 10:38:38 +0000
Message-ID: <05365905529b4fd78ff67989743a8dfb@AMSPEX02CL03.citrite.net>
References: <1488452986-24501-1-git-send-email-paul.durrant@citrix.com>
	<1488452986-24501-6-git-send-email-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1703021426050.17906@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1703021426050.17906@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 5/5] xen: use libxendevicemodel when
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 02 March 2017 22:50
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; Stefano
> Stabellini <sstabellini@kernel.org>; Anthony Perard
> <anthony.perard@citrix.com>
> Subject: Re: [PATCH v2 5/5] xen: use libxendevicemodel when available
>=20
> On Thu, 2 Mar 2017, Paul Durrant wrote:
> > This patch modifies the wrapper functions in xen_common.h to use the
> > new xendevicemodel interface if it is available along with compatibilit=
y
> > code to use the old libxenctrl interface if it is not.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> >
> > v2:
> > - Add a compat define for xenforeignmemory_close() since this is now
> >   used.
> > ---
> >  include/hw/xen/xen_common.h | 115
> +++++++++++++++++++++++++++++++-------------
> >  xen-common.c                |   8 +++
> >  2 files changed, 90 insertions(+), 33 deletions(-)
> >
> > diff --git a/include/hw/xen/xen_common.h
> b/include/hw/xen/xen_common.h
> > index 31cf25f..48444e5 100644
> > --- a/include/hw/xen/xen_common.h
> > +++ b/include/hw/xen/xen_common.h
> > @@ -9,6 +9,7 @@
> >  #undef XC_WANT_COMPAT_EVTCHN_API
> >  #undef XC_WANT_COMPAT_GNTTAB_API
> >  #undef XC_WANT_COMPAT_MAP_FOREIGN_API
> > +#undef XC_WANT_COMPAT_DEVICEMODEL_API
> >
> >  #include <xenctrl.h>
> >  #include <xenstore.h>
> > @@ -26,48 +27,95 @@ extern xc_interface *xen_xc;
> >   * We don't support Xen prior to 4.2.0.
> >   */
> >
> > +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 490
> > +
> > +typedef xc_interface xendevicemodel_handle;
> > +
> > +#define xendevicemodel_open(l, f) xen_xc
> > +
> > +#define xendevicemodel_map_io_range_to_ioreq_server \
> > +    xc_hvm_map_io_range_to_ioreq_server
> > +#define xendevicemodel_unmap_io_range_from_ioreq_server \
> > +    xc_hvm_unmap_io_range_from_ioreq_server
> > +#define xendevicemodel_map_pcidev_to_ioreq_server \
> > +    xc_hvm_map_pcidev_to_ioreq_server
> > +#define xendevicemodel_unmap_pcidev_from_ioreq_server \
> > +    xc_hvm_unmap_pcidev_from_ioreq_server
> > +#define xendevicemodel_create_ioreq_server \
> > +    xc_hvm_create_ioreq_server
> > +#define xendevicemodel_destroy_ioreq_server \
> > +    xc_hvm_destroy_ioreq_server
> > +#define xendevicemodel_get_ioreq_server_info \
> > +    xc_hvm_get_ioreq_server_info
> > +#define xendevicemodel_set_ioreq_server_state \
> > +    xc_hvm_set_ioreq_server_state
> > +#define xendevicemodel_set_pci_intx_level \
> > +    xc_hvm_set_pci_intx_level
> > +#define xendevicemodel_set_pci_link_route \
> > +    xc_hvm_set_pci_link_route
> > +#define xendevicemodel_set_isa_irq_level \
> > +    xc_hvm_set_isa_irq_level
> > +#define xendevicemodel_inject_msi \
> > +    xc_hvm_inject_msi
> > +#define xendevicemodel_set_mem_type \
> > +    xc_hvm_set_mem_type
> > +#define xendevicemodel_track_dirty_vram \
> > +    xc_hvm_track_dirty_vram
> > +#define xendevicemodel_modified_memory \
> > +    xc_hvm_modified_memory
>=20
> It does build correctly now for Xen < 4.9, however it breaks against
> xen-unstable:
>=20
>   ERROR: configure test passed without -Werror but failed with -Werror.
>          This is probably a bug in the configure script. The failing comm=
and
>          will be at the bottom of config.log.
>          You can run configure with --disable-werror to bypass this check=
.
>=20
> and config.log says:
>=20
>   config-temp/qemu-conf.c: In function 'main':
>   config-temp/qemu-conf.c:32:3: error: implicit declaration of function
> 'xc_hvm_set_mem_type' [-Werror=3Dimplicit-function-declaration]
>   config-temp/qemu-conf.c:32:3: error: nested extern declaration of
> 'xc_hvm_set_mem_type' [-Werror=3Dnested-externs]
>   config-temp/qemu-conf.c:34:3: error: implicit declaration of function
> 'xc_hvm_inject_msi' [-Werror=3Dimplicit-function-declaration]
>   config-temp/qemu-conf.c:34:3: error: nested extern declaration of
> 'xc_hvm_inject_msi' [-Werror=3Dnested-externs]
>   config-temp/qemu-conf.c:35:3: error: implicit declaration of function
> 'xc_hvm_create_ioreq_server' [-Werror=3Dimplicit-function-declaration]
>   config-temp/qemu-conf.c:35:3: error: nested extern declaration of
> 'xc_hvm_create_ioreq_server' [-Werror=3Dnested-externs]
>=20
>=20
> With -DXC_WANT_COMPAT_DEVICEMODEL_API=3D1:
>=20
>   In file included from /local/qemu-
> upstream/include/hw/xen/xen_backend.h:4:0,
>                    from hw/block/xen_disk.c:27:
>   /local/qemu-upstream/include/hw/xen/xen_common.h: In function
> 'xen_set_mem_type':
>   /local/qemu-upstream/include/hw/xen/xen_common.h:78:5: error: implicit
> declaration of function 'xc_hvm_set_mem_type' [-Werror=3Dimplicit-functio=
n-
> declaration]
>=20

Ah... Do you have Anthony's patch?

http://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dcommit;h=3D9970e98ace4857470=
1f7e2286fb67090481a3fec

I suspect that may be the problem you're seeing above.

  Paul
