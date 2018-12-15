Received: from eggs.gnu.org ([2001:4830:134:3::10]:41213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gYAj7-0005yt-Qk
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 09:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gYAj2-0000Pe-Qw
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 09:15:33 -0500
Date: Sat, 15 Dec 2018 14:15:05 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181215141505.GU27120@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215135324.152629-7-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/22] qemu-nbd: Fail earlier for -c/-d
 on non-linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, nsoffer@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

On Sat, Dec 15, 2018 at 07:53:08AM -0600, Eric Blake wrote:
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
> 
> ---
> v2: Hoist -c error message to share with -d message [Vladimir]
> Bonus: gets rid of a stray TAB in nbd/client.c
> ---
>  nbd/client.c | 18 +-----------------
>  qemu-nbd.c   | 21 +++++++++++++++++++--
>  2 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/nbd/client.c b/nbd/client.c
> index 5d59d5ba78a..3d9086af39d 100644
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
> index e169b839ece..2807e132396 100644
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
> @@ -814,6 +822,12 @@ int main(int argc, char **argv)
>          }
>      }
> 
> +#if !HAVE_NBD_DEVICE
> +    if (disconnect || device) {
> +        error_report("Kernel /dev/nbdN support not available");
> +        exit(EXIT_FAILURE);
> +    }
> +#else /* HAVE_NBD_DEVICE */
>      if (disconnect) {
>          int nbdfd = open(argv[optind], O_RDWR);
>          if (nbdfd < 0) {
> @@ -829,6 +843,7 @@ int main(int argc, char **argv)
> 
>          return 0;
>      }
> +#endif
> 
>      if ((device && !verbose) || fork_process) {
>          int stderr_fd[2];
> @@ -1006,6 +1021,7 @@ int main(int argc, char **argv)
>      nbd_export_set_description(exp, export_description);
> 
>      if (device) {
> +#if HAVE_NBD_DEVICE
>          int ret;
> 
>          ret = pthread_create(&client_thread, NULL, nbd_client_thread, device);
> @@ -1013,6 +1029,7 @@ int main(int argc, char **argv)
>              error_report("Failed to create client thread: %s", strerror(ret));
>              exit(EXIT_FAILURE);
>          }
> +#endif
>      } else {
>          /* Shut up GCC warnings.  */
>          memset(&client_thread, 0, sizeof(client_thread));
> -- 

An obvious simplification of the last version, so:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
