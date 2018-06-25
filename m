Received: from eggs.gnu.org ([2001:4830:134:3::10]:35024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXRKY-0001c2-25
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXRKU-0002ZD-0p
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:14:54 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:50092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fXRKT-0002XH-Mc
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:14:49 -0400
Received: from player739.ha.ovh.net (unknown [10.109.120.5])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id CD52DB595D
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 15:14:41 +0200 (CEST)
Date: Mon, 25 Jun 2018 15:14:37 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180625151437.01ca6d75@bahia.lan>
In-Reply-To: <ec573a3aaa6aeeb5ba1ffac528e22501b7b168f6.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
	<ec573a3aaa6aeeb5ba1ffac528e22501b7b168f6.1529196703.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/13] 9p: darwin: Handle struct
 stat(fs) differences
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

On Sat, 16 Jun 2018 20:56:47 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---

The problem with 'struct stat' and 'struct statfs' is that they're not only
system types, but also part of the FileOperations API in fsdev/file-op-9p.h:

    int (*lstat)(FsContext *, V9fsPath *, struct stat *);
    int (*fstat)(FsContext *, int, V9fsFidOpenState *, struct stat *);
    int (*statfs)(FsContext *s, V9fsPath *path, struct statfs *stbuf);

and these shouldn't depend on the host OS. I guess it's time to introduce our
own types, based on the Linux ones, as well as qemu_stat*() per-OS helpers.

This would allow to get rid of many ifdefs in this patch.

>  fsdev/virtfs-proxy-helper.c | 14 +++++++++++---
>  hw/9pfs/9p-proxy.c          | 17 ++++++++++++++---
>  hw/9pfs/9p-synth.c          |  2 ++
>  hw/9pfs/9p.c                | 16 ++++++++++++++--
>  4 files changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
> index 94fb069..3bc1269 100644
> --- a/fsdev/virtfs-proxy-helper.c
> +++ b/fsdev/virtfs-proxy-helper.c
> @@ -506,12 +506,15 @@ static void stat_to_prstat(ProxyStat *pr_stat, struct stat *stat)
>      pr_stat->st_size = stat->st_size;
>      pr_stat->st_blksize = stat->st_blksize;
>      pr_stat->st_blocks = stat->st_blocks;
> +#ifdef CONFIG_DARWIN
> +    pr_stat->st_atim_nsec = stat->st_atimespec.tv_nsec;
> +    pr_stat->st_mtim_nsec = stat->st_mtimespec.tv_nsec;
> +    pr_stat->st_ctim_nsec = stat->st_ctimespec.tv_nsec;
> +#else
>      pr_stat->st_atim_sec = stat->st_atim.tv_sec;
> -    pr_stat->st_atim_nsec = stat->st_atim.tv_nsec;
>      pr_stat->st_mtim_sec = stat->st_mtim.tv_sec;
> -    pr_stat->st_mtim_nsec = stat->st_mtim.tv_nsec;
>      pr_stat->st_ctim_sec = stat->st_ctim.tv_sec;
> -    pr_stat->st_ctim_nsec = stat->st_ctim.tv_nsec;

Hmm... this is wrong. It translates tv_nsec only with Darwin and
tv_sec only with Linux.

> +#endif
>  }
>  
>  static void statfs_to_prstatfs(ProxyStatFS *pr_stfs, struct statfs *stfs)
> @@ -524,10 +527,15 @@ static void statfs_to_prstatfs(ProxyStatFS *pr_stfs, struct statfs *stfs)
>      pr_stfs->f_bavail = stfs->f_bavail;
>      pr_stfs->f_files = stfs->f_files;
>      pr_stfs->f_ffree = stfs->f_ffree;
> +#ifdef CONFIG_DARWIN
> +    pr_stfs->f_fsid[0] = stfs->f_fsid.val[0];
> +    pr_stfs->f_fsid[1] = stfs->f_fsid.val[1];
> +#else
>      pr_stfs->f_fsid[0] = stfs->f_fsid.__val[0];
>      pr_stfs->f_fsid[1] = stfs->f_fsid.__val[1];
>      pr_stfs->f_namelen = stfs->f_namelen;
>      pr_stfs->f_frsize = stfs->f_frsize;



Hmm... the ProxyStatFS type is part of the protocol used between
QEMU and virtfs-proxy-helper. It isn't acceptable to send a partly
initialized structure back to QEMU. If something is missing on
Darwin, please provide a fallback in Darwin's implementation for
qemu_statfs().

> +#endif
>  }
>  
>  /*
> diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> index 47a94e0..8a2c174 100644
> --- a/hw/9pfs/9p-proxy.c
> +++ b/hw/9pfs/9p-proxy.c
> @@ -117,10 +117,15 @@ static void prstatfs_to_statfs(struct statfs *stfs, ProxyStatFS *prstfs)
>      stfs->f_bavail = prstfs->f_bavail;
>      stfs->f_files = prstfs->f_files;
>      stfs->f_ffree = prstfs->f_ffree;
> +#ifdef CONFIG_DARWIN
> +    stfs->f_fsid.val[0] = prstfs->f_fsid[0] & 0xFFFFFFFFU;
> +    stfs->f_fsid.val[1] = prstfs->f_fsid[1] >> 32 & 0xFFFFFFFFU;
> +#else
>      stfs->f_fsid.__val[0] = prstfs->f_fsid[0] & 0xFFFFFFFFU;
>      stfs->f_fsid.__val[1] = prstfs->f_fsid[1] >> 32 & 0xFFFFFFFFU;
>      stfs->f_namelen = prstfs->f_namelen;
>      stfs->f_frsize = prstfs->f_frsize;

Same remark.

> +#endif
>  }
>  
>  /* Converts proxy_stat structure to VFS stat structure */
> @@ -137,12 +142,18 @@ static void prstat_to_stat(struct stat *stbuf, ProxyStat *prstat)
>     stbuf->st_size = prstat->st_size;
>     stbuf->st_blksize = prstat->st_blksize;
>     stbuf->st_blocks = prstat->st_blocks;
> -   stbuf->st_atim.tv_sec = prstat->st_atim_sec;
> -   stbuf->st_atim.tv_nsec = prstat->st_atim_nsec;
> +   stbuf->st_atime = prstat->st_atim_sec;
>     stbuf->st_mtime = prstat->st_mtim_sec;
> -   stbuf->st_mtim.tv_nsec = prstat->st_mtim_nsec;
>     stbuf->st_ctime = prstat->st_ctim_sec;
> +#ifdef CONFIG_DARWIN
> +   stbuf->st_atimespec.tv_nsec = prstat->st_atim_nsec;
> +   stbuf->st_mtimespec.tv_nsec = prstat->st_mtim_nsec;
> +   stbuf->st_ctimespec.tv_nsec = prstat->st_ctim_nsec;
> +#else
> +   stbuf->st_atim.tv_nsec = prstat->st_atim_nsec;
> +   stbuf->st_mtim.tv_nsec = prstat->st_mtim_nsec;
>     stbuf->st_ctim.tv_nsec = prstat->st_ctim_nsec;
> +#endif
>  }
>  
>  /*
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index 54239c9..eb68b42 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -426,7 +426,9 @@ static int synth_statfs(FsContext *s, V9fsPath *fs_path,
>      stbuf->f_bsize = 512;
>      stbuf->f_blocks = 0;
>      stbuf->f_files = synth_node_count;
> +#ifndef CONFIG_DARWIN
>      stbuf->f_namelen = NAME_MAX;
> +#endif
>      return 0;
>  }
>  
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index eef289e..8e6b908 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -905,11 +905,17 @@ static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
>      v9lstat->st_blksize = stbuf->st_blksize;
>      v9lstat->st_blocks = stbuf->st_blocks;
>      v9lstat->st_atime_sec = stbuf->st_atime;
> -    v9lstat->st_atime_nsec = stbuf->st_atim.tv_nsec;
>      v9lstat->st_mtime_sec = stbuf->st_mtime;
> -    v9lstat->st_mtime_nsec = stbuf->st_mtim.tv_nsec;
>      v9lstat->st_ctime_sec = stbuf->st_ctime;
> +#ifdef CONFIG_DARWIN
> +    v9lstat->st_atime_nsec = stbuf->st_atimespec.tv_nsec;
> +    v9lstat->st_mtime_nsec = stbuf->st_mtimespec.tv_nsec;
> +    v9lstat->st_ctime_nsec = stbuf->st_ctimespec.tv_nsec;
> +#else
> +    v9lstat->st_atime_nsec = stbuf->st_atim.tv_nsec;
> +    v9lstat->st_mtime_nsec = stbuf->st_mtim.tv_nsec;
>      v9lstat->st_ctime_nsec = stbuf->st_ctim.tv_nsec;
> +#endif
>      /* Currently we only support BASIC fields in stat */
>      v9lstat->st_result_mask = P9_STATS_BASIC;
>  
> @@ -2959,9 +2965,15 @@ static int v9fs_fill_statfs(V9fsState *s, V9fsPDU *pdu, struct statfs *stbuf)
>      f_bavail = stbuf->f_bavail/bsize_factor;
>      f_files  = stbuf->f_files;
>      f_ffree  = stbuf->f_ffree;
> +#ifdef CONFIG_DARWIN
> +    fsid_val = (unsigned int)stbuf->f_fsid.val[0] |
> +               (unsigned long long)stbuf->f_fsid.val[1] << 32;
> +    f_namelen = MAXNAMLEN;

Like said above, I'd prefer f_namelen being set to NAME_MAX, which is
the POSIX equivalent of MAXNAMLEN, in the backends (like you did for
9p synth).

> +#else
>      fsid_val = (unsigned int) stbuf->f_fsid.__val[0] |
>                 (unsigned long long)stbuf->f_fsid.__val[1] << 32;
>      f_namelen = stbuf->f_namelen;
> +#endif
>  
>      return pdu_marshal(pdu, offset, "ddqqqqqqd",
>                         f_type, f_bsize, f_blocks, f_bfree,
