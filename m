Received: from eggs.gnu.org ([209.51.188.92]:50949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0qfX-0008RT-Kc
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0qfV-0005Rz-Fq
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:42:23 -0500
Date: Mon, 4 Mar 2019 16:41:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190304164144.GR4239@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190304162103.18912-1-ndevos@redhat.com>
	<20190304162103.18912-2-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190304162103.18912-2-ndevos@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block/gluster: Handle changed
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

On Mon, Mar 04, 2019 at 05:21:02PM +0100, Niels de Vos wrote:
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
> ---
> v4: rebase to current master branch
> v3: define old backwards compatible glfs_ftruncate() macro, from Eric Blake
> v2: do a compile check as suggested by Eric Blake
> ---
>  block/gluster.c | 11 +++++++++--
>  configure       | 18 ++++++++++++++++++
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/block/gluster.c b/block/gluster.c
> index af64330211..86e5278524 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -20,6 +20,10 @@
>  #include "qemu/option.h"
>  #include "qemu/cutils.h"
>  
> +#ifdef CONFIG_GLUSTERFS_LEGACY_FTRUNCATE
> +# define glfs_ftruncate(fd, offset, _u1, _u2) glfs_ftruncate(fd, offset)
> +#endif

I don't much like this approach as it sets up a trapdoor. If future
QEMU passes a non-NULL value for the 3rd/4th argument it will be
silently ignored depending on glfs version built against which can
result in incorrect behaviour at runtime. If we reverse it:

 #ifndef CONFIG_GLUSTERFS_LEGACY_FTRUNCATE
 # define glfs_ftruncate(fd, offset) glfs_ftruncate(fd, offset, NULL, NULL)
 #endif

then it ensures we can't silently do the wrong thing in future. Anyone
who wants to use the 3rd/4th args will have to make an explicit effort
to ensure it works correctly with old glfs APIs. An added benefit is
that it avoids the following patch chunks.


> +
>  #define GLUSTER_OPT_FILENAME        "filename"
>  #define GLUSTER_OPT_VOLUME          "volume"
>  #define GLUSTER_OPT_PATH            "path"
> @@ -1005,6 +1009,7 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
>                                      PreallocMode prealloc, Error **errp)
>  {
>      int64_t current_length;
> +    int ret;
>  
>      current_length = glfs_lseek(fd, 0, SEEK_END);
>      if (current_length < 0) {
> @@ -1032,7 +1037,8 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
>  #endif /* CONFIG_GLUSTERFS_FALLOCATE */
>  #ifdef CONFIG_GLUSTERFS_ZEROFILL
>      case PREALLOC_MODE_FULL:
> -        if (glfs_ftruncate(fd, offset)) {
> +        ret = glfs_ftruncate(fd, offset, NULL, NULL);
> +        if (ret) {
>              error_setg_errno(errp, errno, "Could not resize file");
>              return -errno;
>          }
> @@ -1043,7 +1049,8 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
>          break;
>  #endif /* CONFIG_GLUSTERFS_ZEROFILL */
>      case PREALLOC_MODE_OFF:
> -        if (glfs_ftruncate(fd, offset)) {
> +        ret = glfs_ftruncate(fd, offset, NULL, NULL);
> +        if (ret) {
>              error_setg_errno(errp, errno, "Could not resize file");
>              return -errno;
>          }
> diff --git a/configure b/configure
> index 540bee19ba..1d09bef1f9 100755
> --- a/configure
> +++ b/configure
> @@ -456,6 +456,7 @@ glusterfs_xlator_opt="no"
>  glusterfs_discard="no"
>  glusterfs_fallocate="no"
>  glusterfs_zerofill="no"
> +glusterfs_legacy_ftruncate="no"
>  gtk=""
>  gtk_gl="no"
>  tls_priority="NORMAL"
> @@ -4057,6 +4058,19 @@ if test "$glusterfs" != "no" ; then
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
> +	return glfs_ftruncate(NULL, 0 /*, NULL, NULL */);
> +}
> +EOF
> +    if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
> +      glusterfs_legacy_ftruncate="yes"
> +    fi
>    else
>      if test "$glusterfs" = "yes" ; then
>        feature_not_found "GlusterFS backend support" \
> @@ -6853,6 +6867,10 @@ if test "$glusterfs_zerofill" = "yes" ; then
>    echo "CONFIG_GLUSTERFS_ZEROFILL=y" >> $config_host_mak
>  fi
>  
> +if test "$glusterfs_legacy_ftruncate" = "yes" ; then
> +  echo "CONFIG_GLUSTERFS_LEGACY_FTRUNCATE=y" >> $config_host_mak
> +fi
> +
>  if test "$libssh2" = "yes" ; then
>    echo "CONFIG_LIBSSH2=m" >> $config_host_mak
>    echo "LIBSSH2_CFLAGS=$libssh2_cflags" >> $config_host_mak
> -- 
> 2.20.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
