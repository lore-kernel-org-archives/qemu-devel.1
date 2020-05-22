Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701B5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 12:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4170720723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 12:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjEJfRJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4170720723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc7H2-0002FT-Dg
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 08:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jc7GA-0001BV-N7
 for qemu-devel@nongnu.org; Fri, 22 May 2020 08:58:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42391
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jc7G9-00010Q-Iq
 for qemu-devel@nongnu.org; Fri, 22 May 2020 08:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590152324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/C3uqZBJPPCkKnCTzF1Ee+D8f5IvukGqA0OWgnIzn5c=;
 b=OjEJfRJAUJvlEWroDdsm/8kjmc/xsDF/D7XtuhyOd21LOZp6lZJqzxzbAxDyXDIxllskkr
 l2MOG2BLQwI3JR5WFqeODLcFWxABBXPtSNT0OHgj5A559gMGlUhFiY28Ei41eRICT73FaZ
 zk4ipKy2fye+hBuAuZuXxY5+6V9Wv8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-qQnt2oFgN0e0ZkEj2Wu1ow-1; Fri, 22 May 2020 08:58:39 -0400
X-MC-Unique: qQnt2oFgN0e0ZkEj2Wu1ow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A450107ACCD;
 Fri, 22 May 2020 12:58:38 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 949B66248F;
 Fri, 22 May 2020 12:58:27 +0000 (UTC)
Subject: Re: [PATCH v4 3/6] migration/block-dirty-bitmap: fix bitmaps
 pre-blockdev migration during mirror job
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200521220648.3255-1-vsementsov@virtuozzo.com>
 <20200521220648.3255-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <77ad0ab1-07c3-9b45-9f22-874fe29a4b70@redhat.com>
Date: Fri, 22 May 2020 07:58:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521220648.3255-4-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 08:01:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, quintela@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 5:06 PM, Vladimir Sementsov-Ogievskiy wrote:
> Important thing for bitmap migration is to select destination block
> node to obtain the migrated bitmap.
> 
> Prepatch, on source we use bdrv_get_device_or_node_name() to identify
> the node, and on target we do bdrv_lookup_bs.
> bdrv_get_device_or_node_name() returns blk name only for direct
> children of blk. So, bitmaps of direct children of blks are migrated by
> blk name and others - by node name.
> 
> Old libvirt is unprepared to bitmap migration by node-name,
> node-names are mostly auto-generated. So actually only migration by blk
> name works for it.
> 
> Newer libvirt will use new interface (which will be added soon) to
> specify node-mapping for bitmaps migration explicitly. Still, let's
> improve the current behavior a bit.
> 
> Now, consider classic libvirt migrations assisted by mirror block job:
> mirror block job inserts filter, so our source is not a direct child of
> blk, and bitmaps are migrated by node-names. And this just doesn't work
> with auto-generated node names.
> 
> Let's fix it by using blk-name even if some implicit filters are
> inserted.
> 
> Note2: we, of course, can't skip filters and use blk name to migrate
> bitmaps in filtered node by blk name for this blk if these filters have
> named bitmaps which should be migrated.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1652424
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 45 +++++++++++++++++++++++++++++++++-
>   1 file changed, 44 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks; I'm queuing this series through my bitmaps tree, and will send a 
pull request probably on Monday.


> +
> +        /* Skip filters without bitmaos */

bitmaps - I'm touching that up

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


