Received: from eggs.gnu.org ([2001:4830:134:3::10]:37555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cWidd-0005ch-Rg
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cWidZ-00078s-VK
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:54:49 -0500
Received: from mo69.mail-out.ovh.net ([178.32.228.69]:60099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cWidZ-00075x-ON
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:54:45 -0500
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 826C019D4F
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 12:54:36 +0100 (CET)
Date: Thu, 26 Jan 2017 12:54:33 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170126125433.5979903a@bahia.lan>
In-Reply-To: <20170126100705.6005-1-pbonzini@redhat.com>
References: <20170126100705.6005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix v9fs_lock error case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com

On Thu, 26 Jan 2017 11:07:05 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> In this case, we are marshaling an error status instead of the errno value.
> Reorganize the out and out_nofid labels to look like all the other cases.
> Coverity reports this because the "err = -ENOENT" and "err = -EINVAL"
> assignments above are dead, overwritten by the call to pdu_marshal.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

There was a confusion indeed: if the server fails it should report it to the
client with an RERROR message.

Responding an RLOCK message with a P9_LOCK_ERROR status only makes sense
when actually implementing locking (i.e. calling flock() on the backend),
which isn't the case in QEMU as stated in the comment above v9fs_lock(). 
We should hence always report a P9_LOCK_SUCCESS status when responding
an RLOCK message.

Just to make it clear, I've modified your patch to open code this and
pushed it to https://github.com/gkurz/qemu/commits/9p-next .

BTW, I've registered to https://scan.coverity.com/projects/qemu as
Peter suggested on IRC. I'll have a look at the other 9pfs issues.

Cheers.

--
Greg

>  hw/9pfs/9p.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 99e9472..d028eca 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3045,14 +3045,15 @@ static void coroutine_fn v9fs_lock(void *opaque)
>          goto out;
>      }
>      status = P9_LOCK_SUCCESS;
> -out:
> -    put_fid(pdu, fidp);
> -out_nofid:
>      err = pdu_marshal(pdu, offset, "b", status);
> -    if (err > 0) {
> -        err += offset;
> +    if (err < 0) {
> +        goto out;
>      }
> +    err += offset;
>      trace_v9fs_lock_return(pdu->tag, pdu->id, status);
> +out:
> +    put_fid(pdu, fidp);
> +out_nofid:
>      pdu_complete(pdu, err);
>      v9fs_string_free(&flock.client_id);
>  }
