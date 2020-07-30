Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70A6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A2C2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoyV3YnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A2C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19y4-00044I-IZ
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k19x8-0003W4-UC
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:54:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52476
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k19x6-00027Q-SS
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596120875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5T7dwG/Ft8LV3WjeHzZzf2EY6AIvd1xnTwoYpxhSME=;
 b=QoyV3YnQYW6PSEk1/H0GRWc/MfXso+71FkRG+IytM+yVmgdbtzGk9XtKeLPRrYqcEjprWL
 rtYpgrfU1+vkMqwUbpqz16a/kYkqcilRSCeGDd54QAtSIY8Q1J8fAlmfp5OqUkMGwrCU9H
 3t4gFhUd2FUZG8+ngRgk7hyhHoY43rM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-jvjlvvy8Nu21izeEKJnMeg-1; Thu, 30 Jul 2020 10:54:31 -0400
X-MC-Unique: jvjlvvy8Nu21izeEKJnMeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CD62800473;
 Thu, 30 Jul 2020 14:54:30 +0000 (UTC)
Received: from [10.3.114.255] (ovpn-114-255.phx2.redhat.com [10.3.114.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D15AA60C84;
 Thu, 30 Jul 2020 14:54:29 +0000 (UTC)
Subject: Re: [PATCH 1/2] qcow2: Release read-only bitmaps when inactivated
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200730120234.49288-1-mreitz@redhat.com>
 <20200730120234.49288-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <53bcd5ce-f1fe-5015-d1d6-93b4263186b3@redhat.com>
Date: Thu, 30 Jul 2020 09:54:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730120234.49288-2-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 7:02 AM, Max Reitz wrote:
> During migration, we release all bitmaps after storing them on disk, as
> long as they are (1) stored on disk, (2) not read-only, and (3)
> consistent.
> 
> (2) seems arbitrary, though.  The reason we do not release them is
> because we do not write them, as there is no need to; and then we just
> forget about all bitmaps that we have not written to the file.  However,
> read-only persistent bitmaps are still in the file and in sync with
> their in-memory representation, so we may as well release them just like
> any R/W bitmap that we have updated.
> 
> It leads to actual problems, too: After migration, letting the source
> continue may result in an error if there were any bitmaps on read-only
> nodes (such as backing images), because those have not been released by
> bdrv_inactive_all(), but bdrv_invalidate_cache_all() attempts to reload
> them (which fails, because they are still present in memory).

I think our alternatives are ensuring no bitmaps are in memory so that 
reloading the RO bitmap from the file succeeds (which then hits the 
earlier question about whether releasing ALL bitmaps affects libvirt's 
ability to query which bitmaps were on the source, but makes reloading 
on the destination easy), or teaching the reload to special-case a RO 
bitmap from the disk that is already in memory (either to make the 
reload a graceful no-op instead of an error that it was already loaded, 
or to go one step further and validate whether the contents in memory 
match the contents reloaded from disk).  If I understand your patch, you 
went with the first of these alternatives.  And since Peter was able to 
test that it fixed the libvirt scenario, I'm okay with the approach you 
took, although I would love a second opinion from Virtuozzo folks.

> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qcow2-bitmap.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 1f38806ca6..8c34b2aef7 100644
> --- a/block/qcow2-bitmap.c

> @@ -1641,6 +1654,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>           g_free(tb);
>       }
>   
> +success:
>       if (release_stored) {
>           QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>               if (bm->dirty_bitmap == NULL) {
> @@ -1651,13 +1665,14 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>           }
>       }
>   
> -success:

Moving the label was an interesting change; I had to look at the file in 
context to see the real effect: basically, you now reach the line:

bdrv_release_dirty_bitmap(bm->dirty_bitmap);

for the set of persistent RO bitmaps that were previously ignored.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


