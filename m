Received: from eggs.gnu.org ([2001:4830:134:3::10]:36244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ejREB-0007vU-ID
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ejRE7-0004T4-4I
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:01:39 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1516366207-109842-6-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-6-git-send-email-anton.nefedov@virtuozzo.com>
Date: Wed, 07 Feb 2018 16:00:56 +0100
Message-ID: <w514lmsvo7r.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 5/8] scsi: move unmap error
 checking to the complete callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

On Fri 19 Jan 2018 01:50:04 PM CET, Anton Nefedov wrote:
> This will help to account the operation in the following commit.
>
> The difference is that we don't call scsi_disk_req_check_error() before
> the 1st discard iteration anymore. That function also checks if
> the request is cancelled, however it shouldn't get canceled until it
> yields in blk_aio() functions anyway.
> Same approach is already used for emulate_write_same.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

> @@ -1665,7 +1662,12 @@ static void scsi_unmap_complete(void *opaque, int ret)
>      r->req.aiocb = NULL;
>  
>      aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
> -    scsi_unmap_complete_noio(data, ret);
> +    if (scsi_disk_req_check_error(r, ret, false)) {
> +        scsi_req_unref(&r->req);
> +        g_free(data);

It would be nice not to have the cleanup code duplicated here, but I
don't see any obvious alternative.

Berto
