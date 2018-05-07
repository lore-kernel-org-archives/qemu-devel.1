Received: from eggs.gnu.org ([2001:4830:134:3::10]:48967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFf9U-0003ge-G8
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFf9Q-00050t-H2
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:22:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFf9Q-0004zf-CG
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:21:56 -0400
Date: Mon, 7 May 2018 14:21:47 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180507122147.vvz4drashaxdoo7j@sirius.home.kraxel.org>
References: <fe730863e2af01b68c7086f2f1f74220@hostfission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe730863e2af01b68c7086f2f1f74220@hostfission.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] ps2: Clear the queue on PS/2 mouse
 reset and obey device disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: geoff@hostfission.com
Cc: qemu-devel@nongnu.org

On Mon, May 07, 2018 at 10:00:22PM +1000, geoff--- via Qemu-devel wrote:
> This allows guest's to correctly reinitialize and identify the mouse
> should the guest decide to re-scan or reset during mouse input events.
> 
> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>  hw/input/ps2.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index 06f5d2ac4a..6edf046820 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -673,6 +673,9 @@ static void ps2_mouse_sync(DeviceState *dev)
>  {
>      PS2MouseState *s = (PS2MouseState *)dev;
> 
> +    if (!(s->mouse_status & MOUSE_STATUS_ENABLED))
> +        return;
> +

Why this is needed?

> @@ -776,6 +779,7 @@ void ps2_write_mouse(void *opaque, int val)
>              s->mouse_resolution = 2;
>              s->mouse_status = 0;
>              s->mouse_type = 0;
> +            ps2_reset_queue(&s->common);

Looks good.

cheers,
  Gerd
