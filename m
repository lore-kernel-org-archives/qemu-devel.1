Received: from eggs.gnu.org ([2001:4830:134:3::10]:40784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXRUR-0001mW-V7
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXRUL-0000DH-CZ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:25:07 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:49910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fXRUK-0000CV-Uo
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:25:01 -0400
Received: from player787.ha.ovh.net (unknown [10.109.122.86])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 0C18A1B944
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 15:24:58 +0200 (CEST)
Date: Mon, 25 Jun 2018 15:24:56 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180625152456.190883d5@bahia.lan>
In-Reply-To: <7d1009b3e1f8c1ee7a5c7bf1fa71282d0345010c.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
	<7d1009b3e1f8c1ee7a5c7bf1fa71282d0345010c.1529196703.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/13] 9p: darwin: Handle struct dirent
 differences
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

On Sat, 16 Jun 2018 20:56:48 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> On darwin d_seekoff exists, but is optional and does not seem to
> be commonly used by file systems. Use `telldir` instead to obtain
> the seek offset.
> 

Thinking again about this one, I guess we also need our own
type for dirent and per-OS qemu_readdir(), and have the Darwin
version to call telldir() directly.

> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  hw/9pfs/9p-synth.c |  2 ++
>  hw/9pfs/9p.c       | 36 ++++++++++++++++++++++++++++++++----
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index eb68b42..a312f8c 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -221,7 +221,9 @@ static void synth_direntry(V9fsSynthNode *node,
>  {
>      strcpy(entry->d_name, node->name);
>      entry->d_ino = node->attr->inode;
> +#ifndef CONFIG_DARWIN
>      entry->d_off = off + 1;
> +#endif
>  }
>  
>  static struct dirent *synth_get_dentry(V9fsSynthNode *dir,
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 8e6b908..06139c9 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1738,6 +1738,25 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
>      return offset;
>  }
>  
> +/**
> + * Get the seek offset of a dirent. If not available from the structure itself,
> + * obtain it by calling telldir.
> + */
> +static int v9fs_dent_telldir(V9fsPDU *pdu, V9fsFidState *fidp,
> +                             struct dirent *dent)
> +{
> +#ifdef CONFIG_DARWIN
> +    /*
> +     * Darwin has d_seekoff, which appears to function similarly to d_off.
> +     * However, it does not appear to be supported on all file systems,
> +     * so use telldir for correctness.
> +     */
> +    return v9fs_co_telldir(pdu, fidp);
> +#else
> +    return dent->d_off;
> +#endif
> +}
> +
>  static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
>                                                    V9fsFidState *fidp,
>                                                    uint32_t max_count)
> @@ -1801,7 +1820,11 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
>          count += len;
>          v9fs_stat_free(&v9stat);
>          v9fs_path_free(&path);
> -        saved_dir_pos = dent->d_off;
> +        saved_dir_pos = v9fs_dent_telldir(pdu, fidp, dent);
> +        if (saved_dir_pos < 0) {
> +            err = saved_dir_pos;
> +            break;
> +        }
>      }
>  
>      v9fs_readdir_unlock(&fidp->fs.dir);
> @@ -1915,7 +1938,7 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>      V9fsString name;
>      int len, err = 0;
>      int32_t count = 0;
> -    off_t saved_dir_pos;
> +    off_t saved_dir_pos, off;
>      struct dirent *dent;
>  
>      /* save the directory position */
> @@ -1951,10 +1974,15 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>          /* Fill the other fields with dummy values */
>          qid.type = 0;
>          qid.version = 0;
> +        off = v9fs_dent_telldir(pdu, fidp, dent);
> +        if (off < 0) {
> +            err = off;
> +            break;
> +        }
>  
>          /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
>          len = pdu_marshal(pdu, 11 + count, "Qqbs",
> -                          &qid, dent->d_off,
> +                          &qid, off,
>                            dent->d_type, &name);
>  
>          v9fs_readdir_unlock(&fidp->fs.dir);
> @@ -1966,7 +1994,7 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>          }
>          count += len;
>          v9fs_string_free(&name);
> -        saved_dir_pos = dent->d_off;
> +        saved_dir_pos = off;
>      }
>  
>      v9fs_readdir_unlock(&fidp->fs.dir);
