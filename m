Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94482C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 23:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B47220658
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 23:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXvSa7r3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B47220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j764S-0003Xq-EQ
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 18:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j763t-00034S-53
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j763r-0003FN-Gi
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:25:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j763r-0003Eb-DB
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582759550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dwy/enVK/cR9i30x2XybdjMS06egMEDmUkaNoOGiAQ=;
 b=eXvSa7r3RYwvQwxe2MRwChecTGY1dCXXZHCiLj1pXlvwcBILDRdGQXQ7D78sQEatQdMkvm
 pTYHA2qqb0F/DfO4aRNFi/sKerFQKxJjVs5MQVrBfDmNowy6w3kYgRTC0iV/1d+VsY14W6
 ZtHFMFiJpbH3S+9lwywTKzRScM3Cp3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-Dbtw6mgpObmGiVHfPwSDNQ-1; Wed, 26 Feb 2020 18:25:44 -0500
X-MC-Unique: Dbtw6mgpObmGiVHfPwSDNQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CD91477;
 Wed, 26 Feb 2020 23:25:43 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43AD310027B8;
 Wed, 26 Feb 2020 23:25:42 +0000 (UTC)
Subject: Re: [PATCH v5 1/2] block/nbd: extract the common cleanup code
To: pannengyuan@huawei.com, kwolf@redhat.com, mreitz@redhat.com
References: <1575517528-44312-1-git-send-email-pannengyuan@huawei.com>
 <1575517528-44312-2-git-send-email-pannengyuan@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9d1fbcbf-a17e-f788-06f6-5d6bed06d891@redhat.com>
Date: Wed, 26 Feb 2020 17:25:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1575517528-44312-2-git-send-email-pannengyuan@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: liyiting@huawei.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, kuhn.chenqun@huawei.com,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 9:45 PM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> The BDRVNBDState cleanup code is common in two places, add
> nbd_clear_bdrvstate() function to do these cleanups.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> +++ b/block/nbd.c
> @@ -94,6 +94,19 @@ typedef struct BDRVNBDState {
>   
>   static int nbd_client_connect(BlockDriverState *bs, Error **errp);
>   
> +void nbd_clear_bdrvstate(BDRVNBDState *s)
> +{

Compilation fails if this is not static (no prior prototype).  I've 
fixed that and now queued this series in my NBD tree, pull request 
coming soon.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


