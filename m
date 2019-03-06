Received: from eggs.gnu.org ([209.51.188.92]:58785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1h1U4U-0002EO-4F
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1h1U4S-000226-Vs
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:46:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1h1U4R-0001wY-OX
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:46:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id q1so12843204wrp.7
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 02:46:41 -0800 (PST)
Date: Wed, 6 Mar 2019 11:46:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190306104637.fq2akqumjqpkzmgh@steredhat.homenet.telecomitalia.it>
References: <20190305154634.4609-1-ndevos@redhat.com>
	<20190305154634.4609-2-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190305154634.4609-2-ndevos@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/2] block/gluster: Handle changed
 glfs_ftruncate signature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Niels de Vos <ndevos@redhat.com>
Cc: qemu-block@nongnu.org, integration@gluster.org, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>

Hi Niels,

On Tue, Mar 05, 2019 at 04:46:33PM +0100, Niels de Vos wrote:
> From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> 
> New versions of Glusters libgfapi.so have an updated glfs_ftruncate()
> function that returns additional 'struct stat' structures to enable
> advanced caching of attributes. This is useful for file servers, not so
> much for QEMU. Nevertheless, the API has changed and needs to be
> adopted.
> 
> Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> Signed-off-by: Niels de Vos <ndevos@redhat.com>
> 
> --
> v5: pass default NULL arguments through macro (Daniel P. Berrangé)
> v4: rebase to current master branch
> v3: define old backwards compatible glfs_ftruncate() macro, from Eric Blake
> v2: do a compile check as suggested by Eric Blake

to avoid to record these information in the commit message, you should use 3
dashes or move these lines after the 3 dashes below.

> ---
>  block/gluster.c |  4 ++++
>  configure       | 18 ++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/block/gluster.c b/block/gluster.c
> index af64330211..f853aa87f4 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -20,6 +20,10 @@
>  #include "qemu/option.h"
>  #include "qemu/cutils.h"
>  
> +#ifdef CONFIG_GLUSTERFS_FTRUNCATE_HAS_STAT
> +# define glfs_ftruncate(fd, offset) glfs_ftruncate(fd, offset, NULL, NULL)
> +#endif
> +
>  #define GLUSTER_OPT_FILENAME        "filename"
>  #define GLUSTER_OPT_VOLUME          "volume"
>  #define GLUSTER_OPT_PATH            "path"
> diff --git a/configure b/configure
> index cefeb8fcce..bbfe587b88 100755
> --- a/configure
> +++ b/configure
> @@ -456,6 +456,7 @@ glusterfs_xlator_opt="no"
>  glusterfs_discard="no"
>  glusterfs_fallocate="no"
>  glusterfs_zerofill="no"
> +glusterfs_ftruncate_has_stat="no"
>  gtk=""
>  gtk_gl="no"
>  tls_priority="NORMAL"
> @@ -4083,6 +4084,19 @@ if test "$glusterfs" != "no" ; then
>        glusterfs_fallocate="yes"
>        glusterfs_zerofill="yes"
>      fi
> +    cat > $TMPC << EOF
> +#include <glusterfs/api/glfs.h>
> +
> +int
> +main(void)
> +{
> +	/* new glfs_ftruncate() passes two additional args */
> +	return glfs_ftruncate(NULL, 0, NULL, NULL);
> +}
> +EOF
> +    if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
> +      glusterfs_ftruncate_has_stat="yes"
> +    fi
>    else
>      if test "$glusterfs" = "yes" ; then
>        feature_not_found "GlusterFS backend support" \
> @@ -6885,6 +6899,10 @@ if test "$glusterfs_zerofill" = "yes" ; then
>    echo "CONFIG_GLUSTERFS_ZEROFILL=y" >> $config_host_mak
>  fi
>  
> +if test "$glusterfs_ftruncate_has_stat" = "yes" ; then
> +  echo "CONFIG_GLUSTERFS_FTRUNCATE_HAS_STAT=y" >> $config_host_mak
> +fi
> +
>  if test "$libssh2" = "yes" ; then
>    echo "CONFIG_LIBSSH2=m" >> $config_host_mak
>    echo "LIBSSH2_CFLAGS=$libssh2_cflags" >> $config_host_mak
> -- 
> 2.20.1
> 
> 

The patch LGTM.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
