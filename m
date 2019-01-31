Received: from eggs.gnu.org ([209.51.188.92]:41387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gp7GG-00019w-4t
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gp7GE-0004gE-32
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:59:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gp7GD-0004dB-T2
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:59:46 -0500
Date: Thu, 31 Jan 2019 08:59:37 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190131075937.hdyiqviwpf35qkpm@sirius.home.kraxel.org>
References: <1548859022-3969-1-git-send-email-liam.merwick@oracle.com>
	<1548859022-3969-2-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548859022-3969-2-git-send-email-liam.merwick@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] usb: rearrange usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: qemu-devel@nongnu.org, Darren.Kenny@oracle.com, Mark.Kanda@oracle.com, ameya.more@oracle.com

On Wed, Jan 30, 2019 at 02:37:01PM +0000, Liam Merwick wrote:
> There is no need to calculate the 'eps' variable in usb_ep_get()
> if 'ep' is the control endpoint.  Instead the calculation should
> be done after validating the input and the resulting pointer also
> validated before returning an entry indexed on the endpoint 'ep'.
> 
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
> Reviewed-by: Ameya More <ameya.more@oracle.com>
> ---
>  hw/usb/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/usb/core.c b/hw/usb/core.c
> index 241ae66b1505..1aa0051b2b2d 100644
> --- a/hw/usb/core.c
> +++ b/hw/usb/core.c
> @@ -720,12 +720,13 @@ struct USBEndpoint *usb_ep_get(USBDevice *dev, int pid, int ep)
>      if (dev == NULL) {
>          return NULL;
>      }
> -    eps = (pid == USB_TOKEN_IN) ? dev->ep_in : dev->ep_out;
>      if (ep == 0) {
>          return &dev->ep_ctl;
>      }
>      assert(pid == USB_TOKEN_IN || pid == USB_TOKEN_OUT);
>      assert(ep > 0 && ep <= USB_MAX_ENDPOINTS);
> +    eps = (pid == USB_TOKEN_IN) ? dev->ep_in : dev->ep_out;
> +    assert(eps != NULL);

That assert is rather pointless.  It's impossible for eps to be NULL at
this point.

cheers,
  Gerd
