Received: from eggs.gnu.org ([2001:4830:134:3::10]:48691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d1E2R-0000ff-Mz
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 11:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d1E2Q-0002wW-MF
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 11:30:31 -0400
Date: Thu, 20 Apr 2017 16:30:16 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170420153016.GI3227@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170420040003.31074-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420040003.31074-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sheepdog: Set error when connection fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, sheepdog@lists.wpkg.org, qemu-block@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>

On Thu, Apr 20, 2017 at 12:00:03PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/sheepdog.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index fb9203e..7e889ee 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -608,6 +608,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
>          qemu_set_nonblock(fd);
>      } else {
>          fd = -EIO;
> +        error_setg(errp, "Failed to connect to sheepdog server");
>      }

This doesn't make much sense to me. The lines just above the
diff context have this:

    fd = socket_connect(s->addr, errp, NULL, NULL);

socket_connect should have already reported an error on "errp"
in the scenario that 'fd == -1'. So AFAICT the new error_setg is
just throwing away the real detailed error message in favour of
a generic message.

So I'm puzzelled why we need to change anything - error reporting
should already be working fine.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
