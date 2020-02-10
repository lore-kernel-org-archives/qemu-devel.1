Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74797C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410F82070A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5r76uIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410F82070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j19GK-0001mN-EL
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j19FU-0000sj-NQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j19FT-00039m-OO
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:37:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35914
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j19FT-00039P-IR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581341835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dz2jXXKF8dxARDf2g94pzh82zl/erD9ODjisL2zY0Yg=;
 b=c5r76uIrubwHkCB350bcxHnh25sb2rTwidawUOiMpDWAgYYwADLTYejuec4SCyDQH9Fr/C
 MbVTWuHtCJyQ9nzf/BB4aLKMn9tyL9xLjiZtEB65MQvlQqf68pIJ6EFGzUaKgwc+/xB7iV
 3ANj51vBOar2MmentxdjR6CwUUM0NL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-Gfhtu6BCPQKlXH-wkpVrNw-1; Mon, 10 Feb 2020 08:37:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1890110054E3;
 Mon, 10 Feb 2020 13:37:09 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3BC3857A9;
 Mon, 10 Feb 2020 13:36:59 +0000 (UTC)
Subject: Re: [PATCH v12 12/13] virtio-iommu: Support migration
From: Auger Eric <eric.auger@redhat.com>
To: quintela@redhat.com
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-13-eric.auger@redhat.com>
 <87eev27hby.fsf@secure.laptop>
 <c8df42d0-c913-94e3-39a0-1e09fa459622@redhat.com>
Message-ID: <6a276f9d-18a3-300b-c55f-00665d30b34f@redhat.com>
Date: Mon, 10 Feb 2020 14:36:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c8df42d0-c913-94e3-39a0-1e09fa459622@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Gfhtu6BCPQKlXH-wkpVrNw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, jean-philippe@linaro.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Juan,

On 2/10/20 2:09 PM, Auger Eric wrote:
> Hi Juan,
> 
> On 2/10/20 1:33 PM, Juan Quintela wrote:
>> Eric Auger <eric.auger@redhat.com> wrote:
>>> Add Migration support. We rely on recently added gtree and qlist
>>> migration. We only migrate the domain gtree. The endpoint gtree
>>> is re-constructed in a post-load operation.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>
>> And yes, this is as confusing as it can be:
>>  a tree of mappings (i.e. key,value)
>>  a list of endpoints
>>
>> I will propose this as most complex structure migrated ever.
> :-) Thank you Juan, Dave, and Peter for your support

I did not notice this at the first glimpse but could you send the R-b on
the v15. I have been running like a hamster on my wheel during last week.

Code has not changed though :-).

Thanks

Eric
> 
> Best Regards
> 
> Eric
>>
>> Later, Juan.
>>
> 
> 


