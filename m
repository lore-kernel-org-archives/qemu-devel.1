Received: from eggs.gnu.org ([2001:4830:134:3::10]:55333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBd00-0008Ck-P1
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBczx-0006Lt-GW
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:11:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBczx-0006Ln-4Y
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:10:57 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0BF48124F
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 08:10:55 +0000 (UTC)
References: <1495177204-16808-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <67826397-2ec6-1936-69e3-93c2cb0da9c4@redhat.com>
Date: Fri, 19 May 2017 10:10:52 +0200
MIME-Version: 1.0
In-Reply-To: <1495177204-16808-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb: Simplify the parameter parsing of the
 legacy usb serial device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>



On 19/05/2017 09:00, Thomas Huth wrote:
> Coverity complains about the current code, so let's get rid of
> the now unneeded while loop and simply always emit "unrecognized
> serial USB option" for all unsupported options.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/usb/dev-serial.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index 83a4f0e..76ceca1 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -516,27 +516,16 @@ static USBDevice *usb_serial_init(USBBus *bus, const char *filename)
>      char label[32];
>      static int index;
>  
> -    while (*filename && *filename != ':') {
> -        const char *p;
> -
> -        if (strstart(filename, "vendorid=", &p)) {
> -            error_report("vendorid is not supported anymore");
> -            return NULL;
> -        } else if (strstart(filename, "productid=", &p)) {
> -            error_report("productid is not supported anymore");
> -            return NULL;
> -        } else {
> -            error_report("unrecognized serial USB option %s", filename);
> -            return NULL;
> -        }
> -        while(*filename == ',')
> -            filename++;
> +    if (*filename == ':') {
> +        filename++;
> +    } else if (*filename) {
> +        error_report("unrecognized serial USB option %s", filename);
> +        return NULL;
>      }
>      if (!*filename) {
>          error_report("character device specification needed");
>          return NULL;
>      }
> -    filename++;
>  
>      snprintf(label, sizeof(label), "usbserial%d", index++);
>      cdrv = qemu_chr_new(label, filename);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
