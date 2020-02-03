Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D94DC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 19:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CFAC2051A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 19:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ck+eEPOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFAC2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygyw-0006r6-IH
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 14:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iygxI-0006EZ-Th
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iygxH-0000hD-Pw
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:00:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52320
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iygxH-0000gS-K0
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580756419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wrl4NLlsQ1GXO/oE7WniDAQ6b1MZ9eSk9C5NfrHRMew=;
 b=Ck+eEPOKW1EW5xhh1jsml7hhH5MdDhQgO0JdlQ8AXZKm/4VoqBQNtuax/rtlVIXpx6j9/e
 WcJ5Pirfufwvs6KwVHu7Qf5CB5Sh27ULYtcUWorLXdfzjPNetv0XgXZ0vMNXOnYemwb8Gr
 ePOCSkFKOo59QYU0Bmf9JutUzhcAU60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-hvd8QlS9O0OwVkFWObJZzg-1; Mon, 03 Feb 2020 14:00:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA0F8107ACC9;
 Mon,  3 Feb 2020 19:00:06 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1750489A82;
 Mon,  3 Feb 2020 19:00:05 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] qemu-img: Add --target-is-zero to convert
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20200124103458.1525982-1-david.edmondson@oracle.com>
 <20200124103458.1525982-2-david.edmondson@oracle.com>
 <4b23f9d9-efe4-000d-0d68-66028ad3d2f3@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2e7777b6-5ae0-973c-1040-dae6def3925c@redhat.com>
Date: Mon, 3 Feb 2020 13:00:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4b23f9d9-efe4-000d-0d68-66028ad3d2f3@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: hvd8QlS9O0OwVkFWObJZzg-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 12:20 PM, Vladimir Sementsov-Ogievskiy wrote:
> 24.01.2020 13:34, David Edmondson wrote:
>> In many cases the target of a convert operation is a newly provisioned
>> target that the user knows is blank (filled with zeroes). In this
>> situation there is no requirement for qemu-img to wastefully zero out
>> the entire device.
>>
>> Add a new option, --target-is-zero, allowing the user to indicate that
>> an existing target device is already zero filled.
> 
> Hi! qemu-img.c part looks OK for me, but other doesn't apply on master now.

Correct. Patch 2/2 is now obsolete and no longer necessary, and patch 1 
needs some tweaks now that we don't have qemu-img.texi.

> 
> I like this thing, and I'd like to make similar option for backup job.

My followup patches to add an all-zero bit to qcow2 are also useful in 
this regard.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


