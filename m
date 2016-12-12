Received: from eggs.gnu.org ([2001:4830:134:3::10]:54067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNiC-0002rs-17
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGNi8-00050Y-Br
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:20:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cGNi8-0004zl-5Z
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:19:56 -0500
Date: Mon, 12 Dec 2016 10:19:51 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161212101951.GD15611@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481530092-20240-1-git-send-email-longpeng2@huawei.com>
	<1481530092-20240-4-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481530092-20240-4-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2 3/7] configure: add
 CONFIG_GCRYPT_SUPPORT_HMAC item
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: eblake@redhat.com, armbru@redhat.com, stefanha@redhat.com, wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Mon, Dec 12, 2016 at 04:08:08PM +0800, Longpeng(Mike) wrote:
> This item will be used for support libcrypt-backed HMAC algorithms.
> 
> Support for hmac has been added in Libgcrypt 1.6.0, but we cannot
> use pkg-config to get libcrypt's version. However we can make a
> in configure to know whether current libcrypt support hmac.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  configure | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/configure b/configure
> index 3770d7c..6eb5f5c 100755
> --- a/configure
> +++ b/configure
> @@ -2417,6 +2417,21 @@ EOF
>          if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
>              gcrypt_kdf=yes
>          fi
> +
> +        cat > $TMPC << EOF
> +#include <gcrypt.h>
> +int main(void) {
> +  gcry_mac_hd_t handle;
> +  gcry_mac_open(&handle, GCRY_MAC_HMAC_MD5,
> +                GCRY_MAC_FLAG_SECURE, NULL);
> +  return 0;
> +}
> +EOF
> +        if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
> +            gcrypy_support_hmac="yes"

Typo,   s/gcrypy/gcrypt/, and repeated a few lines later too

> +        else
> +            gcrypy_support_hmac="no"
> +        fi

For consistency with the KDF probe, just remove the word 'support_'
from this

>      else
>          if test "$gcrypt" = "yes"; then
>              feature_not_found "gcrypt" "Install gcrypt devel"
> @@ -5387,6 +5402,9 @@ if test "$gnutls_rnd" = "yes" ; then
>  fi
>  if test "$gcrypt" = "yes" ; then
>    echo "CONFIG_GCRYPT=y" >> $config_host_mak
> +  if test "gcrypy_support_hmac" = "yes" ; then
> +    echo "CONFIG_GCRYPT_SUPPORT_HMAC=y" >> $config_host_mak
> +  fi

And again  s/support//

>    if test "$gcrypt_kdf" = "yes" ; then
>      echo "CONFIG_GCRYPT_KDF=y" >> $config_host_mak
>    fi
> -- 
> 1.8.3.1
> 
> 

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
