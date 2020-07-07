Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA73C433E3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4DA204EC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doJz8bgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4DA204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspZ4-00050T-9H
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jspYD-0004S3-8v
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:30:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56822
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jspYB-0007qR-I4
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594135826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uhudkcqYa+dJJQVsnYss9EKCCASOYmltouF21ej5Pc=;
 b=doJz8bgcKwGoDW2xZX6n7TpovOptItdd5rOEkFnncev1Xziw8YqW5kdnQIviEk8mhdEM1v
 NCLbF5oN+Q/KUTyeYM4FV1X7DcGENofssZzeff3GitagbP1yy7loRb9mnFy56stYATXp5X
 TJIFtRCC6XkQ3zfg05wseuOwP/8SJF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-7lOhl7LDNj6XwzMasPwVsA-1; Tue, 07 Jul 2020 11:30:06 -0400
X-MC-Unique: 7lOhl7LDNj6XwzMasPwVsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E0F01052509;
 Tue,  7 Jul 2020 15:30:05 +0000 (UTC)
Received: from [10.3.113.97] (ovpn-113-97.phx2.redhat.com [10.3.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2511973FE0;
 Tue,  7 Jul 2020 15:30:04 +0000 (UTC)
Subject: Re: [PATCH] qemu-img map: Don't limit block status request size
To: Kevin Wolf <kwolf@redhat.com>
References: <20200707144629.51235-1-kwolf@redhat.com>
 <9f74d8dc-9c4e-d519-9dd7-0895ece3de17@redhat.com>
 <20200707152147.GC7002@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8cfe5adb-a2ae-86cd-51af-4ba25c34336d@redhat.com>
Date: Tue, 7 Jul 2020 10:30:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707152147.GC7002@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 10:21 AM, Kevin Wolf wrote:
> Am 07.07.2020 um 16:54 hat Eric Blake geschrieben:
>> On 7/7/20 9:46 AM, Kevin Wolf wrote:
>>> Limiting each loop iteration of qemu-img map to 1 GB was arbitrary from
>>> the beginning, though it only cut the maximum in half then because the
>>> interface a signed 32 bit byte count. These days, bdrv_block_status()

interface was a

>>> supports a 64 bit byte count, so the arbitrary limit is even worse.
>>>
>>> On file-posix, bdrv_block_status() eventually maps to SEEK_HOLE and
>>> SEEK_DATA, which don't support a limit, but always do all of the work
>>> necessary to find the start of the next hole/data. Much of this work may
>>> be repeated if we don't use this information fully, but query with an
>>> only slightly larger offset in the next loop iteration. Therefore, if
>>> bdrv_block_status() is called in a loop, it should always pass the
>>> full number of bytes that the whole loop is interested in.
>>>
>>> This removes the arbitrary limit and speeds up 'qemu-img map'
>>> significantly on heavily fragmented images.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>    qemu-img.c | 5 +----
>>>    1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> Do you want this in 5.1?  It seems like a nice optimization.
> 
> I guess now that I have your R-b, I can sneak both patches in for soft
> freeze. :-)

Can we treat optimizations for speed problems as bug fixes if they land 
after soft freeze but before -rc1?

At any rate, this post reminds me that Vladimir's series to support 
64-bit actions elsewhere has probably slipped into 5.2 territory, but I 
still need to fix the fact that nbd is sending uint32_t trim/zero values 
into signed int block layer functions (Vladimir's work is nicer but 
harder to review, so I'll probably end up writing one-off patches for 
5.1 with minimal churn to just block/nbd.c rather than the whole block 
layer...)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


