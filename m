Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9902C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49A72065F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+rGrX8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49A72065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyh14-0000F8-U2
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 15:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyh0O-0008Bo-SG
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 15:35:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyh0M-0001w9-Jx
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 15:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595532945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8TOOYWB4lunXnbSQmUrX9VSxwG3g0jjm9oPj4E6/3Y=;
 b=E+rGrX8cE1U7W1VGw6aEYDfgNy+Wcc0D/AF8g10rpNY4YI+k11hId3rAdzbOqq3IeMJoke
 WXjTgj7JoOmOqNLbSGehqOQMTVymQx+UgYvEYbysPkrD34s8VrQw8/awRaApULBhl9K1Cv
 wOp9hkDXjts/EEtn4WuWYRtXeHr+sys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-2kYnxYwVN6apunvD-rRtyQ-1; Thu, 23 Jul 2020 15:35:43 -0400
X-MC-Unique: 2kYnxYwVN6apunvD-rRtyQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57023100AA24;
 Thu, 23 Jul 2020 19:35:42 +0000 (UTC)
Received: from [10.3.112.189] (ovpn-112-189.phx2.redhat.com [10.3.112.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFA1C8BEE8;
 Thu, 23 Jul 2020 19:35:39 +0000 (UTC)
Subject: Re: [PATCH for-5.1? 0/4] non-blocking connect
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200720180715.10521-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c8a9ac63-6d7d-1955-976d-b51c3ad6b0ab@redhat.com>
Date: Thu, 23 Jul 2020 14:35:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720180715.10521-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, kraxel@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 1:07 PM, Vladimir Sementsov-Ogievskiy wrote:
> Hi! This fixes real problem (see 04). On the other hand it may be too
> much for 5.1, and it's not a degradation. So, up to you.

Given the concerns raised on 3, I think I'll wait for v2 of the series, 
and defer it to 5.2.

> 
> It's based on "[PATCH for-5.1? 0/3] Fix nbd reconnect dead-locks", or
> in other words
> Based-on: <20200720090024.18186-1-vsementsov@virtuozzo.com>
> 
> Vladimir Sementsov-Ogievskiy (4):
>    qemu-sockets: refactor inet_connect_addr
>    qemu-sockets: implement non-blocking connect interface
>    io/channel-socket: implement non-blocking connect
>    block/nbd: use non-blocking connect: fix vm hang on connect()
> 
>   include/io/channel-socket.h | 14 +++++++
>   include/qemu/sockets.h      |  6 +++
>   block/nbd.c                 | 11 +++---
>   io/channel-socket.c         | 74 ++++++++++++++++++++++++++++++++++++
>   util/qemu-sockets.c         | 76 ++++++++++++++++++++++++++-----------
>   5 files changed, 153 insertions(+), 28 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


