Received: from eggs.gnu.org ([2001:4830:134:3::10]:40695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fgDBT-00054M-Nj
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 13:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fgDBS-0003Gn-Ti
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 13:57:47 -0400
References: <20180719034118.27741-1-famz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6757101d-316a-79f5-1dbc-4546b054c9da@redhat.com>
Date: Thu, 19 Jul 2018 13:57:37 -0400
MIME-Version: 1.0
In-Reply-To: <20180719034118.27741-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Don't lock /dev/null
 and /dev/zero automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/18/2018 11:41 PM, Fam Zheng wrote:
> On my Fedora 28, /dev/null is locked by some other process (couldn't
> inspect it due to the current lslocks limitation), so iotests 226 fails
> with some unexpected image locking errors because it uses qemu-io to
> open it.
> 
> Actually it's safe to not use any lock on /dev/null or /dev/zero.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 60af4b3d51..8bf034108a 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -503,7 +503,12 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>          s->use_lock = false;
>          break;
>      case ON_OFF_AUTO_AUTO:
> -        s->use_lock = qemu_has_ofd_lock();
> +        if (!strcmp(filename, "/dev/null") ||
> +                   !strcmp(filename, "/dev/zero")) {
> +            s->use_lock = false;
> +        } else {
> +            s->use_lock = qemu_has_ofd_lock();
> +        }
>          break;
>      default:
>          abort();
> 

I apparently caused a lot of failures with 226, oops!

Should we instead modify the test in this case to not attempt to take a
lock on a device we know cannot meaningfully store state, or is it your
preference to attempt to maintain such a list in the raw driver itself?

I guess we never want QEMU to try to lock things like /dev/zero, but I
don't know if there are more such pseudo-devices we should never try to
lock and if so, what common property unifies them such that we don't
have to maintain a list.
