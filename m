Received: from eggs.gnu.org ([209.51.188.92]:60569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1h1U9j-00057l-QD
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1h1U9i-00071S-T1
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:52:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1h1U9i-00070l-Kv
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:52:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id q187so5472299wme.5
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 02:52:10 -0800 (PST)
Date: Wed, 6 Mar 2019 11:52:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190306105206.5f6bjbc5cncty6bt@steredhat.homenet.telecomitalia.it>
References: <20190305154634.4609-1-ndevos@redhat.com>
	<20190305154634.4609-3-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305154634.4609-3-ndevos@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] gluster: the glfs_io_cbk callback
 function pointer adds pre/post stat args
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Niels de Vos <ndevos@redhat.com>
Cc: qemu-block@nongnu.org, integration@gluster.org, qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>

On Tue, Mar 05, 2019 at 04:46:34PM +0100, Niels de Vos wrote:
> The glfs_*_async() functions do a callback once finished. This callback
> has changed its arguments, pre- and post-stat structures have been
> added. This makes it possible to improve caching, which is useful for
> Samba and NFS-Ganesha, but not so much for QEMU. Gluster 6 is the first
> release that includes these new arguments.
> 
> With an additional detection in ./configure, the new arguments can
> conditionally get included in the glfs_io_cbk handler.
> 
> Signed-off-by: Niels de Vos <ndevos@redhat.com>
> 
> --
> v2: correct typo in commit message (Kevin Wolf)

Also here, please use 3 dashes or move below.

> ---
>  block/gluster.c |  6 +++++-
>  configure       | 24 ++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/block/gluster.c b/block/gluster.c
> index f853aa87f4..51f184cbd8 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -729,7 +729,11 @@ static struct glfs *qemu_gluster_init(BlockdevOptionsGluster *gconf,
>  /*
>   * AIO callback routine called from GlusterFS thread.
>   */
> -static void gluster_finish_aiocb(struct glfs_fd *fd, ssize_t ret, void *arg)
> +static void gluster_finish_aiocb(struct glfs_fd *fd, ssize_t ret,
> +#ifdef CONFIG_GLUSTERFS_IOCB_HAS_STAT
> +                                 struct glfs_stat *pre, struct glfs_stat *post,
> +#endif
> +                                 void *arg)

I'm note sure that is a good idea put function parameters in the ifdef
block.
What do you think to rename gluster_finish_aiocb() in
gluster_finish_aiocb_common() or something like that and create two
functions for the two cases with the right parameters that call
gluster_finish_aiocb_common()?

#ifdef CONFIG_GLUSTERFS_IOCB_HAS_STAT
static void gluster_finish_aiocb(struct glfs_fd *fd, ssize_t ret,
                                 struct glfs_stat *pre, struct glfs_stat *post,
                                 void *arg)
{
    gluster_finish_aiocb_common(fd, ret, args);
}
#else
static void gluster_finish_aiocb(struct glfs_fd *fd, ssize_t ret, void *arg)
{
    gluster_finish_aiocb_common(fd, ret, args);
}
#endif /* CONFIG_GLUSTERFS_IOCB_HAS_STAT */

Thanks,
Stefano

>  {
>      GlusterAIOCB *acb = (GlusterAIOCB *)arg;
>  
> diff --git a/configure b/configure
> index bbfe587b88..db548d9b08 100755
> --- a/configure
> +++ b/configure
> @@ -457,6 +457,7 @@ glusterfs_discard="no"
>  glusterfs_fallocate="no"
>  glusterfs_zerofill="no"
>  glusterfs_ftruncate_has_stat="no"
> +glusterfs_iocb_has_stat="no"
>  gtk=""
>  gtk_gl="no"
>  tls_priority="NORMAL"
> @@ -4097,6 +4098,25 @@ EOF
>      if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
>        glusterfs_ftruncate_has_stat="yes"
>      fi
> +    cat > $TMPC << EOF
> +#include <glusterfs/api/glfs.h>
> +
> +/* new glfs_io_cbk() passes two additional glfs_stat structs */
> +static void
> +glusterfs_iocb(glfs_fd_t *fd, ssize_t ret, struct glfs_stat *prestat, struct glfs_stat *poststat, void *data)
> +{}
> +
> +int
> +main(void)
> +{
> +	glfs_io_cbk iocb = &glusterfs_iocb;
> +	iocb(NULL, 0 , NULL, NULL, NULL);
> +	return 0;
> +}
> +EOF
> +    if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
> +      glusterfs_iocb_has_stat="yes"
> +    fi
>    else
>      if test "$glusterfs" = "yes" ; then
>        feature_not_found "GlusterFS backend support" \
> @@ -6903,6 +6923,10 @@ if test "$glusterfs_ftruncate_has_stat" = "yes" ; then
>    echo "CONFIG_GLUSTERFS_FTRUNCATE_HAS_STAT=y" >> $config_host_mak
>  fi
>  
> +if test "$glusterfs_iocb_has_stat" = "yes" ; then
> +  echo "CONFIG_GLUSTERFS_IOCB_HAS_STAT=y" >> $config_host_mak
> +fi
> +
>  if test "$libssh2" = "yes" ; then
>    echo "CONFIG_LIBSSH2=m" >> $config_host_mak
>    echo "LIBSSH2_CFLAGS=$libssh2_cflags" >> $config_host_mak
> -- 
> 2.20.1
> 
> 
