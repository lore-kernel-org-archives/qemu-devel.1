Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF67C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACABB2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6H7RMVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACABB2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Xd3-0000Rp-T0
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1XcU-0008Q1-T4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1XcT-0005Sx-UM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:38:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36650
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1XcT-0005Sk-RL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581435517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odjyb2z8Rww/KIgp3fvzwtTrymB6/YOLlRMyxP6HYVA=;
 b=b6H7RMVAXCCRxe80OcHW4v9/jcSoB4flIe47hb+ZpQpRJ3wCdqftyShwYD3x9BQGol9BXr
 QtretVsSCD0y3uns0hfs/EUMW/WU/0VqHtRFjriRVIKH8iVO+knKAjbB5IDu3hnrs7/iUJ
 BlzL7qceMn/KIwctFxbOz/84Xtleq7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-xA8aeYPYOCiP9lwUyjOFMw-1; Tue, 11 Feb 2020 10:38:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D89411902EA2;
 Tue, 11 Feb 2020 15:38:33 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C7965C109;
 Tue, 11 Feb 2020 15:38:33 +0000 (UTC)
Subject: Re: [PATCH v2 15/33] block: Pull out bdrv_default_perms_for_backing()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-16-mreitz@redhat.com>
 <b6369806-c265-661c-cd51-6a3808eb4816@redhat.com>
 <b1e9ed4e-32a0-9e9b-003a-1ec2304c3348@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <afc7789f-8100-2833-7510-65844444d0a6@redhat.com>
Date: Tue, 11 Feb 2020 09:38:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b1e9ed4e-32a0-9e9b-003a-1ec2304c3348@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: xA8aeYPYOCiP9lwUyjOFMw-1
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

On 2/6/20 5:19 AM, Max Reitz wrote:
> On 05.02.20 21:56, Eric Blake wrote:
>> On 2/4/20 11:08 AM, Max Reitz wrote:
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>
>> Rather light on the commit message. But looks like straightforward
>> refactoring (with the previous patch making it easier to follow).
> 
> Would this work:
> 
> Right now, bdrv_format_default_perms() is used by format parents
> (generally). We want to switch to a model where most parents use a
> single BdrvChildClass, which then decides the permissions based on the
> child role. To do so, we have to split bdrv_format_default_perms() into
> separate functions for each such role.
> 
> ?

Yes.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


