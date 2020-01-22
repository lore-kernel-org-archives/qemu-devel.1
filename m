Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B2CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 18:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF4524673
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 18:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVE98VND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF4524673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuLAo-0000g5-7a
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 13:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iuLA7-0000A6-Vk
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iuLA5-0006O2-Pg
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:55:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49401
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iuLA5-0006NZ-JJ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579719332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCorWx9KlztxV39ts3inGEOca9PAAuqvYJJg+0tFUAs=;
 b=JVE98VNDd/inItWVd1HrW1sGzys8QNQaBHJRKiOVvI6GMnHsd2/7WexmAbBtLPX+JUgZS6
 D0bfSOwGV0Jt9SRYnqFYhuiZItNUX+Kxx6csFRbgPTvcAUz5Si5udGWEMiAbVdw4y+p8VO
 SQc6MEQox6fcZFnmEkaZueoVfCCHTPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-obf2rM8pOMWEI6OzSDS-eg-1; Wed, 22 Jan 2020 13:55:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F451477;
 Wed, 22 Jan 2020 18:55:29 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11CA28BE3D;
 Wed, 22 Jan 2020 18:55:28 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] block/nbd: Fix hang in .bdrv_close()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200122164532.178040-1-mreitz@redhat.com>
 <20200122164532.178040-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8bb662ae-b055-1591-682b-5e47023338b5@redhat.com>
Date: Wed, 22 Jan 2020 12:55:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122164532.178040-2-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: obf2rM8pOMWEI6OzSDS-eg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 10:45 AM, Max Reitz wrote:
> When nbd_close() is called from a coroutine, the connection_co never
> gets to run, and thus nbd_teardown_connection() hangs.
> 
> This is because aio_co_enter() only puts the connection_co into the main
> coroutine's wake-up queue, so this main coroutine needs to yield and
> wait for connection_co to terminate.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/nbd.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

I'm assuming it is better to take the entire series through somewhere 
other than my NBD tree, since the remaining patches touch more than NBD?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


