Received: from eggs.gnu.org ([2001:4830:134:3::10]:48909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXl0o-0002GV-A9
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXl0j-0000cW-8H
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:15:50 -0400
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:36412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fXl0j-0000cC-0k
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:15:45 -0400
Received: from player760.ha.ovh.net (unknown [10.109.122.110])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 511311658ED
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 12:15:42 +0200 (CEST)
Date: Tue, 26 Jun 2018 12:15:35 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180626121535.3fd52346@bahia.lan>
In-Reply-To: <b8df01a2077daf301da4f3e3cd9c2fbbbd0fea5e.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
	<b8df01a2077daf301da4f3e3cd9c2fbbbd0fea5e.1529196703.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/13] 9p: darwin: Provide a
 compatibility definition for XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: qemu-devel@nongnu.org

On Sat, 16 Jun 2018 20:56:51 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  hw/9pfs/9p.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index e650459..abfb8dc 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3374,6 +3374,13 @@ out_nofid:
>      v9fs_string_free(&name);
>  }
>  
> +#if defined(CONFIG_DARWIN) && !defined(XATTR_SIZE_MAX)
> +/* Darwin doesn't seem to define a maximum xattr size in its user
> +   user space header, but looking at the kernel source, HFS supports
> +   up to INT32_MAX, so use that as the maximum.
> +*/
> +#define XATTR_SIZE_MAX INT32_MAX

XATTR_SIZE_MAX is used to cap the size that was received from the client,
and then we do:

    xattr_fidp->fs.xattr.value = g_malloc0(size);

so I'd rather have something very much smaller than 4 gigs.

I now think that having an explicit dependency on XATTR_SIZE_MAX was a poor
choice actually. The problem isn't related to what the host supports, but
only to set a reasonable limit on what we accept from guests. We don't want
a buggy 9p client to crash QEMU.

TXATTRCREATE is only present in the 9p2000.L protocol, ie, linux guests,
which I don't expect to create extended attributes greater than 64k (ie,
XATTR_SIZE_MAX in the guest). We've been using this value for nearly two
years and nobody complained.

No need for a define. I guess you can open code the limit at the only
location where it is needed, with a short comment.

> +#endif
>  static void coroutine_fn v9fs_xattrcreate(void *opaque)
>  {
>      int flags, rflags = 0;
