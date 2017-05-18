Received: from eggs.gnu.org ([2001:4830:134:3::10]:55574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1dBQzZ-0002rP-LP
	for qemu-devel@nongnu.org; Thu, 18 May 2017 15:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1dBQzY-00032x-8I
	for qemu-devel@nongnu.org; Thu, 18 May 2017 15:21:45 -0400
Date: Thu, 18 May 2017 21:21:34 +0200
From: Niels de Vos <ndevos@redhat.com>
Message-ID: <20170518192134.GH2431@ndevos-x240.usersys.redhat.com>
References: <20170515191136.24314-1-ndevos@redhat.com>
	<20170518095422.12555-1-ndevos@redhat.com>
	<20170518175436.GF6761@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170518175436.GF6761@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2] gluster: add support for
 PREALLOC_MODE_FALLOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Thu, May 18, 2017 at 01:54:36PM -0400, Jeff Cody wrote:
> On Thu, May 18, 2017 at 11:54:22AM +0200, Niels de Vos wrote:
> > Add missing support for "preallocation=falloc" to the Gluster block
> > driver. This change bases its logic on that of block/file-posix.c and
> > removed the gluster_supports_zerofill() and qemu_gluster_zerofill()
> > functiond in favour of #ifdef checks in an easy to read
> > switch-statement.
> > 
> > Both glfs_zerofill() and glfs_fallocate() have been introduced with
> > GlusterFS 3.5.0 (pkg-config glusterfs-api = 6). A #define for the
> > availability of glfs_fallocate() has been added to ./configure.
> > 
> > Reported-by: Satheesaran Sundaramoorthi <sasundar@redhat.com>
> > URL: https://bugzilla.redhat.com/1450759
> > Signed-off-by: Niels de Vos <ndevos@redhat.com>
> > ---
> > v2 changes requested by Jeff Cody:
> > - add CONFIG_GLUSTERFS_FALLOCATE
> > - remove unneeded wrapper qemu_gluster_zerofill()
> > 
> >  block/gluster.c | 76 ++++++++++++++++++++++++++++++---------------------------
> >  configure       |  6 +++++
> >  2 files changed, 46 insertions(+), 36 deletions(-)
> > 
> > diff --git a/block/gluster.c b/block/gluster.c
> > index 7c76cd0..0610183 100644
> > --- a/block/gluster.c
> > +++ b/block/gluster.c
> > @@ -964,29 +964,6 @@ static coroutine_fn int qemu_gluster_co_pwrite_zeroes(BlockDriverState *bs,
> >      qemu_coroutine_yield();
> >      return acb.ret;
> >  }
> > -
> > -static inline bool gluster_supports_zerofill(void)
> > -{
> > -    return 1;
> > -}
> > -
> > -static inline int qemu_gluster_zerofill(struct glfs_fd *fd, int64_t offset,
> > -                                        int64_t size)
> > -{
> > -    return glfs_zerofill(fd, offset, size);
> > -}
> > -
> > -#else
> > -static inline bool gluster_supports_zerofill(void)
> > -{
> > -    return 0;
> > -}
> > -
> > -static inline int qemu_gluster_zerofill(struct glfs_fd *fd, int64_t offset,
> > -                                        int64_t size)
> > -{
> > -    return 0;
> > -}
> >  #endif
> >  
> >  static int qemu_gluster_create(const char *filename,
> > @@ -996,9 +973,10 @@ static int qemu_gluster_create(const char *filename,
> >      struct glfs *glfs;
> >      struct glfs_fd *fd;
> >      int ret = 0;
> > -    int prealloc = 0;
> > +    PreallocMode prealloc;
> >      int64_t total_size = 0;
> >      char *tmp = NULL;
> > +    Error *local_err = NULL;
> >  
> >      gconf = g_new0(BlockdevOptionsGluster, 1);
> >      gconf->debug = qemu_opt_get_number_del(opts, GLUSTER_OPT_DEBUG,
> > @@ -1026,13 +1004,12 @@ static int qemu_gluster_create(const char *filename,
> >                            BDRV_SECTOR_SIZE);
> >  
> >      tmp = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
> > -    if (!tmp || !strcmp(tmp, "off")) {
> > -        prealloc = 0;
> > -    } else if (!strcmp(tmp, "full") && gluster_supports_zerofill()) {
> > -        prealloc = 1;
> > -    } else {
> > -        error_setg(errp, "Invalid preallocation mode: '%s'"
> > -                         " or GlusterFS doesn't support zerofill API", tmp);
> > +    prealloc = qapi_enum_parse(PreallocMode_lookup, tmp,
> > +                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
> > +                               &local_err);
> > +    g_free(tmp);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> >          ret = -EINVAL;
> >          goto out;
> >      }
> > @@ -1041,21 +1018,48 @@ static int qemu_gluster_create(const char *filename,
> >                      O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR | S_IWUSR);
> >      if (!fd) {
> >          ret = -errno;
> > -    } else {
> > +        goto out;
> > +    }
> > +
> > +    switch (prealloc) {
> > +#ifdef CONFIG_GLUSTERFS_FALLOCATE
> > +    case PREALLOC_MODE_FALLOC:
> > +        if (!glfs_fallocate(fd, 0, 0, total_size)) {
> 
> Does glfs_fallocate() return 0 on failure?  Both posix and linux versions of
> fallocate() return 0 on success.

No, it should return 0 on success. This is a copy/paste error from the
glfs_ftruncate() below, and that if/else structure is a little
different. I did not notice the error message during my testing
though... Will check it again tomorrow.

Thanks,
Niels


> 
> > +            error_setg(errp, "Could not preallocate data for the new file");
> > +            ret = -errno;
> > +        }
> > +        break;
> > +#endif /* CONFIG_GLUSTERFS_FALLOCATE */
> > +#ifdef CONFIG_GLUSTERFS_ZEROFILL
> > +    case PREALLOC_MODE_FULL:
> >          if (!glfs_ftruncate(fd, total_size)) {
> > -            if (prealloc && qemu_gluster_zerofill(fd, 0, total_size)) {
> > +            if (glfs_zerofill(fd, 0, total_size)) {
> > +                error_setg(errp, "Could not zerofill the new file");
> >                  ret = -errno;
> >              }
> >          } else {
> > +            error_setg(errp, "Could not resize file");
> >              ret = -errno;
> >          }
> > -
> > -        if (glfs_close(fd) != 0) {
> > +        break;
> > +#endif /* CONFIG_GLUSTERFS_ZEROFILL */
> > +    case PREALLOC_MODE_OFF:
> > +        if (glfs_ftruncate(fd, total_size) != 0) {
> >              ret = -errno;
> > +            error_setg(errp, "Could not resize file");
> >          }
> > +        break;
> > +    default:
> > +        ret = -EINVAL;
> > +        error_setg(errp, "Unsupported preallocation mode: %s",
> > +                   PreallocMode_lookup[prealloc]);
> > +        break;
> > +    }
> > +
> > +    if (glfs_close(fd) != 0) {
> > +        ret = -errno;
> >      }
> >  out:
> > -    g_free(tmp);
> >      qapi_free_BlockdevOptionsGluster(gconf);
> >      glfs_clear_preopened(glfs);
> >      return ret;
> > diff --git a/configure b/configure
> > index 7c020c0..8b8291e 100755
> > --- a/configure
> > +++ b/configure
> > @@ -300,6 +300,7 @@ seccomp=""
> >  glusterfs=""
> >  glusterfs_xlator_opt="no"
> >  glusterfs_discard="no"
> > +glusterfs_fallocate="no"
> >  glusterfs_zerofill="no"
> >  gtk=""
> >  gtkabi=""
> > @@ -3576,6 +3577,7 @@ if test "$glusterfs" != "no" ; then
> >        glusterfs_discard="yes"
> >      fi
> >      if $pkg_config --atleast-version=6 glusterfs-api; then
> > +      glusterfs_fallocate="yes"
> >        glusterfs_zerofill="yes"
> >      fi
> >    else
> > @@ -5780,6 +5782,10 @@ if test "$glusterfs_discard" = "yes" ; then
> >    echo "CONFIG_GLUSTERFS_DISCARD=y" >> $config_host_mak
> >  fi
> >  
> > +if test "$glusterfs_fallocate" = "yes" ; then
> > +  echo "CONFIG_GLUSTERFS_FALLOCATE=y" >> $config_host_mak
> > +fi
> > +
> >  if test "$glusterfs_zerofill" = "yes" ; then
> >    echo "CONFIG_GLUSTERFS_ZEROFILL=y" >> $config_host_mak
> >  fi
> > -- 
> > 2.9.3
> > 
