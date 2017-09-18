Received: from eggs.gnu.org ([2001:4830:134:3::10]:33698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1du4VQ-0001ov-G1
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1du4VN-0004dj-CC
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:27:08 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:44364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1du4VN-0004d8-4a
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:27:05 -0400
Received: from player711.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8CB9C7B5B0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 00:27:02 +0200 (CEST)
Date: Tue, 19 Sep 2017 00:26:59 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170919002659.3cd0004a@bahia.lan>
In-Reply-To: <1505767397-20462-1-git-send-email-jan.dakinevich@gmail.com>
References: <150574930075.27635.3945832472060840946.stgit@bahia>
	<1505767397-20462-1-git-send-email-jan.dakinevich@gmail.com>
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

On Mon, 18 Sep 2017 23:43:17 +0300
Jan Dakinevich <jan.dakinevich@gmail.com> wrote:

> ---
> Greg,
> 
> What do you think about this way?

I couldn't reproduce the issue with the symbolic link... can you
provide your QEMU command line and the mount options of the 9p
filesystem ?

Anyway, I had the very same patch in mind because only v9fs_stat() needs the
basename actually and it shouldn't be open-coded in stat_to_v9stat().

Please resend with proper changelog and Signed-off-by and I'll gladly
take it.

Cheers,

--
Greg

> ---
>  hw/9pfs/9p.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index d152f5c..4697c00 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -826,11 +826,11 @@ static uint32_t stat_to_v9mode(const struct stat *stbuf)
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
> @@ -864,14 +864,7 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *name,
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
> @@ -1080,6 +1073,7 @@ static void coroutine_fn v9fs_stat(void *opaque)
>      struct stat stbuf;
>      V9fsFidState *fidp;
>      V9fsPDU *pdu = opaque;
> +    char *basename;
>  
>      err = pdu_unmarshal(pdu, offset, "d", &fid);
>      if (err < 0) {
> @@ -1096,7 +1090,9 @@ static void coroutine_fn v9fs_stat(void *opaque)
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
> @@ -1772,7 +1768,7 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
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
