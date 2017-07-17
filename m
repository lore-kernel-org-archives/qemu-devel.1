Received: from eggs.gnu.org ([2001:4830:134:3::10]:35177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dX9YJ-0006KE-9C
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dX9YE-0005Hi-JK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:11:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170717151334.17954-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <64dc6715-c032-3e74-4eb8-f00b10e9c968@amsat.org>
Date: Mon, 17 Jul 2017 14:11:03 -0300
MIME-Version: 1.0
In-Reply-To: <20170717151334.17954-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] usb: Fix build with newer
 gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, dgilbert@redhat.com, kraxel@redhat.com

On 07/17/2017 12:13 PM, Eric Blake wrote:
> gcc 7 is pickier about our sources:
> 
> hw/usb/bus.c: In function ‘usb_port_location’:
> hw/usb/bus.c:410:66: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size between 0 and 15 [-Werror=format-truncation=]
>           snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
>                                                                    ^~
> hw/usb/bus.c:410:9: note: ‘snprintf’ output between 3 and 28 bytes into a destination of size 16
>           snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                    upstream->path, portnr);
>                    ~~~~~~~~~~~~~~~~~~~~~~~
> 
> But we know that there are at most 5 levels of USB hubs, with at
> most two digits per level; that plus the separating dots means we
> use at most 15 bytes (including trailing NUL) of our 16-byte field.
> Adding an assertion to show gcc that we checked for truncation is
> enough to shut up the false-positive warning.
> 
> Inspired by an idea by Dr. David Alan Gilbert <dgilbert@redhat.com>.

elegant :)

> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/usb/bus.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index 5939b273b9..d910f849e7 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -407,8 +407,10 @@ void usb_register_companion(const char *masterbus, USBPort *ports[],
>   void usb_port_location(USBPort *downstream, USBPort *upstream, int portnr)
>   {
>       if (upstream) {
> -        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
> -                 upstream->path, portnr);
> +        int l = snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
> +                         upstream->path, portnr);
> +        /* Max string is nn.nn.nn.nn.nn, which fits in 16 bytes */
> +        assert(l < sizeof(downstream->path));
>           downstream->hubcount = upstream->hubcount + 1;
>       } else {
>           snprintf(downstream->path, sizeof(downstream->path), "%d", portnr);
> 
