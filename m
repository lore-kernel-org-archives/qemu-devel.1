Received: from eggs.gnu.org ([2001:4830:134:3::10]:36123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSrJ3-0001qs-HB
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSrJ2-0004Sx-0h
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:30:41 -0500
Date: Fri, 30 Nov 2018 22:30:25 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181130223025.GC27120@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130220344.3350618-6-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/14] nbd/client: Drop pointless buf
 variable
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

On Fri, Nov 30, 2018 at 04:03:34PM -0600, Eric Blake wrote:
> There's no need to read into a temporary buffer (oversized
> since commit 7d3123e1) followed by a byteswap into a uint64_t
> to check for a magic number via memcmp(), when the code
> immediately below demonstrates reading into the uint64_t then
> byteswapping in place and checking for a magic number via
> integer math.  What's more, having a different error message
> when the server's first reply byte is 0 is unusual - it's no
> different from any other wrong magic number, and we already
> detected short reads.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/nbd-internal.h |  1 +
>  nbd/client.c       | 14 +++-----------
>  2 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
> index eeff78d3c98..306a533dcd1 100644
> --- a/nbd/nbd-internal.h
> +++ b/nbd/nbd-internal.h
> @@ -46,6 +46,7 @@
>  /* Size of oldstyle negotiation */
>  #define NBD_OLDSTYLE_NEGOTIATE_SIZE (8 + 8 + 8 + 4 + 124)
> 
> +#define NBD_INIT_MAGIC              0x4e42444d41474943LL
>  #define NBD_REQUEST_MAGIC           0x25609513
>  #define NBD_OPTS_MAGIC              0x49484156454F5054LL
>  #define NBD_CLIENT_MAGIC            0x0000420281861253LL
> diff --git a/nbd/client.c b/nbd/client.c
> index 0be89f9e641..17ee24492a4 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -731,7 +731,6 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>                            QIOChannel **outioc, NBDExportInfo *info,
>                            Error **errp)
>  {
> -    char buf[256];
>      uint64_t magic;
>      int rc;
>      bool zeroes = true;
> @@ -752,21 +751,14 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>          goto fail;
>      }
> 
> -    if (nbd_read(ioc, buf, 8, errp) < 0) {
> +    if (nbd_read(ioc, &magic, sizeof(magic), errp) < 0) {
>          error_prepend(errp, "Failed to read data: ");
>          goto fail;
>      }
> -
> -    buf[8] = '\0';
> -    if (strlen(buf) == 0) {
> -        error_setg(errp, "Server connection closed unexpectedly");
> -        goto fail;
> -    }
> -
> -    magic = ldq_be_p(buf);
> +    magic = be64_to_cpu(magic);
>      trace_nbd_receive_negotiate_magic(magic);
> 
> -    if (memcmp(buf, "NBDMAGIC", 8) != 0) {
> +    if (magic != NBD_INIT_MAGIC) {
>          error_setg(errp, "Invalid magic received");
>          goto fail;
>      }

The original code is really odd.  What's the whole strlen about?
Anyway this is an obvious improvement so:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
