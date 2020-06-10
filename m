Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA0CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E94206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFM8Uw5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E94206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj6yY-0005uD-UU
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj6vZ-0002vg-14
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:02:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26749
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj6vX-0000CS-80
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591819342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RjDaqfoc8uBUQyC6TA74CxQQrVEwQkkBfACH1VLW5mQ=;
 b=aFM8Uw5C0SFMug8YuqTm3ZkzKzwWp6Mb658fH6RblOYj6n2Cm4xr+Q+W5G86VbGKEABzhp
 olcC37QBMZlUdRwhB/IcmSuj0r+1VtpRPLmXGOXmLbJe0i3YLFFiaXjKEdkxVvrnWo3V5a
 F7VP1S8p1OSMheFKzxm6c1BIkN6oNi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-hhgPWyOAMvKt5zxCdJdydg-1; Wed, 10 Jun 2020 16:02:20 -0400
X-MC-Unique: hhgPWyOAMvKt5zxCdJdydg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C638C461;
 Wed, 10 Jun 2020 20:02:18 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6618C5D9D3;
 Wed, 10 Jun 2020 20:02:18 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Fix preallocation on images with unaligned sizes
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200610094600.4029-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <abffdc15-605b-6561-2df8-c6b38a8275c5@redhat.com>
Date: Wed, 10 Jun 2020 15:02:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610094600.4029-1-berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 15:44:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 4:46 AM, Alberto Garcia wrote:
> When resizing an image with qcow2_co_truncate() using the falloc or
> full preallocation modes the code assumes that both the old and new
> sizes are cluster-aligned.
> 
> There are two problems with this:
> 
>    1) The calculation of how many clusters are involved does not always
>       get the right result.
> 
>       Example: creating a 60KB image and resizing it (with
>       preallocation=full) to 80KB won't allocate the second cluster.
> 
>    2) No copy-on-write is performed, so in the previous example if
>       there is a backing file then the first 60KB of the first cluster
>       won't be filled with data from the backing file.
> 
> This patch fixes both issues.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.c              | 17 ++++++++++++++---
>   tests/qemu-iotests/125     | 21 +++++++++++++++++++++
>   tests/qemu-iotests/125.out |  9 +++++++++
>   3 files changed, 44 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


