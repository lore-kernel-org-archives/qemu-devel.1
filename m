Received: from eggs.gnu.org ([2001:4830:134:3::10]:49051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNlC3-0000MH-Qx
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNlBz-0003au-Qs
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:26:07 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:42713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fNlBz-0003aO-KH
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:26:03 -0400
Received: from player696.ha.ovh.net (unknown [10.109.108.84])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 0122AC08F6
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 22:26:01 +0200 (CEST)
Date: Tue, 29 May 2018 22:25:58 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180529222558.59230642@bahia.lan>
In-Reply-To: <6205f39b495ee7356478cc53faf5e32289f57182.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<6205f39b495ee7356478cc53faf5e32289f57182.1527310210.git.keno@alumni.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/13] 9p: darwin: Handle struct dirent
 differences
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keno@juliacomputing.com
Cc: qemu-devel@nongnu.org, Keno Fischer <keno@alumni.harvard.edu>

On Sat, 26 May 2018 01:23:07 -0400
keno@juliacomputing.com wrote:

> From: Keno Fischer <keno@alumni.harvard.edu>
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  hw/9pfs/9p-synth.c |  4 ++++
>  hw/9pfs/9p.c       | 18 ++++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index eb68b42..3c0a6d8 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -221,7 +221,11 @@ static void synth_direntry(V9fsSynthNode *node,
>  {
>      strcpy(entry->d_name, node->name);
>      entry->d_ino = node->attr->inode;
> +#ifdef CONFIG_DARWIN
> +    entry->d_seekoff = off + 1;

Hmm... what's that for ? No users in the patchset and the comment
below seem to indicate this wouldn't be trusted anyway.

> +#else
>      entry->d_off = off + 1;
> +#endif
>  }
>  
>  static struct dirent *synth_get_dentry(V9fsSynthNode *dir,
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 1cfdf7d..49654ae 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1801,7 +1801,11 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
>          count += len;
>          v9fs_stat_free(&v9stat);
>          v9fs_path_free(&path);
> +#ifdef CONFIG_DARWIN
> +        saved_dir_pos = v9fs_co_telldir(pdu, fidp);
> +#else
>          saved_dir_pos = dent->d_off;
> +#endif
>      }
>  
>      v9fs_readdir_unlock(&fidp->fs.dir);
> @@ -1952,9 +1956,19 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>          qid.type = 0;
>          qid.version = 0;
>  
> +#ifdef CONFIG_DARWIN
> +        // Darwin has d_seekoff, which appears to function
> +        // analogously to d_off. However, it does not appear
> +        // to be supported on all file systems, so use
> +        // telldir for correctness.

Please use /* */

> +        off_t off = v9fs_co_telldir(pdu, fidp);

Please declare local variables at the beginning of the function. Also,
v9fs_co_telldir() can fail. This requires proper error handling.

> +#else
> +        off_t off = dent->d_off;
> +#endif

Please make this a helper and call it in v9fs_do_readdir_with_stat() as well.

> +
>          /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
>          len = pdu_marshal(pdu, 11 + count, "Qqbs",
> -                          &qid, dent->d_off,
> +                          &qid, off,
>                            dent->d_type, &name);
>  
>          v9fs_readdir_unlock(&fidp->fs.dir);
> @@ -1966,7 +1980,7 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>          }
>          count += len;
>          v9fs_string_free(&name);
> -        saved_dir_pos = dent->d_off;
> +        saved_dir_pos = off;
>      }
>  
>      v9fs_readdir_unlock(&fidp->fs.dir);
