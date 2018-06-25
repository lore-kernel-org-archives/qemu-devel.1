Received: from eggs.gnu.org ([2001:4830:134:3::10]:44143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXTQz-0005S7-MX
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXTQw-0000iI-0Z
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:29:41 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fXTQv-0000he-IB
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:29:37 -0400
Received: by mail-ed1-x542.google.com with SMTP id c1-v6so5666271edt.2
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:29:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625112204.GH18580@redhat.com>
References: <20180625110706.23332-1-sameeh@daynix.com>
	<20180625110706.23332-3-sameeh@daynix.com>
	<20180625112204.GH18580@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 25 Jun 2018 18:29:35 +0300
Message-ID: <CAKPgXcGq=CDGOPUDh2cFTHFAUcMa6KkXHWH+gJH6aUErRMJ3QQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 2/2] virtio-net: Example Patch for using
 BPF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, Amnon Ilan <ailan@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Mon, Jun 25, 2018 at 2:22 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om>
wrote:

> On Mon, Jun 25, 2018 at 02:07:06PM +0300, Sameeh Jubran wrote:
> > From: Sameeh Jubran <sjubran@redhat.com>
> >
> > This commit is a sample only for using the libbpf in the code and
> > shouldn't be committed.
> >
> > Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> > ---
> >  hw/net/Makefile.objs | 4 ++++
> >  hw/net/virtio-net.c  | 4 ++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> > index fa461d4463..0fb271436d 100644
> > --- a/hw/net/Makefile.objs
> > +++ b/hw/net/Makefile.objs
> > @@ -37,6 +37,10 @@ obj-$(CONFIG_PSERIES) +=3D spapr_llan.o
> >  obj-$(CONFIG_XILINX_ETHLITE) +=3D xilinx_ethlite.o
> >
> >  obj-$(CONFIG_VIRTIO_NET) +=3D virtio-net.o
> > +ifeq ($(CONFIG_BPF),y)
> > +     virtio-net.o-cflags :=3D $(CFLAGS_BPF)
> > +     virtio-net.o-libs :=3D $(LIBS_BPF)
> > +endif
> >  obj-y +=3D vhost_net.o
> >
> >  obj-$(CONFIG_ETSEC) +=3D fsl_etsec/etsec.o fsl_etsec/registers.o \
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 90502fca7c..b4840838c1 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -27,6 +27,7 @@
> >  #include "hw/virtio/virtio-access.h"
> >  #include "migration/misc.h"
> >  #include "standard-headers/linux/ethtool.h"
> > +#include "standard-headers/linux/libbpf.h"
> >
> >  #define VIRTIO_NET_VM_VERSION    11
> >
> > @@ -1329,6 +1330,9 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue
> *q)
> >      VirtQueueElement *elem;
> >      int32_t num_packets =3D 0;
> >      int queue_index =3D vq2q(virtio_get_queue_index(q->tx_vq));
> > +
> > +    struct bpf_object *obj =3D NULL;
> > +    bpf_object__load(obj);
>
> This really doesn't tell us anything useful about how this will be
> used and integrated in qemu. I'd expect this patch to actually
> be doing a real feature complete impl of RSS for virtio-net.
>
No problem, I'll be sending the full series ASAP,
Thanks :)

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>



--=20
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
