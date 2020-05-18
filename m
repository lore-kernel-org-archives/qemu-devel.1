Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B745FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A00A20756
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HS65qHc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A00A20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamql-0005e4-MG
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jampZ-0004N0-Ce
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:57:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jampY-0007Sm-Hy
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589835467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5FWCUOXFfM74kP1zoJr6PxLN+1gd9w5JXqLKgNpxRdE=;
 b=HS65qHc1cEdlYKfxXPND6dDAQcbQclGsGQBxG3N9Vbw39zlZ9IORGgOHjqsITlFA0LMTYz
 lbuTDwVGzbzEMvjGE16gV5LZhUKh2PSgk9uBxrJrREHqjNF7Zy6WIJEfggNjZNUIRKvOzg
 qRKyJJYWde7Z5UvY+3ImCZVHMDIyP7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-YeTh37o7M8y43tqO2s1I0g-1; Mon, 18 May 2020 16:57:45 -0400
X-MC-Unique: YeTh37o7M8y43tqO2s1I0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9956EC1A4;
 Mon, 18 May 2020 20:57:44 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 327C4100164D;
 Mon, 18 May 2020 20:57:44 +0000 (UTC)
Subject: Re: [PATCH RFC v2 2/5] blockdev: combine DriveBackupState and
 BlockdevBackupState
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514034922.24834-1-jsnow@redhat.com>
 <20200514034922.24834-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <88e3bb16-8f67-cd00-a1ae-6b6fd4341d71@redhat.com>
Date: Mon, 18 May 2020 15:57:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514034922.24834-3-jsnow@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 vsementsov@virtuozzo.com, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 10:49 PM, John Snow wrote:
> They have the same fields -- rename it BlockJobState.

This says BlockJobState...

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockdev.c | 30 ++++++++++++------------------
>   1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index b3c840ec03..d3e8a6ca22 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1702,11 +1702,11 @@ static void external_snapshot_clean(BlkActionState *common)
>       aio_context_release(aio_context);
>   }
>   
> -typedef struct DriveBackupState {
> +typedef struct BlockJobActionState {

...but this does not.  I'm assuming it is just a typo in the commit message?

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


