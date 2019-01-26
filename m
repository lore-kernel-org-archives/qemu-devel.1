Received: from eggs.gnu.org ([209.51.188.92]:56200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gnIDt-00005k-Oa
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 02:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gnIDq-0003df-7w
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 02:17:48 -0500
Date: Sat, 26 Jan 2019 07:17:12 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190126071712.GT12500@redhat.com>
References: <20190125234837.2272-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125234837.2272-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-nbd: Deprecate qemu-nbd --partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, qemu-block@nongnu.org, thuth@redhat.com, "reviewer:Incompatible changes" <libvir-list@redhat.com>

On Fri, Jan 25, 2019 at 05:48:37PM -0600, Eric Blake wrote:
> The existing qemu-nbd --partition code claims to handle logical
> partitions up to 8, since its introduction in 2008 (commit 7a5ca86).
> However, the implementation is bogus (actual MBR logical partitions
> form a sort of linked list, with one partition per extended table
> entry, rather than four logical partitions in a single extended
> table), making the code unlikely to work for anything beyond -P5 on
> actual guest images. What's more, the code does not support GPT
> partitions, which are becoming more popular, and maintaining device
> subsetting in both NBD and the raw device is unnecessary duplication
> of effort (even if it is not too difficult).
> 
> Note that obtaining the offsets of a partition (MBR or GPT) can be
> learned by using 'qemu-nbd -c /dev/nbd0 file.qcow2 && sfdisk --dump
> /dev/nbd0', but by the time you've done that, you might as well
> just mount /dev/nbd0p1 that the kernel creates for you instead of
> bothering with qemu exporting a subset.  Or, keeping to just
> user-space code, use nbdkit's partition filter, which has already
> known both GPT and primary MBR partitions for a while, and was
> just recently enhanced to support arbitrary logical MBR parititions.
> 
> Start the clock on the deprecation cycle, with examples of how
> to write device subsetting without using -P.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: actual nbdkit example [Rich], improved doc wording
> ---
>  qemu-deprecated.texi | 33 +++++++++++++++++++++++++++++++++
>  qemu-nbd.texi        |  6 ++++--
>  qemu-nbd.c           |  2 ++
>  3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 219206a836f..d35e78c81ff 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -175,3 +175,36 @@ The above, converted to the current supported format:
>  @subsubsection "irq": "" (since 3.0.0)
> 
>  The ``irq'' property is obsoleted.
> +
> +@section Related binaries
> +
> +@subsection qemu-nbd --partition (since 4.0.0)
> +
> +The ``qemu-nbd --partition $digit'' code (also spelled @option{-P})
> +can only handle MBR partitions, and has never correctly handled
> +logical partitions beyond partition 5.  If you know the offset and
> +length of the partition (perhaps by using @code{sfdisk} within the
> +guest), you can achieve the effect of exporting just that subset of
> +the disk by use of the @option{--image-opts} option with a raw
> +blockdev using the @code{offset} and @code{size} parameters layered on
> +top of any other existing blockdev. For example, if partition 1 is
> +100MiB long starting at 1MiB, the old command:
> +
> +@code{qemu-nbd -t -P 1 -f qcow2 file.qcow2}
> +
> +can be rewritten as:
> +
> +@code{qemu-nbd -t --image-opts driver=raw,offset=1M,size=100M,file.driver=qcow2,file.backing.driver=file,file.backing.filename=file.qcow2}
> +
> +Alternatively, the @code{nbdkit} project provides a more powerful
> +partition filter on top of its nbd plugin, which can be used to select
> +an arbitrary MBR or GPT partition on top of any other full-image NBD
> +export.  Using this to rewrite the above example results in:
> +
> +@code{qemu-nbd -t -k /tmp/sock -f qcow2 file.qcow2 &}
> +@code{nbdkit -f --filter=partition nbd socket=/tmp/sock partition=1}
> +
> +Note that if you are exposing the export via /dev/nbd0, it is easier
> +to just export the entire image and then mount only /dev/nbd0p1 than
> +it is to reinvoke @command{qemu-nbd -c /dev/nbd0} limited to just a
> +subset of the image.
> diff --git a/qemu-nbd.texi b/qemu-nbd.texi
> index 386bece4680..d0c51828149 100644
> --- a/qemu-nbd.texi
> +++ b/qemu-nbd.texi
> @@ -56,8 +56,10 @@ auto-detecting.
>  @item -r, --read-only
>  Export the disk as read-only.
>  @item -P, --partition=@var{num}
> -Only expose MBR partition @var{num}.  Understands physical partitions
> -1-4 and logical partitions 5-8.
> +Deprecated: Only expose MBR partition @var{num}.  Understands physical
> +partitions 1-4 and logical partition 5. New code should instead use
> +@option{--image-opts} with the raw driver wrapping a subset of the
> +original image.
>  @item -B, --bitmap=@var{name}
>  If @var{filename} has a qcow2 persistent bitmap @var{name}, expose
>  that bitmap via the ``qemu:dirty-bitmap:@var{name}'' context
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 1f7b2a03f5d..00c07fd27ea 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -787,6 +787,8 @@ int main(int argc, char **argv)
>              flags &= ~BDRV_O_RDWR;
>              break;
>          case 'P':
> +            warn_report("The '-P' option is deprecated; use --image-opts with "
> +                        "a raw device wrapper for subset exports instead");
>              if (qemu_strtoi(optarg, NULL, 0, &partition) < 0 ||
>                  partition < 1 || partition > 8) {
>                  error_report("Invalid partition '%s'", optarg);
> -- 
> 2.20.1

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
