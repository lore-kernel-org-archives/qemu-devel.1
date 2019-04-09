Received: from eggs.gnu.org ([209.51.188.92]:35512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvyR-0008HK-LZ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvyQ-0001sU-NJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:59:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDvyQ-0001sG-E7
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:59:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id r186so3035357wmf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 11:59:58 -0700 (PDT)
References: <20190409174018.25798-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
Date: Tue, 9 Apr 2019 20:59:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190409174018.25798-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alistair.francis@wdc.com, slp@redhat.com, david@gibson.dropbear.id.au

On 4/9/19 7:40 PM, Markus Armbruster wrote:
> If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
> computation of @dt_size overflows to a negative number, which then
> gets converted to a very large size_t for g_malloc0() and
> load_image_size().  In the (fortunately improbable) case g_malloc0()
> succeeds and load_image_size() survives, we'd assign the negative
> number to *sizep.  What that would do to the callers I can't say, but
> it's unlikely to be good.
> 
> Fix by rejecting images whose size would overflow.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  device_tree.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/device_tree.c b/device_tree.c
> index 296278e12a..f8b46b3c73 100644
> --- a/device_tree.c
> +++ b/device_tree.c
> @@ -84,6 +84,10 @@ void *load_device_tree(const char *filename_path, int *sizep)
>                       filename_path);
>          goto fail;
>      }
> +    if (dt_size > INT_MAX / 2 - 10000) {

We should avoid magic number duplication.
That said, this patch looks safe.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

BTW how did you figure that out?

> +        error_report("Device tree file '%s' is too large", filename_path);
> +        goto fail;
> +    }
>  
>      /* Expand to 2x size to give enough room for manipulation.  */
>      dt_size += 10000;
> 
