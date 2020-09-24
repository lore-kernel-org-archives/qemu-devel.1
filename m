Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB0CC4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C409723899
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5n/kbVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C409723899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXdH-000184-SG
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 16:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLXal-0008GN-Ur
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 16:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLXaj-0003uS-1D
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 16:11:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600978301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tmVROCzkY+Kh2WMK4U9uKp7iP+U7o5K2T+DSCLoDQY=;
 b=T5n/kbVI3TJYgEnMCbHXLqp6m3GxeTOjt8Wb/6ZhRveAuk3BK6/iMJz4CdoEQpaVx3v89a
 CfNlNoYn/AxGlqK+rzwvZFaP+KqvvTxgxv+L/VIY78pHFrGID7+zhUEyqzt4jYlmO3MGgn
 4K5/RBx1gUYEi11VZjt53Yn/ypLag7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-xm4YYgWLNzSzlAxGdb1qkg-1; Thu, 24 Sep 2020 16:11:39 -0400
X-MC-Unique: xm4YYgWLNzSzlAxGdb1qkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9E3C56BE2;
 Thu, 24 Sep 2020 20:11:37 +0000 (UTC)
Received: from [10.3.114.148] (ovpn-114-148.phx2.redhat.com [10.3.114.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB5845D9DD;
 Thu, 24 Sep 2020 20:11:33 +0000 (UTC)
Subject: Re: [PATCH v7 4/5] block/io: fix bdrv_is_allocated_above
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200924194003.22080-1-vsementsov@virtuozzo.com>
 <20200924194003.22080-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <dba7a866-700b-2ee6-40fa-ddfb5b1494ed@redhat.com>
Date: Thu, 24 Sep 2020 15:11:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924194003.22080-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/20 2:40 PM, Vladimir Sementsov-Ogievskiy wrote:
> bdrv_is_allocated_above wrongly handles short backing files: it reports
> after-EOF space as UNALLOCATED which is wrong, as on read the data is
> generated on the level of short backing file (if all overlays has

s/has/have/

> unallocated area at that place).
> 
> Reusing bdrv_common_block_status_above fixes the issue and unifies code
> path.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/io.c | 43 +++++--------------------------------------
>   1 file changed, 5 insertions(+), 38 deletions(-)

Nice diffstat, R-b remains in force.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


