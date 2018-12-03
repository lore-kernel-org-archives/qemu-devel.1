Received: from eggs.gnu.org ([2001:4830:134:3::10]:59487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gTknE-0007Pi-7u
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gTknB-0005mp-23
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:45:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gTknA-0005lC-7M
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:45:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so11375407wrw.5
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 01:45:24 -0800 (PST)
References: <20181203085938.10247-1-kraxel@redhat.com>
	<20181203085938.10247-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2c987f8a-1614-de5d-a890-fdefc0a2cb12@redhat.com>
Date: Mon, 3 Dec 2018 10:45:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181203085938.10247-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 v2 2/2] usb-mtp: outlaw slashes in
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
Cc: public@hansmi.ch

On 3/12/18 9:59, Gerd Hoffmann wrote:
> Slash is unix directory separator, so they are not allowed in filenames.
> Note this also stops the classic escape via "../".
> 
> Fixes: CVE-2018-16867
> Reported-by: Michael Hanselmann <public@hansmi.ch>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/usb/dev-mtp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 0f6a9702ef..e340a2c6e3 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1719,6 +1719,12 @@ static void usb_mtp_write_metadata(MTPState *s)
>  
>      filename = utf16_to_str(dataset->length, dataset->filename);
>  
> +    if (strchr(filename, '/')) {
> +        usb_mtp_queue_result(s, PARAMETER_NOT_SUPPORTED, d->trans,
> +                             0, 0, 0, 0);
> +        return;
> +    }
> +
>      o = usb_mtp_object_lookup_name(p, filename, dataset->length);
>      if (o != NULL) {
>          next_handle = o->handle;
> 
