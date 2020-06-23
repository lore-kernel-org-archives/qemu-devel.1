Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C4EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6202078A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBdBl+Ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6202078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhyp-0005sw-Js
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jnhRM-0005CZ-H2
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:50:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42730
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jnhRK-00019X-R4
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592913009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hXpNUxUFcr6PIh6YNMbvHQMWlkf/2g00gqXLGwHhXNM=;
 b=PBdBl+AhfuaX9KhW8fCSHsc/Z2EGdCqjdR6rIrjJcwlDfAYEqf4ivsqiJkQsgnSyLDQYoW
 39Vm737ncf6WSmURoVWbU9XSg7LuBMT8yM8B4GJLzv0IEvkxgdDbCSg7zhgCmvbKNLGkga
 jk+eDrepwGirrrQYbckTigXe3bb37F8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-SczzgQKjOFadhU1J4DlEDA-1; Tue, 23 Jun 2020 07:50:08 -0400
X-MC-Unique: SczzgQKjOFadhU1J4DlEDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2364D8031D8;
 Tue, 23 Jun 2020 11:50:07 +0000 (UTC)
Received: from linux.fritz.box (ovpn-115-78.ams2.redhat.com [10.36.115.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78E9B5D9DA;
 Tue, 23 Jun 2020 11:50:02 +0000 (UTC)
Date: Tue, 23 Jun 2020 13:50:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 1/6] block: add bitmap-populate job
Message-ID: <20200623115000.GA15708@linux.fritz.box>
References: <20200619195621.58740-1-eblake@redhat.com>
 <20200619195621.58740-2-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200619195621.58740-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
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
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.06.2020 um 21:56 hat Eric Blake geschrieben:
> From: John Snow <jsnow@redhat.com>
> 
> This job copies the allocation map into a bitmap. It's a job because
> there's no guarantee that allocation interrogation will be quick (or
> won't hang), so it cannot be retrofitted into block-dirty-bitmap-merge.
> 
> It was designed with different possible population patterns in mind,
> but only top layer allocation was implemented for now.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

> +BlockJob *bitpop_job_create(
> +    const char *job_id,
> +    BlockDriverState *bs,
> +    BdrvDirtyBitmap *target_bitmap,
> +    BitmapPattern pattern,
> +    BlockdevOnError on_error,
> +    int creation_flags,
> +    BlockCompletionFunc *cb,
> +    void *opaque,
> +    JobTxn *txn,
> +    Error **errp)
> +{
> +    int64_t len;
> +    BitpopBlockJob *job = NULL;
> +    int64_t cluster_size;
> +    BdrvDirtyBitmap *new_bitmap = NULL;
> +
> +    assert(bs);
> +    assert(target_bitmap);
> +
> +    if (!bdrv_is_inserted(bs)) {
> +        error_setg(errp, "Device is not inserted: %s",
> +                   bdrv_get_device_name(bs));
> +        return NULL;
> +    }
> +
> +    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOURCE, errp)) {
> +        return NULL;
> +    }

So did we decide that we'll keep the legacy op blocker with the type of
another block job even though nobody could tell what it's good for?

Kevin


