Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60D1C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D960206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JH/Pav5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D960206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRdgA-0004Qc-Mw
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRdfQ-0003vG-Pl
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRdfH-00082y-7Y
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:21:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60506
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRdfG-00082r-RW
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587655282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8oCYnX8h4Qa23lIkvOI01SCOwUCby4qOJAPcCDoDvA=;
 b=JH/Pav5VSdz8tCQO/WN1bnO0RwPc1TdK9sS0ZCGy0g/hiSoEQS0Ly6OleXdkfqOmEtfv79
 czABeR/6sOU4x6uSpD229Vt/f36MGj3UFHksHaeIKJF+QNzoDky8wwDiA3vAMMV3xDvbHc
 PjmVvpZbBQP0WTXGJ0qPGD/5GeYlRLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-UQeMHysDPPC3UpJElo1AKA-1; Thu, 23 Apr 2020 11:21:18 -0400
X-MC-Unique: UQeMHysDPPC3UpJElo1AKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40EC456B32;
 Thu, 23 Apr 2020 15:21:17 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67A035D9D3;
 Thu, 23 Apr 2020 15:21:16 +0000 (UTC)
Subject: Re: [PATCH v6 07/10] block: truncate: Don't make backing file data
 visible
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-8-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8685fe45-1c38-adbb-3394-86fb0dfb12f9@redhat.com>
Date: Thu, 23 Apr 2020 10:21:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423150127.142609-8-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 10:01 AM, Kevin Wolf wrote:
> When extending the size of an image that has a backing file larger than
> its old size, make sure that the backing file data doesn't become
> visible in the guest, but the added area is properly zeroed out.
> 
> Consider the following scenario where the overlay is shorter than its
> backing file:
> 
>      base.qcow2:     AAAAAAAA
>      overlay.qcow2:  BBBB
> 
> When resizing (extending) overlay.qcow2, the new blocks should not stay
> unallocated and make the additional As from base.qcow2 visible like
> before this patch, but zeros should be read.
> 
> A similar case happens with the various variants of a commit job when an
> intermediate file is short (- for unallocated):
> 
>      base.qcow2:     A-A-AAAA
>      mid.qcow2:      BB-B
>      top.qcow2:      C--C--C-
> 
> After commit top.qcow2 to mid.qcow2, the following happens:
> 
>      mid.qcow2:      CB-C00C0 (correct result)
>      mid.qcow2:      CB-C--C- (before this fix)
> 
> Without the fix, blocks that previously read as zeros on top.qcow2
> suddenly turn into A.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/io.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


