Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7784C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0BC02065E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1NI4nGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BC02065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyi2y-0002yg-Vb
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 16:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyi1M-0001fB-Om
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 16:40:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52760
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyi0c-0002rh-5I
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 16:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595536804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+b14UTSAR0qPrH6Z49+F0DMdWcgYnOoC095c5AUxtew=;
 b=D1NI4nGAxOp8yV9EB/WT9RyHNSqbihlCkOE5TYgnBpOKZCKCWb77OBbGEq9YPlEx+hleQ9
 honN/XK5Qa1LjwcKGjOA+HriDMWsxpVG1gwJuoGKKWJNKJZYFHiYHZsINhXsVskc184qVI
 PrBNHtw27q4Fzb3cwhC2GiPedHJI2+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-SdJJLfE0NMCI9f8u2L4YZQ-1; Thu, 23 Jul 2020 16:39:27 -0400
X-MC-Unique: SdJJLfE0NMCI9f8u2L4YZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8A118017FB;
 Thu, 23 Jul 2020 20:39:25 +0000 (UTC)
Received: from [10.3.112.189] (ovpn-112-189.phx2.redhat.com [10.3.112.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9378471D28;
 Thu, 23 Jul 2020 20:39:21 +0000 (UTC)
Subject: Re: [PATCH v2 00/22] Fix error handling during bitmap postcopy
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <0bfccf62-30e4-8ef7-7f26-1af3a3824a6d@virtuozzo.com>
 <090c8382-192e-bbb3-749e-d83a7df7fba3@redhat.com>
 <b359557d-1fd6-e30b-97bd-55d46c021696@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a81676f8-933e-ccb5-99da-eb2d8e8bb975@redhat.com>
Date: Thu, 23 Jul 2020 15:39:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b359557d-1fd6-e30b-97bd-55d46c021696@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-stable@nongnu.org, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 andrey.shinkevich@virtuozzo.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 7:16 AM, Vladimir Sementsov-Ogievskiy wrote:
> 29.05.2020 14:58, Eric Blake wrote:
>> On 4/2/20 2:42 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Ping!
>>>
>>> It's a fix, but not a degradation and I'm afraid too big for 5.0.
>>>
>>> Still, I think I should ping it anyway. John, I'm afraid, that this 
>>> all is for your branch :)
>>
>> Just noticing this thread, now that we've shuffled bitmaps 
>> maintainers. Is there anything here that we still need to include in 5.1?
> 
> Yes, we need the whole series.

I'm starting to go through it now, to see what is still worth getting in 
to 5.1-rc2, but no promises as it is a long series and I don't want to 
introduce last-minute regressions (the fact that this missed 5.0 says 
that 5.1 will be no worse than 5.0 if we don't get this in until 5.2).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


