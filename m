Received: from eggs.gnu.org ([2001:4830:134:3::10]:35067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNfWa-0001C5-PX
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNfWZ-0007wY-Tm
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:22:56 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-16-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4f76d9d2-5c4b-a6ef-e050-9d9a1f31be85@amsat.org>
Date: Tue, 29 May 2018 11:22:46 -0300
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-16-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 15/35] usb: correctly handle Zero
 Length Packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 07/24/2017 03:27 PM, Philippe Mathieu-Daudé wrote:
> USB Specification Revision 2.0, §5.5.3:
>   The Data stage of a control transfer from an endpoint to the host is complete when the endpoint does one of the following:
>   • Has transferred exactly the amount of data specified during the Setup stage
>   • Transfers a packet with a payload size less than wMaxPacketSize or transfers a zero-length packet"
> 
> hw/usb/redirect.c:802:9: warning: Declared variable-length array (VLA) has zero size
>         uint8_t buf[size];
>         ^~~~~~~~~~~ ~~~~
> 
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/usb/redirect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index 5e42730449..5b7073d2cd 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -795,7 +795,7 @@ static void usbredir_handle_bulk_data(USBRedirDevice *dev, USBPacket *p,
>             usbredirparser_peer_has_cap(dev->parser,
>                                         usb_redir_cap_32bits_bulk_length));
>  
> -    if (ep & USB_DIR_IN) {
> +    if (ep & USB_DIR_IN || size == 0) {
>          usbredirparser_send_bulk_packet(dev->parser, p->id,
>                                          &bulk_packet, NULL, 0);
>      } else {
> 

Ping?
