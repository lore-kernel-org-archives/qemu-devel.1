Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7A3C4332E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E92F2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfXxLOX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E92F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF26X-0007Gq-DS
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 16:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jF25r-0006kh-Kk
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jF25q-0007sa-66
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:48:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55413)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jF25q-0007rl-2k
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584650921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Muy3tfFd+GorOfGquCXgawvTrretvQgMR4KM65gL/k8=;
 b=AfXxLOX5ljhyEZLG5x7JJKbzpkvR/Hze5mIrZRnlLdytTfE4BqkNbwBUv4sN4eUEsUlCkj
 PkszJgDxce04+GfiwN+XGDwYhqKxC3wk5fg35UA09w3O3sKdtTg7Zy/DZLfTOCw5GACJ1c
 jpKWCTZPYoLUpC74sztDFHnH/09Cx8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-HYe_ZYiqOZqM3ltxaP_R8w-1; Thu, 19 Mar 2020 16:48:35 -0400
X-MC-Unique: HYe_ZYiqOZqM3ltxaP_R8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B06B107ACC4;
 Thu, 19 Mar 2020 20:48:34 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93B435C1B0;
 Thu, 19 Mar 2020 20:48:27 +0000 (UTC)
Subject: Re: [PATCH] lockable: replaced locks with lock guard macros where
 appropriate
To: dnbrdsky@gmail.com, stefanha@gmail.com
References: <20200319161925.1818377-1-dnbrdsky@gmail.com>
 <20200319161925.1818377-2-dnbrdsky@gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8a44d121-81fe-fb52-29db-edb0ad4d48be@redhat.com>
Date: Thu, 19 Mar 2020 15:48:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319161925.1818377-2-dnbrdsky@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 11:19 AM, dnbrdsky@gmail.com wrote:
> From: danbrodsky <dnbrdsky@gmail.com>
> 
> - ran regexp "qemu_mutex_lock\(.*\).*\n.*if" to find targets
> - replaced result with QEMU_LOCK_GUARD if all unlocks at function end
> - replaced result with WITH_QEMU_LOCK_GUARD if unlock not at end
> 
> Signed-off-by: danbrodsky <dnbrdsky@gmail.com>
> ---
>   block/iscsi.c         | 23 +++++++------------
>   block/nfs.c           | 53 ++++++++++++++++++++-----------------------
>   cpus-common.c         | 13 ++++-------
>   hw/display/qxl.c      | 44 +++++++++++++++++------------------
>   hw/vfio/platform.c    |  4 +---
>   migration/migration.c |  3 +--
>   migration/multifd.c   |  8 +++----
>   migration/ram.c       |  3 +--
>   monitor/misc.c        |  4 +---
>   ui/spice-display.c    | 14 ++++++------
>   util/log.c            |  4 ++--
>   util/qemu-timer.c     | 17 +++++++-------
>   util/rcu.c            |  8 +++----
>   util/thread-pool.c    |  3 +--
>   util/vfio-helpers.c   |  4 ++--
>   15 files changed, 90 insertions(+), 115 deletions(-)

That's a rather big patch touching multiple areas of code at once; I'm 
not sure if it would be easier to review if you were to break it up into 
a series of smaller patches each touching a smaller group of related 
files.  For example, I don't mind reviwing block/, but tend to shy away 
from migration/ code.

> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 682abd8e09..df73bde114 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -1086,23 +1086,21 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
>       acb->task->expxferlen = acb->ioh->dxfer_len;
>   
>       data.size = 0;
> -    qemu_mutex_lock(&iscsilun->mutex);
> +    QEMU_LOCK_GUARD(&iscsilun->mutex);
>       if (acb->task->xfer_dir == SCSI_XFER_WRITE) {
>           if (acb->ioh->iovec_count == 0) {
>               data.data = acb->ioh->dxferp;
>               data.size = acb->ioh->dxfer_len;
>           } else {
>               scsi_task_set_iov_out(acb->task,
> -                                 (struct scsi_iovec *) acb->ioh->dxferp,
> -                                 acb->ioh->iovec_count);
> +                                  (struct scsi_iovec *)acb->ioh->dxferp,
> +                                  acb->ioh->iovec_count);

This looks like a spurious whitespace change.  Why is it part of the patch?

>           }
>       }
>   
>       if (iscsi_scsi_command_async(iscsi, iscsilun->lun, acb->task,
>                                    iscsi_aio_ioctl_cb,
> -                                 (data.size > 0) ? &data : NULL,
> -                                 acb) != 0) {
> -        qemu_mutex_unlock(&iscsilun->mutex);
> +                                 (data.size > 0) ? &data : NULL, acb) != 0) {
>           scsi_free_scsi_task(acb->task);

Unwrapping the line fit in 80 columns, but again, why are you mixing 
whitespace changes in rather than focusing on the cleanup of mutex 
actions?  Did you create this patch mechanically with a tool like 
Coccinelle, as the source of your reflowing of lines?  If so, what was 
the input to Coccinelle; if it was some other automated tool, can you 
include the formula so that someone else could reproduce your changes 
(whitespace and all)?  If it was not automated, that's also okay, but 
then I would not expect as much whitespace churn.

> @@ -1111,18 +1109,16 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
>       /* tell libiscsi to read straight into the buffer we got from ioctl */
>       if (acb->task->xfer_dir == SCSI_XFER_READ) {
>           if (acb->ioh->iovec_count == 0) {
> -            scsi_task_add_data_in_buffer(acb->task,
> -                                         acb->ioh->dxfer_len,
> +            scsi_task_add_data_in_buffer(acb->task, acb->ioh->dxfer_len,
>                                            acb->ioh->dxferp);
>           } else {
>               scsi_task_set_iov_in(acb->task,
> -                                 (struct scsi_iovec *) acb->ioh->dxferp,
> +                                 (struct scsi_iovec *)acb->ioh->dxferp,
>                                    acb->ioh->iovec_count);

Again, spurious whitespace changes.

>           }
>       }
>   
>       iscsi_set_events(iscsilun);
> -    qemu_mutex_unlock(&iscsilun->mutex);
>   
>       return &acb->common;
>   }
> @@ -1395,20 +1391,17 @@ static void iscsi_nop_timed_event(void *opaque)
>   {
>       IscsiLun *iscsilun = opaque;
>   
> -    qemu_mutex_lock(&iscsilun->mutex);
> +    QEMU_LOCK_GUARD(&iscsilun->mutex);
>       if (iscsi_get_nops_in_flight(iscsilun->iscsi) >= MAX_NOP_FAILURES) {
>           error_report("iSCSI: NOP timeout. Reconnecting...");
>           iscsilun->request_timed_out = true;
>       } else if (iscsi_nop_out_async(iscsilun->iscsi, NULL, NULL, 0, NULL) != 0) {
>           error_report("iSCSI: failed to sent NOP-Out. Disabling NOP messages.");
> -        goto out;
> +        return;
>       }
>   
>       timer_mod(iscsilun->nop_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + NOP_INTERVAL);
>       iscsi_set_events(iscsilun);
> -
> -out:
> -    qemu_mutex_unlock(&iscsilun->mutex);
>   }

But the cleanup itself is functionally correct in this file.

>   
>   static void iscsi_readcapacity_sync(IscsiLun *iscsilun, Error **errp)
> diff --git a/block/nfs.c b/block/nfs.c
> index 9a6311e270..37e8b82731 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -273,15 +273,14 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offset,
>       nfs_co_init_task(bs, &task);
>       task.iov = iov;
>   
> -    qemu_mutex_lock(&client->mutex);
> -    if (nfs_pread_async(client->context, client->fh,
> -                        offset, bytes, nfs_co_generic_cb, &task) != 0) {
> -        qemu_mutex_unlock(&client->mutex);
> -        return -ENOMEM;
> -    }
> +    WITH_QEMU_LOCK_GUARD(&client->mutex) {
> +        if (nfs_pread_async(client->context, client->fh,
> +                            offset, bytes, nfs_co_generic_cb, &task) != 0) {
> +            return -ENOMEM;
> +        }
>   
> -    nfs_set_events(client);
> -    qemu_mutex_unlock(&client->mutex);
> +        nfs_set_events(client);
> +    }
>       while (!task.complete) {
>           qemu_coroutine_yield();
>       }

This one also looks correct.

> @@ -290,7 +289,7 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offset,
>           return task.ret;
>       }
>   
> -    /* zero pad short reads */
> +/* zero pad short reads */
>       if (task.ret < iov->size) {

Another spurious whitespace change; in fact, the indentation on the 
comment is now wrong.

> +++ b/cpus-common.c

And that's as far as I feel comfortable reviewing.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


