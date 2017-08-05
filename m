Received: from eggs.gnu.org ([2001:4830:134:3::10]:59203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ddtgR-0002Vc-7s
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 03:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ddtgN-0004Hf-AT
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 03:39:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ddtgN-0004GB-0c
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 03:39:35 -0400
References: <20170803090746.30532-1-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1eca7ede-f103-ee90-1f9a-0fc44ef2b708@redhat.com>
Date: Sat, 5 Aug 2017 09:39:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170803090746.30532-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] build-sys: add --disable-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, philippe.mathieu.daude@gmail.com

On 03.08.2017 11:07, Marc-Andr=C3=A9 Lureau wrote:
> Learn to compile out vhost-user (net, scsi & upcoming users). Keep it
> enabled by default on non-win32, that is assumed to be POSIX. Fail if
> trying to enable it on win32.
>=20
> When trying to make a vhost-user netdev, it gives the following error:
>=20
> -netdev vhost-user,id=3Dfoo,chardev=3Dchr-test: Parameter 'type' expect=
s a netdev backend type
>=20
> And similar error with the HMP/QMP monitors.
>=20
> While at it, rename CONFIG_VHOST_NET_TEST CONFIG_VHOST_USER_NET_TEST
> since it's a vhost-user specific variable.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/virtio/virtio-pci.c            |  4 ++--
>  configure                         | 28 ++++++++++++++++++++++++++--
>  default-configs/pci.mak           |  2 +-
>  default-configs/s390x-softmmu.mak |  2 +-
>  tests/Makefile.include            |  6 +++---
>  5 files changed, 33 insertions(+), 9 deletions(-)
>=20
> v3:
> - user error_exit in configure
> - drop patch to compile out net/vhost-user.c
>=20
> v2:
> - remove some #ifdef, reuse CONFIG_VHOST_NET_USED
> - split the patch to have net/vhost-user.c compiled out (adding 2 ifdef=
s)
> - fail if --enable-vhost-user on win32
>=20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 5d14bd66dc..8b0d6b69cd 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2135,7 +2135,7 @@ static const TypeInfo vhost_scsi_pci_info =3D {
>  };
>  #endif
> =20
> -#ifdef CONFIG_LINUX
> +#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
>  /* vhost-user-scsi-pci */
>  static Property vhost_user_scsi_pci_properties[] =3D {
>      DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> @@ -2665,7 +2665,7 @@ static void virtio_pci_register_types(void)
>  #ifdef CONFIG_VHOST_SCSI
>      type_register_static(&vhost_scsi_pci_info);
>  #endif
> -#ifdef CONFIG_LINUX
> +#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
>      type_register_static(&vhost_user_scsi_pci_info);
>  #endif
>  #ifdef CONFIG_VHOST_VSOCK
> diff --git a/configure b/configure
> index 987f59ba88..dd73cce62f 100755
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
> @@ -1282,6 +1283,14 @@ for opt do
>    ;;
>    --enable-vxhs) vxhs=3D"yes"
>    ;;
> +  --disable-vhost-user) vhost_user=3D"no"
> +  ;;
> +  --enable-vhost-user)
> +      vhost_user=3D"yes"
> +      if test "$mingw32" =3D "yes"; then
> +          error_exit "vhost-user isn't available on win32"
> +      fi
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1290,6 +1299,14 @@ for opt do
>    esac
>  done
> =20
> +if test "$vhost_user" =3D ""; then
> +    if test "$mingw32" =3D "yes"; then
> +        vhost_user=3D"no"
> +    else
> +        vhost_user=3D"yes"
> +    fi
> +fi
> +
>  case "$cpu" in
>      ppc)
>             CPU_CFLAGS=3D"-m32"
> @@ -1518,6 +1535,7 @@ disabled with --disable-FEATURE, default is enabl=
ed if available:
>    tools           build qemu-io, qemu-nbd and qemu-image tools
>    vxhs            Veritas HyperScale vDisk backend support
>    crypto-afalg    Linux AF_ALG crypto backend driver
> +  vhost-user      vhost-user support
> =20
>  NOTE: The object files are built at the place where configure is launc=
hed
>  EOF
> @@ -5348,6 +5366,7 @@ echo "libcap-ng support $cap_ng"
>  echo "vhost-net support $vhost_net"
>  echo "vhost-scsi support $vhost_scsi"
>  echo "vhost-vsock support $vhost_vsock"
> +echo "vhost-user support $vhost_user"
>  echo "Trace backends    $trace_backends"
>  if have_backend "simple"; then
>  echo "Trace output file $trace_file-<pid>"
> @@ -5757,12 +5776,15 @@ fi
>  if test "$vhost_scsi" =3D "yes" ; then
>    echo "CONFIG_VHOST_SCSI=3Dy" >> $config_host_mak
>  fi
> -if test "$vhost_net" =3D "yes" ; then
> +if test "$vhost_net" =3D "yes" -a "$vhost_user" =3D "yes"; then
>    echo "CONFIG_VHOST_NET_USED=3Dy" >> $config_host_mak
>  fi
>  if test "$vhost_vsock" =3D "yes" ; then
>    echo "CONFIG_VHOST_VSOCK=3Dy" >> $config_host_mak
>  fi
> +if test "$vhost_user" =3D "yes" ; then
> +  echo "CONFIG_VHOST_USER=3Dy" >> $config_host_mak
> +fi
>  if test "$blobs" =3D "yes" ; then
>    echo "INSTALL_BLOBS=3Dyes" >> $config_host_mak
>  fi
> @@ -6358,7 +6380,9 @@ if supported_kvm_target $target; then
>      echo "CONFIG_KVM=3Dy" >> $config_target_mak
>      if test "$vhost_net" =3D "yes" ; then
>          echo "CONFIG_VHOST_NET=3Dy" >> $config_target_mak
> -        echo "CONFIG_VHOST_NET_TEST_$target_name=3Dy" >> $config_host_=
mak
> +        if test "$vhost_user" =3D "yes" ; then
> +            echo "CONFIG_VHOST_USER_NET_TEST_$target_name=3Dy" >> $con=
fig_host_mak
> +        fi
>      fi
>  fi
>  if supported_hax_target $target; then
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> index acaa70301a..a758630d30 100644
> --- a/default-configs/pci.mak
> +++ b/default-configs/pci.mak
> @@ -43,4 +43,4 @@ CONFIG_VGA=3Dy
>  CONFIG_VGA_PCI=3Dy
>  CONFIG_IVSHMEM_DEVICE=3D$(CONFIG_IVSHMEM)
>  CONFIG_ROCKER=3Dy
> -CONFIG_VHOST_USER_SCSI=3D$(CONFIG_LINUX)
> +CONFIG_VHOST_USER_SCSI=3D$(and $(CONFIG_VHOST_USER),$(CONFIG_LINUX))
> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-=
softmmu.mak
> index b227a36179..51191b77df 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -1,6 +1,6 @@
>  CONFIG_PCI=3Dy
>  CONFIG_VIRTIO_PCI=3Dy
> -CONFIG_VHOST_USER_SCSI=3D$(CONFIG_LINUX)
> +CONFIG_VHOST_USER_SCSI=3D$(and $(CONFIG_VHOST_USER),$(CONFIG_LINUX))

I have to say that I don't really like using $(and ...) in our makefiles
like this. You rely on the fact that the config variables are either set
to "y" or not set at all ... but if somebody ever tries to set
CONFIG_VHOST_USER=3Dn and CONFIG_LINUX=3Dy for example (which sounds vali=
d,
too), this will break. Isn't there a better way of checking that both
variables are set to "y" ?

 Thomas
