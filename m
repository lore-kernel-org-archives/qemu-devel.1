Received: from eggs.gnu.org ([2001:4830:134:3::10]:54553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1davm3-0000Bv-4E
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 23:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1davlz-000530-RY
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 23:17:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1davlz-00050y-G6
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 23:17:07 -0400
Date: Fri, 28 Jul 2017 06:09:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170728060441-mutt-send-email-mst@kernel.org>
References: <20170718163437.18001-1-marcandre.lureau@redhat.com>
	<20170726203933-mutt-send-email-mst@kernel.org>
	<CAJ+F1CLGn2Vj_DE_tyumTDH=UjCPKO-x+6yN9b3uPOw4U9Q4JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLGn2Vj_DE_tyumTDH=UjCPKO-x+6yN9b3uPOw4U9Q4JQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build-sys: add --disable-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

On Fri, Jul 28, 2017 at 01:31:31AM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Wed, Jul 26, 2017 at 7:53 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> >
> > On Tue, Jul 18, 2017 at 06:34:37PM +0200, Marc-Andr=E9 Lureau wrote:
> > > Learn to compile out vhost-user. Keep it enabled by default on
> > > non-mingw, that is assumed to be on POSIX.
> > >
> > > When trying to make a vhost-user netdev, it gives the following err=
or:
> > >
> > > -netdev vhost-user,id=3Dfoo,chardev=3Dchr-test: Parameter 'type' ex=
pects a netdev backend type
> > >
> > > And similar error with the HMP/QMP monitors.
> > >
> > > In the future, we may want to hide vhost-user from QAPI/introspecti=
on
> > > with conditional compilation, although the design of this hasn't be=
en
> > > fully fleshed out yet and shouldn't prevent this patch from being
> > > applied.
> > >
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >
> > After an offline discussion, looks like the idea is to be able to shi=
p a
> > cut down binary with less features (and e.g. smaller attack surface?)=
.
> >
> > Besides failing build on freebsd, this patch has too much ifdefery fo=
r
> > my taste. How about we patch just net/net.c?
> >
>=20
> The point with --disable-vhost-user was to remove all vhost-user code.

Does not seem to be worth the cost of all these ifdefs.

> For netdev vhost-user only,

Wouldn't we want to disable scsi as well?

> it would be as simple as
> removing/compiling out the line:
>=20
>        [NET_CLIENT_DRIVER_VHOST_USER] =3D net_init_vhost_user,

And I guess the help and tests as well?

> Not sure it's worth a configure option in this case.

Seems like a reasonable thing to do but up to you.

> >
> >
> > > ---
> > >  hw/net/vhost_net.c                | 12 ++++++++++--
> > >  hw/net/virtio-net.c               |  4 ++++
> > >  hw/virtio/virtio-pci.c            |  4 ++--
> > >  net/hub.c                         |  2 ++
> > >  net/net.c                         |  4 +++-
> > >  configure                         | 22 +++++++++++++++++++++-
> > >  default-configs/pci.mak           |  2 +-
> > >  default-configs/s390x-softmmu.mak |  2 +-
> > >  net/Makefile.objs                 |  2 +-
> > >  qemu-options.hx                   |  4 ++++
> > >  tests/Makefile.include            |  6 +++---
> > >  11 files changed, 52 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > > index e037db63a3..565a1cc99d 100644
> > > --- a/hw/net/vhost_net.c
> > > +++ b/hw/net/vhost_net.c
> > > @@ -56,6 +56,7 @@ static const int kernel_feature_bits[] =3D {
> > >      VHOST_INVALID_FEATURE_BIT
> > >  };
> > >
> > > +#ifdef CONFIG_VHOST_USER
> > >  /* Features supported by others. */
> > >  static const int user_feature_bits[] =3D {
> > >      VIRTIO_F_NOTIFY_ON_EMPTY,
> > > @@ -86,6 +87,7 @@ static const int user_feature_bits[] =3D {
> > >
> > >      VHOST_INVALID_FEATURE_BIT
> > >  };
> > > +#endif
> > >
> > >  static const int *vhost_net_get_feature_bits(struct vhost_net *net=
)
> > >  {
> > > @@ -95,9 +97,11 @@ static const int *vhost_net_get_feature_bits(str=
uct vhost_net *net)
> > >      case NET_CLIENT_DRIVER_TAP:
> > >          feature_bits =3D kernel_feature_bits;
> > >          break;
> > > +#ifdef CONFIG_VHOST_USER
> > >      case NET_CLIENT_DRIVER_VHOST_USER:
> > >          feature_bits =3D user_feature_bits;
> > >          break;
> > > +#endif
> > >      default:
> > >          error_report("Feature bits not defined for this type: %d",
> > >                  net->nc->info->type);
> > > @@ -193,6 +197,7 @@ struct vhost_net *vhost_net_init(VhostNetOption=
s *options)
> > >          }
> > >      }
> > >
> > > +#ifdef CONFIG_VHOST_USER
> > >      /* Set sane init value. Override when guest acks. */
> > >      if (net->nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_USER) {
> > >          features =3D vhost_user_get_acked_features(net->nc);
> > > @@ -203,7 +208,7 @@ struct vhost_net *vhost_net_init(VhostNetOption=
s *options)
> > >              goto fail;
> > >          }
> > >      }
> > > -
> > > +#endif
> > >      vhost_net_ack_features(net, features);
> > >
> > >      return net;
> > > @@ -309,6 +314,7 @@ int vhost_net_start(VirtIODevice *dev, NetClien=
tState *ncs,
> > >          net =3D get_vhost_net(ncs[i].peer);
> > >          vhost_net_set_vq_index(net, i * 2);
> > >
> > > +#ifdef CONFIG_VHOST_USER
> > >          /* Suppress the masking guest notifiers on vhost user
> > >           * because vhost user doesn't interrupt masking/unmasking
> > >           * properly.
> > > @@ -316,8 +322,8 @@ int vhost_net_start(VirtIODevice *dev, NetClien=
tState *ncs,
> > >          if (net->nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_USE=
R) {
> > >              dev->use_guest_notifier_mask =3D false;
> > >          }
> > > +#endif
> > >       }
> > > -
> > >      r =3D k->set_guest_notifiers(qbus->parent, total_queues * 2, t=
rue);
> > >      if (r < 0) {
> > >          error_report("Error binding guest notifier: %d", -r);
> > > @@ -414,10 +420,12 @@ VHostNetState *get_vhost_net(NetClientState *=
nc)
> > >      case NET_CLIENT_DRIVER_TAP:
> > >          vhost_net =3D tap_get_vhost_net(nc);
> > >          break;
> > > +#ifdef CONFIG_VHOST_USER
> > >      case NET_CLIENT_DRIVER_VHOST_USER:
> > >          vhost_net =3D vhost_user_get_vhost_net(nc);
> > >          assert(vhost_net);
> > >          break;
> > > +#endif
> > >      default:
> > >          break;
> > >      }
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 148071a396..9bda4ab4f8 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -524,9 +524,11 @@ static int peer_attach(VirtIONet *n, int index=
)
> > >          return 0;
> > >      }
> > >
> > > +#ifdef CONFIG_VHOST_USER
> > >      if (nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_USER) =
{
> > >          vhost_set_vring_enable(nc->peer, 1);
> > >      }
> > > +#endif
> > >
> > >      if (nc->peer->info->type !=3D NET_CLIENT_DRIVER_TAP) {
> > >          return 0;
> > > @@ -547,9 +549,11 @@ static int peer_detach(VirtIONet *n, int index=
)
> > >          return 0;
> > >      }
> > >
> > > +#ifdef CONFIG_VHOST_USER
> > >      if (nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_USER) =
{
> > >          vhost_set_vring_enable(nc->peer, 0);
> > >      }
> > > +#endif
> > >
> > >      if (nc->peer->info->type !=3D  NET_CLIENT_DRIVER_TAP) {
> > >          return 0;
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index 5d14bd66dc..85b82e6c94 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -2135,7 +2135,7 @@ static const TypeInfo vhost_scsi_pci_info =3D=
 {
> > >  };
> > >  #endif
> > >
> > > -#ifdef CONFIG_LINUX
> > > +#ifdef CONFIG_VHOST_USER
> > >  /* vhost-user-scsi-pci */
> > >  static Property vhost_user_scsi_pci_properties[] =3D {
> > >      DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> > > @@ -2665,7 +2665,7 @@ static void virtio_pci_register_types(void)
> > >  #ifdef CONFIG_VHOST_SCSI
> > >      type_register_static(&vhost_scsi_pci_info);
> > >  #endif
> > > -#ifdef CONFIG_LINUX
> > > +#ifdef CONFIG_VHOST_USER
> > >      type_register_static(&vhost_user_scsi_pci_info);
> > >  #endif
> > >  #ifdef CONFIG_VHOST_VSOCK
> > > diff --git a/net/hub.c b/net/hub.c
> > > index 32d8cf5cd4..ec06275ff6 100644
> > > --- a/net/hub.c
> > > +++ b/net/hub.c
> > > @@ -322,7 +322,9 @@ void net_hub_check_clients(void)
> > >              case NET_CLIENT_DRIVER_TAP:
> > >              case NET_CLIENT_DRIVER_SOCKET:
> > >              case NET_CLIENT_DRIVER_VDE:
> > > +#ifdef CONFIG_VHOST_USER
> > >              case NET_CLIENT_DRIVER_VHOST_USER:
> > > +#endif
> > >                  has_host_dev =3D 1;
> > >                  break;
> > >              default:
> > > diff --git a/net/net.c b/net/net.c
> > > index 0e28099554..d11909421c 100644
> > > --- a/net/net.c
> > > +++ b/net/net.c
> > > @@ -957,7 +957,7 @@ static int (* const net_client_init_fun[NET_CLI=
ENT_DRIVER__MAX])(
> > >          [NET_CLIENT_DRIVER_BRIDGE]    =3D net_init_bridge,
> > >  #endif
> > >          [NET_CLIENT_DRIVER_HUBPORT]   =3D net_init_hubport,
> > > -#ifdef CONFIG_VHOST_NET_USED
> > > +#if defined(CONFIG_VHOST_NET_USED) && defined(CONFIG_VHOST_USER)
> > >          [NET_CLIENT_DRIVER_VHOST_USER] =3D net_init_vhost_user,
> > >  #endif
> > >  #ifdef CONFIG_L2TPV3
> > > @@ -1033,10 +1033,12 @@ static int net_client_init1(const void *obj=
ect, bool is_netdev, Error **errp)
> > >              legacy.type =3D NET_CLIENT_DRIVER_NETMAP;
> > >              legacy.u.netmap =3D opts->u.netmap;
> > >              break;
> > > +#ifdef CONFIG_VHOST_USER
> > >          case NET_LEGACY_OPTIONS_TYPE_VHOST_USER:
> > >              legacy.type =3D NET_CLIENT_DRIVER_VHOST_USER;
> > >              legacy.u.vhost_user =3D opts->u.vhost_user;
> > >              break;
> > > +#endif
> > >          default:
> > >              abort();
> > >          }
> > > diff --git a/configure b/configure
> > > index a3f0522e8f..defb9e9974 100755
> > > --- a/configure
> > > +++ b/configure
> > > @@ -306,6 +306,7 @@ tcg=3D"yes"
> > >  vhost_net=3D"no"
> > >  vhost_scsi=3D"no"
> > >  vhost_vsock=3D"no"
> > > +vhost_user=3D""
> > >  kvm=3D"no"
> > >  hax=3D"no"
> > >  rdma=3D""
> > > @@ -1283,6 +1284,10 @@ for opt do
> > >    ;;
> > >    --enable-vxhs) vxhs=3D"yes"
> > >    ;;
> > > +  --disable-vhost-user) vhost_user=3D"no"
> > > +  ;;
> > > +  --enable-vhost-user) vhost_user=3D"yes"
> > > +  ;;
> > >    *)
> > >        echo "ERROR: unknown option $opt"
> > >        echo "Try '$0 --help' for more information"
> > > @@ -1291,6 +1296,14 @@ for opt do
> > >    esac
> > >  done
> > >
> > > +if test "$vhost_user" =3D ""; then
> > > +    if test "$mingw32" =3D "yes" ; then
> > > +        vhost_user=3D"no"
> > > +    else
> > > +        vhost_user=3D"yes"
> > > +    fi
> > > +fi
> > > +
> > >  case "$cpu" in
> > >      ppc)
> > >             CPU_CFLAGS=3D"-m32"
> > > @@ -1518,6 +1531,7 @@ disabled with --disable-FEATURE, default is e=
nabled if available:
> > >    qom-cast-debug  cast debugging support
> > >    tools           build qemu-io, qemu-nbd and qemu-image tools
> > >    vxhs            Veritas HyperScale vDisk backend support
> > > +  vhost-user      vhost-user support
> > >
> > >  NOTE: The object files are built at the place where configure is l=
aunched
> > >  EOF
> > > @@ -5278,6 +5292,7 @@ echo "libcap-ng support $cap_ng"
> > >  echo "vhost-net support $vhost_net"
> > >  echo "vhost-scsi support $vhost_scsi"
> > >  echo "vhost-vsock support $vhost_vsock"
> > > +echo "vhost-user support $vhost_user"
> > >  echo "Trace backends    $trace_backends"
> > >  if have_backend "simple"; then
> > >  echo "Trace output file $trace_file-<pid>"
> > > @@ -5696,6 +5711,9 @@ fi
> > >  if test "$vhost_vsock" =3D "yes" ; then
> > >    echo "CONFIG_VHOST_VSOCK=3Dy" >> $config_host_mak
> > >  fi
> > > +if test "$vhost_user" =3D "yes" ; then
> > > +  echo "CONFIG_VHOST_USER=3Dy" >> $config_host_mak
> > > +fi
> > >  if test "$blobs" =3D "yes" ; then
> > >    echo "INSTALL_BLOBS=3Dyes" >> $config_host_mak
> > >  fi
> > > @@ -6279,7 +6297,9 @@ if supported_kvm_target $target; then
> > >      echo "CONFIG_KVM=3Dy" >> $config_target_mak
> > >      if test "$vhost_net" =3D "yes" ; then
> > >          echo "CONFIG_VHOST_NET=3Dy" >> $config_target_mak
> > > -        echo "CONFIG_VHOST_NET_TEST_$target_name=3Dy" >> $config_h=
ost_mak
> > > +        if test "$vhost_user" =3D "yes" ; then
> > > +            echo "CONFIG_VHOST_USER_NET_TEST_$target_name=3Dy" >> =
$config_host_mak
> > > +        fi
> > >      fi
> > >  fi
> > >  if supported_hax_target $target; then
> > > diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> > > index 53ff10975c..708d7b19ad 100644
> > > --- a/default-configs/pci.mak
> > > +++ b/default-configs/pci.mak
> > > @@ -43,4 +43,4 @@ CONFIG_VGA=3Dy
> > >  CONFIG_VGA_PCI=3Dy
> > >  CONFIG_IVSHMEM=3D$(CONFIG_EVENTFD)
> > >  CONFIG_ROCKER=3Dy
> > > -CONFIG_VHOST_USER_SCSI=3D$(CONFIG_LINUX)
> > > +CONFIG_VHOST_USER_SCSI=3D$(CONFIG_VHOST_USER)
> > > diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s3=
90x-softmmu.mak
> > > index b227a36179..bb870477f8 100644
> > > --- a/default-configs/s390x-softmmu.mak
> > > +++ b/default-configs/s390x-softmmu.mak
> > > @@ -1,6 +1,6 @@
> > >  CONFIG_PCI=3Dy
> > >  CONFIG_VIRTIO_PCI=3Dy
> > > -CONFIG_VHOST_USER_SCSI=3D$(CONFIG_LINUX)
> > > +CONFIG_VHOST_USER_SCSI=3D$(CONFIG_VHOST_USER)
> > >  CONFIG_VIRTIO=3Dy
> > >  CONFIG_SCLPCONSOLE=3Dy
> > >  CONFIG_TERMINAL3270=3Dy
> > > diff --git a/net/Makefile.objs b/net/Makefile.objs
> > > index 67ba5e26fb..7cac7ed1e4 100644
> > > --- a/net/Makefile.objs
> > > +++ b/net/Makefile.objs
> > > @@ -3,7 +3,7 @@ common-obj-y +=3D socket.o
> > >  common-obj-y +=3D dump.o
> > >  common-obj-y +=3D eth.o
> > >  common-obj-$(CONFIG_L2TPV3) +=3D l2tpv3.o
> > > -common-obj-$(CONFIG_POSIX) +=3D vhost-user.o
> > > +common-obj-$(CONFIG_VHOST_USER) +=3D vhost-user.o
> > >  common-obj-$(CONFIG_SLIRP) +=3D slirp.o
> > >  common-obj-$(CONFIG_VDE) +=3D vde.o
> > >  common-obj-$(CONFIG_NETMAP) +=3D netmap.o
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 746b5fa75d..c2d4ae440f 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -1994,8 +1994,10 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
> > >      "                VALE port (created on the fly) called 'name' =
('nmname' is name of the \n"
> > >      "                netmap device, defaults to '/dev/netmap')\n"
> > >  #endif
> > > +#ifdef CONFIG_VHOST_USER
> > >      "-netdev vhost-user,id=3Dstr,chardev=3Ddev[,vhostforce=3Don|of=
f]\n"
> > >      "                configure a vhost-user network, backed by a c=
hardev 'dev'\n"
> > > +#endif
> > >      "-netdev hubport,id=3Dstr,hubid=3Dn\n"
> > >      "                configure a hub port on QEMU VLAN 'n'\n", QEM=
U_ARCH_ALL)
> > >  DEF("net", HAS_ARG, QEMU_OPTION_net,
> > > @@ -2428,6 +2430,7 @@ The hubport netdev lets you connect a NIC to =
a QEMU "vlan" instead of a single
> > >  netdev.  @code{-net} and @code{-device} with parameter @option{vla=
n} create the
> > >  required hub automatically.
> > >
> > > +#ifdef CONFIG_VHOST_USER
> > >  @item -netdev vhost-user,chardev=3D@var{id}[,vhostforce=3Don|off][=
,queues=3Dn]
> > >
> > >  Establish a vhost-user netdev, backed by a chardev @var{id}. The c=
hardev should
> > > @@ -2445,6 +2448,7 @@ qemu -m 512 -object memory-backend-file,id=3D=
mem,size=3D512M,mem-path=3D/hugetlbfs,sha
> > >       -netdev type=3Dvhost-user,id=3Dnet0,chardev=3Dchr0 \
> > >       -device virtio-net-pci,netdev=3Dnet0
> > >  @end example
> > > +#endif
> > >
> > >  @item -net dump[,vlan=3D@var{n}][,file=3D@var{file}][,len=3D@var{l=
en}]
> > >  Dump network traffic on VLAN @var{n} to file @var{file} (@file{qem=
u-vlan0.pcap} by default).
> > > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > > index cfbb689e0e..6b9a0ce07e 100644
> > > --- a/tests/Makefile.include
> > > +++ b/tests/Makefile.include
> > > @@ -252,9 +252,9 @@ check-qtest-i386-y +=3D tests/pc-cpu-test$(EXES=
UF)
> > >  check-qtest-i386-y +=3D tests/q35-test$(EXESUF)
> > >  check-qtest-i386-y +=3D tests/vmgenid-test$(EXESUF)
> > >  gcov-files-i386-y +=3D hw/pci-host/q35.c
> > > -check-qtest-i386-$(CONFIG_VHOST_NET_TEST_i386) +=3D tests/vhost-us=
er-test$(EXESUF)
> > > -ifeq ($(CONFIG_VHOST_NET_TEST_i386),)
> > > -check-qtest-x86_64-$(CONFIG_VHOST_NET_TEST_x86_64) +=3D tests/vhos=
t-user-test$(EXESUF)
> > > +check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) +=3D tests/vho=
st-user-test$(EXESUF)
> > > +ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
> > > +check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) +=3D tests=
/vhost-user-test$(EXESUF)
> > >  endif
> > >  check-qtest-i386-y +=3D tests/test-netfilter$(EXESUF)
> > >  check-qtest-i386-y +=3D tests/test-filter-mirror$(EXESUF)
> > > --
> > > 2.14.0.rc0.1.g40ca67566
> >
