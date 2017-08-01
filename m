Received: from eggs.gnu.org ([2001:4830:134:3::10]:54801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcZdr-0004xP-E1
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcZdn-0001bJ-Fz
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:03:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcZdn-0001ap-9z
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:03:27 -0400
Date: Tue, 1 Aug 2017 19:03:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170801190003-mutt-send-email-mst@kernel.org>
References: <20170728141309.14275-1-marcandre.lureau@redhat.com>
	<20170728141309.14275-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170728141309.14275-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] build-sys: do not compile
 net/vhost-user.c if vhost-user is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, philippe.mathieu.daude@gmail.com, Jason Wang <jasowang@redhat.com>

On Fri, Jul 28, 2017 at 04:13:09PM +0200, Marc-Andr=E9 Lureau wrote:
> This adds two extra #ifdef that have fairly limited conflict potential.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

OK but why can't we keep all ifdefs in net/ where all the
rest of the features are ifdef'ed?

My concern is no one is going to test this weird configuration
so we might accidentally re-enable it without noticing.
net/net.c is where all command line play happens so
people know a bunch of configs need to be tested when
changing it.


> ---
>  hw/net/vhost_net.c | 4 ++++
>  net/Makefile.objs  | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index e037db63a3..96c4da49e4 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -193,6 +193,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *o=
ptions)
>          }
>      }
> =20
> +#ifdef CONFIG_VHOST_USER
>      /* Set sane init value. Override when guest acks. */
>      if (net->nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_USER) {
>          features =3D vhost_user_get_acked_features(net->nc);
> @@ -203,6 +204,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *o=
ptions)
>              goto fail;
>          }
>      }
> +#endif
> =20
>      vhost_net_ack_features(net, features);
> =20
> @@ -414,10 +416,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>      case NET_CLIENT_DRIVER_TAP:
>          vhost_net =3D tap_get_vhost_net(nc);
>          break;
> +#ifdef CONFIG_VHOST_USER
>      case NET_CLIENT_DRIVER_VHOST_USER:
>          vhost_net =3D vhost_user_get_vhost_net(nc);
>          assert(vhost_net);
>          break;
> +#endif
>      default:
>          break;
>      }
> diff --git a/net/Makefile.objs b/net/Makefile.objs
> index 67ba5e26fb..7cac7ed1e4 100644
> --- a/net/Makefile.objs
> +++ b/net/Makefile.objs
> @@ -3,7 +3,7 @@ common-obj-y +=3D socket.o
>  common-obj-y +=3D dump.o
>  common-obj-y +=3D eth.o
>  common-obj-$(CONFIG_L2TPV3) +=3D l2tpv3.o
> -common-obj-$(CONFIG_POSIX) +=3D vhost-user.o
> +common-obj-$(CONFIG_VHOST_USER) +=3D vhost-user.o
>  common-obj-$(CONFIG_SLIRP) +=3D slirp.o
>  common-obj-$(CONFIG_VDE) +=3D vde.o
>  common-obj-$(CONFIG_NETMAP) +=3D netmap.o
> --=20
> 2.14.0.rc0.1.g40ca67566
