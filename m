Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CD8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F261206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpGr7hT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F261206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEoX-0001X8-NS
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZEeg-0002Qi-RI
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:16:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52859
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZEee-0004Ip-GU
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589465767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYN00FzTNQ5GfDV9YCtCP9NPirobkMHA4kq6PCid/X0=;
 b=PpGr7hT/96Y/Vm6ZJQ2sIQvGyNnb9KVYoP/oyy1CEbvGm7vOHoFM9plMO3si9hzCQk3p4Q
 14FJ03i7DkvsiCcR9VYRzhnkBaWFDVydeBi8YzB9RX5s2sAIVQWubg8a7RhWK0lPKMginy
 86NNHs3BRCVL9lZbkywnBYTzB9K02y4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-4nYbvJEHMN6hWPXKZLWY-Q-1; Thu, 14 May 2020 10:16:01 -0400
X-MC-Unique: 4nYbvJEHMN6hWPXKZLWY-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83A91107BEF6;
 Thu, 14 May 2020 14:16:00 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC8381025EB7;
 Thu, 14 May 2020 14:15:59 +0000 (UTC)
Subject: Re: [PATCH v4 5/9] blockdev: Split off basic bitmap operations for
 qemu-img
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-6-eblake@redhat.com>
 <59288d06-6da0-0479-bfd9-7beaf8d3f35c@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1afffb4d-5bd6-7674-bc6d-d3482ec78920@redhat.com>
Date: Thu, 14 May 2020 09:15:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <59288d06-6da0-0479-bfd9-7beaf8d3f35c@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, mreitz@redhat.com, nsoffer@redhat.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 1:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> 13.05.2020 04:16, Eric Blake wrote:
>> Upcoming patches want to add some basic bitmap manipulation abilities
>> to qemu-img.  But blockdev.o is too heavyweight to link into qemu-img
>> (among other things, it would drag in block jobs and transaction
>> support - qemu-img does offline manipulation, where atomicity is less
>> important because there are no concurrent modifications to compete
>> with), so it's time to split off the bare bones of what we will need
>> into a new file block/monitor/bitmap-qmp-cmds.o.
>>
>> This is sufficient to expose 6 QMP commands for use by qemu-img (add,
>> remove, clear, enable, disable, merge), as well as move the three
>> helper functions touched in the previous patch.  Regarding
>> MAINTAINERS, the new file is automatically part of block core, but
>> also makes sense as related to other dirty bitmap files.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> ---

>> +++ b/block/monitor/bitmap-qmp-cmds.c
> 
> Hmm, shouldn't transaction bitmap actions be moved here too? May be, not 
> in these series..

No, the very reason that we split this file off of blockdev.c is that 
transactions are NOT needed in qemu-img.  You have to have separate .o 
files for what qemu-img needs, vs. what the rest of qemu proper needs, 
and transactions are only needed in qemu proper at the moment.  If we 
ever need transactions in Kevin's qemu-storage-daemon but not all of 
blockdev.c, then we'd need yet another .c file independent from either 
blockdev.c or this patch's new bitmap-qmp-cmds.c.

> 
>> @@ -0,0 +1,323 @@
>> +/*
>> + * QEMU host block device bitmaps
> 
> A bit conflicts with tha fact that they are not of block-device level 
> but of node-level.
> 
> May be just "Block dirty bitmap qmp commands" ?

Copy-and-paste from blockdev.c, tweaked by adding one word.  Your 
wording is also fine.

> 
>> + *
>> + * Copyright (c) 2003-2008 Fabrice Bellard
> 
> Does it really apply here? block-dirty-bitmap-add was added in 2015.. 
> May be Red Hat and Virtuozzo copyrights would be more appropriate.

When splitting a file, the safest course of action is to preserve ALL 
copyright from the original file into the new file.

Adding additional copyright lines is okay as part of submitting new 
functionality, but in this case, I don't feel comfortable adding Red Hat 
copyright (my split isn't adding new functionality), and I don't have 
authorization to add Virtuozzo copyright (as that is not my employer).


>> +#include "qemu/osdep.h"
>> +
>> +#include "sysemu/blockdev.h"
>> +#include "block/block.h"
>> +#include "block/block_int.h"
>> +#include "qapi/qapi-commands-block.h"
>> +#include "qapi/error.h"
> 
> compiles for with only four:
> 
>    #include "qemu/osdep.h"
>    #include "block/block_int.h"
>    #include "qapi/qapi-commands-block.h"
>    #include "qapi/error.h"

Thanks. I blame rebase; an earlier version used a different header in 
patch 4/9; when I moved things to block_int.h in that patch, I didn't 
realize that this patch could be improved.

> 
> with at least extra includes dropped:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


