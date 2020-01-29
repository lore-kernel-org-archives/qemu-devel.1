Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E43CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E59206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rMQEcUw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E59206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxYU-0007mB-Bt
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=29084464a=jgrall@amazon.com>)
 id 1iwvjG-0001S8-UU
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 17:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=29084464a=jgrall@amazon.com>)
 id 1iwvjG-0005zT-20
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 17:22:34 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:43609)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=29084464a=jgrall@amazon.com>)
 id 1iwvjD-0005uw-GM; Wed, 29 Jan 2020 17:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1580336552; x=1611872552;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=Hr++Xm5/SV7JXThAprauznben7RfJdieVJTXWnIIrzU=;
 b=rMQEcUw+iQ7RFqunvRYaY2c0czXAm/pdD9r6colzZeQhyMilf5CQa2jp
 nJI8TadPXUnTD3YzzScWArJvxez051zmd+RP7pxYp2/GVcJ2Jm5vV9was
 KYACM7RLQ+jxp4m1ztTom4lkQOdhzh+PQ8wqcuSGYE3nG8Hus9Mvn5Fku k=;
IronPort-SDR: duQNqjC0vKtnAwnN17m+Ex5lKeC3uKAZlerF7G6ef6Is9JC9wCVNCuSaFbosyFZoifP796SDj4
 yciI89LZxk5w==
X-IronPort-AV: E=Sophos;i="5.70,379,1574121600"; d="scan'208";a="21907583"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
 29 Jan 2020 22:22:19 +0000
Received: from EX13MTAUEA002.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS
 id 6DF74A1762; Wed, 29 Jan 2020 22:22:18 +0000 (UTC)
Received: from EX13D32EUB003.ant.amazon.com (10.43.166.165) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 29 Jan 2020 22:22:18 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D32EUB003.ant.amazon.com (10.43.166.165) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 Jan 2020 22:22:17 +0000
Received: from a483e7b01a66.ant.amazon.com (10.95.157.113) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1236.3 via Frontend Transport; Wed, 29 Jan 2020 22:22:15 +0000
Subject: Re: [PATCH] xen-bus/block: explicitly assign event channels to an
 AioContext
To: Anthony PERARD <anthony.perard@citrix.com>, Paul Durrant
 <pdurrant@amazon.com>
CC: <xen-devel@lists.xenproject.org>, <qemu-block@nongnu.org>,
 <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, "Stefan
 Hajnoczi" <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz
 <mreitz@redhat.com>
References: <20191216143451.19024-1-pdurrant@amazon.com>
 <20191219171158.GF1267@perard.uk.xensource.com>
From: Julien Grall <jgrall@amazon.com>
Message-ID: <b2762e84-1cc4-649c-9b53-8754678525f6@amazon.com>
Date: Wed, 29 Jan 2020 22:22:14 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191219171158.GF1267@perard.uk.xensource.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 207.171.184.29
X-Mailman-Approved-At: Wed, 29 Jan 2020 19:02:01 -0500
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

Hi Anthony,

On 19/12/2019 17:11, Anthony PERARD wrote:
> On Mon, Dec 16, 2019 at 02:34:51PM +0000, Paul Durrant wrote:
>> It is not safe to close an event channel from the QEMU main thread when
>> that channel's poller is running in IOThread context.
>>
>> This patch adds a new xen_device_set_event_channel_context() function
>> to explicitly assign the channel AioContext, and modifies
>> xen_device_bind_event_channel() to initially assign the channel's poller
>> to the QEMU main thread context. The code in xen-block's dataplane is
>> then modified to assign the channel to IOThread context during
>> xen_block_dataplane_start() and de-assign it during in
>> xen_block_dataplane_stop(), such that the channel is always assigned
>> back to main thread context before it is closed. aio_set_fd_handler()
>> already deals with all the necessary synchronization when moving an fd
>> between AioContext-s so no extra code is needed to manage this.
>>
>> Reported-by: Julien Grall <jgrall@amazon.com>
>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> 
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

I can't find the patch in QEMU upstream. Are we missing any ack/review 
for this patch?

> 
>> Tested against an HVM debian guest with a QCOW2 image as system disk, and
>> as a hot-plugged/unplgged secondary disk.
> 
> And I've run an osstest flight with the patch.
> 
> Thanks,
> 

Cheers,

-- 
Julien Grall

