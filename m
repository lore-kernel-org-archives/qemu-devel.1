Received: from eggs.gnu.org ([209.51.188.92]:47079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gjT9v-0001Du-Gr
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gjT9u-0008Pi-G5
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:09:55 -0500
Date: Tue, 15 Jan 2019 18:09:41 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190115180941.GI27120@redhat.com>
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190112175812.27068-7-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/19] qemu-nbd: Avoid strtol open-coding
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

On Sat, Jan 12, 2019 at 11:57:59AM -0600, Eric Blake wrote:
> Our copy-and-pasted open-coding of strtol handling forgot to
> handle overflow conditions.  Use qemu_strto*() instead.
> 
> In the case of --partition, since we insist on a user-supplied
> partition to be non-zero, we can use 0 rather than -1 for our
> initial value to distinguish when a partition is not being
> served, for slightly more optimal code.
> 
> The error messages for out-of-bounds values are less specific,
> but should not be a terrible loss in quality.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20181215135324.152629-8-eblake@redhat.com>
> 
> ---
> v3: rebase to use int64_t rather than off_t [Vladimir]
> ---
>  qemu-nbd.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 96c0829970c..4670b659167 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -546,9 +546,8 @@ int main(int argc, char **argv)
>      };
>      int ch;
>      int opt_ind = 0;
> -    char *end;
>      int flags = BDRV_O_RDWR;
> -    int partition = -1;
> +    int partition = 0;
>      int ret = 0;
>      bool seen_cache = false;
>      bool seen_discard = false;
> @@ -660,9 +659,8 @@ int main(int argc, char **argv)
>              port = optarg;
>              break;
>          case 'o':
> -                dev_offset = strtoll (optarg, &end, 0);
> -            if (*end) {
> -                error_report("Invalid offset `%s'", optarg);
> +            if (qemu_strtou64(optarg, NULL, 0, &dev_offset) < 0) {
> +                error_report("Invalid offset '%s'", optarg);
>                  exit(EXIT_FAILURE);
>              }
>              break;
> @@ -684,13 +682,9 @@ int main(int argc, char **argv)
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
> +                error_report("Invalid partition '%s'", optarg);
>                  exit(EXIT_FAILURE);
>              }
>              break;
> @@ -711,15 +705,11 @@ int main(int argc, char **argv)
>              device = optarg;
>              break;
>          case 'e':
> -            shared = strtol(optarg, &end, 0);
> -            if (*end) {
> +            if (qemu_strtoi(optarg, NULL, 0, &shared) < 0 ||
> +                shared < 1) {
>                  error_report("Invalid shared device number '%s'", optarg);
>                  exit(EXIT_FAILURE);
>              }
> -            if (shared < 1) {
> -                error_report("Shared device number must be greater than 0");
> -                exit(EXIT_FAILURE);
> -            }
>              break;
>          case 'f':
>              fmt = optarg;
> @@ -1007,7 +997,7 @@ int main(int argc, char **argv)
>      }
>      fd_size -= dev_offset;
> 
> -    if (partition != -1) {
> +    if (partition) {
>          int64_t limit;
> 
>          if (dev_offset) {

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
