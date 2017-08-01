Received: from eggs.gnu.org ([2001:4830:134:3::10]:41206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dcSLD-0005nr-VJ
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dcSLA-0003F1-P0
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:15:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dcSLA-0003EK-HR
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 04:15:44 -0400
Date: Tue, 1 Aug 2017 10:15:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170801101535.16f4d486@gondolin>
In-Reply-To: <20170728141309.14275-2-marcandre.lureau@redhat.com>
References: <20170728141309.14275-1-marcandre.lureau@redhat.com>
	<20170728141309.14275-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] build-sys: add --disable-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, philippe.mathieu.daude@gmail.com, mst@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On Fri, 28 Jul 2017 16:13:08 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Learn to compile out vhost-user. Keep it enabled by default on
> non-win32, that is assumed to be POSIX. Fail if trying to enable it on
> win32.
>=20
> When trying to make a vhost-user netdev, it gives the following error:
>=20
> -netdev vhost-user,id=3Dfoo,chardev=3Dchr-test: Parameter 'type' expects =
a netdev backend type
>=20
> And similar error with the HMP/QMP monitors.
>=20
> While at it, rename CONFIG_VHOST_NET_TEST CONFIG_VHOST_USER_NET_TEST
> since it's a vhost-user specific variable.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/virtio/virtio-pci.c            |  4 ++--
>  configure                         | 29 +++++++++++++++++++++++++++--
>  default-configs/pci.mak           |  2 +-
>  default-configs/s390x-softmmu.mak |  2 +-
>  tests/Makefile.include            |  6 +++---
>  5 files changed, 34 insertions(+), 9 deletions(-)
>=20
(...)
> diff --git a/configure b/configure
> index 987f59ba88..efec1a613e 100755
> --- a/configure
> +++ b/configure
> @@ -306,6 +306,7 @@ tcg=3D"yes"
>  vhost_net=3D"no"
>  vhost_scsi=3D"no"
>  vhost_vsock=3D"no"
> +vhost_user=3D""
>  kvm=3D"no"
>  hax=3D"no"
>  rdma=3D""
> @@ -1282,6 +1283,15 @@ for opt do
>    ;;
>    --enable-vxhs) vxhs=3D"yes"
>    ;;
> +  --disable-vhost-user) vhost_user=3D"no"
> +  ;;
> +  --enable-vhost-user)
> +      vhost_user=3D"yes"
> +      if test "$mingw32" =3D "yes" ; then
> +          echo "ERROR: vhost-user isn't available on win32"
> +          exit 1

error_exit?

> +      fi
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
(...)

> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-so=
ftmmu.mak
> index b227a36179..51191b77df 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -1,6 +1,6 @@
>  CONFIG_PCI=3Dy
>  CONFIG_VIRTIO_PCI=3Dy
> -CONFIG_VHOST_USER_SCSI=3D$(CONFIG_LINUX)
> +CONFIG_VHOST_USER_SCSI=3D$(and $(CONFIG_VHOST_USER),$(CONFIG_LINUX))

Huh. I wonder if anyone actually tried this on s390x?

(The change is fine in the context of this patch, of course.)

>  CONFIG_VIRTIO=3Dy
>  CONFIG_SCLPCONSOLE=3Dy
>  CONFIG_TERMINAL3270=3Dy
