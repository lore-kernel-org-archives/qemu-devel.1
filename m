Received: from eggs.gnu.org ([2001:4830:134:3::10]:58055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elfds-0007Rv-Kj
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elfdq-0006xI-0i
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:49:24 -0500
References: <20180118164439.2120-1-ptoscano@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <19874fff-b615-593f-c0a4-16954fa2732c@redhat.com>
Date: Tue, 13 Feb 2018 19:49:12 +0100
MIME-Version: 1.0
In-Reply-To: <20180118164439.2120-1-ptoscano@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zJcTGuTlZbCpXTTViyZ5mWNWRKaZoToHX"
Subject: Re: [Qemu-devel] [PATCH v4] ssh: switch from libssh2 to libssh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: rjones@redhat.com, jcody@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zJcTGuTlZbCpXTTViyZ5mWNWRKaZoToHX
From: Max Reitz <mreitz@redhat.com>
To: Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: rjones@redhat.com, jcody@redhat.com, kwolf@redhat.com
Message-ID: <19874fff-b615-593f-c0a4-16954fa2732c@redhat.com>
Subject: Re: [PATCH v4] ssh: switch from libssh2 to libssh
References: <20180118164439.2120-1-ptoscano@redhat.com>
In-Reply-To: <20180118164439.2120-1-ptoscano@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-18 17:44, Pino Toscano wrote:
> Rewrite the implementation of the ssh block driver to use libssh instea=
d
> of libssh2.  The libssh library has various advantages over libssh2:
> - easier API for authentication (for example for using ssh-agent)
> - easier API for known_hosts handling
> - supports newer types of keys in known_hosts
>=20
> Kerberos authentication can be enabled once the libssh bug for it [1] i=
s
> fixed.
>=20
> The development version of libssh (i.e. the future 0.8.x) supports
> fsync, so reuse the build time check for this.
>=20
> [1] https://red.libssh.org/issues/242
>=20
> Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> ---
>=20
> Changes from v3:
> - fix socket cleanup in connect_to_ssh()
> - add comments about the socket cleanup
> - improve the error reporting (closer to what was with libssh2)
> - improve EOF detection on sftp_read()
>=20
> Changes from v2:
> - used again an own fd
> - fixed co_yield() implementation
>=20
> Changes from v1:
> - fixed jumbo packets writing
> - fixed missing 'err' assignment
> - fixed commit message

One thing: The performance seems to have dropped hugely, from what I can
tell.

Before this patch, running the iotests 1-10 over ssh (raw/ssh) took
12.6 s.  With this patch, they take 59.3 s.  Perhaps the starkest
contrast can be seen in test 1, which took 4 s before and 27 s after --
this test simply reads and writes 128 MB of continuous data.

I like having elliptic curves, but I think this patch needs optimization
work before we can replace libssh2.

>  block/Makefile.objs |   6 +-
>  block/ssh.c         | 522 ++++++++++++++++++++++++--------------------=
--------
>  configure           |  65 ++++---
>  3 files changed, 278 insertions(+), 315 deletions(-)

[...]

> diff --git a/block/ssh.c b/block/ssh.c
> index b049a16eb9..2975fc27d8 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c

[...]

> @@ -87,27 +81,25 @@ static void ssh_state_init(BDRVSSHState *s)
>  {
>      memset(s, 0, sizeof *s);
>      s->sock =3D -1;
> -    s->offset =3D -1;
>      qemu_co_mutex_init(&s->lock);
>  }
> =20
>  static void ssh_state_free(BDRVSSHState *s)
>  {
> +    if (s->attrs) {
> +        sftp_attributes_free(s->attrs);
> +    }
>      if (s->sftp_handle) {
> -        libssh2_sftp_close(s->sftp_handle);
> +        sftp_close(s->sftp_handle);
>      }
>      if (s->sftp) {
> -        libssh2_sftp_shutdown(s->sftp);
> +        sftp_free(s->sftp);
>      }
>      if (s->session) {
> -        libssh2_session_disconnect(s->session,
> -                                   "from qemu ssh client: "
> -                                   "user closed the connection");
> -        libssh2_session_free(s->session);
> -    }
> -    if (s->sock >=3D 0) {
> -        close(s->sock);
> +        ssh_disconnect(s->session);
> +        ssh_free(s->session);
>      }
> +    /* s->sock is owned by the ssh_session, which free's it. */

s/free's/frees/

>  }
> =20
>  static void GCC_FMT_ATTR(3, 4)
> @@ -121,13 +113,13 @@ session_error_setg(Error **errp, BDRVSSHState *s,=
 const char *fs, ...)
>      va_end(args);
> =20
>      if (s->session) {
> -        char *ssh_err;
> +        const char *ssh_err;
>          int ssh_err_code;
> =20
> -        /* This is not an errno.  See <libssh2.h>. */
> -        ssh_err_code =3D libssh2_session_last_error(s->session,
> -                                                  &ssh_err, NULL, 0);
> -        error_setg(errp, "%s: %s (libssh2 error code: %d)",
> +        /* This is not an errno.  See <libssh/libssh.h>. */
> +        ssh_err =3D ssh_get_error(s->session);
> +        ssh_err_code =3D ssh_get_error_code(s->session);
> +        error_setg(errp, "%s: %s (libssh error code: %d)",
>                     msg, ssh_err, ssh_err_code);

Maybe we should not append the error info if there is no error.

(Example:

$ ./qemu-img info ssh://localhost/tmp/foo
qemu-img: Could not open 'ssh://localhost/tmp/foo': no host key was
found in known_hosts:  (libssh error code: 0)

)

>      } else {
>          error_setg(errp, "%s", msg);

[...]

> @@ -291,68 +283,41 @@ static void ssh_parse_filename(const char *filena=
me, QDict *options,
>  static int check_host_key_knownhosts(BDRVSSHState *s,
>                                       const char *host, int port, Error=
 **errp)
>  {
> -    const char *home;
> -    char *knh_file =3D NULL;
> -    LIBSSH2_KNOWNHOSTS *knh =3D NULL;
> -    struct libssh2_knownhost *found;
> -    int ret, r;
> -    const char *hostkey;
> -    size_t len;
> -    int type;
> +    int ret;
> +    int state;
> =20
> -    hostkey =3D libssh2_session_hostkey(s->session, &len, &type);
> -    if (!hostkey) {
> -        ret =3D -EINVAL;
> -        session_error_setg(errp, s, "failed to read remote host key");=

> -        goto out;
> -    }
> +    state =3D ssh_is_server_known(s->session);
> =20
> -    knh =3D libssh2_knownhost_init(s->session);
> -    if (!knh) {
> -        ret =3D -EINVAL;
> -        session_error_setg(errp, s,
> -                           "failed to initialize known hosts support")=
;
> -        goto out;
> -    }
> -
> -    home =3D getenv("HOME");
> -    if (home) {
> -        knh_file =3D g_strdup_printf("%s/.ssh/known_hosts", home);
> -    } else {
> -        knh_file =3D g_strdup_printf("/root/.ssh/known_hosts");
> -    }
> -
> -    /* Read all known hosts from OpenSSH-style known_hosts file. */
> -    libssh2_knownhost_readfile(knh, knh_file, LIBSSH2_KNOWNHOST_FILE_O=
PENSSH);
> -
> -    r =3D libssh2_knownhost_checkp(knh, host, port, hostkey, len,
> -                                 LIBSSH2_KNOWNHOST_TYPE_PLAIN|
> -                                 LIBSSH2_KNOWNHOST_KEYENC_RAW,
> -                                 &found);
> -    switch (r) {
> -    case LIBSSH2_KNOWNHOST_CHECK_MATCH:
> +    switch (state) {
> +    case SSH_SERVER_KNOWN_OK:
>          /* OK */
> -        DPRINTF("host key OK: %s", found->key);
>          break;
> -    case LIBSSH2_KNOWNHOST_CHECK_MISMATCH:
> +    case SSH_SERVER_KNOWN_CHANGED:
>          ret =3D -EINVAL;
>          session_error_setg(errp, s,
> -                      "host key does not match the one in known_hosts"=

> -                      " (found key %s)", found->key);
> +                      "host key does not match the one in known_hosts"=
);

Technically, this is against the specification which requires us to warn
the user about a possible attack. :-P

>          goto out;
> -    case LIBSSH2_KNOWNHOST_CHECK_NOTFOUND:
> +    case SSH_SERVER_FOUND_OTHER:
> +        ret =3D -EINVAL;
> +        session_error_setg(errp, s,
> +                      "host key for this server not found, another typ=
e "
> +                      "exists");
> +        goto out;
> +    case SSH_SERVER_FILE_NOT_FOUND:
> +        ret =3D -EINVAL;

Technically, this should be -ENOENT, but it doesn't actually matter (I
hope).

> +        session_error_setg(errp, s, "known_hosts file not found");
> +        goto out;
> +    case SSH_SERVER_NOT_KNOWN:
>          ret =3D -EINVAL;
>          session_error_setg(errp, s, "no host key was found in known_ho=
sts");
>          goto out;
> -    case LIBSSH2_KNOWNHOST_CHECK_FAILURE:
> +    case SSH_SERVER_ERROR:
>          ret =3D -EINVAL;
> -        session_error_setg(errp, s,
> -                      "failure matching the host key with known_hosts"=
);
> +        session_error_setg(errp, s, "server error");
>          goto out;
>      default:
>          ret =3D -EINVAL;
> -        session_error_setg(errp, s, "unknown error matching the host k=
ey"
> -                      " with known_hosts (%d)", r);
> +        session_error_setg(errp, s, "error while checking for known se=
rver");
>          goto out;
>      }

Only SSH_SERVER_ERROR actually sets a session error, I think.  So I
guess all the rest should just use error_setg() instead of
session_error_setg().  Otherwise, as in my example above, we'll just
append an empty string and error code 0, or even worse, we append an
unrelated error description.

[...]

> @@ -407,18 +368,31 @@ static int compare_fingerprint(const unsigned cha=
r *fingerprint, size_t len,
> =20
>  static int
>  check_host_key_hash(BDRVSSHState *s, const char *hash,
> -                    int hash_type, size_t fingerprint_len, Error **err=
p)
> +                    enum ssh_publickey_hash_type type, size_t fingerpr=
int_len,
> +                    Error **errp)
>  {
> -    const char *fingerprint;
> +    int r;
> +    ssh_key pubkey;
> +    unsigned char *server_hash;
> +    size_t server_hash_len;
> =20
> -    fingerprint =3D libssh2_hostkey_hash(s->session, hash_type);
> -    if (!fingerprint) {
> +    r =3D ssh_get_publickey(s->session, &pubkey);

The documentation says this is deprecated and one should use
ssh_get_server_publickey() instead (it just looks like a rename, though).=


> +    if (r < 0) {

This works, but I think I'd prefer "r !=3D SSH_OK" (because that's what
the documentation says).

(Also in all other places that check ssh_* function call return values.)

>          session_error_setg(errp, s, "failed to read remote host key");=

>          return -EINVAL;
>      }
> =20
> -    if(compare_fingerprint((unsigned char *) fingerprint, fingerprint_=
len,
> -                           hash) !=3D 0) {
> +    r =3D ssh_get_publickey_hash(pubkey, type, &server_hash, &server_h=
ash_len);
> +    ssh_key_free(pubkey);
> +    if (r < 0) {
> +        session_error_setg(errp, s,
> +                           "failed reading the hash of the server SSH =
key");
> +        return -EINVAL;
> +    }
> +
> +    r =3D compare_fingerprint(server_hash, server_hash_len, hash);

Now this is interesting, thanks for fixing an out-of-bounds access, I
guess (by using server_hash_len instead of fingerprint_len).  But now
fingerprint_len is completely unused in this function.

It's OK because compare_fingerprint() stops on anything but [:0-9a-fA-F]
(including \0), even though I really don't like this implicit safety.
It would be OK if it was noted in compare_fingerprint()'s description at
least (that you don't need to pass the length of host_key_check as long
as it's null-terminated).

I guess we should just add that comment and scrap the fingerprint_len
parameter altogether.  It doesn't make any sense now anymore.  We get
the actual hash's length from libssh; and it didn't have any correlation
to the actual length of the @hash string.  It is just set to 16/20,
depending on the caller, disregarding how long the actual string is.

> +    ssh_clean_pubkey_hash(&server_hash);
> +    if (r !=3D 0) {
>          error_setg(errp, "remote host key does not match host_key_chec=
k '%s'",
>                     hash);
>          return -EPERM;

[...]

> @@ -459,57 +433,32 @@ static int check_host_key(BDRVSSHState *s, const =
char *host, int port,
>  static int authenticate(BDRVSSHState *s, const char *user, Error **err=
p)
>  {
>      int r, ret;
> -    const char *userauthlist;
> -    LIBSSH2_AGENT *agent =3D NULL;
> -    struct libssh2_agent_publickey *identity;
> -    struct libssh2_agent_publickey *prev_identity =3D NULL;
> +    int method;
> =20
> -    userauthlist =3D libssh2_userauth_list(s->session, user, strlen(us=
er));
> -    if (strstr(userauthlist, "publickey") =3D=3D NULL) {
> +    r =3D ssh_userauth_none(s->session, NULL);
> +    if (r =3D=3D SSH_AUTH_ERROR) {

If you are going to keep this none-authentication, we should also catch
the case where it returns SSH_AUTH_SUCCESS and we don't even need to
supply a public key.

>          ret =3D -EPERM;
> -        error_setg(errp,
> -                "remote server does not support \"publickey\" authenti=
cation");
> +        session_error_setg(errp, s, "failed to call ssh_userauth_none"=
);
>          goto out;
>      }
> =20
> -    /* Connect to ssh-agent and try each identity in turn. */
> -    agent =3D libssh2_agent_init(s->session);
> -    if (!agent) {
> -        ret =3D -EINVAL;
> -        session_error_setg(errp, s, "failed to initialize ssh-agent su=
pport");
> -        goto out;
> -    }
> -    if (libssh2_agent_connect(agent)) {
> -        ret =3D -ECONNREFUSED;
> -        session_error_setg(errp, s, "failed to connect to ssh-agent");=

> -        goto out;
> -    }
> -    if (libssh2_agent_list_identities(agent)) {
> -        ret =3D -EINVAL;
> -        session_error_setg(errp, s,
> -                           "failed requesting identities from ssh-agen=
t");
> -        goto out;
> -    }
> +    method =3D ssh_userauth_list(s->session, NULL);
> =20
> -    for(;;) {
> -        r =3D libssh2_agent_get_identity(agent, &identity, prev_identi=
ty);
> -        if (r =3D=3D 1) {           /* end of list */
> -            break;
> -        }
> -        if (r < 0) {
> +    /* Try to authenticate with publickey, using the ssh-agent
> +     * if available.
> +     */
> +    if (method & SSH_AUTH_METHOD_PUBLICKEY) {
> +        r =3D ssh_userauth_publickey_auto(s->session, NULL, NULL);

Why do we need the none authentication to find out which authentication
methods are allowed if we are going to use ssh_userauth_publickey()
anyway?  We could call that right from the start and if the server
doesn't support it, well, then it will fail anyway.

(Maybe it makes sense to keep the ssh_userauth_none() because maybe
someone has configured his server like that, but I don't see the point
of ssh_userauth_list().)

I suspect @user is NULL because that's set through ssh_options_set()?
If so, we can just drop the @user parameter from this function (because
it is unused now).

> +        if (r =3D=3D SSH_AUTH_ERROR) {
>              ret =3D -EINVAL;
> -            session_error_setg(errp, s,
> -                               "failed to obtain identity from ssh-age=
nt");
> +            error_setg(errp, "failed to authenticate using publickey "=

> +                             "authentication");
>              goto out;
> -        }
> -        r =3D libssh2_agent_userauth(agent, user, identity);
> -        if (r =3D=3D 0) {
> +        } else if (r =3D=3D SSH_AUTH_SUCCESS) {
>              /* Authenticated! */
>              ret =3D 0;
>              goto out;
>          }
> -        /* Failed to authenticate with this identity, try the next one=
=2E */
> -        prev_identity =3D identity;
>      }
> =20
>      ret =3D -EPERM;

[...]

> @@ -628,6 +570,8 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *o=
ptions,
>      Error *local_err =3D NULL;
>      const char *user, *path, *host_key_check;
>      long port =3D 0;
> +    unsigned long portU =3D 0;

I was about to say: How about making port an unsigned long and swapping
the qemu_strtol() for a qemu_strtoul()?

But I think you'd rather want an unsigned int instead (and that won't
work with qemu_strtoul()).

> +    int new_sock =3D -1;
> =20
>      opts =3D qemu_opts_create(&ssh_runtime_opts, NULL, 0, &error_abort=
);
>      qemu_opts_absorb_qdict(opts, options, &local_err);
> @@ -678,26 +622,74 @@ static int connect_to_ssh(BDRVSSHState *s, QDict =
*options,
>      }
> =20
>      /* Open the socket and connect. */
> -    s->sock =3D inet_connect_saddr(s->inet, errp);
> -    if (s->sock < 0) {
> +    new_sock =3D inet_connect_saddr(s->inet, errp);
> +    if (new_sock < 0) {
>          ret =3D -EIO;
>          goto err;
>      }
> =20
>      /* Create SSH session. */
> -    s->session =3D libssh2_session_init();
> +    s->session =3D ssh_new();
>      if (!s->session) {
>          ret =3D -EINVAL;
> -        session_error_setg(errp, s, "failed to initialize libssh2 sess=
ion");
> +        session_error_setg(errp, s, "failed to initialize libssh sessi=
on");
>          goto err;
>      }
> =20
> -#if TRACE_LIBSSH2 !=3D 0
> -    libssh2_trace(s->session, TRACE_LIBSSH2);
> -#endif
> +    /* Make sure we are in blocking mode during the connection and
> +     * authentication phases.
> +     */
> +    ssh_set_blocking(s->session, 1);
> =20
> -    r =3D libssh2_session_handshake(s->session, s->sock);
> -    if (r !=3D 0) {
> +    r =3D ssh_options_set(s->session, SSH_OPTIONS_USER, user);
> +    if (r < 0) {
> +        ret =3D -EINVAL;
> +        session_error_setg(errp, s,
> +                           "failed to set the user in the libssh sessi=
on");
> +        goto err;
> +    }
> +
> +    r =3D ssh_options_set(s->session, SSH_OPTIONS_HOST, s->inet->host)=
;
> +    if (r < 0) {
> +        ret =3D -EINVAL;
> +        session_error_setg(errp, s,
> +                           "failed to set the host in the libssh sessi=
on");
> +        goto err;
> +    }
> +
> +    if (port > 0) {
> +        portU =3D port;
> +        r =3D ssh_options_set(s->session, SSH_OPTIONS_PORT, &portU);

My documentation says:
> SSH_OPTIONS_PORT: The port to connect to (unsigned int).

int is not long, so this happens to do the right thing only on LE hardwar=
e.

> +        if (r < 0) {
> +            ret =3D -EINVAL;
> +            session_error_setg(errp, s,
> +                               "failed to set the port in the libssh s=
ession");
> +            goto err;
> +        }
> +    }
> +
> +    /* Read ~/.ssh/config. */
> +    r =3D ssh_options_parse_config(s->session, NULL);
> +    if (r < 0) {
> +        ret =3D -EINVAL;
> +        session_error_setg(errp, s, "failed to parse ~/.ssh/config");
> +        goto err;
> +    }
> +
> +    r =3D ssh_options_set(s->session, SSH_OPTIONS_FD, &new_sock);
> +    if (r < 0) {
> +        ret =3D -EINVAL;
> +        session_error_setg(errp, s,
> +                           "failed to set the socket in the libssh ses=
sion");
> +        goto err;
> +    }
> +    /* libssh took ownership of the socket. */
> +    s->sock =3D new_sock;
> +    new_sock =3D -1;
> +
> +    /* Connect. */
> +    r =3D ssh_connect(s->session);
> +    if (r < 0) {
>          ret =3D -EINVAL;
>          session_error_setg(errp, s, "failed to establish SSH session")=
;
>          goto err;
> @@ -717,8 +709,15 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *=
options,
>      }
> =20
>      /* Start SFTP. */
> -    s->sftp =3D libssh2_sftp_init(s->session);
> +    s->sftp =3D sftp_new(s->session);
>      if (!s->sftp) {
> +        session_error_setg(errp, s, "failed to create sftp handle");
> +        ret =3D -EINVAL;
> +        goto err;
> +    }
> +
> +    r =3D sftp_init(s->sftp);
> +    if (r < 0) {
>          session_error_setg(errp, s, "failed to initialize sftp handle"=
);

Should this be sftp_error_setg()?

>          ret =3D -EINVAL;
>          goto err;
> @@ -727,17 +726,20 @@ static int connect_to_ssh(BDRVSSHState *s, QDict =
*options,
>      /* Open the remote file. */
>      DPRINTF("opening file %s flags=3D0x%x creat_mode=3D0%o",
>              path, ssh_flags, creat_mode);
> -    s->sftp_handle =3D libssh2_sftp_open(s->sftp, path, ssh_flags, cre=
at_mode);
> +    s->sftp_handle =3D sftp_open(s->sftp, path, ssh_flags, creat_mode)=
;
>      if (!s->sftp_handle) {
>          session_error_setg(errp, s, "failed to open remote file '%s'",=
 path);

Same here.

>          ret =3D -EINVAL;
>          goto err;
>      }
> =20
> +    /* Make sure the SFTP file is handled in blocking mode. */
> +    sftp_file_set_blocking(s->sftp_handle);
> +

Hm, but ssh_file_open() makes the SSH session non-blocking immediately
afterwards, and it doesn't seem like the old libssh2 cared about how
SFTP behaved.  Was that the same thing in libssh2?  Should
ssh_file_open() make the SFTP session non-blocking as well?

>      qemu_opts_del(opts);
> =20
> -    r =3D libssh2_sftp_fstat(s->sftp_handle, &s->attrs);
> -    if (r < 0) {
> +    s->attrs =3D sftp_fstat(s->sftp_handle);
> +    if (!s->attrs) {
>          sftp_error_setg(errp, s, "failed to read file attributes");
>          return -EINVAL;
>      }

[...]

> @@ -937,33 +935,6 @@ static coroutine_fn void co_yield(BDRVSSHState *s,=
 BlockDriverState *bs)
>      DPRINTF("s->sock=3D%d - back", s->sock);
>  }
> =20
> -/* SFTP has a function `libssh2_sftp_seek64' which seeks to a position=

> - * in the remote file.  Notice that it just updates a field in the
> - * sftp_handle structure, so there is no network traffic and it cannot=

> - * fail.
> - *
> - * However, `libssh2_sftp_seek64' does have a catastrophic effect on
> - * performance since it causes the handle to throw away all in-flight
> - * reads and buffered readahead data.  Therefore this function tries
> - * to be intelligent about when to call the underlying libssh2 functio=
n.
> - */
> -#define SSH_SEEK_WRITE 0
> -#define SSH_SEEK_READ  1
> -#define SSH_SEEK_FORCE 2
> -
> -static void ssh_seek(BDRVSSHState *s, int64_t offset, int flags)
> -{
> -    bool op_read =3D (flags & SSH_SEEK_READ) !=3D 0;
> -    bool force =3D (flags & SSH_SEEK_FORCE) !=3D 0;
> -
> -    if (force || op_read !=3D s->offset_op_read || offset !=3D s->offs=
et) {
> -        DPRINTF("seeking to offset=3D%" PRIi64, offset);
> -        libssh2_sftp_seek64(s->sftp_handle, offset);
> -        s->offset =3D offset;
> -        s->offset_op_read =3D op_read;
> -    }
> -}
> -

So I guess this is not an issue in libssh? :-)

Max

>  static coroutine_fn int ssh_read(BDRVSSHState *s, BlockDriverState *bs=
,
>                                   int64_t offset, size_t size,
>                                   QEMUIOVector *qiov)


--zJcTGuTlZbCpXTTViyZ5mWNWRKaZoToHX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqDMygSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ar+0H/0DE/oaVVit/3KyDwn4d4oJUQqIyL97l
SIexl4YeW2+0njrUJnf2fZsVID6xSqQjeEFzO9JMxjoBTigwMB8i37MJVc0x45iP
l5E83FSYIHHr/Vg3Wio839VRY4f22CDqUGgohFkBia36sR7R9A3HjZHpz2TiGURX
snFgdjDGnmt68laUIdWvNOGcKQcbCtI/J8Z+wSEfeaQEbmin7QmBX1P2ERZiDA7f
Kahw6kWfd1Aka6kMgVdkCetpt5Hb6p5xpHekFjfwEpxnkXBwdXwM7tDt3nARm77L
KZxTRZlJ6f7nIyxRfb9DT0SONxqHzG+b1U5dwQLFPzkRH40JTtJs5wQ=
=kAP3
-----END PGP SIGNATURE-----

--zJcTGuTlZbCpXTTViyZ5mWNWRKaZoToHX--
