Received: from eggs.gnu.org ([209.51.188.92]:52932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZVT-0002Jh-8o
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZNB-0007j6-My
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:29:06 -0400
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<f2aaec5b3c12a8512cd7078f3a5d1230906d80ea.1556650594.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <900dab1c-d200-18fa-530b-43c3d6f017a5@vivier.eu>
Date: Tue, 30 Apr 2019 22:28:45 +0200
MIME-Version: 1.0
In-Reply-To: <f2aaec5b3c12a8512cd7078f3a5d1230906d80ea.1556650594.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 3/5] hw/usb/dev-mtp: Fix GCC 9 build
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

Le 30/04/2019 à 22:09, Alistair Francis a écrit :
> Fix this warning with GCC 9 on Fedora 30:
> hw/usb/dev-mtp.c:1715:36: error: taking address of packed member of ‘struct <anonymous>’ may result in an unaligned pointer value [-Werror=address-of-packed-member]
>  1715 |                             dataset->filename);
>       |                             ~~~~~~~^~~~~~~~~~
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/usb/dev-mtp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 99548b012d..6de85d99e6 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1711,9 +1711,22 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
>      assert(!s->write_pending);
>      assert(p != NULL);
>  
> +/*
> + * We are about to access a packed struct. We are confident that the pointer
> + * address won't be unalligned, so we ignore GCC warnings.
> + */
> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9, 0)
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
> +#endif
> +
>      filename = utf16_to_str(MIN(dataset->length, filename_chars),
>                              dataset->filename);
>  
> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9, 0)
> +#pragma GCC diagnostic pop
> +#endif
> +
>      if (strchr(filename, '/')) {
>          usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
>                               0, 0, 0, 0);
> 

You should move and use PRAGMA_DISABLE_PACKED_WARNING and
PRAGMA_REENABLE_PACKED_WARNING from linux-user/qemu.h.

It has laready been very well tested :)

Thanks,
Laurent
