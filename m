Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA59C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACA52073E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dO1xnBDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACA52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqXiQ-0007LP-J0
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 04:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqXhl-0006q8-Ua
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 04:02:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33161
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqXh2-0007fx-6h
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 04:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593590526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWw33BeuuKAUTzS6nM0K3WNFFDsLnygx3g0egqRr9+M=;
 b=dO1xnBDPJK95DmfzUZcxyl//HDj97xa1XaDMjA25hYkR53W8GeBV1MZrcMHbKuWMFAWJp5
 74rBCJKKydh85ZwD1TR7h6dWKptfFtzaBSKRShbCVoyxVH0UHxnAqCSs0+bSVaKJwWfoWT
 7tgrmT8ua8SaWqrCSjF2s5EOH1lqdsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-UyvsBWLzNGSooMZE8tzT8A-1; Wed, 01 Jul 2020 04:02:05 -0400
X-MC-Unique: UyvsBWLzNGSooMZE8tzT8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08A0D185B387;
 Wed,  1 Jul 2020 08:02:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D3C42B6CF;
 Wed,  1 Jul 2020 08:02:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A11411384A6; Wed,  1 Jul 2020 10:02:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 10/46] qemu-option: Check return value instead of @err
 where convenient
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-11-armbru@redhat.com>
 <f8e32618-ff39-d505-9d49-1eddf71d364e@virtuozzo.com>
Date: Wed, 01 Jul 2020 10:02:02 +0200
In-Reply-To: <f8e32618-ff39-d505-9d49-1eddf71d364e@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 29 Jun 2020 12:11:42 +0300")
Message-ID: <87v9j7br45.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 24.06.2020 19:43, Markus Armbruster wrote:
>> Convert uses like
>>
>>      opts = qemu_opts_create(..., &err);
>>      if (err) {
>>          ...
>>      }
>>
>> to
>>
>>      opts = qemu_opts_create(..., &err);
>>      if (!opts) {
>>          ...
>>      }
>>
>> Eliminate error_propagate() that are now unnecessary.  Delete @err
>> that are now unused.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   block/parallels.c  |  4 ++--
>>   blockdev.c         |  5 ++---
>>   qdev-monitor.c     |  6 ++----
>>   util/qemu-config.c | 10 ++++------
>>   util/qemu-option.c | 12 ++++--------
>>   5 files changed, 14 insertions(+), 23 deletions(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 860dbb80a2..b15c9ac28d 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -823,8 +823,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>>           }
>>       }
>>   -    opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0,
>> &local_err);
>> -    if (local_err != NULL) {
>> +    opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
>> +    if (!opts) {
>>           goto fail_options;
>>       }
>
> Honestly, I don't like this hunk. as already complicated code (crossing gotos) becomes more
> complicated (add one more pattern to fail_options path: no-op error_propagate).
>
> At least, we'll need a follow-up patch, refactoring parallels_open() to drop "fail_options"
> label completely.

For what it's worth, this is how it looks at the end of the series:

    static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
                              Error **errp)
    {
        BDRVParallelsState *s = bs->opaque;
        ParallelsHeader ph;
        int ret, size, i;
        QemuOpts *opts = NULL;
        Error *local_err = NULL;
        char *buf;

        bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
                                   BDRV_CHILD_IMAGE, false, errp);
        if (!bs->file) {
            return -EINVAL;
        }

        ret = bdrv_pread(bs->file, 0, &ph, sizeof(ph));
        if (ret < 0) {
            goto fail;
        }

        bs->total_sectors = le64_to_cpu(ph.nb_sectors);

        if (le32_to_cpu(ph.version) != HEADER_VERSION) {
            goto fail_format;
        }
        if (!memcmp(ph.magic, HEADER_MAGIC, 16)) {
            s->off_multiplier = 1;
            bs->total_sectors = 0xffffffff & bs->total_sectors;
        } else if (!memcmp(ph.magic, HEADER_MAGIC2, 16)) {
            s->off_multiplier = le32_to_cpu(ph.tracks);
        } else {
            goto fail_format;
        }

        s->tracks = le32_to_cpu(ph.tracks);
        if (s->tracks == 0) {
            error_setg(errp, "Invalid image: Zero sectors per track");
            ret = -EINVAL;
            goto fail;
        }
        if (s->tracks > INT32_MAX/513) {
            error_setg(errp, "Invalid image: Too big cluster");
            ret = -EFBIG;
            goto fail;
        }

        s->bat_size = le32_to_cpu(ph.bat_entries);
        if (s->bat_size > INT_MAX / sizeof(uint32_t)) {
            error_setg(errp, "Catalog too large");
            ret = -EFBIG;
            goto fail;
        }

        size = bat_entry_off(s->bat_size);
        s->header_size = ROUND_UP(size, bdrv_opt_mem_align(bs->file->bs));
        s->header = qemu_try_blockalign(bs->file->bs, s->header_size);
        if (s->header == NULL) {
            ret = -ENOMEM;
            goto fail;
        }
        s->data_end = le32_to_cpu(ph.data_off);
        if (s->data_end == 0) {
            s->data_end = ROUND_UP(bat_entry_off(s->bat_size), BDRV_SECTOR_SIZE);
        }
        if (s->data_end < s->header_size) {
            /* there is not enough unused space to fit to block align between BAT
               and actual data. We can't avoid read-modify-write... */
            s->header_size = size;
        }

        ret = bdrv_pread(bs->file, 0, s->header, s->header_size);
        if (ret < 0) {
            goto fail;
        }
        s->bat_bitmap = (uint32_t *)(s->header + 1);

        for (i = 0; i < s->bat_size; i++) {
            int64_t off = bat2sect(s, i);
            if (off >= s->data_end) {
                s->data_end = off + s->tracks;
            }
        }

        if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
            /* Image was not closed correctly. The check is mandatory */
            s->header_unclean = true;
            if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_CHECK)) {
                error_setg(errp, "parallels: Image was not closed correctly; "
                           "cannot be opened read/write");
                ret = -EACCES;
                goto fail;
            }
        }

        opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
        if (!opts) {
            goto fail_options;
        }

        if (!qemu_opts_absorb_qdict(opts, options, errp)) {
            goto fail_options;
        }

        s->prealloc_size =
            qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
        s->prealloc_size = MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_BITS);
        buf = qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
        /* prealloc_mode can be downgraded later during allocate_clusters */
        s->prealloc_mode = qapi_enum_parse(&prealloc_mode_lookup, buf,
                                           PRL_PREALLOC_MODE_FALLOCATE,
                                           &local_err);
        g_free(buf);
        if (local_err != NULL) {
            error_propagate(errp, local_err);
            goto fail_options;
        }

        if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_INACTIVE)) {
            s->header->inuse = cpu_to_le32(HEADER_INUSE_MAGIC);
            ret = parallels_update_header(bs);
            if (ret < 0) {
                goto fail;
            }
        }

        s->bat_dirty_block = 4 * qemu_real_host_page_size;
        s->bat_dirty_bmap =
            bitmap_new(DIV_ROUND_UP(s->header_size, s->bat_dirty_block));

        /* Disable migration until bdrv_invalidate_cache method is added */
        error_setg(&s->migration_blocker, "The Parallels format used by node '%s' "
                   "does not support live migration",
                   bdrv_get_device_or_node_name(bs));
        ret = migrate_add_blocker(s->migration_blocker, errp);
        if (ret < 0) {
            error_free(s->migration_blocker);
            goto fail;
        }
        qemu_co_mutex_init(&s->lock);
        return 0;

    fail_format:
        error_setg(errp, "Image not in Parallels format");
    fail_options:
        ret = -EINVAL;
    fail:
        qemu_vfree(s->header);
        return ret;
    }

Care to suggest further improvements?

> Still, it should work and the rest is fine, so:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks!


