Received: from eggs.gnu.org ([2001:4830:134:3::10]:60175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFY3M-0001iB-Ez
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 23:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFY3J-0001mD-AW
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 23:14:56 -0500
Date: Fri, 17 Nov 2017 06:14:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171117061341-mutt-send-email-mst@kernel.org>
References: <1510867014-13423-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510867014-13423-1-git-send-email-thuth@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>, Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>, qemu-s390x@nongnu.org

On Thu, Nov 16, 2017 at 10:16:54PM +0100, Thomas Huth wrote:
> Since commit 1865e288a823c764cd4344d ("Fix eepro100 simple transmission
> mode"), the test/pxe-test is broken for the eepro100 device on big
> endian hosts. However, it seems like that commit did not introduce the
> problem, but just uncovered it: The EEPRO100State->tx.tbd_array_addr and
> EEPRO100State->tx.tcb_bytes fields are already in host byte order, since
> they have already been byte-swapped in the read_cb() function.
> Thus byte-swapping them in tx_command() again results in the wrong
> endianness. Removing the byte-swapping here fixes the pxe-test.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Thomas, how about adding sparse endian-ness annotations
a la le32 in Linux? We could then use static checkers to
catch these bugs at build time.

> ---
>  hw/net/eepro100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index a63ed2c..03e00f7 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -756,8 +756,8 @@ static void read_cb(EEPRO100State *s)
>  
>  static void tx_command(EEPRO100State *s)
>  {
> -    uint32_t tbd_array = le32_to_cpu(s->tx.tbd_array_addr);
> -    uint16_t tcb_bytes = (le16_to_cpu(s->tx.tcb_bytes) & 0x3fff);
> +    uint32_t tbd_array = s->tx.tbd_array_addr;
> +    uint16_t tcb_bytes = s->tx.tcb_bytes & 0x3fff;
>      /* Sends larger than MAX_ETH_FRAME_SIZE are allowed, up to 2600 bytes. */
>      uint8_t buf[2600];
>      uint16_t size = 0;
> -- 
> 1.8.3.1
