Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C31C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 21:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E498A2073F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 21:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWGCvTPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E498A2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icGAH-0008HI-3f
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 16:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icFrJ-0001Ea-Oo
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:37:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icFrB-000355-LB
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:37:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56225
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icFrB-0002kE-Fu
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575409032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBUGIMgVwqwKg7n2RfLhiuSC/TvnKSGgFJ2sYbYmtlY=;
 b=OWGCvTPzIwC4xfM7XdtQqAtp88t4KX209i22Jxws1Wdh6kkpfdcS36PaXFsYVl0nbw5KRe
 l8ZrJSzafnYct84v/ZSmTx+qEAj08GzTsMp9Hqnr1FF+yJMXiVjhTKQ12DWCBMOZ6sMoJc
 5pOw+oNO31s98qSAfN7TkT71932zVx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-WSeXyd6MP_-VtYiKBmQD-g-1; Tue, 03 Dec 2019 16:37:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 024F9800D5A;
 Tue,  3 Dec 2019 21:37:07 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B27D60BE1;
 Tue,  3 Dec 2019 21:37:03 +0000 (UTC)
Subject: Re: [PATCH 13/21] memory-device: Fix latent memory pre-plug error
 handling bugs
To: Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-14-armbru@redhat.com>
 <5306b8e8-fea3-c482-badb-9b78891d7e27@redhat.com>
 <87h82jnwlx.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c3483308-e0b4-81ea-5346-9c501644046f@redhat.com>
Date: Tue, 3 Dec 2019 15:37:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87h82jnwlx.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: WSeXyd6MP_-VtYiKBmQD-g-1
X-Mimecast-Spam-Score: 0
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/1/19 11:07 PM, Markus Armbruster wrote:

>>>   {
>>> +    Error *err = NULL;

>> I remember that some time ago, the best practice was to use "local_err",
>> what is the latest state of that?
> 
> Hundreds of local Error * variables are named @local_err, and hundreds
> more are named @err.
> 
> For what it's worth, the big comment in error.h uses @err, except in one
> place where it needs two of them.

What's more, if we go through with Vladimir's Coccinelle cleanup to use 
ERRP_AUTO_PROPAGATE, then we don't have either name to worry about (both 
'&local_err' and '&err' are replaced by 'errp').

> 
>> I still disagree that these are BUGs or even latent BUGs. If somebody
>> things these are BUGs and not cleanups, then we should probably have
>> proper "Fixes: " tags instead.
> 
> Let's continue that discussion in the sub-thread where you first raised
> this objection.

One benefit of fixing the style (whether or not you count it as a bug 
fix) is that the Coccinelle script for updating to a new style is more 
likely to apply correctly.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


