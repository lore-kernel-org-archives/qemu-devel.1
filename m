Received: from eggs.gnu.org ([2001:4830:134:3::10]:51965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ptoscano@redhat.com>) id 1ecD1q-0005BD-Oj
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ptoscano@redhat.com>) id 1ecD1o-0001G4-Ge
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:27:02 -0500
From: Pino Toscano <ptoscano@redhat.com>
Date: Thu, 18 Jan 2018 17:26:44 +0100
Message-ID: <2739418.2Y1EeV9v1H@thyrus.usersys.redhat.com>
In-Reply-To: <20171218195519.GB31765@localhost.localdomain>
References: <20171115162648.30135-1-ptoscano@redhat.com>
	<20171218195519.GB31765@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4649752.yEHmKe79qv";
	micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3] ssh: switch from libssh2 to libssh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, rjones@redhat.com, mreitz@redhat.com

--nextPart4649752.yEHmKe79qv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 18 December 2017 20:55:19 CET Jeff Cody wrote:
> On Wed, Nov 15, 2017 at 05:26:48PM +0100, Pino Toscano wrote:
> > Rewrite the implementation of the ssh block driver to use libssh instead
> > of libssh2.  The libssh library has various advantages over libssh2:
> > - easier API for authentication (for example for using ssh-agent)
> > - easier API for known_hosts handling
> > - supports newer types of keys in known_hosts
> > 
> > Kerberos authentication can be enabled once the libssh bug for it [1] is
> > fixed.
> > 
> > The development version of libssh (i.e. the future 0.8.x) supports
> > fsync, so reuse the build time check for this.
> > 
> > [1] https://red.libssh.org/issues/242
> > 
> > Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> > ---
> > 
> > Changes from v2:
> > - used again an own fd
> > - fixed co_yield() implementation
> > 
> > Changes from v1:
> > - fixed jumbo packets writing
> > - fixed missing 'err' assignment
> > - fixed commit message
> > 
> >  block/Makefile.objs |   6 +-
> >  block/ssh.c         | 494 ++++++++++++++++++++++++----------------------------
> >  configure           |  65 ++++---
> >  3 files changed, 259 insertions(+), 306 deletions(-)
> > 
> > diff --git a/block/Makefile.objs b/block/Makefile.objs
> > index 6eaf78a046..c0df21d0b4 100644
> > --- a/block/Makefile.objs
> > +++ b/block/Makefile.objs
> > @@ -20,7 +20,7 @@ block-obj-$(CONFIG_CURL) += curl.o
> >  block-obj-$(CONFIG_RBD) += rbd.o
> >  block-obj-$(CONFIG_GLUSTERFS) += gluster.o
> >  block-obj-$(CONFIG_VXHS) += vxhs.o
> > -block-obj-$(CONFIG_LIBSSH2) += ssh.o
> > +block-obj-$(CONFIG_LIBSSH) += ssh.o
> >  block-obj-y += accounting.o dirty-bitmap.o
> >  block-obj-y += write-threshold.o
> >  block-obj-y += backup.o
> > @@ -41,8 +41,8 @@ rbd.o-libs         := $(RBD_LIBS)
> >  gluster.o-cflags   := $(GLUSTERFS_CFLAGS)
> >  gluster.o-libs     := $(GLUSTERFS_LIBS)
> >  vxhs.o-libs        := $(VXHS_LIBS)
> > -ssh.o-cflags       := $(LIBSSH2_CFLAGS)
> > -ssh.o-libs         := $(LIBSSH2_LIBS)
> > +ssh.o-cflags       := $(LIBSSH_CFLAGS)
> > +ssh.o-libs         := $(LIBSSH_LIBS)
> >  block-obj-$(if $(CONFIG_BZIP2),m,n) += dmg-bz2.o
> >  dmg-bz2.o-libs     := $(BZIP2_LIBS)
> >  qcow.o-libs        := -lz
> > diff --git a/block/ssh.c b/block/ssh.c
> > index b049a16eb9..9e96c9d684 100644
> > --- a/block/ssh.c
> > +++ b/block/ssh.c
> > @@ -24,8 +24,8 @@
> >  
> >  #include "qemu/osdep.h"
> >  
> > -#include <libssh2.h>
> > -#include <libssh2_sftp.h>
> > +#include <libssh/libssh.h>
> > +#include <libssh/sftp.h>
> >  
> >  #include "block/block_int.h"
> >  #include "qapi/error.h"
> > @@ -41,14 +41,12 @@
> >  /* DEBUG_SSH=1 enables the DPRINTF (debugging printf) statements in
> >   * this block driver code.
> >   *
> > - * TRACE_LIBSSH2=<bitmask> enables tracing in libssh2 itself.  Note
> > - * that this requires that libssh2 was specially compiled with the
> > - * `./configure --enable-debug' option, so most likely you will have
> > - * to compile it yourself.  The meaning of <bitmask> is described
> > - * here: http://www.libssh2.org/libssh2_trace.html
> > + * TRACE_LIBSSH=<level> enables tracing in libssh itself.
> > + * The meaning of <level> is described here:
> > + * http://api.libssh.org/master/group__libssh__log.html
> >   */
> >  #define DEBUG_SSH     0
> > -#define TRACE_LIBSSH2 0 /* or try: LIBSSH2_TRACE_SFTP */
> > +#define TRACE_LIBSSH  0 /* see: SSH_LOG_* */
> >  
> >  #define DPRINTF(fmt, ...)                           \
> >      do {                                            \
> > @@ -64,18 +62,14 @@ typedef struct BDRVSSHState {
> >  
> >      /* SSH connection. */
> >      int sock;                         /* socket */
> > -    LIBSSH2_SESSION *session;         /* ssh session */
> > -    LIBSSH2_SFTP *sftp;               /* sftp session */
> > -    LIBSSH2_SFTP_HANDLE *sftp_handle; /* sftp remote file handle */
> > +    ssh_session session;              /* ssh session */
> > +    sftp_session sftp;                /* sftp session */
> > +    sftp_file sftp_handle;            /* sftp remote file handle */
> >  
> > -    /* See ssh_seek() function below. */
> > -    int64_t offset;
> > -    bool offset_op_read;
> > -
> > -    /* File attributes at open.  We try to keep the .filesize field
> > +    /* File attributes at open.  We try to keep the .size field
> >       * updated if it changes (eg by writing at the end of the file).
> >       */
> > -    LIBSSH2_SFTP_ATTRIBUTES attrs;
> > +    sftp_attributes attrs;
> >  
> >      InetSocketAddress *inet;
> >  
> > @@ -87,26 +81,23 @@ static void ssh_state_init(BDRVSSHState *s)
> >  {
> >      memset(s, 0, sizeof *s);
> >      s->sock = -1;
> > -    s->offset = -1;
> >      qemu_co_mutex_init(&s->lock);
> >  }
> >  
> >  static void ssh_state_free(BDRVSSHState *s)
> >  {
> > +    if (s->attrs) {
> > +        sftp_attributes_free(s->attrs);
> > +    }
> >      if (s->sftp_handle) {
> > -        libssh2_sftp_close(s->sftp_handle);
> > +        sftp_close(s->sftp_handle);
> >      }
> >      if (s->sftp) {
> > -        libssh2_sftp_shutdown(s->sftp);
> > +        sftp_free(s->sftp);
> >      }
> >      if (s->session) {
> > -        libssh2_session_disconnect(s->session,
> > -                                   "from qemu ssh client: "
> > -                                   "user closed the connection");
> > -        libssh2_session_free(s->session);
> > -    }
> > -    if (s->sock >= 0) {
> > -        close(s->sock);
> 
> Do we still want close(s->sock) here?

libssh takes ownership of the fd set using
  ssh_options_set(..., SSH_OPTIONS_FD, ..)
so it is not needed in most of the cases; I will add a comment about
this, so it is not forgotten.

That said, that made me notice that in connect_to_ssh(), if there is
any error between inet_connect_saddr() and the aforementioned
ssh_options_set() then the socket is closed twice (once by ssh_free(),
and the second time in ssh_file_open())-- I reworked the socket
handling in connect_to_ssh(), so it is freed only when needed.

> > -
> >  static coroutine_fn int ssh_read(BDRVSSHState *s, BlockDriverState *bs,
> >                                   int64_t offset, size_t size,
> >                                   QEMUIOVector *qiov)
> > @@ -975,7 +936,7 @@ static coroutine_fn int ssh_read(BDRVSSHState *s, BlockDriverState *bs,
> >  
> >      DPRINTF("offset=%" PRIi64 " size=%zu", offset, size);
> >  
> > -    ssh_seek(s, offset, SSH_SEEK_READ);
> > +    sftp_seek64(s->sftp_handle, offset);
> >  
> >      /* This keeps track of the current iovec element ('i'), where we
> >       * will write to next ('buf'), and the end of the current iovec
> > @@ -985,35 +946,34 @@ static coroutine_fn int ssh_read(BDRVSSHState *s, BlockDriverState *bs,
> >      buf = i->iov_base;
> >      end_of_vec = i->iov_base + i->iov_len;
> >  
> > -    /* libssh2 has a hard-coded limit of 2000 bytes per request,
> > -     * although it will also do readahead behind our backs.  Therefore
> > -     * we may have to do repeated reads here until we have read 'size'
> > -     * bytes.
> > -     */
> >      for (got = 0; got < size; ) {
> >      again:
> > -        DPRINTF("sftp_read buf=%p size=%zu", buf, end_of_vec - buf);
> > -        r = libssh2_sftp_read(s->sftp_handle, buf, end_of_vec - buf);
> > +        DPRINTF("sftp_read buf=%p size=%zu (actual size=%zu)",
> > +                buf, end_of_vec - buf, MIN(end_of_vec - buf, 16384));
> > +        /* The size of SFTP packets is limited to 32K bytes, so limit
> > +         * the amount of data requested to 16K, as libssh currently
> > +         * does not handle multiple requests on its own:
> > +         * https://red.libssh.org/issues/58
> > +         */
> > +        r = sftp_read(s->sftp_handle, buf, MIN(end_of_vec - buf, 16384));
> >          DPRINTF("sftp_read returned %zd", r);
> >  
> > -        if (r == LIBSSH2_ERROR_EAGAIN || r == LIBSSH2_ERROR_TIMEOUT) {
> > +        if (r == SSH_AGAIN) {
> >              co_yield(s, bs);
> >              goto again;
> 
> Hmm, this does not work.
> 
> If I test with an image create via ssh, it works fine.  However, trying to
> read an image that was not create via ssh, it hangs and loops here.
> 
> The only difference between the two images is the actual image size, and the
> zero padding:
> 
> ./qemu-img create -f qcow2 ssh://127.0.0.1/tmp/test-1.qcow2 100M
> ./qemu-img create -f qcow2 /tmp/test-2.qcow2 100M
> 
> 
> Created image differences:
> 
> diff <(xxd -c 4 -a /tmp/test-1.qcow2) <(xxd -c 4 -a /tmp/test-2.qcow2) 
> 45c45
> < 000301fc: 0000 0000  ....
> ---
> > 00030004: 0000 0000  ....
> 
> 
> Now when trying to read the images with ssh, test-2 will hang forever (at
> sector 384):
> 
> This hangs: ./qemu-io -c "read 0 100M" ssh://127.0.0.1/tmp/test-2.qcow2
> This works: ./qemu-io -c "read 0 100M" ssh://127.0.0.1/tmp/test-1.qcow2
> 
> We seem to be missing EOF in the case of a short read.

Indeed, this is something I can reproduce it locally too, thanks.

> Looking into the libssh APIs some:
> 
> The call to sftp_read() seems to be checking the return code incorrectly.
> From the libssh API documentation, sftp_read returns < 0 on error, or the
> number of bytes read. On error, sftp error is set, so this implies to me
> that you should be calling sftp_get_error() to obtain the actual error
> value.
> 
> But this isn't the only issue... sftp_read() is returning 0 instead of a
> value < 0.  I don't know if this is by design in libssh, or a libssh bug.

After a better look, it looks like an EOF reported by the server gives
as result sftp_read() = 0, and sftp_get_error() = SSH_FX_EOF.

> I am using libssh version 0.7.4-1.fc25.  Looking at the libssh git repo,
> this commit seems suspicious, but it appears to be present in 0.7.4, so I'm
> not sure:
> 
>   commit 6697f85b5053e36a880f725ea87d1fbba5ee0563
>   Author: Jeremy Cross <JCross@bomgar.com>
>   Date:   Mon Jul 25 22:55:04 2016 +0000
>   
>       sftp: ensure sftp_packet_read recognizes channel EOF to avoid infinite loop
>       
>       Signed-off-by: Jeremy Cross <jcross@bomgar.com>
>       Reviewed-by: Andreas Schneider <asn@cryptomilk.org>
>       (cherry picked from commit dbf72ffba2ad5b5694cd55aa1a7ca99053d20386)
>   
>   diff --git a/src/sftp.c b/src/sftp.c
>   index 6bcd8a6..fa2d3f4 100644
>   --- a/src/sftp.c
>   +++ b/src/sftp.c
>   @@ -334,7 +334,7 @@ sftp_packet sftp_packet_read(sftp_session sftp) {
>      do {
>        // read from channel until 4 bytes have been read or an error occurs
>        s=ssh_channel_read(sftp->channel, buffer+r, 4-r, 0);
>   -    if (s < 0) {
>   +    if (s <= 0) {
>          ssh_buffer_free(packet->payload);
>          SAFE_FREE(packet);
>          return NULL;

This was one of the fixes, but it had side effects (like spinning on
EOF), and it was fixed with 1b0bf852bef0acfde0825163a6d313a5654b1d74,
which is in 0.7.4 too.

> In any case, If I change the above hunk of your patch from this:
> 
> > +        r = sftp_read(s->sftp_handle, buf, MIN(end_of_vec - buf, 16384));
> >          DPRINTF("sftp_read returned %zd", r);
> >  
> > -        if (r == LIBSSH2_ERROR_EAGAIN || r == LIBSSH2_ERROR_TIMEOUT) {
> > +        if (r == SSH_AGAIN) {
> >              co_yield(s, bs);
> >              goto again;
> 
> 
> To this:
> 
> 
>  +        r = sftp_read(s->sftp_handle, buf, MIN(end_of_vec - buf, 16384));
>           DPRINTF("sftp_read returned %zd", r);
>   
>  +
>  +        if (r <= 0) {
>  +            r = sftp_get_error(s->sftp);
>  +        }
>  -        if (r == LIBSSH2_ERROR_EAGAIN || r == LIBSSH2_ERROR_TIMEOUT) {
>  +        if (r == SSH_AGAIN) {
>               co_yield(s, bs);
>               goto again;
> 
> 
> Then I appear to hit SSH_EOF correctly.
> 
> However, I am not sure it is always valid to check sftp_get_error() when 0
> is returned for sftp_read(), so I don't know if we can rely on this as a
> workaround.

This does not look a proper check though, since what sftp_get_error()
returns (i.e. the various SSH_FX_* constants) is different than
SSH_AGAIN & co.  My take on this is to check for SSH_FX_EOF as sftp
error when sftp_read() returns 0.

> 
> >          }
> > -        if (r < 0) {
> > -            sftp_error_report(s, "read failed");
> > -            s->offset = -1;
> > -            return -EIO;
> > -        }
> > -        if (r == 0) {
> > +        if (r == SSH_EOF) {
> >              /* EOF: Short read so pad the buffer with zeroes and return it. */
> >              qemu_iovec_memset(qiov, got, 0, size - got);
> >              return 0;
> >          }
> > +        if (r < 0) {
> > +            sftp_error_report(s, "read failed");
> > +            return -EIO;
> > +        }
> >  
> >          got += r;
> >          buf += r;
> > -        s->offset += r;
> >          if (buf >= end_of_vec && got < size) {
> >              i++;
> >              buf = i->iov_base;
> > @@ -1050,7 +1010,7 @@ static int ssh_write(BDRVSSHState *s, BlockDriverState *bs,
> >  
> >      DPRINTF("offset=%" PRIi64 " size=%zu", offset, size);
> >  
> > -    ssh_seek(s, offset, SSH_SEEK_WRITE);
> > +    sftp_seek64(s->sftp_handle, offset);
> >  
> >      /* This keeps track of the current iovec element ('i'), where we
> >       * will read from next ('buf'), and the end of the current iovec
> > @@ -1062,45 +1022,35 @@ static int ssh_write(BDRVSSHState *s, BlockDriverState *bs,
> >  
> >      for (written = 0; written < size; ) {
> >      again:
> > -        DPRINTF("sftp_write buf=%p size=%zu", buf, end_of_vec - buf);
> > -        r = libssh2_sftp_write(s->sftp_handle, buf, end_of_vec - buf);
> > +        DPRINTF("sftp_write buf=%p size=%zu (actual size=%zu)",
> > +                buf, end_of_vec - buf, MIN(end_of_vec - buf, 131072));
> > +        /* Avoid too large data packets, as libssh currently does not
> > +         * handle multiple requests on its own:
> > +         * https://red.libssh.org/issues/58
> > +         */
> > +        r = sftp_write(s->sftp_handle, buf, MIN(end_of_vec - buf, 131072));
> >          DPRINTF("sftp_write returned %zd", r);
> >  
> > -        if (r == LIBSSH2_ERROR_EAGAIN || r == LIBSSH2_ERROR_TIMEOUT) {
> > +        if (r == SSH_AGAIN) {
> >              co_yield(s, bs);
> >              goto again;
> >          }
> 
> I didn't verify, but I assume we probably have a similar issue here.

I think here there should not be the same issue.

-- 
Pino Toscano
--nextPart4649752.yEHmKe79qv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAlpgysQACgkQw9FMLZhk
N83d0Q//eIl62OIEqCEdYqO2TkN/UM9B448kgJwPZc+7gdgO4gwZwHiRDxUtakyW
y8/eMylgUjJivQu9XvVsN4mxRzk6shOHIffgJ9k9u6HuhfPvvJLRb9L8A7J8QBo9
VkV+xkOhv5WUw/LkP9+aoLwnOR33YZt6R/IXmwMM6gWrTEGV8GDaIOgEyqiSk8rO
Jr/iyiwWxsnZ7TqydxQ9D/hl0fKSJ4vpAz+MhFmobEBrVQtz09p2wEJDYTnn1Qsy
MGMVjvXxrR7vDZdvMa7ydG49kUpMPvo2fOhnwlBXzq6QhiT99uqftF/UKs+GR9Gg
Uj1qAd8I9w+oZO0aLquMuJCTxoGtUX6rAIT+cbcdd4FCe2d06FKsvQ5BR/pQwUvS
Tw/mk0ilVhTeifv/isv/B5/SC6lJtMySPopq5NV8vaytFXA6l0Xa4r+vNGV2VsBe
/kiEYhRVToKKv9OunyoAT0bxX+eHoD0T7UjP9NhTpxKDEv4+EJucQhiQEgbroFJL
xFPU87QUtfGazwVqxDcjICJJhPC6wUI7a3AEYJDkn6M8Ue5GX3ISWIhkjQgFuUJS
Tvos8JwpYOroh/lT7/xRbTKhVT9YzG7/xW7EVA8227SlE4a3yY1YFIuwrFKO1ObT
alSX8Cm43YR+Em1KrXzQvty43+PHbNSeyif2O8+sXypWrwUO2Xo=
=F2ji
-----END PGP SIGNATURE-----

--nextPart4649752.yEHmKe79qv--
