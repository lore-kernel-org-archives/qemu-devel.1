Received: from eggs.gnu.org ([2001:4830:134:3::10]:35281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSrFS-0007ty-Ss
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSrFR-0006SU-0Q
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:26:58 -0500
Date: Fri, 30 Nov 2018 22:26:45 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181130222645.GB27120@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130220344.3350618-5-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/14] qemu-nbd: Simplify --partition
 handling
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

On Fri, Nov 30, 2018 at 04:03:33PM -0600, Eric Blake wrote:
> Our open-coding of strtol handling forgot to handle overflow
> conditions. What's more, since we insiste on a user-supplied

"insist"

> partition to be non-zero, we can use 0 rather than -1 for our
> initial value to distinguish when a partition is not being
> served, for slightly more optimal code.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-nbd.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 55e29bd9a7e..866e64779f1 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -546,7 +546,7 @@ int main(int argc, char **argv)
>      int opt_ind = 0;
>      char *end;
>      int flags = BDRV_O_RDWR;
> -    int partition = -1;
> +    int partition = 0;
>      int ret = 0;
>      bool seen_cache = false;
>      bool seen_discard = false;
> @@ -685,13 +685,9 @@ int main(int argc, char **argv)
>              flags &= ~BDRV_O_RDWR;
>              break;
>          case 'P':
> -            partition = strtol(optarg, &end, 0);
> -            if (*end) {
> -                error_report("Invalid partition `%s'", optarg);
> -                exit(EXIT_FAILURE);
> -            }
> -            if (partition < 1 || partition > 8) {
> -                error_report("Invalid partition %d", partition);
> +            if (qemu_strtoi(optarg, NULL, 0, &partition) < 0 ||
> +                partition < 1 || partition > 8) {
> +                error_report("Invalid partition %s", optarg);

Pffft only supporting a mere 8 partitions :-?  I raised the limits in
nbdkit recently so it can handle an infinite number of partitions :-)

Anyway, it's a problem with the existing code, so doesn't affect the
review.

>                  exit(EXIT_FAILURE);
>              }
>              break;
> @@ -1004,7 +1000,7 @@ int main(int argc, char **argv)
>      }
>      fd_size -= dev_offset;
> 
> -    if (partition != -1) {
> +    if (partition) {
>          ret = find_partition(blk, partition, &dev_offset, &fd_size);
>          if (ret < 0) {
>              error_report("Could not find partition %d: %s", partition,
> -- 
> 2.17.2

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
