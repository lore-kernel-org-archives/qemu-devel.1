Received: from eggs.gnu.org ([2001:4830:134:3::10]:35209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSo9y-0003Kb-OZ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSo9u-0000Vz-Qb
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:09:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gSo9u-0000VH-KP
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:09:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so6283852wrs.8
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 11:09:01 -0800 (PST)
References: <20181130111222.25386-1-kraxel@redhat.com>
	<20181130111222.25386-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <75c973a5-f571-e69e-e2fd-72d3b3b118b2@redhat.com>
Date: Fri, 30 Nov 2018 20:08:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181130111222.25386-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] usb-mtp: outlaw slashes in
 filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 30/11/18 12:12, Gerd Hoffmann wrote:
> Slash is unix directory separator, so they are not allowed in filenames.
> Note this also stops the classic escape via "../".
> 
> Fixes: CVE-2018-16867
> Reported-by: Michael Hanselmann (hansmi.ch)

It's common for scripts to match '<email>', can you write this one as
Michael Hanselmann <hansmi.ch>?

(Same suggestion applies for patch 1/2).

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index fbe1ace035..87eeac1084 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1718,6 +1718,12 @@ static void usb_mtp_write_metadata(MTPState *s)
>  
>      filename = utf16_to_str(dataset->length, dataset->filename);
>  
> +    if (strchr(filename, '/')) {
> +        usb_mtp_queue_result(s, RES_INVALID_PARAMETER, d->trans,
> +                             0, 0, 0, 0);
> +        return;
> +    }

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>      o = usb_mtp_object_lookup_name(p, filename, dataset->length);
>      if (o != NULL) {
>          next_handle = o->handle;
> 
