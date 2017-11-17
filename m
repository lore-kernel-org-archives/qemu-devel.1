Received: from eggs.gnu.org ([2001:4830:134:3::10]:39252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFWeO-0002Wj-5z
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 21:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFWeJ-0007DI-9s
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 21:45:04 -0500
References: <1510867014-13423-1-git-send-email-thuth@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <03577b95-7387-6fc6-edfd-16aa78ecbd36@redhat.com>
Date: Fri, 17 Nov 2017 10:44:51 +0800
MIME-Version: 1.0
In-Reply-To: <1510867014-13423-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/net/eepro100: Fix endianness
 problem on big endian hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>, mst@redhat.com, qemu-s390x@nongnu.org



On 2017=E5=B9=B411=E6=9C=8817=E6=97=A5 05:16, Thomas Huth wrote:
> Since commit 1865e288a823c764cd4344d ("Fix eepro100 simple transmission
> mode"), the test/pxe-test is broken for the eepro100 device on big
> endian hosts. However, it seems like that commit did not introduce the
> problem, but just uncovered it: The EEPRO100State->tx.tbd_array_addr an=
d
> EEPRO100State->tx.tcb_bytes fields are already in host byte order, sinc=
e
> they have already been byte-swapped in the read_cb() function.
> Thus byte-swapping them in tx_command() again results in the wrong
> endianness. Removing the byte-swapping here fixes the pxe-test.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/net/eepro100.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index a63ed2c..03e00f7 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -756,8 +756,8 @@ static void read_cb(EEPRO100State *s)
>  =20
>   static void tx_command(EEPRO100State *s)
>   {
> -    uint32_t tbd_array =3D le32_to_cpu(s->tx.tbd_array_addr);
> -    uint16_t tcb_bytes =3D (le16_to_cpu(s->tx.tcb_bytes) & 0x3fff);
> +    uint32_t tbd_array =3D s->tx.tbd_array_addr;
> +    uint16_t tcb_bytes =3D s->tx.tcb_bytes & 0x3fff;
>       /* Sends larger than MAX_ETH_FRAME_SIZE are allowed, up to 2600 b=
ytes. */
>       uint8_t buf[2600];
>       uint16_t size =3D 0;

Applied.

Thanks
