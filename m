Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E4FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 21:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD30207C4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 21:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXLNkLde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD30207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jan2m-0004Qn-CE
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 17:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jan25-00041A-9y
 for qemu-devel@nongnu.org; Mon, 18 May 2020 17:10:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58328
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jan24-0002Nz-Ek
 for qemu-devel@nongnu.org; Mon, 18 May 2020 17:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589836243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vXiBbl99xC5ghCNKEzt95X1dMPoMoDHIj0pPrgvcjw=;
 b=LXLNkLdefPDshMEdJCetEKEN5VOu7dK0r/cMOXi+fne1aDh6mUmoTJRZX4dBpY7Ru8I5i0
 oQTX8ZuC/F2EdSo1Xf9zUEdslaXPgfKyl5CqIRFI+cDDUoFqaWj/HYNPVjEu/C7t9YEmaP
 p3ZxOvO1RBQvaUW5/fSgfVUjXV5kct0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-Zzg7lVblORSZ2T3483D-Zw-1; Mon, 18 May 2020 17:10:28 -0400
X-MC-Unique: Zzg7lVblORSZ2T3483D-Zw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA88B1005510;
 Mon, 18 May 2020 21:10:26 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 391A010023A6;
 Mon, 18 May 2020 21:10:26 +0000 (UTC)
Subject: Re: [PATCH RFC v2 3/5] qmp: expose block-dirty-bitmap-populate
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514034922.24834-1-jsnow@redhat.com>
 <20200514034922.24834-4-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d9901437-498d-d90f-563b-0f1cffd76968@redhat.com>
Date: Mon, 18 May 2020 16:10:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514034922.24834-4-jsnow@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 16:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 vsementsov@virtuozzo.com, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 10:49 PM, John Snow wrote:
> This is a new job-creating command.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/block-core.json  | 18 +++++++++++
>   qapi/transaction.json |  2 ++
>   blockdev.c            | 74 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 94 insertions(+)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0fb527a9a1..f7cae77fc9 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2250,6 +2250,24 @@
>               '*auto-finalize': 'bool',
>               '*auto-dismiss': 'bool' } }
>   
> +##
> +# @block-dirty-bitmap-populate:
> +#
> +# Creates a new job that writes a pattern into a dirty bitmap.
> +#
> +# Since: 5.0

5.1

> +++ b/qapi/transaction.json
> @@ -50,6 +50,7 @@
>   # - @block-dirty-bitmap-enable: since 4.0
>   # - @block-dirty-bitmap-disable: since 4.0
>   # - @block-dirty-bitmap-merge: since 4.0
> +# - @block-dirty-bitmap-populate: since 5.0

ditto


> +++ b/blockdev.c
> @@ -2233,6 +2233,63 @@ static void block_dirty_bitmap_remove_commit(BlkActionState *common)
>       bdrv_release_dirty_bitmap(state->bitmap);
>   }
>   
> +static void block_dirty_bitmap_populate_prepare(BlkActionState *common,
> +                                                Error **errp)
> +{
> +    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
> +    BlockDirtyBitmapPopulate *bitpop;
> +    BlockDriverState *bs;
> +    AioContext *aio_context;
> +    BdrvDirtyBitmap *bmap = NULL;
> +    int job_flags = JOB_DEFAULT;
> +
> +    assert(common->action->type == \
> +           TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE);

\ is not necessary here.

> +    bitpop = common->action->u.block_dirty_bitmap_populate.data;
> +
> +    bmap = block_dirty_bitmap_lookup(bitpop->node, bitpop->name, &bs, errp);
> +    if (!bmap) {
> +        return;
> +    }

So the bitmap has to already exist, and we are just merging into it, 
correct?

Otherwise looks good.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


