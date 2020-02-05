Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E0BC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F95920702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVz9K9Ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F95920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLbR-0003wg-MG
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izLZs-000264-61
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izLZq-00048N-FP
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:22:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40580
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izLZq-00044k-AH
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580912569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kGyZVAKv8T7pubEw3PssG3dFyl4bhchS/E1t9Fk3qmM=;
 b=FVz9K9Ut716VwZ905Ro8QUbyXCkK4oHgXAM7Xzr6CaEOrxT6R2KYh3Dwx/nr6n86CYTG+K
 AZDSY6PkuwOlaG3jy7mrIQZyYYTwbor5x4DoTTDg/xnSVD/7a/hppFOdRAIRXDwfrD3F6A
 l7GJZdiNrXWssghjw86Jy1Wv+xzNMI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-VYjMBV57OEmWwb_6Ld0oVA-1; Wed, 05 Feb 2020 09:22:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A1D81835A03;
 Wed,  5 Feb 2020 14:22:30 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18D023D92;
 Wed,  5 Feb 2020 14:22:30 +0000 (UTC)
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <3bad82d4-4d60-4341-d87e-af37e1dd680e@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9f2d8730-23ca-f070-52dd-0cbcbb08913b@redhat.com>
Date: Wed, 5 Feb 2020 08:22:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3bad82d4-4d60-4341-d87e-af37e1dd680e@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: VYjMBV57OEmWwb_6Ld0oVA-1
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
Cc: david.edmondson@oracle.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 3:04 AM, Vladimir Sementsov-Ogievskiy wrote:

>> [repo.or.cz appears to be down as I type this; I'll post a link to a
>> repository later when it comes back up]

Now up
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/qcow2-all-zero-v1

>>
> 
> I have several ideas around it.
> 
> 1. For generic block layer.
> Did you consider as alternative to BDRV_ZEO_OPEN, to export the
> information through normal block_status? So, if we have the
> information, that disk is all-zero, we can always add _ZERO
> flag to block-status result.

Makes sense.

> And in generic bdrv_is_all_zeroes(),
> we can just call block_status(0, disk_size), which will return
> ZERO and n=disk_size if driver supports all-zero feature and is
> all-zero now.

Less obvious.  block_status is not required to visit the entire disk, 
even if the entire disk is all zero.  For example, qcow2 visits at most 
one L2 page in a call (if the request spans L1 entries, it will be 
truncated at the boundary, even if the region before and after the 
boundary have the same status).  I'm also worried if we still have 
32-bit limitations in block_status (ideally, we've fixed things to 
support 64-bit status where possible, but I'm not counting on it).

> I think block-status is a native way for such information, and I
> think that we anyway want to come to support of 64bit block-status
> for qcow2 and nbd.

Block status requires an O(n) loop over the disk, where n is the number 
of distinct extents possible.  If you get lucky, and 
block_status(0,size) returns a single extent, then yes that can feed the 
'is_zeroes' request.  Similarly, a single return of non-zero data can 
instantly tell you that 'is_zeroes' is false.  But given that drivers 
may break up their response on convenient boundaries, such as qcow2 on 
L1 entry granularity, you cannot blindly assume that a return of zero 
data for smaller than the requested size implies non-zero data, only 
that there is insufficient information to tell if the disk is all_zeroes 
without querying further block_status calls, and that's where you lose 
out on the speed compared to just being told up-front from an 'is_zero' 
call.

> 
> 2. For NBD
> Again, possible alternative is BLOCK_STATUS, but we need 64bit
> commands for it. I plan to send a proposal anyway. Still, nothing
> bad in two possible path of receiving all-zero information.
> And even with your NBD extension, we can export this information
> through block-status [1.]

Yes, having 64-bit BLOCK_STATUS in NBD is orthogonal to this, but both 
ideas are independently useful, and as the level of difficulty in 
implementing things may vary, it is conceivable to have both a server 
that provides 'is_zero' but not BLOCK_STATUS, and a server that provides 
64-bit BLOCK_STATUS but not 'is_zero'.

> 
> 3. For qcow2
> Hmm. Here, as I understand, than main case is freshly created qcow2,
> which is fully-unallocated. To understand that it is empty, we
> need only to check all L1 entries. And for empty L1 table it is fast.
> So we don't need any qcow2 format improvement to check it.

The benefit of this patch series is that it detects preallocated qcow2 
images as all_zero.  What's more, scanning all L1 entries is O(n), but 
detecting an autoclear all_zero bit is O(1).  Your proposed L1 scan is 
accurate for fewer cases, and costs more time.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


