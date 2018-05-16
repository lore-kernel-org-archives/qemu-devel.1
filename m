Received: from eggs.gnu.org ([2001:4830:134:3::10]:53874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fIzwV-0003y7-PR
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fIzwR-00029w-HY
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:10:23 -0400
Date: Wed, 16 May 2018 13:10:12 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180516171012.GB6999@localhost.localdomain>
References: <20180516160816.26259-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516160816.26259-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nfs: Remove processed options from QDict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org

On Wed, May 16, 2018 at 06:08:16PM +0200, Kevin Wolf wrote:
> Commit c22a03454 QAPIfied option parsing in the NFS block driver, but
> forgot to remove all the options we processed. Therefore, we get an
> error in bdrv_open_inherit(), which thinks the remaining options are
> invalid. Trying to open an NFS image will result in an error like this:
> 
>     Block protocol 'nfs' doesn't support the option 'server.host'
> 
> Remove all options from the QDict to make the NFS driver work again.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/nfs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/nfs.c b/block/nfs.c
> index 66fddf12d4..d6364d28bb 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -557,6 +557,7 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
>      BlockdevOptionsNfs *opts = NULL;
>      QObject *crumpled = NULL;
>      Visitor *v;
> +    const QDictEntry *e;
>      Error *local_err = NULL;
>  
>      crumpled = qdict_crumple(options, errp);
> @@ -573,6 +574,12 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
>          return NULL;
>      }
>  
> +    /* Remove the processed options from the QDict (the visitor processes
> +     * _all_ options in the QDict) */
> +    while ((e = qdict_first(options))) {
> +        qdict_del(options, e->key);
> +    }
> +
>      return opts;
>  }
>  
> -- 
> 2.13.6
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff
