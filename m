Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF91FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 22:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA05A21835
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 22:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA05A21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKryy-00048B-RP
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 18:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iKrws-0003HM-Tl
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 18:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iKrwr-0006xF-TN
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 18:39:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iKrwo-0006uy-EK; Wed, 16 Oct 2019 18:39:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D0DE330832E9;
 Wed, 16 Oct 2019 22:39:11 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E85C5D6A9;
 Wed, 16 Oct 2019 22:39:08 +0000 (UTC)
Subject: Re: [PATCH v10 2/3] block/nbd: nbd reconnect
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191009084158.15614-1-vsementsov@virtuozzo.com>
 <20191009084158.15614-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3b1f9697-fdfe-0a4e-e1bc-a64fd12f7dfe@redhat.com>
Date: Wed, 16 Oct 2019 17:39:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009084158.15614-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 16 Oct 2019 22:39:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/19 3:41 AM, Vladimir Sementsov-Ogievskiy wrote:
> Implement reconnect. To achieve this:
> 
> 1. add new modes:
>     connecting-wait: means, that reconnecting is in progress, and there
>       were small number of reconnect attempts, so all requests are
>       waiting for the connection.
>     connecting-nowait: reconnecting is in progress, there were a lot of
>       attempts of reconnect, all requests will return errors.
> 
>     two old modes are used too:
>     connected: normal state
>     quit: exiting after fatal error or on close
> 
> Possible transitions are:
> 
>     * -> quit
>     connecting-* -> connected
>     connecting-wait -> connecting-nowait (transition is done after
>                        reconnect-delay seconds in connecting-wait mode)
>     connected -> connecting-wait
> 
> 2. Implement reconnect in connection_co. So, in connecting-* mode,
>      connection_co, tries to reconnect unlimited times.
> 
> 3. Retry nbd queries on channel error, if we are in connecting-wait
>      state.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd.c | 331 ++++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 268 insertions(+), 63 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

