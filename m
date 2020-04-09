Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15F2C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2DA20678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Uh6QOcaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2DA20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMaWW-00037O-Tc
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 12:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jMaNc-000466-VT
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jMaNb-0004JW-JH
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:50:16 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:53299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jMaNb-0004IM-0p; Thu, 09 Apr 2020 12:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=I+6mDo4XSvy8YKAoUz+SvkbY6cJVefu99/5tiFkst/Y=; 
 b=Uh6QOcaRM2qMjVHAjyWMle3zDrALSVrSy3mWoXd+M9lb2cCdS2aAbEzL2PXbVc2YcJMa4gDG7U4oH5MP1kRB6ZdNqsUfkLvHERBADayI5MyTE6POjES+jsgJ2oAhSOqiAyKZN1ZxJ5OrncEIjRvwpMl5ANkc50QbeLh1eUWq3gYBQzAAR8KXyHNu/KP2OU1nkRweURRwuTRlg5zNBp9Z3kFDKM16I7N4qWX3eMTgxW/C8M3eC5t7QCQVrtq04SC1PKVNCjTR/mjh3Hjk9trkyx4E+D6pMhazgSof1BKTi9alnVHvyqoa2jqb64p2Bdad6ZneA23jzGCpnU8OQ5iyQw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jMaNW-0004mS-WB; Thu, 09 Apr 2020 18:50:11 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jMaNW-0000Cm-Ln; Thu, 09 Apr 2020 18:50:10 +0200
From: Alberto Garcia <berto@igalia.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v12 2/3] qcow2: Allow writing compressed data of multiple
 clusters
In-Reply-To: <1575288906-551879-3-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1575288906-551879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1575288906-551879-3-git-send-email-andrey.shinkevich@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 09 Apr 2020 18:50:10 +0200
Message-ID: <w51y2r41u4d.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 02 Dec 2019 01:15:05 PM CET, Andrey Shinkevich wrote:
> +static coroutine_fn int
> +qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
> +                                 uint64_t offset, uint64_t bytes,
> +                                 QEMUIOVector *qiov, size_t qiov_offset)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    AioTaskPool *aio = NULL;
> +    int ret = 0;
> +
> +    if (has_data_file(bs)) {
> +        return -ENOTSUP;
> +    }
> +
> +    if (bytes == 0) {
> +        /*
> +         * align end of file to a sector boundary to ease reading with
> +         * sector based I/Os
> +         */
> +        int64_t len = bdrv_getlength(bs->file->bs);
> +        if (len < 0) {
> +            return len;
> +        }
> +        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, NULL);
> +    }
> +
> +    if (offset_into_cluster(s, offset)) {
> +        return -EINVAL;
> +    }
> +
> +    while (bytes && aio_task_pool_status(aio) == 0) {
> +        uint64_t chunk_size = MIN(bytes, s->cluster_size);
> +
> +        if (!aio && chunk_size != bytes) {
> +            aio = aio_task_pool_new(QCOW2_MAX_WORKERS);
> +        }
> +
> +        ret = qcow2_add_task(bs, aio, qcow2_co_pwritev_compressed_task_entry,
> +                             0, 0, offset, chunk_size, qiov, qiov_offset, NULL);
> +        if (ret < 0) {
> +            break;
> +        }
> +        qiov_offset += chunk_size;
> +        offset += chunk_size;
> +        bytes -= chunk_size;
> +    }

This patch allows the user to write more than one cluster of compressed
data at a time, and it does so by splitting the request into many
cluster-sized requests and using qcow2_add_task() for each one of them.

What happens however is that there's no guarantee that the requests are
processed in the same order that they were added.

One consequence is that running on an empty qcow2 file a command as
simple as this one:

   qemu-io -c 'write -c 0 256k' image.qcow2

does not always produce the same results.

This does not have any user-visible consequences for the guest. In all
cases the data is correctly written, it's just that the ordering of the
compressed clusters (and therefore the contents of the L2 entries) will
be different each time.

Because of this a test cannot expect that running the same commands on
an empty image produces always the same results.

Is this something that we should be concerned about?

Berto

