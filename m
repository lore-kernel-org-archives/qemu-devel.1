Received: from eggs.gnu.org ([2001:4830:134:3::10]:34412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSrC0-0006Dt-EE
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSrBz-0001uy-8L
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:23:24 -0500
Date: Fri, 30 Nov 2018 22:23:12 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181130222312.GA27120@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130220344.3350618-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/14] qemu-nbd: Fail earlier for -c/-d on
 non-linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, nsoffer@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

On Fri, Nov 30, 2018 at 04:03:32PM -0600, Eric Blake wrote:
> Connecting to a /dev/nbdN device is a Linux-specific action.
> We were already masking -c and -d from 'qemu-nbd --help' on
> non-linux.  However, while -d fails with a sensible error
> message, it took hunting through a couple of files to prove
> that.  What's more, the code for -c doesn't fail until after
> it has created a pthread and tried to open a device - possibly
> even printing an error message with %m on a non-Linux platform
> in spite of the comment that %m is glibc-specific.  Make the
> failure happen sooner, then get rid of stubs that are no
> longer needed because of the early exits.
> 
> While at it: tweak the blank newlines in --help output to be
> consistent, whether or not built on Linux.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/client.c | 18 +-----------------
>  qemu-nbd.c   | 22 ++++++++++++++++++++--
>  2 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/nbd/client.c b/nbd/client.c
> index b667a1b56fd..0be89f9e641 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -1029,23 +1029,7 @@ int nbd_disconnect(int fd)
>      return 0;
>  }
> 
> -#else
> -int nbd_init(int fd, QIOChannelSocket *ioc, NBDExportInfo *info,
> -	     Error **errp)
> -{
> -    error_setg(errp, "nbd_init is only supported on Linux");
> -    return -ENOTSUP;
> -}
> -
> -int nbd_client(int fd)
> -{
> -    return -ENOTSUP;
> -}
> -int nbd_disconnect(int fd)
> -{
> -    return -ENOTSUP;
> -}
> -#endif
> +#endif /* __linux__ */
> 
>  int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
>  {
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index e169b839ece..55e29bd9a7e 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -43,6 +43,12 @@
>  #include "trace/control.h"
>  #include "qemu-version.h"
> 
> +#ifdef __linux__
> +#define HAVE_NBD_DEVICE 1
> +#else
> +#define HAVE_NBD_DEVICE 0
> +#endif
> +
>  #define SOCKET_PATH                "/var/lock/qemu-nbd-%s"
>  #define QEMU_NBD_OPT_CACHE         256
>  #define QEMU_NBD_OPT_AIO           257
> @@ -98,11 +104,11 @@ static void usage(const char *name)
>  "                            specify tracing options\n"
>  "  --fork                    fork off the server process and exit the parent\n"
>  "                            once the server is running\n"
> -#ifdef __linux__
> +#if HAVE_NBD_DEVICE
> +"\n"
>  "Kernel NBD client support:\n"
>  "  -c, --connect=DEV         connect FILE to the local NBD device DEV\n"
>  "  -d, --disconnect          disconnect the specified device\n"
> -"\n"
>  #endif
>  "\n"
>  "Block device options:\n"
> @@ -236,6 +242,7 @@ static void termsig_handler(int signum)
>  }
> 
> 
> +#if HAVE_NBD_DEVICE
>  static void *show_parts(void *arg)
>  {
>      char *device = arg;
> @@ -321,6 +328,7 @@ out:
>      kill(getpid(), SIGTERM);
>      return (void *) EXIT_FAILURE;
>  }
> +#endif /* HAVE_NBD_DEVICE */
> 
>  static int nbd_can_accept(void)
>  {
> @@ -815,6 +823,7 @@ int main(int argc, char **argv)
>      }
> 
>      if (disconnect) {
> +#if HAVE_NBD_DEVICE
>          int nbdfd = open(argv[optind], O_RDWR);
>          if (nbdfd < 0) {
>              error_report("Cannot open %s: %s", argv[optind],
> @@ -828,6 +837,10 @@ int main(int argc, char **argv)
>          printf("%s disconnected\n", argv[optind]);
> 
>          return 0;
> +#else
> +        error_report("Kernel /dev/nbdN support not available");
> +        exit(EXIT_FAILURE);
> +#endif
>      }
> 
>      if ((device && !verbose) || fork_process) {
> @@ -1006,6 +1019,7 @@ int main(int argc, char **argv)
>      nbd_export_set_description(exp, export_description);
> 
>      if (device) {
> +#if HAVE_NBD_DEVICE
>          int ret;
> 
>          ret = pthread_create(&client_thread, NULL, nbd_client_thread, device);
> @@ -1013,6 +1027,10 @@ int main(int argc, char **argv)
>              error_report("Failed to create client thread: %s", strerror(ret));
>              exit(EXIT_FAILURE);
>          }
> +#else
> +        error_report("Kernel /dev/nbdN support not available");
> +        exit(EXIT_FAILURE);
> +#endif
>      } else {
>          /* Shut up GCC warnings.  */
>          memset(&client_thread, 0, sizeof(client_thread));

Looks like a sensible code refactoring/simplification to me, so:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
