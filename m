Received: from eggs.gnu.org ([2001:4830:134:3::10]:57328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpW8Q-0001Pn-SJ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpW8O-0007ug-8o
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:56:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpW8O-0007uH-2U
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:56:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 160567E42D
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 08:56:31 +0000 (UTC)
Date: Wed, 6 Sep 2017 09:56:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170906085626.GG15510@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170906074418.10903-1-famz@redhat.com>
	<20170906074418.10903-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170906074418.10903-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] buildsys: Move gcrypt cflags/libs
 to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Sep 06, 2017 at 03:44:18PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  configure            | 5 ++---
>  crypto/Makefile.objs | 7 +++++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index 6d90e73a8b..b37cd54bda 100755
> --- a/configure
> +++ b/configure
> @@ -2565,9 +2565,6 @@ if test "$gcrypt" != "no"; then
>          then
>              gcrypt_libs="$gcrypt_libs -lgpg-error"
>          fi
> -        libs_softmmu="$gcrypt_libs $libs_softmmu"
> -        libs_tools="$gcrypt_libs $libs_tools"
> -        QEMU_CFLAGS="$QEMU_CFLAGS $gcrypt_cflags"
>          gcrypt="yes"
>          if test -z "$nettle"; then
>             nettle="no"
> @@ -5715,6 +5712,8 @@ if test "$gnutls_rnd" = "yes" ; then
>  fi
>  if test "$gcrypt" = "yes" ; then
>    echo "CONFIG_GCRYPT=y" >> $config_host_mak
> +  echo "GCRYPT_CFLAGS=$gcrypt_cflags" >> $config_host_mak
> +  echo "GCRYPT_LIBS=$gcrypt_libs" >> $config_host_mak
>    if test "$gcrypt_hmac" = "yes" ; then
>      echo "CONFIG_GCRYPT_HMAC=y" >> $config_host_mak
>    fi
> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index 0cb5fa24b6..45f7c0c80d 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -34,6 +34,13 @@ crypto-obj-y += block.o
>  crypto-obj-y += block-qcow.o
>  crypto-obj-y += block-luks.o
>  
> +$(if $(CONFIG_GCRYPT), \
> +	$(foreach x, init cipher hash-gcrypt hmac-gcrypt random-gcrypt \
> +			pbkdf-gcrypt, \
> +		$(eval $x.o-cflags := $(NETTLE_CFLAGS)) \
> +		$(eval $x.o-libs := $(NETTLE_LIBS))) \
> +)
> +
>  $(if $(CONFIG_NETTLE), \
>  	$(foreach x, cipher hash-nettle hmac-nettle pbkdf-nettle, \
>  		$(eval $x.o-cflags := $(NETTLE_CFLAGS)) \

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
