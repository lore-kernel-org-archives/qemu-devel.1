Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38F6C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413D82075A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doeHNzax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413D82075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMuHB-0007hy-2S
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 10:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kMuFv-0006QF-9I
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kMuFp-0005It-Hu
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:35:55 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601303748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWFumjoqgqaxg7Lw/kkvNKiYd0uqtrru8F0pQ5H5hLM=;
 b=doeHNzaxRxJ5pcWEax71neIsW8XIMvMwyzUlT0aU9u2IxoMhc6wEXLKEPlH/omtlAGn74+
 uHIiD5nFxZj423AFxds5oIAXh7UDHDrW5X76PdqSFATCOE4csRZe23vzK7LkZ6WybFYyaE
 T0jew5n9nO4DquaSfn3InMz518XHFS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-5tSahJ-wPGe42Fniu8KLuA-1; Mon, 28 Sep 2020 10:35:45 -0400
X-MC-Unique: 5tSahJ-wPGe42Fniu8KLuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F6511019624;
 Mon, 28 Sep 2020 14:35:44 +0000 (UTC)
Received: from [10.3.112.208] (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E463B55799;
 Mon, 28 Sep 2020 14:35:43 +0000 (UTC)
Subject: Re: [PATCH 3/3] nbd: Add 'qemu-nbd -A' to expose allocation depth
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200925203249.155705-1-eblake@redhat.com>
 <20200925203249.155705-4-eblake@redhat.com>
 <ee868912-173e-328d-5138-b1e19a0ca2b1@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5908bfab-f9ab-bbb9-5a47-85c38c1040e5@redhat.com>
Date: Mon, 28 Sep 2020 09:35:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ee868912-173e-328d-5138-b1e19a0ca2b1@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, rjones@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/20 8:32 AM, Vladimir Sementsov-Ogievskiy wrote:
> 25.09.2020 23:32, Eric Blake wrote:
>> Allow the server to expose an additional metacontext to be requested
>> by savvy clients.  qemu-nbd adds a new option -A to expose the
>> qemu:allocation-depth metacontext through NBD_CMD_BLOCK_STATUS; this
>> can also be set via QMP when using nbd-server-add.
>>
>> qemu as client can be hacked into viewing this new context by using
>> the now-misnamed x-dirty-bitmap option when creating an NBD blockdev;
> 
> may be rename it to x-block-status ?

I thought about it.  We don't promise any back-compat with x- prefix, 
but at the same time, if there's not a strong reason to change it, 
scripts written against older qemu will not break as long as we still 
have the hack.

> 
>> although it is worth noting the decoding of how such context
>> information will appear in 'qemu-img map --output=json':
>>
>> NBD_STATE_DEPTH_UNALLOC => "zero":false, "data":true
>> NBD_STATE_DEPTH_LOCAL => "zero":false, "data":false
>> NBD_STATE_DEPTH_BACKING => "zero":true, "data":true
> 
> It wouldn't be so simple if we decide to export exact depth number..

It's still simple to do tri-state results if we separate the exact depth 
number to bits 31-4, leaving bits 1-0 as the tri-state summary...

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


