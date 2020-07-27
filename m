Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A319C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079392072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBD4hYL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079392072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0BFa-0005um-68
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 18:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0BC7-0002Qy-Rj
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 18:02:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41576
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0BC1-0004sk-AI
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 18:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595887315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nb1kFPazJv+IWfagIPDZL6tVyCO7pbbpzAUfvLlaI/c=;
 b=EBD4hYL8ABgr/I7Z7dEBck1HaVppzTTYPQcW0a4SubgW7QEiF/dqr6P2jAxSQIb2kKMHee
 6q5z0a6ketZPkqxSJwYm1rPRTFG+TBppngA5mJmCC33tSQJpUrmiGf+6KGWN5BpA5ZI81n
 uJeFH4HIULjfq0NMRuE7tDXZmu3U9jE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-5hbpZKezPdyouisREZ7EcQ-1; Mon, 27 Jul 2020 18:01:51 -0400
X-MC-Unique: 5hbpZKezPdyouisREZ7EcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 461BF100CC89;
 Mon, 27 Jul 2020 22:01:50 +0000 (UTC)
Received: from [10.10.118.248] (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B0F610013C4;
 Mon, 27 Jul 2020 22:01:49 +0000 (UTC)
Subject: Re: [PATCH v2 for-5.1? 0/5] Fix nbd reconnect dead-locks
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200727184751.15704-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ac74e0e7-e3ec-5eed-5339-cf38787436a7@redhat.com>
Date: Mon, 27 Jul 2020 17:01:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727184751.15704-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, berrange@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 1:47 PM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> v2: it's a bit updated "[PATCH for-5.1? 0/3] Fix nbd reconnect dead-locks"
> plus completely rewritten "[PATCH for-5.1? 0/4] non-blocking connect"
> (which is now the only one patch 05)
> 
> 01: new
> 02: rebased on 01, fix (add outer "if")
> 03-04: add Eric's r-b:
> 05: new
> 
> If 05 is too big for 5.1, it's OK to take only 01-04 or less, as well as
> postponing everything to 5.2, as it's all not a degradation of 5.1
> (it's a degradation of 4.2, together with the whole reconnect feature).

I think I like where 5/5 is headed, but am not sure yet whether all 
paths are thread-safe or if there is anything we can reuse to make its 
implementation smaller.  You are right that it's probably best to defer 
that to 5.2.  In the meantime, I'll queue 1-4 for my NBD pull request 
for -rc2.

> 
> Vladimir Sementsov-Ogievskiy (5):
>    block/nbd: split nbd_establish_connection out of nbd_client_connect
>    block/nbd: allow drain during reconnect attempt
>    block/nbd: on shutdown terminate connection attempt
>    block/nbd: nbd_co_reconnect_loop(): don't sleep if drained
>    block/nbd: use non-blocking connect: fix vm hang on connect()
> 
>   block/nbd.c        | 360 +++++++++++++++++++++++++++++++++++++++++----
>   block/trace-events |   4 +-
>   2 files changed, 331 insertions(+), 33 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


