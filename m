Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38373C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8B72076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSfPxstl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8B72076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWoW-0002DY-4a
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEWnt-0001kf-SX
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEWns-0005xY-QZ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:24:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20749)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEWns-0005vx-NI
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584530644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j99XqB7N5Ym3kA8k6A09CA0a0Y9lCOR2hHEXhIYZax4=;
 b=iSfPxstl6pCh64ioIwVmJ7jvLKH4Y+kHhMZihUL0SlzfbySs5FFNZAHjFgqKadbPWfs7Yl
 AMB0Aj+Y4SOrGKquSpjFnVCwuUJdsXXY0psrzrdiBwTBVn27qDNqJssbglfm7qT5eAfANA
 CDD4m0V7rurb6fQL4Izdehmg0rCCeR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-ZaH9BHlXN5uyOBtgxOMHvw-1; Wed, 18 Mar 2020 07:24:00 -0400
X-MC-Unique: ZaH9BHlXN5uyOBtgxOMHvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CC77100550D;
 Wed, 18 Mar 2020 11:23:59 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EE445D9C5;
 Wed, 18 Mar 2020 11:23:57 +0000 (UTC)
Subject: Re: [PATCH v4 01/30] qcow2: Make Qcow2AioTask store the full host
 offset
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <d5e20c41da4fa7821704ad1125167fd507eaf7a7.1584468723.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e1ad7fd1-5cdd-126b-7c9f-3d4c97ffdf7a@redhat.com>
Date: Wed, 18 Mar 2020 06:23:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d5e20c41da4fa7821704ad1125167fd507eaf7a7.1584468723.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 1:15 PM, Alberto Garcia wrote:
> The file_cluster_offset field of Qcow2AioTask stores a cluster-aligned
> host offset. In practice this is not very useful because all users(*)
> of this structure need the final host offset into the cluster, which
> they calculate using
> 
>     host_offset = file_cluster_offset + offset_into_cluster(s, offset)
> 
> There is no reason why Qcow2AioTask cannot store host_offset directly
> and that is what this patch does.
> 
> (*) compressed clusters are the exception: in this case what
>      file_cluster_offset was storing was the full compressed cluster
>      descriptor (offset + size). This does not change with this patch
>      but it is documented now.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.c | 68 +++++++++++++++++++++++++--------------------------
>   1 file changed, 33 insertions(+), 35 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


