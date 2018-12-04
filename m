Received: from eggs.gnu.org ([2001:4830:134:3::10]:57849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUDC9-00035O-M3
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:05:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUDC3-0007mw-FY
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:05:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUDC3-0007me-8P
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:05:03 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-2-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8cff6a08-ed0e-3098-3036-9f0ca63027fe@redhat.com>
Date: Tue, 4 Dec 2018 17:04:50 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/71] vhost-net: move stubs to a separate
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, "Michael S . Tsirkin" <mst@redhat.com>

On 2018-12-03 16:32, Paolo Bonzini wrote:
> There is no reason for CONFIG_VHOST_NET to be specific to a single targ=
et;
> it is a host feature that can be add to all targets, as long as they su=
pport
> the virtio-net device.  Currently CONFIG_VHOST_NET depends on CONFIG_KV=
M,
> but ioeventfd support is present in the core memory API and works with
> other accelerators as well.
>=20
> As a first step, move the vhost-net stubs to a separate file.  Later, t=
hey
> will become conditional on CONFIG_VIRTIO_NET, which is not available in=
 .c
> files.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/net/Makefile.objs    |  4 ++-
>  hw/net/vhost_net-stub.c | 95 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  hw/net/vhost_net.c      | 74 --------------------------------------
>  3 files changed, 98 insertions(+), 75 deletions(-)
>  create mode 100644 hw/net/vhost_net-stub.c
>=20
> diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> index fa461d4..c2705e6 100644
> --- a/hw/net/Makefile.objs
> +++ b/hw/net/Makefile.objs
> @@ -37,7 +37,9 @@ obj-$(CONFIG_PSERIES) +=3D spapr_llan.o
>  obj-$(CONFIG_XILINX_ETHLITE) +=3D xilinx_ethlite.o
> =20
>  obj-$(CONFIG_VIRTIO_NET) +=3D virtio-net.o
> -obj-y +=3D vhost_net.o
> +obj-$(CONFIG_VHOST_NET) +=3D vhost_net.o
> +common-obj-$(call lnot,$(CONFIG_VHOST_NET)) +=3D vhost_net-stub.o
> +common-obj-$(CONFIG_ALL) +=3D vhost_net-stub.o
> =20
>  obj-$(CONFIG_ETSEC) +=3D fsl_etsec/etsec.o fsl_etsec/registers.o \
>  			fsl_etsec/rings.o fsl_etsec/miim.o
> diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
> new file mode 100644
> index 0000000..4de1dfb
> --- /dev/null
> +++ b/hw/net/vhost_net-stub.c
> @@ -0,0 +1,95 @@
> +/*
> + * vhost-net support
> + *
> + * Copyright Red Hat, Inc. 2010
> + *
> + * Authors:
> + *  Michael S. Tsirkin <mst@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  S=
ee
> + * the COPYING file in the top-level directory.
> + *
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.

According to "git blame", most of the stubs line have been added after
January in 2012, so if Michael agrees for the remaining lines, you could
maybe use a proper GPLv2+ text only for this file instead of the
confusing "dual" licensing?

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>
