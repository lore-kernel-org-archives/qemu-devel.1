Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D96C55193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE2A2077D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3XjhIu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE2A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRcOW-000613-Gm
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 10:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRcNu-0005WA-Uk
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRcNt-0001h7-Q0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:59:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47168
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRcNt-0001fy-9k
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587650360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ROI2zE1i8rjGCCkkDt9KX9co/8oUiXho6803pYH4Kw=;
 b=N3XjhIu+jv1ue+wm/VAFt+iOf/iGm7EUeLxuyAOOss+GlIzt/eITkW91MD0hOW/R5OZFo0
 6ElesbCY4IIEKOi2FgANzUDzmiss7rrPr4ORFDyDUw6n1j6QP/FX2Ue5gdjDxlpEkbRdHp
 0J3QaX7qtoQoaZh7hL6lvRA31EMtyww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-CtW6yGLsP-mrtZ-KFYo17g-1; Thu, 23 Apr 2020 09:59:16 -0400
X-MC-Unique: CtW6yGLsP-mrtZ-KFYo17g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83D68460;
 Thu, 23 Apr 2020 13:59:15 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DFAD6084C;
 Thu, 23 Apr 2020 13:59:14 +0000 (UTC)
Subject: Re: [PATCH v5 4/9] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
To: Kevin Wolf <kwolf@redhat.com>
References: <20200422152129.167074-1-kwolf@redhat.com>
 <20200422152129.167074-5-kwolf@redhat.com>
 <84c6ca49-aef3-adf4-2efe-68357dd20ce8@redhat.com>
 <20200422155835.GC7155@linux.fritz.box>
 <20d12788-2d62-12a4-0949-f29594054026@redhat.com>
 <20200423132302.GA23654@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <be3189fa-8120-9bae-166d-f95f5d3a94c7@redhat.com>
Date: Thu, 23 Apr 2020 08:59:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423132302.GA23654@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 8:23 AM, Kevin Wolf wrote:

>>>
>>> So qcow2_cluster_zeroize() seems to accept the unaligned tail. It would
>>> still set the zero flag for the partial last cluster and for the
>>> external data file, bdrv_co_pwrite_zeroes() would have the correct size.
>>
>> Then I'm in favor of NOT rounding the tail.  That's an easy enough change
>> and we've now justified that it does what we want, so R-b stands with that
>> one-line tweak.
> 
> Would have been too easy... bs->total_sectors isn't updated yet, so the
> assertion does fail.
> 
> I can make the assertion check end_offset >= ... instead. That should
> still check what we wanted to check here and allow the unaligned
> extension.

Yes, that works for me.

> 
> This feels like the better option to me compared to updating
> bs->total_sectors earlier and then undoing that change in every error
> path.

Indeed.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


