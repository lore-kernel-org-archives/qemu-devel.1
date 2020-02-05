Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFA5C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C2E20730
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnvX/32Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C2E20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izTaU-0001Qi-78
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 17:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izTZT-0000vj-Ci
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izTZS-0000Sz-01
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:54:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54680
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izTZR-0000SO-Pt
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580943296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bHvqZOl+gsXPGWuZsZhz4KjjbvqNeHzaasPTa7G9BQE=;
 b=gnvX/32Y6lfagxI3YniJWUjxLjeaVexYv3iOtUYIBCgZMbsTgTLSC2EbjivFOo/KC1Px9m
 zYu9HoNbcuyozUtfOp14CwJTIBJZWeXFgJm6F0nfzMUvikJ+N/IgI5NR4t2FJtzM7YAyqe
 34ihXNJ1+LxHhI6uA+w61JIWcvLFi1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-fXZTy9kINpmTbMrr-AWoTQ-1; Wed, 05 Feb 2020 17:54:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03F11DBE5;
 Wed,  5 Feb 2020 22:54:52 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CF5A66834;
 Wed,  5 Feb 2020 22:54:50 +0000 (UTC)
Subject: Re: [PATCH v2 24/33] block: Make format drivers use child_of_bds
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-25-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8f4d2c07-2c1b-879f-d511-9250d75be33e@redhat.com>
Date: Wed, 5 Feb 2020 16:54:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-25-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: fXZTy9kINpmTbMrr-AWoTQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:08 AM, Max Reitz wrote:
> Commonly, they need to pass the BDRV_CHILD_IMAGE set as the
> BdrvChildRole; but there are exceptions for drivers with external data
> files (qcow2 and vmdk).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


