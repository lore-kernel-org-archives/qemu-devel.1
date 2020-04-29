Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A09C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B74206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIqGhpHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B74206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTo8X-0006Xl-1t
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTo7X-0004n6-2g
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTo7W-0005z4-BD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:55:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTo7V-0005pU-Rj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588172128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLNpJosC4b8/+sIjY4Z2IHGTFMDr5d1UUJ34VO9VuMQ=;
 b=RIqGhpHuZQKPaQ6GNxsRQlhrSa+HOWErwlSLi1GRhSbvvzIy3+KPa2i4hm7pWddV5LPJYz
 roF7gA68ighw1QSZihQhmpXMI2FpjMGTwIa3jgp4Osk9q0VKkj11zjqnNIJGJBenyZkPks
 FnhLIHVL1PVg/CTDSL/T/Ndx8Nkc3T8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-BiNSSER9NZa5_WCxAl0PVw-1; Wed, 29 Apr 2020 10:55:26 -0400
X-MC-Unique: BiNSSER9NZa5_WCxAl0PVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B98F8835B67;
 Wed, 29 Apr 2020 14:55:25 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B19B282E2;
 Wed, 29 Apr 2020 14:55:24 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] block: Use blk_make_empty() after commits
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200429141126.85159-1-mreitz@redhat.com>
 <20200429141126.85159-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <dc44399a-402d-c3fc-d68f-fa6c38d1f27a@redhat.com>
Date: Wed, 29 Apr 2020 09:55:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429141126.85159-5-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 9:11 AM, Max Reitz wrote:
> bdrv_commit() already has a BlockBackend pointing to the BDS that we
> want to empty, it just has the wrong permissions.
> 
> qemu-img commit has no BlockBackend pointing to the old backing file
> yet, but introducing one is simple.
> 
> After this commit, bdrv_make_empty() is the only remaining caller of
> BlockDriver.bdrv_make_empty().
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/commit.c | 16 +++++++++-------
>   qemu-img.c     | 19 ++++++++++++++-----
>   2 files changed, 23 insertions(+), 12 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


