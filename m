Received: from eggs.gnu.org ([2001:4830:134:3::10]:36167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiSQ-0003pz-Mj
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiSM-0004bV-M4
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:32:58 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBiSM-0004b1-FA
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:32:54 -0500
Received: by mail-wm0-f66.google.com with SMTP id t139so14664486wmt.1
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 06:32:54 -0800 (PST)
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-17-michael@fritscher.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c7210696-6cac-1c76-46d3-e973bd6d190b@redhat.com>
Date: Mon, 6 Nov 2017 15:32:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170929111323.6308-17-michael@fritscher.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/18] Workaround for missing
 dent->d_type/d_off under Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>, gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org

On 29/09/2017 13:13, Michael Fritscher wrote:
> Signed-off-by: Michael Fritscher <michael@fritscher.net>

I think you should use your own "struct V9fsDirent" instead of "struct
dirent".

Paolo

> ---
>  hw/9pfs/9p.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index f4ccb45f64..4e07bfc71b 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1794,7 +1794,11 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
>          count += len;
>          v9fs_stat_free(&v9stat);
>          v9fs_path_free(&path);
> +#ifdef _WIN32
> +        saved_dir_pos = v9fs_co_telldir(pdu, fidp);
> +#else
>          saved_dir_pos = dent->d_off;
> +#endif
>      }
>  
>      v9fs_readdir_unlock(&fidp->fs.dir);
> @@ -1946,9 +1950,15 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>          qid.version = 0;
>  
>          /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
> +#ifdef _WIN32
> +        len = pdu_marshal(pdu, 11 + count, "Qqbs",
> +                          &qid, v9fs_co_telldir(pdu, fidp),
> +                          DT_UNKNOWN, &name);
> +#else
>          len = pdu_marshal(pdu, 11 + count, "Qqbs",
>                            &qid, dent->d_off,
>                            dent->d_type, &name);
> +#endif
>  
>          v9fs_readdir_unlock(&fidp->fs.dir);
>  
> @@ -1959,7 +1969,11 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>          }
>          count += len;
>          v9fs_string_free(&name);
> +#ifdef _WIN32
> +        saved_dir_pos = v9fs_co_telldir(pdu, fidp);
> +#else
>          saved_dir_pos = dent->d_off;
> +#endif
>      }
>  
>      v9fs_readdir_unlock(&fidp->fs.dir);
> 
