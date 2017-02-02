Received: from eggs.gnu.org ([2001:4830:134:3::10]:43060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZIvq-0007jH-4C
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:04:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZIvm-0002PO-RZ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:04:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cZIvm-0002P3-JV
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:04:14 -0500
Date: Thu, 2 Feb 2017 15:04:07 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170202150407.GP2915@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170202145159.20440-1-rjones@redhat.com>
	<20170202145159.20440-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170202145159.20440-2-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, den@openvz.org, rkagan@virtuozzo.com, dplotnikov@virtuozzo.com, stefanha@gmail.com

On Thu, Feb 02, 2017 at 02:51:59PM +0000, Richard W.M. Jones wrote:
> Socket activation (sometimes known as systemd socket activation)
> allows an Internet superserver to pass a pre-opened listening socket
> to the process, instead of having qemu-nbd open a socket itself.  This
> is done via the LISTEN_FDS and LISTEN_PID environment variables, and a
> standard file descriptor range.
> 
> This change partially implements socket activation for qemu-nbd.  If
> the environment variables are set correctly, then socket activation
> will happen automatically, otherwise everything works as before.  The
> limitation is that LISTEN_FDS must be 1.
> 
> Signed-off-by: Richard W.M. Jones.
> ---
>  qemu-nbd.c | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 162 insertions(+), 12 deletions(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index c734f62..bfa52c3 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -386,9 +386,9 @@ static void nbd_update_server_watch(void)
>  }
>  
>  
> -static SocketAddress *nbd_build_socket_address(const char *sockpath,
> -                                               const char *bindto,
> -                                               const char *port)
> +static SocketAddress *nbd_build_socket_fd(const char *sockpath,
> +                                          const char *bindto,
> +                                          const char *port)

I don't think this needs renaming - its still returning an address
rather than an FD

>  {
>      SocketAddress *saddr;
>  
> @@ -463,6 +463,131 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
>      return creds;
>  }
>  
> +static void setup_address_and_port(const char **address, const char **port)
> +{
> +    if (*address == NULL) {
> +        *address = "0.0.0.0";
> +    }
> +
> +    if (*port == NULL) {
> +        *port = g_strdup_printf("%d", NBD_DEFAULT_PORT);;
> +    }
> +}
> +
> +#define FIRST_SOCKET_ACTIVATION_FD 3 /* defined by systemd ABI */
> +
> +#ifndef _WIN32
> +/*
> + * Check if socket activation was requested via use of the
> + * LISTEN_FDS and LISTEN_PID environment variables.
> + *
> + * Returns 0 if no socket activation, or the number of FDs.
> + */
> +static unsigned int check_socket_activation(void)
> +{
> +    const char *s;
> +    unsigned int pid;
> +    unsigned int nr_fds;
> +    unsigned int i;
> +    int fd;
> +
> +    s = getenv("LISTEN_PID");
> +    if (s == NULL) {
> +        return 0;
> +    }
> +    if (sscanf(s, "%u", &pid) != 1) {

IIRC qemu_strtoul would be preferred for this.

> +        if (verbose) {
> +            fprintf(stderr, "malformed %s environment variable (ignored)\n",
> +                    "LISTEN_PID");
> +        }
> +        return 0;
> +    }
> +    if (pid != getpid()) {
> +        if (verbose) {
> +            fprintf(stderr, "%s was not for us (ignored)\n",
> +                    "LISTEN_PID");
> +        }
> +        return 0;
> +    }
> +
> +    s = getenv("LISTEN_FDS");
> +    if (s == NULL) {
> +        return 0;
> +    }
> +    if (sscanf(s, "%u", &nr_fds) != 1) {

And this.

> +        if (verbose) {
> +            fprintf(stderr, "malformed %s environment variable (ignored)\n",
> +                    "LISTEN_FDS");
> +        }
> +        return 0;
> +    }
> +
> +    /* A limitation of current qemu-nbd is that it can only listen on
> +     * a single socket.  When that limitation is lifted, we can change
> +     * this function to allow LISTEN_FDS > 1, and remove the assertion
> +     * in the main function below.
> +     */
> +    if (nr_fds > 1) {
> +        error_report("qemu-nbd does not support socket activation with %s > 1",
> +                     "LISTEN_FDS");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /* So these are not passed to any child processes we might start. */
> +    unsetenv("LISTEN_FDS");
> +    unsetenv("LISTEN_PID");
> +
> +    /* So the file descriptors don't leak into child processes. */
> +    for (i = 0; i < nr_fds; ++i) {
> +        fd = FIRST_SOCKET_ACTIVATION_FD + i;
> +        if (fcntl(fd, F_SETFD, FD_CLOEXEC) == -1) {
> +            /* If we cannot set FD_CLOEXEC then it probably means the file
> +             * descriptor is invalid, so socket activation has gone wrong
> +             * and we should exit.
> +             */
> +            error_report("Socket activation failed: "
> +                         "invalid file descriptor fd = %d: %m",
> +                         fd);
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
> +    return nr_fds;
> +}
> +
> +#else /* !_WIN32 */
> +static unsigned int check_socket_activation(void)
> +{
> +    return 0;
> +}
> +#endif

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
