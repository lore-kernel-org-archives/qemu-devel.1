Received: from eggs.gnu.org ([2001:4830:134:3::10]:56085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1duMc0-0002lJ-LU
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1duMbw-0004sr-2Y
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:47:08 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:44834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1duMbv-0004pB-Q2
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:47:04 -0400
Received: from player687.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id D1D1B72A2C
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 19:46:59 +0200 (CEST)
Date: Tue, 19 Sep 2017 19:46:50 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170919194650.5a0c2927@bahia.lan>
In-Reply-To: <20170919142858.73056-1-jan.dakinevich@gmail.com>
References: <20170919002659.3cd0004a@bahia.lan>
	<20170919142858.73056-1-jan.dakinevich@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix readdir() for 9p2000.u
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Dakinevich <jan.dakinevich@gmail.com>
Cc: qemu-devel@nongnu.org

On Tue, 19 Sep 2017 16:28:58 +0200
Jan Dakinevich <jan.dakinevich@gmail.com> wrote:

> -- >8 --  
> Greg,
> 
> Usually, I use 9p as rootfs and run qemu in one of these way. First,
> using initrd with built-in 9p modules:
> 
> $ sudo /path/to/qemu-system-x86_64 \
>     -machine accel=kvm -m 1G -nographic -vga none -serial mon:stdio \
>     -kernel $PWD/rootfs/boot/vmlinuz-3.16.0-4-amd64 \
>     -initrd $PWD/rootfs/boot/initrd.img-3.16.0-4-amd64 \
>     -append "root=rootfs rw rootfstype=9p rootflags=trans=virtio,version=9p2000.u console=ttyS0" \
>     -fsdev local,id=fsdev0,path=$PWD/rootfs,security_model=passthrough \
>     -device virtio-9p-pci,fsdev=fsdev0,mount_tag=rootfs
> 
> Second, with compiled into the kernel 9p support and without initrd (but
> this way quite tricky):
> 
> $ sudo /path/to/qemu-system-x86_64 \
>     -machine accel=kvm -m 1G -nographic -vga none -serial mon:stdio \
>     -kernel /path/to/bzImage \
>     -append "root=/dev/root rw rootfstype=9p rootflags=trans=virtio,version=9p2000.u console=ttyS0" \
>     -fsdev local,id=fsdev0,path=$PWD/rootfs,security_model=passthrough \
>     -device virtio-9p-pci,fsdev=fsdev0,mount_tag=/dev/root
> 

Thanks. I'll give a try.

> This patch mostly uses your commit message, because it is much more
> informative than I could ever suggest.
> 

No problem.

> --
> Best regards
> Jan Dakinevich
> -- >8 -- 

BTW, 'git am' takes all the mail body down to the '---' to build the commit
message, and assumes the patch starts at the first 'diff -'. Anything in
between is silently dropped.

This means that the commit for this patch had to be manually edited to
remove the '-- 8< --' ... '-- >8 --' part.

When you have something to add in the mail that shouldn't go into the
commit message, just put it between the '---' and the patch and it
will be ignored by 'git am' as explained above.

> If the client is using 9p2000.u, the following occurs:
> 
> $ cd ${virtfs_shared_dir}
> $ mkdir -p a/b/c
> $ ls a/b
> ls: cannot access 'a/b/a': No such file or directory
> ls: cannot access 'a/b/b': No such file or directory
> a  b  c
> 
> instead of the expected:
> 
> $ ls a/b
> c
> 
> This is a regression introduced by commit f57f5878578a;
> local_name_to_path() now resolves ".." and "." in paths,
> and v9fs_do_readdir_with_stat()->stat_to_v9stat() then
> copies the basename of the resulting path to the response.
> With the example above, this means that "." and ".." are
> turned into "b" and "a" respectively...
> 
> Actually, the name we need to pass is the d_name field of
> the dirent. Meanwhile, name argument of stat_to_v9stat is
> preserved, since it used to symbolic links resolving.
> 
> To satisfy stat_to_v9stat(), v9fs_stat() takes a care of the
> logic from old stat_to_v9stat() for determining basename of
> the given path.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Even if we agreed on the list that this was the way to go, I'm not
the author, so it shouldn't contain my Signed-off-by yet... It will
have to when I repost it for the pull request though

Anyway, thanks for finding the issue and taking time to fix it.

I hope to merge this and the other patches soon.

Cheers,

--
Greg

> Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
> ---
>  hw/9pfs/9p.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 4d4ed85..6cb9dfc 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -804,11 +804,11 @@ static uint32_t stat_to_v9mode(const struct stat *stbuf)
>  }
>  
>  static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *name,
> +                                       const char *basename,
>                                         const struct stat *stbuf,
>                                         V9fsStat *v9stat)
>  {
>      int err;
> -    const char *str;
>  
>      memset(v9stat, 0, sizeof(*v9stat));
>  
> @@ -842,14 +842,7 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *name,
>                  "HARDLINKCOUNT", (unsigned long)stbuf->st_nlink);
>      }
>  
> -    str = strrchr(name->data, '/');
> -    if (str) {
> -        str += 1;
> -    } else {
> -        str = name->data;
> -    }
> -
> -    v9fs_string_sprintf(&v9stat->name, "%s", str);
> +    v9fs_string_sprintf(&v9stat->name, "%s", basename);
>  
>      v9stat->size = 61 +
>          v9fs_string_size(&v9stat->name) +
> @@ -1058,6 +1051,7 @@ static void coroutine_fn v9fs_stat(void *opaque)
>      struct stat stbuf;
>      V9fsFidState *fidp;
>      V9fsPDU *pdu = opaque;
> +    char *basename;
>  
>      err = pdu_unmarshal(pdu, offset, "d", &fid);
>      if (err < 0) {
> @@ -1074,7 +1068,9 @@ static void coroutine_fn v9fs_stat(void *opaque)
>      if (err < 0) {
>          goto out;
>      }
> -    err = stat_to_v9stat(pdu, &fidp->path, &stbuf, &v9stat);
> +    basename = g_path_get_basename(fidp->path.data);
> +    err = stat_to_v9stat(pdu, &fidp->path, basename, &stbuf, &v9stat);
> +    g_free(basename);
>      if (err < 0) {
>          goto out;
>      }
> @@ -1750,7 +1746,7 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
>          if (err < 0) {
>              break;
>          }
> -        err = stat_to_v9stat(pdu, &path, &stbuf, &v9stat);
> +        err = stat_to_v9stat(pdu, &path, dent->d_name, &stbuf, &v9stat);
>          if (err < 0) {
>              break;
>          }



-- 
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.com
Software Engineer @ IBM/LTC                      http://www.ibm.com
Tel 33-5-6218-1607

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.
