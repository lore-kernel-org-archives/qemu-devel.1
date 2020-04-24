Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C0EC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0E420736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4pmM49g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0E420736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRz9W-0003rC-EB
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 10:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRz8Q-0002g9-0H
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRz8P-0007QO-JY
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:16:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59062
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRz8P-0007Ow-6A
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587737811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQAGfkUDFE7b56+xClaXX7ThAZpSI03xk6J8cvAnEFU=;
 b=f4pmM49g2qmVaBm5T6FYEXFwnrrbm7zTZLTadHlYf7ZBDDd5vWvIXSXCeQBOvn1AS5xKJ7
 M7i6qb++6Gss9//tVO9JB2I778qFJbHBvK384S2WaIO93K74Nl+/pgfKDRFZhcEYNpzZjt
 bw7dfcgkD4CbMQHjP55VX7vOA7yHW3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-z65JLhIsPRidlkKgfZ-7_w-1; Fri, 24 Apr 2020 10:16:43 -0400
X-MC-Unique: z65JLhIsPRidlkKgfZ-7_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 910DC463;
 Fri, 24 Apr 2020 14:16:42 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B712600E8;
 Fri, 24 Apr 2020 14:16:41 +0000 (UTC)
Subject: Re: [PATCH v6 04/10] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-5-kwolf@redhat.com>
 <436f15ce-da79-7016-6478-c5ab8642ee25@virtuozzo.com>
 <20200424121712.GA4921@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <48c05a8e-bc60-d0b9-2b0a-dd219cc4466b@redhat.com>
Date: Fri, 24 Apr 2020 09:16:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424121712.GA4921@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 7:17 AM, Kevin Wolf wrote:

> 
>>> +            ret = qcow2_co_pwritev_part(bs, old_length, qiov.size, &qiov, 0, 0);
>>
>> Better not do it if this cluster is already ZERO.. But it may be a
>> later patch to improve that.
> 
> I doubt it's worth writing code to optimise a corner case inside a
> corner case.

I spotted the same issue, and my suggestion was to use 
qcow2_co_pwrite_zero instead of qcow2_co_pwritev_part, but Kevin pointed 
out that my idea would probably not work the way I thought.  Then again, 
checking if the page is already zero is all the more benefit that 
qcow2_co_pwrite_zero would have given for me to have raised the 
question.  The following example illustrates why it might be worthwhile:

Suppose we have an image with 1M clusters, which is an unaligned 100.5M 
in length but started life with all clusters sparse.  We then resize it 
to another unaligned 200.5M.  The call to qcow2_co_pwritev_part will 
cause the image to be non-sparse for one cluster out of 201, whereas 
adding a check to skip the pwritev because the original unaligned tail 
cluster already read as zero will let us keep all clusters sparse.

At any rate, I argued that any such optimization would be a followup 
patch, and Kevin is right that it is a corner case optimization unlikely 
to affect many real-life images.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


