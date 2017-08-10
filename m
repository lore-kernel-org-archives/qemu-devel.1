Received: from eggs.gnu.org ([2001:4830:134:3::10]:38676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dfkdf-0005UN-O9
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 06:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dfkdb-0006cY-OO
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 06:24:27 -0400
Date: Thu, 10 Aug 2017 12:24:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170810102414.GB3650@localhost.localdomain>
References: <DM5PR17MB1451D437FA7145AEBE4688CFDB880@DM5PR17MB1451.namprd17.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR17MB1451D437FA7145AEBE4688CFDB880@DM5PR17MB1451.namprd17.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH] block/qcow2-snapshot: Fix a null pointer
 dereference in qcow2_free_snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hu Chaojian <chaojianhu@hotmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "ppandit@redhat.com" <ppandit@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>

Am 10.08.2017 um 09:52 hat Hu Chaojian geschrieben:
> From: chaojianhu <chaojianhu@hotmail.com>
> 
> In function qcow2_do_open, if "go fail;" before calling qcow2_read_snapshots, then snapshots 
> will always be NULL. When dealing with "fail:", qcow2_free_snapshots will be called, and 
> s->snapshots will be dereferenced without checked.

Did you try to reproduce an actual crash?

Becasue I don't think there will be one. In this case, s->nb_snapshots
is 0, so the loop doesn't even run.

Kevin

> Reported-by: chaojianhu <chaojianhu@hotmail.com>
> Signed-off-by: chaojianhu <chaojianhu@hotmail.com>
> 
> ---
>  block/qcow2-snapshot.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
> index 44243e0..4a8128c 100644
> --- a/block/qcow2-snapshot.c
> +++ b/block/qcow2-snapshot.c
> @@ -35,6 +35,10 @@ void qcow2_free_snapshots(BlockDriverState *bs)
>      BDRVQcow2State *s = bs->opaque;
>      int i;
>  
> +    if (NULL == s->snapshots) {
> +        return;
> +    }
> +
>      for(i = 0; i < s->nb_snapshots; i++) {
>          g_free(s->snapshots[i].name);
>          g_free(s->snapshots[i].id_str);
> -- 
> 1.9.1
> 
