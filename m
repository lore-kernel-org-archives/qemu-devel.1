Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDA2C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB40F2082E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ja37lRxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB40F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhFn-00069q-4U
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWhF2-0005Q8-2d
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:11:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWhF1-0007Dq-Am
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588860670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6gDFEk3HUZleQss0I6sk+IeY91ntcLnuvLpPtojJ7NY=;
 b=Ja37lRxuX8Md90qblS9IZDimz5u4Lgc1u5RDPWmuN2UvP39khvFlkVge+UhNmz4dEPv2JY
 yDhLcIz0NxPAv3ScPCI9tbib2AZ/iQLy3PwtAWTk7i2YqqwlyQ0i9as3rIk63Bj/3FxqK+
 bnf4LrYgNck5it4W1bVzXCkiJ2pO9M8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493--eejGLSxPcaW1aJ5jzlK9w-1; Thu, 07 May 2020 10:11:07 -0400
X-MC-Unique: -eejGLSxPcaW1aJ5jzlK9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 666A21902EA2;
 Thu,  7 May 2020 14:11:05 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC8525D9C5;
 Thu,  7 May 2020 14:11:01 +0000 (UTC)
Subject: Re: [PATCH v2 4/9] block/vpc: return ZERO block-status when
 appropriate
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200507084800.20596-1-vsementsov@virtuozzo.com>
 <20200507084800.20596-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e8b28f4a-0bc6-2a08-14e2-ee68fb04efcb@redhat.com>
Date: Thu, 7 May 2020 09:11:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507084800.20596-5-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: fam@euphon.net, kwolf@redhat.com, ronniesahlberg@gmail.com, sw@weilnetz.de,
 pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 3:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> In case when get_image_offset() returns -1, we do zero out the
> corresponding chunk of qiov. So, this should be reported as ZERO.
> 
> Note that this changes visible output of "qemu-img map --output=json"
> and "qemu-io -c map" commands. For qemu-img map, the change is obvious:
> we just mark as zero what is really zero. For qemu-io it's less
> obvious: what was unallocated now is allocated.
> 
> There is an inconsistency in understanding of unallocated regions in
> Qemu: backing-supporting format-drivers return 0 block-status to report
> go-to-backing logic for this area. Some protocol-drivers (iscsi) return
> 0 to report fs-unallocated-non-zero status (i.e., don't occupy space on
> disk, read result is undefined).
> 
> BDRV_BLOCK_ALLOCATED is defined as something more close to
> go-to-backing logic. Still it is calculated as ZERO | DATA, so 0 from
> iscsi is treated as unallocated. It doesn't influence backing-chain
> behavior, as iscsi can't have backing file. But it does influence
> "qemu-io -c map".
> 
> We should solve this inconsistency at some future point. Now, let's
> just make backing-not-supporting format drivers (vdi in the previous
> patch and vpc now) to behave more like backing-supporting drivers
> and not report 0 block-status. More over, returning ZERO status is
> absolutely valid thing, and again, corresponds to how the other
> format-drivers (backing-supporting) work.
> 
> After block-status update, it never reports 0, so setting
> unallocated_blocks_are_zero doesn't make sense (as the only user of it
> is bdrv_co_block_status and it checks unallocated_blocks_are_zero only
> for unallocated areas). Drop it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/vpc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


