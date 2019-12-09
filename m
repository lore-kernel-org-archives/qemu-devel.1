Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7389FC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 22:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3780020637
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 22:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHML+Ls1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3780020637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieR74-00070p-Ae
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 17:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ieR6B-0005xM-Ku
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ieR68-0003yC-Ln
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:01:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46041
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ieR68-0003xn-IY
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575928903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2Wf2hBNC9ZmY4pS6Y99+qcbU+HODaGjsQJmno0IiUQ=;
 b=bHML+Ls1P6poJ0ZHwmRA1zM4FXL5gk8tJW2m97XSP6fe/JZnk8SH9ARmipjjYpXkdSn8w1
 mtnTUkfHP2TGlHHCJYAPbspDVYjFMOh4rZLtdhgiukXs4vylikGPoC9QcqOvfUMdwfUchU
 iqWaa4wp/ZzvukoIV5K3os66IEofV3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-nUnQ0rLxPxGPfKuLREPVxQ-1; Mon, 09 Dec 2019 17:01:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EA3818B5FA0;
 Mon,  9 Dec 2019 22:01:39 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17ADD5DA60;
 Mon,  9 Dec 2019 22:01:34 +0000 (UTC)
Subject: Re: [PATCH for 4.2-rc5 1/1] block/qcow2-bitmap: fix crash bug in
 qcow2_co_remove_persistent_dirty_bitmap
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20191209160015.20253-1-eblake@redhat.com>
 <20191209161607.20894-1-eblake@redhat.com>
 <aa4571a2-2386-a9f0-a9a2-a51dbf6b146f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5d64f01e-aa1e-d5a7-06d9-73655ad3b36b@redhat.com>
Date: Mon, 9 Dec 2019 16:01:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <aa4571a2-2386-a9f0-a9a2-a51dbf6b146f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: nUnQ0rLxPxGPfKuLREPVxQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 vsementsov@virtuozzo.com, "open list:qcow2" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 11:03 AM, John Snow wrote:
> Did you mean to mark this as [PULL] ?

Probably - that's the curse of hand-editing a mail sent in-reply-to the 
cover letter after the fact, instead of sending a v2 of the overall pull 
request.  At any rate, the correct commit made it in (f56281abd9).

> 
> On 12/9/19 11:16 AM, Eric Blake wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Here is double bug:
>>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


