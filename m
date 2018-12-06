Received: from eggs.gnu.org ([2001:4830:134:3::10]:42271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUtir-0007Z0-QM
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUtio-0001xk-L6
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:29:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUtio-0001xa-D1
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:29:42 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-3-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cdcc8379-3b77-ebfd-fe18-26da16bfb33c@redhat.com>
Date: Thu, 6 Dec 2018 14:29:37 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-3-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/71] vhost-net-user: add stubs for when
 no virtio-net device is present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 2018-12-03 16:32, Paolo Bonzini wrote:
> hw/net/vhost_net.c needs functions that are declared in net/vhost-user.=
c: the
> vhost-user code is always compiled into QEMU, only the constructor
> net_init_vhost_user is unreachable.  Also, net/vhost-user.c needs funct=
ions
> declared in hw/virtio/vhost-stub.c even if no virtio device exists.
>=20
> Break this dependency.  First, add a minimal version of net/vhost-user.=
c,
> with no functionality and no dependency on vhost code.  Second, #ifdef =
out
> the calls back to net/vhost-user.c from hw/net/vhost_net.c.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure             |  2 +-
>  hw/net/vhost_net.c    |  4 ++++
>  net/Makefile.objs     |  4 +++-
>  net/net.c             |  2 +-
>  net/vhost-user-stub.c | 23 +++++++++++++++++++++++
>  5 files changed, 32 insertions(+), 3 deletions(-)
>  create mode 100644 net/vhost-user-stub.c
>=20
> diff --git a/configure b/configure
> index 0a3c6a7..cda17ef 100755
> --- a/configure
> +++ b/configure
> @@ -6513,7 +6513,7 @@ if test "$vhost_scsi" =3D "yes" ; then
>    echo "CONFIG_VHOST_SCSI=3Dy" >> $config_host_mak
>  fi
>  if test "$vhost_net" =3D "yes" -a "$vhost_user" =3D "yes"; then
> -  echo "CONFIG_VHOST_NET_USED=3Dy" >> $config_host_mak
> +  echo "CONFIG_VHOST_NET_USER=3Dy" >> $config_host_mak

Maybe mention this in the patch description, too?

>  fi
>  if test "$vhost_crypto" =3D "yes" ; then
>    echo "CONFIG_VHOST_CRYPTO=3Dy" >> $config_host_mak
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index b901306..fe6202a 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -193,6 +193,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *o=
ptions)
>      }
> =20
>      /* Set sane init value. Override when guest acks. */
> +#ifdef CONFIG_VHOST_USER
>      if (net->nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_USER) {
>          features =3D vhost_user_get_acked_features(net->nc);
>          if (~net->dev.features & features) {
> @@ -202,6 +203,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *o=
ptions)
>              goto fail;
>          }
>      }
> +#endif
> =20
>      vhost_net_ack_features(net, features);
> =20
> @@ -413,10 +415,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>      case NET_CLIENT_DRIVER_TAP:
>          vhost_net =3D tap_get_vhost_net(nc);
>          break;
> +#ifdef CONFIG_VHOST_NET_USER
>      case NET_CLIENT_DRIVER_VHOST_USER:
>          vhost_net =3D vhost_user_get_vhost_net(nc);
>          assert(vhost_net);
>          break;
> +#endif
>      default:
>          break;
>      }
> diff --git a/net/Makefile.objs b/net/Makefile.objs
> index b2bf88a..df2b409 100644
> --- a/net/Makefile.objs
> +++ b/net/Makefile.objs
> @@ -3,7 +3,9 @@ common-obj-y +=3D socket.o
>  common-obj-y +=3D dump.o
>  common-obj-y +=3D eth.o
>  common-obj-$(CONFIG_L2TPV3) +=3D l2tpv3.o
> -common-obj-$(CONFIG_POSIX) +=3D vhost-user.o
> +common-obj-$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET_USER)) =
+=3D vhost-user.o
> +common-obj-$(call land,$(call lnot,$(CONFIG_VIRTIO_NET)),$(CONFIG_VHOS=
T_NET_USER)) +=3D vhost-user-stub.o
> +common-obj-$(CONFIG_ALL) +=3D vhost-user-stub.o
>  common-obj-$(CONFIG_SLIRP) +=3D slirp.o
>  common-obj-$(CONFIG_VDE) +=3D vde.o
>  common-obj-$(CONFIG_NETMAP) +=3D netmap.o
> diff --git a/net/net.c b/net/net.c
> index 07c194a..95a74ad 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -955,7 +955,7 @@ static int (* const net_client_init_fun[NET_CLIENT_=
DRIVER__MAX])(
>          [NET_CLIENT_DRIVER_BRIDGE]    =3D net_init_bridge,
>  #endif
>          [NET_CLIENT_DRIVER_HUBPORT]   =3D net_init_hubport,
> -#ifdef CONFIG_VHOST_NET_USED
> +#ifdef CONFIG_VHOST_NET_USER
>          [NET_CLIENT_DRIVER_VHOST_USER] =3D net_init_vhost_user,
>  #endif
>  #ifdef CONFIG_L2TPV3
> diff --git a/net/vhost-user-stub.c b/net/vhost-user-stub.c
> new file mode 100644
> index 0000000..52ab4e1
> --- /dev/null
> +++ b/net/vhost-user-stub.c
> @@ -0,0 +1,23 @@
> +/*
> + * vhost-user-stub.c
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "clients.h"
> +#include "net/vhost_net.h"
> +#include "net/vhost-user.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +
> +int net_init_vhost_user(const Netdev *netdev, const char *name,
> +                        NetClientState *peer, Error **errp)
> +{
> +    error_setg(errp, "vhost-user requires frontend driver virtio-net-*=
");
> +    return -1;
> +}
>=20

It's a little bit sad that we need the stub in this case, but since
CONFIG_VIRTIO_NET is not available as a CPP macro, I also don't have any
better ideas.

Reviewed-by: Thomas Huth <thuth@redhat.com>
