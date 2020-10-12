Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA713C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF1E20776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSEo8AA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF1E20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRukc-0003kr-TB
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kRujb-000272-KB
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kRujY-0003qK-Cj
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602497231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ox6JDBdWbmjMl3RbvNaq1m/MOGVEVtm9owGp3KPebRM=;
 b=WSEo8AA8hgflyjHFJeEn+Hyjx/7+t3RXHnOXCaoI2i9CvOvjkmNujofqUP4OFSvpyM90vc
 qvvZWHEx+0nek2+JgBzx9m1Ocmogg/ANo2kcNSIdqiF7t8noETpvO3DVaD8FxM2/wMnaXn
 gSBwTHNSNfXbX4KwQA/smLFys/nH2s8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-meOI6ABlPUi4hjyaEi5JKQ-1; Mon, 12 Oct 2020 06:07:10 -0400
X-MC-Unique: meOI6ABlPUi4hjyaEi5JKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8FB1835B52;
 Mon, 12 Oct 2020 10:07:08 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.193.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5255D10512;
 Mon, 12 Oct 2020 10:07:05 +0000 (UTC)
Subject: Re: [PATCH 1/3] block: push error reporting into bdrv_all_*_snapshot
 functions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201008174803.2696619-1-philmd@redhat.com>
 <20201008174803.2696619-2-philmd@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <8f2e2439-4100-a64d-b52e-c03d439cb743@redhat.com>
Date: Mon, 12 Oct 2020 12:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201008174803.2696619-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.10.20 19:48, Philippe Mathieu-Daudé wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The bdrv_all_*_snapshot functions return a BlockDriverState pointer
> for the invalid backend, which the callers then use to report an
> error message. In some cases multiple callers are reporting the
> same error message, but with slightly different text. In the future
> there will be more error scenarios for some of these methods, which
> will benefit from fine grained error message reporting. So it is
> helpful to push error reporting down a level.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/block/snapshot.h       | 14 +++----
>  block/monitor/block-hmp-cmds.c |  7 ++--
>  block/snapshot.c               | 77 +++++++++++++++++-----------------
>  migration/savevm.c             | 37 +++++-----------
>  monitor/hmp-cmds.c             |  7 +---
>  replay/replay-debugging.c      |  4 +-
>  tests/qemu-iotests/267.out     | 10 ++---
>  7 files changed, 67 insertions(+), 89 deletions(-)

Looks good overall to me, but for some reason this patch pulls in the
@ok and @ret variables from the top scope of all concerned functions
into the inner scopes of the BDS loops, and drops their initialization.
 That’s wrong, because we only call the respective snapshotting
functions on some BDSs, so the return value stays uninitialized for all
other BDSs:

> diff --git a/block/snapshot.c b/block/snapshot.c
> index a2bf3a54eb..50e35bb9fa 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -462,14 +462,14 @@ static bool bdrv_all_snapshots_includes_bs(BlockDriverState *bs)
>   * These functions will properly handle dataplane (take aio_context_acquire
>   * when appropriate for appropriate block drivers) */
>  
> -bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs)
> +bool bdrv_all_can_snapshot(Error **errp)
>  {
> -    bool ok = true;
>      BlockDriverState *bs;
>      BdrvNextIterator it;
>  
>      for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>          AioContext *ctx = bdrv_get_aio_context(bs);
> +        bool ok;

So I think @ok must be initialized.

>  
>          aio_context_acquire(ctx);
>          if (bdrv_all_snapshots_includes_bs(bs)) {
> @@ -477,26 +477,25 @@ bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs)
>          }
>          aio_context_release(ctx);
>          if (!ok) {
> +            error_setg(errp, "Device '%s' is writable but does not support "
> +                       "snapshots", bdrv_get_device_or_node_name(bs));
>              bdrv_next_cleanup(&it);
> -            goto fail;
> +            return false;
>          }
>      }
>  
> -fail:
> -    *first_bad_bs = bs;
> -    return ok;
> +    return true;
>  }
>  
> -int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bad_bs,
> -                             Error **errp)
> +int bdrv_all_delete_snapshot(const char *name, Error **errp)
>  {
> -    int ret = 0;
>      BlockDriverState *bs;
>      BdrvNextIterator it;
>      QEMUSnapshotInfo sn1, *snapshot = &sn1;
>  
>      for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>          AioContext *ctx = bdrv_get_aio_context(bs);
> +        int ret;

Same here, @ret must be initialized.

>  
>          aio_context_acquire(ctx);
>          if (bdrv_all_snapshots_includes_bs(bs) &&
> @@ -507,26 +506,25 @@ int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bad_bs,
>          }
>          aio_context_release(ctx);
>          if (ret < 0) {
> +            error_prepend(errp, "Could not delete snapshot '%s' on '%s': ",
> +                          name, bdrv_get_device_or_node_name(bs));
>              bdrv_next_cleanup(&it);
> -            goto fail;
> +            return -1;
>          }
>      }
>  
> -fail:
> -    *first_bad_bs = bs;
> -    return ret;
> +    return 0;
>  }
>  
>  
> -int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
> -                           Error **errp)
> +int bdrv_all_goto_snapshot(const char *name, Error **errp)
>  {
> -    int ret = 0;
>      BlockDriverState *bs;
>      BdrvNextIterator it;
>  
>      for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>          AioContext *ctx = bdrv_get_aio_context(bs);
> +        int ret;

And again.

>  
>          aio_context_acquire(ctx);
>          if (bdrv_all_snapshots_includes_bs(bs)) {
> @@ -534,75 +532,75 @@ int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
>          }
>          aio_context_release(ctx);
>          if (ret < 0) {
> +            error_prepend(errp, "Could not load snapshot '%s' on '%s': ",
> +                          name, bdrv_get_device_or_node_name(bs));
>              bdrv_next_cleanup(&it);
> -            goto fail;
> +            return -1;
>          }
>      }
>  
> -fail:
> -    *first_bad_bs = bs;
> -    return ret;
> +    return 0;
>  }
>  
> -int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs)
> +int bdrv_all_find_snapshot(const char *name, Error **errp)
>  {
>      QEMUSnapshotInfo sn;
> -    int err = 0;
>      BlockDriverState *bs;
>      BdrvNextIterator it;
>  
>      for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>          AioContext *ctx = bdrv_get_aio_context(bs);
> +        int ret;

Again.

>  
>          aio_context_acquire(ctx);
>          if (bdrv_all_snapshots_includes_bs(bs)) {
> -            err = bdrv_snapshot_find(bs, &sn, name);
> +            ret = bdrv_snapshot_find(bs, &sn, name);
>          }
>          aio_context_release(ctx);
> -        if (err < 0) {
> +        if (ret < 0) {
> +            error_setg(errp, "Could not find snapshot '%s' on '%s'",
> +                       name, bdrv_get_device_or_node_name(bs));
>              bdrv_next_cleanup(&it);
> -            goto fail;
> +            return -1;
>          }
>      }
>  
> -fail:
> -    *first_bad_bs = bs;
> -    return err;
> +    return 0;
>  }
>  
>  int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
>                               BlockDriverState *vm_state_bs,
>                               uint64_t vm_state_size,
> -                             BlockDriverState **first_bad_bs)
> +                             Error **errp)
>  {
> -    int err = 0;
>      BlockDriverState *bs;
>      BdrvNextIterator it;
>  
>      for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>          AioContext *ctx = bdrv_get_aio_context(bs);
> +        int ret;

And one final time.

Max

>          aio_context_acquire(ctx);
>          if (bs == vm_state_bs) {
>              sn->vm_state_size = vm_state_size;
> -            err = bdrv_snapshot_create(bs, sn);
> +            ret = bdrv_snapshot_create(bs, sn);
>          } else if (bdrv_all_snapshots_includes_bs(bs)) {
>              sn->vm_state_size = 0;
> -            err = bdrv_snapshot_create(bs, sn);
> +            ret = bdrv_snapshot_create(bs, sn);
>          }
>          aio_context_release(ctx);
> -        if (err < 0) {
> +        if (ret < 0) {
> +            error_setg(errp, "Could not create snapshot '%s' on '%s'",
> +                       sn->name, bdrv_get_device_or_node_name(bs));
>              bdrv_next_cleanup(&it);
> -            goto fail;
> +            return -1;
>          }
>      }


