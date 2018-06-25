Received: from eggs.gnu.org ([2001:4830:134:3::10]:55575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ptoscano@redhat.com>) id 1fXVVI-0001oV-96
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ptoscano@redhat.com>) id 1fXVVE-0002iG-Ud
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:42:16 -0400
From: Pino Toscano <ptoscano@redhat.com>
Date: Mon, 25 Jun 2018 19:41:59 +0200
Message-ID: <12353567.D0f3bM4Uqd@thyrus.usersys.redhat.com>
In-Reply-To: <19874fff-b615-593f-c0a4-16954fa2732c@redhat.com>
References: <20180118164439.2120-1-ptoscano@redhat.com>
	<19874fff-b615-593f-c0a4-16954fa2732c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6209396.0V6bUlrYrR";
	micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4] ssh: switch from libssh2 to libssh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com, jcody@redhat.com, kwolf@redhat.com

--nextPart6209396.0V6bUlrYrR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 13 February 2018 19:49:12 CET Max Reitz wrote:
> On 2018-01-18 17:44, Pino Toscano wrote:
> > Rewrite the implementation of the ssh block driver to use libssh instead
> > of libssh2.  The libssh library has various advantages over libssh2:
> > - easier API for authentication (for example for using ssh-agent)
> > - easier API for known_hosts handling
> > - supports newer types of keys in known_hosts
> > 
> > Kerberos authentication can be enabled once the libssh buxg for it [1] is
> > fixed.
> > 
> > The development version of libssh (i.e. the future 0.8.x) supports
> > fsync, so reuse the build time check for this.
> > 
> > [1] https://red.libssh.org/issues/242
> > 
> > Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> > ---

Sorry for the (very late) reply.

I fixed basically all the code issues noted with this review; follow
few replies/notes that are not just "fixed".

> > Changes from v3:
> > - fix socket cleanup in connect_to_ssh()
> > - add comments about the socket cleanup
> > - improve the error reporting (closer to what was with libssh2)
> > - improve EOF detection on sftp_read()
> > 
> > Changes from v2:
> > - used again an own fd
> > - fixed co_yield() implementation
> > 
> > Changes from v1:
> > - fixed jumbo packets writing
> > - fixed missing 'err' assignment
> > - fixed commit message
> 
> One thing: The performance seems to have dropped hugely, from what I can
> tell.
> 
> Before this patch, running the iotests 1-10 over ssh (raw/ssh) took
> 12.6 s.  With this patch, they take 59.3 s.  Perhaps the starkest
> contrast can be seen in test 1, which took 4 s before and 27 s after --
> this test simply reads and writes 128 MB of continuous data.
> 
> I like having elliptic curves, but I think this patch needs optimization
> work before we can replace libssh2.

One thing that I discovered helping a lot is setting the TCP_NODELAY
option on the socket, to disable the Nagle algorithm; this drastically
reduced the overhead, which now does not seem to be more than 200% on
the very intensive tests (at least with my benchmarks).
Also using libssh from master shows more improvements too (and a bit
more of instability though, but that's a different story), and the
resulting overhead seems more acceptable to me now.

> 
> >  block/Makefile.objs |   6 +-
> >  block/ssh.c         | 522 ++++++++++++++++++++++++----------------------------
> >  configure           |  65 ++++---
> >  3 files changed, 278 insertions(+), 315 deletions(-)
> 
> [...]
> 
> > diff --git a/block/ssh.c b/block/ssh.c
> > index b049a16eb9..2975fc27d8 100644
> > --- a/block/ssh.c
> > +++ b/block/ssh.c
> 
> [...]
> 
> > @@ -87,27 +81,25 @@ static void ssh_state_init(BDRVSSHState *s)
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
> > +        ssh_disconnect(s->session);
> > +        ssh_free(s->session);
> >      }
> > +    /* s->sock is owned by the ssh_session, which free's it. */
> 
> s/free's/frees/
> 
> >  }
> >  
> >  static void GCC_FMT_ATTR(3, 4)
> > @@ -121,13 +113,13 @@ session_error_setg(Error **errp, BDRVSSHState *s, const char *fs, ...)
> >      va_end(args);
> >  
> >      if (s->session) {
> > -        char *ssh_err;
> > +        const char *ssh_err;
> >          int ssh_err_code;
> >  
> > -        /* This is not an errno.  See <libssh2.h>. */
> > -        ssh_err_code = libssh2_session_last_error(s->session,
> > -                                                  &ssh_err, NULL, 0);
> > -        error_setg(errp, "%s: %s (libssh2 error code: %d)",
> > +        /* This is not an errno.  See <libssh/libssh.h>. */
> > +        ssh_err = ssh_get_error(s->session);
> > +        ssh_err_code = ssh_get_error_code(s->session);
> > +        error_setg(errp, "%s: %s (libssh error code: %d)",
> >                     msg, ssh_err, ssh_err_code);
> 
> Maybe we should not append the error info if there is no error.
> 
> (Example:
> 
> $ ./qemu-img info ssh://localhost/tmp/foo
> qemu-img: Could not open 'ssh://localhost/tmp/foo': no host key was
> found in known_hosts:  (libssh error code: 0)

The current libssh2 code has the same issue -- the solution is what you
mention later on, i.e. use error_setg() directly.

There were few more "mismatches" on the usage of the error functions,
which I fixed.

> > @@ -291,68 +283,41 @@ static void ssh_parse_filename(const char *filename, QDict *options,
> >  static int check_host_key_knownhosts(BDRVSSHState *s,
> >                                       const char *host, int port, Error **errp)
> >  {
> > -    const char *home;
> > -    char *knh_file = NULL;
> > -    LIBSSH2_KNOWNHOSTS *knh = NULL;
> > -    struct libssh2_knownhost *found;
> > -    int ret, r;
> > -    const char *hostkey;
> > -    size_t len;
> > -    int type;
> > +    int ret;
> > +    int state;
> >  
> > -    hostkey = libssh2_session_hostkey(s->session, &len, &type);
> > -    if (!hostkey) {
> > -        ret = -EINVAL;
> > -        session_error_setg(errp, s, "failed to read remote host key");
> > -        goto out;
> > -    }
> > +    state = ssh_is_server_known(s->session);
> >  
> > -    knh = libssh2_knownhost_init(s->session);
> > -    if (!knh) {
> > -        ret = -EINVAL;
> > -        session_error_setg(errp, s,
> > -                           "failed to initialize known hosts support");
> > -        goto out;
> > -    }
> > -
> > -    home = getenv("HOME");
> > -    if (home) {
> > -        knh_file = g_strdup_printf("%s/.ssh/known_hosts", home);
> > -    } else {
> > -        knh_file = g_strdup_printf("/root/.ssh/known_hosts");
> > -    }
> > -
> > -    /* Read all known hosts from OpenSSH-style known_hosts file. */
> > -    libssh2_knownhost_readfile(knh, knh_file, LIBSSH2_KNOWNHOST_FILE_OPENSSH);
> > -
> > -    r = libssh2_knownhost_checkp(knh, host, port, hostkey, len,
> > -                                 LIBSSH2_KNOWNHOST_TYPE_PLAIN|
> > -                                 LIBSSH2_KNOWNHOST_KEYENC_RAW,
> > -                                 &found);
> > -    switch (r) {
> > -    case LIBSSH2_KNOWNHOST_CHECK_MATCH:
> > +    switch (state) {
> > +    case SSH_SERVER_KNOWN_OK:
> >          /* OK */
> > -        DPRINTF("host key OK: %s", found->key);
> >          break;
> > -    case LIBSSH2_KNOWNHOST_CHECK_MISMATCH:
> > +    case SSH_SERVER_KNOWN_CHANGED:
> >          ret = -EINVAL;
> >          session_error_setg(errp, s,
> > -                      "host key does not match the one in known_hosts"
> > -                      " (found key %s)", found->key);
> > +                      "host key does not match the one in known_hosts");
> 
> Technically, this is against the specification which requires us to warn
> the user about a possible attack. :-P

Sadly libssh up to 0.7 does not provide an API for this; there is work
ongoing upstream to expand the "knownhosts" API, and query for this
information. Once it is finalized (e.g. with a 0.8 release), I will
make this block device use it.

> > @@ -407,18 +368,31 @@ static int compare_fingerprint(const unsigned char *fingerprint, size_t len,
> >  
> >  static int
> >  check_host_key_hash(BDRVSSHState *s, const char *hash,
> > -                    int hash_type, size_t fingerprint_len, Error **errp)
> > +                    enum ssh_publickey_hash_type type, size_t fingerprint_len,
> > +                    Error **errp)
> >  {
> > -    const char *fingerprint;
> > +    int r;
> > +    ssh_key pubkey;
> > +    unsigned char *server_hash;
> > +    size_t server_hash_len;
> >  
> > -    fingerprint = libssh2_hostkey_hash(s->session, hash_type);
> > -    if (!fingerprint) {
> > +    r = ssh_get_publickey(s->session, &pubkey);
> 
> The documentation says this is deprecated and one should use
> ssh_get_server_publickey() instead (it just looks like a rename, though).

Only in current master, i.e the future 0.8.

> > @@ -628,6 +570,8 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
> >      Error *local_err = NULL;
> >      const char *user, *path, *host_key_check;
> >      long port = 0;
> > +    unsigned long portU = 0;
> 
> I was about to say: How about making port an unsigned long and swapping
> the qemu_strtol() for a qemu_strtoul()?
> 
> But I think you'd rather want an unsigned int instead (and that won't
> work with qemu_strtoul()).

After Dan implemented qemu_strtoui(), this now can use unsigned int.

> >          ret = -EINVAL;
> >          goto err;
> >      }
> >  
> > +    /* Make sure the SFTP file is handled in blocking mode. */
> > +    sftp_file_set_blocking(s->sftp_handle);
> > +
> 
> Hm, but ssh_file_open() makes the SSH session non-blocking immediately
> afterwards, and it doesn't seem like the old libssh2 cared about how
> SFTP behaved.  Was that the same thing in libssh2?  Should
> ssh_file_open() make the SFTP session non-blocking as well?

The implementation for blocking/non-blocking follows the behaviour
currently implemented using libssh2, and in libssh2 itself.

-- 
Pino Toscano
--nextPart6209396.0V6bUlrYrR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAlsxKWcACgkQw9FMLZhk
N81C0Q//XWuIOkUSAeP+xQ7dROiTCaoW1sIhFTNaPRM9FYiHsp4gc0QhBgukcYBA
8T1dD2n9kRD6hEfkR73jfHAtHiW9APhtyDvsG7c1CcPBNqb5QZy/8Gc9hBq5WUof
wL626/FM3UUR6oiPsO9fckZx3lXz7O0VzchRO5tH8Z/sEocYIe5hisy3ZLJOGVR3
q6q6GQUVhSM+niRfuFZhOH2qrZP4c9TNyvzp8HMQxYDupyBczpXeNya3vKtc0Zd4
kdYf6gBjJUsdxFEsbpTcCqc5iL5tvlBVOyAFmOM67MseaWFq2VRMdKnBEIB+ggy6
7GNYQTJ3TWLoa3vsCI8Vtac/Bq3W2mZylLi72Hf3rOtBBNSu2d4TrhzTH5jXvksY
pbMde1qY0octO+5W+dGFD2FNNTBVUOWQKIddfT9JvLUhi2UVEkrtM8JdtrGRHG8z
7I4evfoYTbQebRtoYdRwCTAIn00JzBirX04SSQ7IQGiNGSFy5sOdK62voOzZiGlY
SrwFsOrSkgASpoluMELbbfiyrDjvwTs6GyfUjNeQX5djnD1agUbSpyThqdETC6Kv
3w0zCeHJDqf8Auzq4LZR/OJwIFOlJJ1wflPg71nLe9uihEsNjS5Ucmn9CiMDXGor
q4ciDUBqulT9xq/ZOlkCy/aRn0KJWM7EKmoKhCOtMQpvvWQ4emo=
=Up35
-----END PGP SIGNATURE-----

--nextPart6209396.0V6bUlrYrR--
