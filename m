Received: from eggs.gnu.org ([209.51.188.92]:37370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gloEr-0007no-OD
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gloEq-0008B4-Uq
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:04:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gloEq-00088h-PV
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:04:40 -0500
Date: Tue, 22 Jan 2019 00:04:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190122000421-mutt-send-email-mst@kernel.org>
References: <20190121181030.2112-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190121181030.2112-1-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-net: Fix VirtIONet typedef
 redefinition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, Thomas Huth <thuth@redhat.com>, Wei Xu <wexu@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Mon, Jan 21, 2019 at 07:10:30PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Commit 2974e916df8 introduced the VirtioNetRscChain structure which
> refer to a VirtIONet, declared later, thus required VirtIONet typedef
> to be declarated forward.
> However, when compiling with Clang in -std=3Dgnu99 mode, this triggers
> the following warning/error:
>=20
>     CC      hw/net/virtio-net.o
>   In file included from qemu/hw/net/virtio-net.c:22:
>   include/hw/virtio/virtio-net.h:189:3: error: redefinition of typedef =
'VirtIONet' is a C11 feature [-Werror,-Wtypedef-redefinition]
>   } VirtIONet;
>     ^
>   include/hw/virtio/virtio-net.h:110:26: note: previous definition is h=
ere
>   typedef struct VirtIONet VirtIONet;
>                            ^
>   1 error generated.
>   make: *** [rules.mak:69: hw/net/virtio-net.o] Error 1
>=20
> Fix it by removing the duplicate typedef definition.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/hw/virtio/virtio-net.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
> index c7ec1a755f..bd662752d2 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -106,7 +106,6 @@ typedef struct VirtioNetRscSeg {
>      NetClientState *nc;
>  } VirtioNetRscSeg;
> =20
> -struct VirtIONet;
>  typedef struct VirtIONet VirtIONet;
> =20
>  /* Chain is divided by protocol(ipv4/v6) and NetClientInfo */
> @@ -136,7 +135,7 @@ typedef struct VirtIONetQueue {
>      struct VirtIONet *n;
>  } VirtIONetQueue;
> =20
> -typedef struct VirtIONet {
> +struct VirtIONet {
>      VirtIODevice parent_obj;
>      uint8_t mac[ETH_ALEN];
>      uint16_t status;
> @@ -186,7 +185,7 @@ typedef struct VirtIONet {
>      int announce_counter;
>      bool needs_vnet_hdr_swap;
>      bool mtu_bypass_backend;
> -} VirtIONet;
> +};
> =20
>  void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
>                                     const char *type);
> --=20
> 2.20.1
