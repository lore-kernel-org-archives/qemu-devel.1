Received: from eggs.gnu.org ([209.51.188.92]:47426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guB0s-0006du-4M
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 02:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guB0i-00048P-ON
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 02:00:47 -0500
References: <20190213211827.20300-1-thomas.petazzoni@bootlin.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8defa16a-2af8-a1a7-0e3e-cb281f9a477d@redhat.com>
Date: Thu, 14 Feb 2019 08:00:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190213211827.20300-1-thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: improve usbfs check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-stable@nongnu.org

On 2019-02-13 22:18, Thomas Petazzoni wrote:
> The current check to test if usbfs support should be compiled or not
> solely relies on the presence of <linux/usbdevice_fs.h>, without
> actually checking that all definition used by Qemu are provided by
> this header file.
> 
> With sufficiently old kernel headers, <linux/usbdevice_fs.h> may be
> present, but some of the definitions needed by Qemu may not be
> available.
> 
> This commit improves the check by building a small program that
> actually tests whether the necessary definitions are available.
> 
> In addition, it fixes a bug where have_usbfs was set to "yes"
> regardless of the result of the test.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  configure | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index 3d89870d99..799c8e3b08 100755
> --- a/configure
> +++ b/configure
> @@ -4266,10 +4266,25 @@ fi
>  # check for usbfs
>  have_usbfs=no
>  if test "$linux_user" = "yes"; then
> -  if check_include linux/usbdevice_fs.h; then
> +  cat > $TMPC << EOF
> +#include <linux/usbdevice_fs.h>
> +
> +#ifndef USBDEVFS_GET_CAPABILITIES
> +#error "USBDEVFS_GET_CAPABILITIES undefined"
> +#endif
> +
> +#ifndef USBDEVFS_DISCONNECT_CLAIM
> +#error "USBDEVFS_DISCONNECT_CLAIM undefined"
> +#endif
> +
> +int main(void)
> +{
> +    return 0;
> +}
> +EOF
> +  if compile_prog "" ""; then
>      have_usbfs=yes
>    fi
> -  have_usbfs=yes
>  fi
>  
>  # check for fallocate

Reviewed-by: Thomas Huth <thuth@redhat.com>
