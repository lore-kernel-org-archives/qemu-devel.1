Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFC0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B9F2065F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WH8NchuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B9F2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZIzt-00048R-DH
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 14:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZIyL-0001bL-Ti
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:52:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26892
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZIyL-0008Q3-1b
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589482364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFHmAo/Ta9Am41+z7YYXNGdux6kJyGnK/Xf1wjEHH28=;
 b=WH8NchuSi2wB/bbPOxqvYWpLVJ8PZHhzmddQ2P+ZLfmzSdhi0hxMSuI5B1bOnhFxuTEbEJ
 1ZYn1haGBUNqcFD6FV63izL1qcKZ5TVr3oY0VzEpo5zSs/B0Hz6jxG9RNCLh64sH4kfjtK
 RmB1+3gAv3Cg/rSS8EdPuxtXR6CvhGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-HPAlWh3jNFuwmYk8sIHWIw-1; Thu, 14 May 2020 14:52:42 -0400
X-MC-Unique: HPAlWh3jNFuwmYk8sIHWIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA87D80183C;
 Thu, 14 May 2020 18:52:40 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50B6746;
 Thu, 14 May 2020 18:52:37 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] migration/block-dirty-bitmap: fix bitmaps
 migration during mirror job
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219085106.22309-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2002b98a-d58a-017c-5014-02986f4e58e3@redhat.com>
Date: Thu, 14 May 2020 13:52:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20191219085106.22309-5-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:35:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 2:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> Important thing for bitmap migration is to select destination block
> node to obtain the migrated bitmap.
> 
> Prepatch, on source we use bdrv_get_device_or_node_name() to identify
> the node, and on target we do bdrv_lookup_bs.
> bdrv_get_device_or_node_name() returns blk name only for direct
> children of blk. So, bitmaps of direct children of blks are migrated by
> blk name and others - by node name.
> 
> Libvirt currently is unprepared to bitmap migration by node-name,
> node-names are mostly auto-generated. So actually only migration by blk
> name works.

It depends on whether -blockdev is in use.  With -blockdev, libvirt 
should be supplying a node name everywhere, without, it is only device 
names.

> 
> Now, consider classic libvirt migrations assisted by mirror block job:
> mirror block job inserts filter, so our source is not a direct child of
> blk, and bitmaps are migrated by node-names. And this just don't work.

Does Max' work to improve seeing through filters fix this?

> 
> Let's fix it by allowing use blk-name even if some implicit filters are
> inserted.
> 
> Note, that we possibly want to allow explicit filters skipping too, but
> this is another story.
> 
> Note2: we, of course, can't skip filters and use blk name to migrate
> bitmaps in filtered node by blk name for this blk if these filters have
> named bitmaps which should be migrated.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1652424

That bug has been marked CLOSED in the meantime, but it appears to be 
only because libvirt is now using -blockdev rather than the older drive, 
while the problem affects drive usage.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 39 +++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
> 
> 

Okay, after reading some more history on this project (the curse of 
coming up to speed after volunteering to become a co-maintainer), it 
looks like Max's idea replaces this patch altogether.  How much of the 
rest of the series is still important?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


