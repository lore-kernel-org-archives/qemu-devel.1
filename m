Received: from eggs.gnu.org ([2001:4830:134:3::10]:60624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cJ126-0005DT-6t
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:43:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cJ120-0001vd-3C
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:43:26 -0500
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:33510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cJ11z-0001uC-S0
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:43:20 -0500
Received: by mail-yw0-x243.google.com with SMTP id s68so9039474ywg.0
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 08:43:17 -0800 (PST)
MIME-Version: 1.0
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 19 Dec 2016 16:43:06 +0000
Message-ID: <CAJ+F1CKWSznG3hxj0=F1UAJD+ZOZg=q+Oio1YnbsRyz6vy51FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RESEND Patch v1 00/37] Implementation of
 vhost-pci for inter-vm commucation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

Hi Wei,

On Mon, Dec 19, 2016 at 7:00 AM Wei Wang <wei.w.wang@intel.com> wrote:

> This patch series implements vhost-pci, which is a point-to-point based
> inter-vm
> communication solution. The QEMU side implementation includes the
> vhost-user
> extension, vhost-pci device emulation and management. The current device
> part
> implementation is based on virtio 1.0, but it can be easily upgraded to
> support
> the upcoming virtio 1.1.
>
> The current QEMU implementation supports the polling mode driver on both
> sides
> to receive packets. More features, such as interrupt support, live
> migration
> support, protected memory accesses will be added later.
>


I highly appreciate the effort you put in splitting the patch series and
commenting each, although some are probably superfluous. Before going into
details, I suppose you have kernel side bits too. I'd suggest before
sending individual patches for review, that you send a RFC with links to
the various git trees and instructions to test the proposed device. This
would really help things and potentially bring more people for testing and
comments (think about libvirt side etc). Even better would be to have some
tests (with qtest).

High level question, why do you need to create device dynamically? I would
rather have the following qemu setup:

-chardev socket,id=3Dchr,path=3D.. -device vhost-pci-net,chardev=3Dchr

This would also avoid some global state (vp_slave etc)

Regarding the protocol changes to support slave request: I tried to
explained that before, apprently I didn't manage to. It is not enough to
support bidirectionnal communications to simply add chardev frontend
handlers. Until now, qemu's code expects an immediate reply after a
request. With your protocol change, it must now also consider that the
slave may send a request before the master request reaches the slave
handler. So all req/reply write()/read() must now handle in between
requests from slave to be race-free (master can read back a request when it
expects a reply). That's not really trivial change, that's why I proposed
to have a secondary channel for slave->master communications in the past.
Not only would this be easier to implement, but the protocol documentation
would also be simpler, the cost is simply 1 additional unix socket (that I
proposed to setup and pass with ancilliary data on the main channel).

Another question, what are vpnet->rqs used for?


> RESEND change: Fixed some coding style issue
>

there are some spelling to be fixed, and perhaps some variables/fields to
rename  (asyn -> async, crq -> ctrlq?) That can be addressed in a detailed
review.

>
> Wei Wang (37):
>   vhost-pci-net: the fundamental vhost-pci-net device emulation
>   vhost-pci-net: the fundamental implementation of vhost-pci-net-pci
>   vhost-user: share the vhost-user protocol related structures
>   vl: add the vhost-pci-slave command line option
>   vhost-pci-slave: start the implementation of vhost-pci-slave
>   vhost-pci-slave: set up the fundamental handlers for the server socket
>   vhost-pci-slave/msg: VHOST_USER_GET_FEATURES
>   vhost-pci-slave/msg: VHOST_USER_SET_FEATURES
>   vhost-pci-slave/msg: VHOST_USER_GET_PROTOCOL_FEATURES
>   vhost-pci-slave/msg: VHOST_USER_SET_PROTOCOL_FEATURES
>   vhost-user/msg: VHOST_USER_PROTOCOL_F_SET_DEVICE_ID
>   vhost-pci-slave/msg: VHOST_USER_SET_DEVICE_ID
>   vhost-pci-slave/msg: VHOST_USER_GET_QUEUE_NUM
>   vhost-pci-slave/msg: VHOST_USER_SET_OWNER
>   vhost-pci-slave/msg: VHOST_USER_SET_MEM_TABLE
>   vhost-pci-slave/msg: VHOST_USER_SET_VRING_NUM
>   vhost-pci-slave/msg: VHOST_USER_SET_VRING_BASE
>   vhost-user: send guest physical address of virtqueues to the slave
>   vhost-pci-slave/msg: VHOST_USER_SET_VRING_ADDR
>   vhost-pci-slave/msg: VHOST_USER_SET_VRING_KICK
>   vhost-pci-slave/msg: VHOST_USER_SET_VRING_CALL
>   vhost-pci-slave/msg: VHOST_USER_SET_VRING_ENABLE
>   vhost-pci-slave/msg: VHOST_USER_SET_LOG_BASE
>   vhost-pci-slave/msg: VHOST_USER_SET_LOG_FD
>   vhost-pci-slave/msg: VHOST_USER_SEND_RARP
>   vhost-pci-slave/msg: VHOST_USER_GET_VRING_BASE
>   vhost-pci-net: pass the info collected by vp_slave to the device
>   vhost-pci-net: pass the mem and vring info to the driver
>   vhost-pci-slave/msg: VHOST_USER_SET_VHOST_PCI (start)
>   vhost-pci-slave/msg: VHOST_USER_SET_VHOST_PCI (stop)
>   vhost-user/msg: send VHOST_USER_SET_VHOST_PCI (start/stop)
>   vhost-user: add asynchronous read for the vhost-user master
>   vhost-pci-net: send the negotiated feature bits to the master
>   vhost-pci-slave: add "peer_reset"
>   vhost-pci-net: start the vhost-pci-net device
>   vhost-user/msg: handling VHOST_USER_SET_FEATURES
>   vl: enable vhost-pci-slave
>
>  hw/net/Makefile.objs                           |   2 +-
>  hw/net/vhost-pci-net.c                         | 268 ++++++++++++
>  hw/net/vhost_net.c                             |  39 ++
>  hw/virtio/Makefile.objs                        |   1 +
>  hw/virtio/vhost-pci-slave.c                    | 570
> +++++++++++++++++++++++++
>  hw/virtio/vhost-user.c                         | 187 ++++----
>  hw/virtio/vhost.c                              |  64 ++-
>  hw/virtio/virtio-pci.c                         |  80 ++++
>  hw/virtio/virtio-pci.h                         |  16 +
>  include/hw/pci/pci.h                           |   1 +
>  include/hw/virtio/vhost-backend.h              |   2 +
>  include/hw/virtio/vhost-pci-net.h              |  45 ++
>  include/hw/virtio/vhost-pci-slave.h            |  46 ++
>  include/hw/virtio/vhost-user.h                 | 109 +++++
>  include/hw/virtio/vhost.h                      |   3 +
>  include/net/vhost-user.h                       |  22 +-
>  include/net/vhost_net.h                        |   2 +
>  include/standard-headers/linux/vhost_pci_net.h |  85 ++++
>  include/standard-headers/linux/virtio_ids.h    |  29 +-
>  net/vhost-user.c                               |  37 +-
>  qemu-options.hx                                |   4 +
>  vl.c                                           |  43 ++
>  22 files changed, 1520 insertions(+), 135 deletions(-)
>  create mode 100644 hw/net/vhost-pci-net.c
>  create mode 100644 hw/virtio/vhost-pci-slave.c
>  create mode 100644 include/hw/virtio/vhost-pci-net.h
>  create mode 100644 include/hw/virtio/vhost-pci-slave.h
>  create mode 100644 include/hw/virtio/vhost-user.h
>  create mode 100644 include/standard-headers/linux/vhost_pci_net.h
>
> --
> 2.7.4
>
> --
Marc-Andr=C3=A9 Lureau
