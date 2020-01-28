Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8AEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B733F206F0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfdKz3zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B733F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwX8L-0006eB-V9
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 15:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iwX7Z-0005md-5h
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iwX7Y-00025W-5o
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:06:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iwX7Y-00025P-2b
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580241959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8jW79ThubXDyw1e63hFUyoOCVTkE8OZf2tL93gd7vI=;
 b=IfdKz3zpLJ0NTjlei+wVE4gg+2ddNtTeGoVENS3UO8xKhqSl+qadLFOy3JTx7liw1RJgFS
 E3jIRGIdcsvsm90mi0Tc4vT+79UbomB8G5sgA2EJESzb55J39g1g3IcABiCnEPb9Wt6sg+
 /VcwjskVSiReHIFXhl55/aXPAralfZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-uGynRypxOaO9yeKcf1rhhQ-1; Tue, 28 Jan 2020 15:05:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FDB680268A;
 Tue, 28 Jan 2020 20:05:48 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 827D060BFB;
 Tue, 28 Jan 2020 20:05:44 +0000 (UTC)
Subject: Re: [PATCH v3 08/13] monitor/hmp: move hmp_nbd_server* to
 block-hmp-cmds.c
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-9-mlevitsk@redhat.com> <20200128185627.GD3215@work-vm>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <29f7b27f-946d-0620-7d62-99f0f3988e80@redhat.com>
Date: Tue, 28 Jan 2020 14:05:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128185627.GD3215@work-vm>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uGynRypxOaO9yeKcf1rhhQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/28/20 12:56 PM, Dr. David Alan Gilbert wrote:
> * Maxim Levitsky (mlevitsk@redhat.com) wrote:
>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Yes, I think that's OK; I can imagine nbd might want to move on it's own
> somewhere since it's not really core block code; copying in Eric.

I think that nbd-server-start and friends ARE related to core block 
code; they do not work without a BDS node.  It's not the same as a block 
driver, though, in that it is exposing the BDS to the outside world, 
rather than connecting an outside resource for use internally by the guest.

At any rate, block-hmp-cmds.c seems reasonable enough as a new location 
for these HMP commands.

> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
>> ---
>>   block/monitor/block-hmp-cmds.c     | 88 ++++++++++++++++++++++++++++++
>>   include/block/block-hmp-commands.h |  5 ++
>>   include/monitor/hmp.h              |  4 --
>>   monitor/hmp-cmds.c                 | 87 -----------------------------
>>   4 files changed, 93 insertions(+), 91 deletions(-)
>>
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


