Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A05C2D0C8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 13:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A8320716
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 13:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2NkQ5qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A8320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihCir-0003XS-BR
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 08:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ihChb-0002qJ-47
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ihCha-0003ir-3D
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:15:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44820
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ihChZ-0003ig-Vw
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576588549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KzgfB1pVl8vuP10FEbSvBNjLt+ueTgy7JwUUSe3mBy0=;
 b=V2NkQ5qyCSrfO0Zu7Wry+VdtonN0RtGGT+2raGYHRodPLkfnwwbgor7HKdc1xWObdKkvK3
 rE9RYr5Pdg7qmLUv8oJERsfMNEusE/tAbJU8O5SENSOF2BK7Fu2tLHzYMrm0IBLqGNhUmF
 sW41W6zKIlKmimMyapOc30cTARfLv1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-2eq6f71uNQ-hLDPm69KiAQ-1; Tue, 17 Dec 2019 08:15:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C359800D48;
 Tue, 17 Dec 2019 13:15:45 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E309960BE2;
 Tue, 17 Dec 2019 13:15:41 +0000 (UTC)
Subject: Re: [PATCH RFC] qapi: Allow getting flat output from
 'query-named-block-nodes'
To: Markus Armbruster <armbru@redhat.com>
References: <42dae98e1f6a9f444f48a20192f45195337824f0.1576246045.git.pkrempa@redhat.com>
 <836c1a18-b67d-0426-2137-8f464e4e5c9b@redhat.com>
 <87lfrbjtdu.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fa269c43-f966-54a7-6589-46f28138ea15@redhat.com>
Date: Tue, 17 Dec 2019 07:15:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87lfrbjtdu.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2eq6f71uNQ-hLDPm69KiAQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 1:36 AM, Markus Armbruster wrote:

> Un-snipping the QAPI schema change:

Sorry about that...

> 
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 0cf68fea14..bd651106bd 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -1752,6 +1752,8 @@
>>>   #
>>>   # Get the named block driver list
>>>   #
>>> +# @flat: don't recurse into backing images if true. Default is false (Since 5.0)
>>> +#
>>>   # Returns: the list of BlockDeviceInfo
>>>   #
>>>   # Since: 2.0
> 
> What does it mean not to recurse?  Sounds like flat: false asks for a
> subset of the full set.  How exactly is the subset defined?

Bike-shedding:

Would it be easier to explain as:

@recurse: If true, include child information in each node (note that 
this can result in redundant output). Default is true (since 5.0)

and then pass false when you don't want recursion, with it being more 
obvious that using the new flag results in more compact output with no 
loss of information.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


