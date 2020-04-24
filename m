Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC45CC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67F320736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqKg8BLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67F320736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRzVM-0005c6-PY
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 10:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRzUL-0004Qd-8t
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRzUK-0002O1-QP
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:39:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59066
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRzUK-0002Kq-Dk
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587739171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wPFfTCGtlefTLmvLZt3CjzEH3mGc3FjXMng5KRzjdQ4=;
 b=KqKg8BLH6uDr36iZyJok6xdaeqVMTuUdgmFJUQWWW68mmRABcKyBwrHz9ufkydeu58aR8j
 SkvDwJIAas12MQPV25pxdeT9mz/r4ux0PUcMh1ZCVzpoMACpTFLP9aU5jmNt9sV66OMeOy
 bvXUzhdH24TyIdRBLthcoJJF04qGcks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-8PtvV1PGPTiPI2pf9_E1PA-1; Fri, 24 Apr 2020 10:39:26 -0400
X-MC-Unique: 8PtvV1PGPTiPI2pf9_E1PA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AE9B1005510;
 Fri, 24 Apr 2020 14:39:25 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51FD95D715;
 Fri, 24 Apr 2020 14:39:23 +0000 (UTC)
Subject: Re: [PATCH v7 04/10] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200424125448.63318-1-kwolf@redhat.com>
 <20200424125448.63318-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <edee3eed-0a5c-a89f-7fc9-16eb29ec4b82@redhat.com>
Date: Fri, 24 Apr 2020 09:39:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424125448.63318-5-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:54:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 7:54 AM, Kevin Wolf wrote:
> If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
> qcow2_cluster_zeroize() with flags=0 does the right thing: It doesn't
> undo any previous preallocation, but just adds the zero flag to all
> relevant L2 entries. If an external data file is in use, a write_zeroes
> request to the data file is made instead.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qcow2-cluster.c |  2 +-
>   block/qcow2.c         | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


