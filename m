Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD028C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779772065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyhCfl6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779772065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SBr-0003AQ-Cy
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1k0SB2-0002Pz-P7
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:10:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26461
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1k0SB0-0000nN-L0
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595952601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iqd87XIaNvrpF5Ax+ULRDBB8xQkomL9GuLbu4PiEfl4=;
 b=WyhCfl6hSrybAdyCoZlgxNcbdJn0OA9r9937KUdnywXma4sIshVtNPuje9YFR8sO0T6Jrc
 ROwnU0SXMnTWofe5AAjKWwBsyvtEOQ5vfRnVWGJfUYVQYBpft3d/XQ76TNvA8E+n9w0q9f
 mztPhC6zyWperHkWJZm/k805ol+VTZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-xhn1gmctN-i9RClxvH-53Q-1; Tue, 28 Jul 2020 12:10:00 -0400
X-MC-Unique: xhn1gmctN-i9RClxvH-53Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11DD919057B8;
 Tue, 28 Jul 2020 16:09:59 +0000 (UTC)
Received: from titinator (ovpn-114-132.ams2.redhat.com [10.36.114.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F80E76216;
 Tue, 28 Jul 2020 16:09:57 +0000 (UTC)
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-2-mreitz@redhat.com>
 <12e568be-f931-fc16-0ca2-a7ec54e538ea@virtuozzo.com>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 01/47] block: Add child access functions
In-reply-to: <12e568be-f931-fc16-0ca2-a7ec54e538ea@virtuozzo.com>
Date: Tue, 28 Jul 2020 18:09:55 +0200
Message-ID: <ly1rkvhb8s.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-07-13 at 11:06 CEST, Vladimir Sementsov-Ogievskiy wrote...
> 25.06.2020 18:21, Max Reitz wrote:
>> There are BDS children that the general block layer code can access,
>> namely bs->file and bs->backing.  Since the introduction of filters and
>> external data files, their meaning is not quite clear.  bs->backing can
>> be a COW source, or it can be a filtered child; bs->file can be a
>> filtered child, it can be data and metadata storage, or it can be just
>> metadata storage.
>>
>> This overloading really is not helpful.  This patch adds functions that
>> retrieve the correct child for each exact purpose.  Later patches in
>> this series will make use of them.  Doing so will allow us to handle
>> filter nodes in a meaningful way.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>
> [..]
>
>> +/*
>> + * Return the primary child of this node: For filters, that is the
>> + * filtered child.  For other nodes, that is usually the child storing
>> + * metadata.
>> + * (A generally more helpful description is that this is (usually) the
>> + * child that has the same filename as @bs.)
>> + *
>> + * Drivers do not necessarily have a primary child; for example quorum
>> + * does not.
>> + */
>> +BdrvChild *bdrv_primary_child(BlockDriverState *bs)
>> +{
>> +    BdrvChild *c;
>> +
>> +    QLIST_FOREACH(c, &bs->children, next) {
>> +        if (c->role & BDRV_CHILD_PRIMARY) {
>> +            return c;
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>>
>
> Suggest squash-in to also assert that not more than one primary child:
> --- a/block.c
> +++ b/block.c
> @@ -6998,13 +6998,14 @@ BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs)
>    */
>   BdrvChild *bdrv_primary_child(BlockDriverState *bs)
>   {
> -    BdrvChild *c;
> +    BdrvChild *c, *found = NULL;
>
>       QLIST_FOREACH(c, &bs->children, next) {
>           if (c->role & BDRV_CHILD_PRIMARY) {
> -            return c;
> +            assert(!found);
> +            found = c;
>           }
>       }
>
> -    return NULL;
> +    return c;

Shouldn't that be "return found"?
>   }
>
>
> with or without:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--
Cheers,
Christophe de Dinechin (IRC c3d)


