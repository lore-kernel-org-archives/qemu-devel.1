Received: from eggs.gnu.org ([2001:4830:134:3::10]:50849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTsg5-0005Di-G5
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:10:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTsg0-0003C2-Hk
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:10:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8599)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gTsg0-0003BM-BQ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:10:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181203101045.27976-1-kraxel@redhat.com>
	<20181203101045.27976-2-kraxel@redhat.com>
Date: Mon, 03 Dec 2018 19:10:33 +0100
In-Reply-To: <20181203101045.27976-2-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Mon, 3 Dec 2018 11:10:44 +0100")
Message-ID: <87d0qio50m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v3 1/2] usb-mtp: fix utf16_to_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, public@hansmi.ch

Gerd Hoffmann <kraxel@redhat.com> writes:

> Make utf16_to_str return an allocated string.  Remove the assumtion that
> the number of string bytes equals the number of utf16 chars (which is
> only true for ascii chars).  Instead call wcstombs twice, once to figure
> the storage size and once for the actual conversion (as suggested by the
> wcstombs manpage).
>
> Reported-by: Michael Hanselmann <public@hansmi.ch>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 00a3691bae..0f6a9702ef 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1593,17 +1593,23 @@ static void usb_mtp_cancel_packet(USBDevice *dev, USBPacket *p)
>      fprintf(stderr, "%s\n", __func__);
>  }
>  
> -static void utf16_to_str(uint8_t len, uint16_t *arr, char *name)
> +static char *utf16_to_str(uint8_t len, uint16_t *arr)
>  {
> -    int count;
> -    wchar_t *wstr = g_new0(wchar_t, len);
> +    wchar_t *wstr = g_new0(wchar_t, len + 1);
> +    int count, dlen;
> +    char *dest;
>  
>      for (count = 0; count < len; count++) {
> +        /* FIXME: not working for surrogate pairs */

Please mention the FIXME in the commit message.

With that:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

>          wstr[count] = (wchar_t)arr[count];
>      }
> +    wstr[count] = 0;
>  
> -    wcstombs(name, wstr, len);
> +    dlen = wcstombs(NULL, wstr, 0) + 1;
> +    dest = g_malloc(dlen);
> +    wcstombs(dest, wstr, dlen);
>      g_free(wstr);
> +    return dest;
>  }
>  
>  /* Wrapper around write, returns 0 on failure */
[...]
