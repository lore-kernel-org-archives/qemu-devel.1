Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F03BC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 22:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B71F20678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 22:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQg5r88F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B71F20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioxIL-0002fG-Cu
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 17:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ioxHb-0001xt-BM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ioxHZ-0007y2-1e
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:25:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59614
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ioxHY-0007wx-LB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578435899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wu6+//PuyxvN3yZSXwe9b6I2h+XlsoMUJ7bekawFeMw=;
 b=SQg5r88FavAHNW/uSmTk6tKml0hWmioJXDKIVhzRi9zQsmWSclQYXQisYz0FGWlLxcXUkZ
 8e+aeITzZoOb+DrrlfaqIkw1KvoCnQcEc/IwYdyMb0akS21xSf+OfCT6XOPZmIoVETaU8N
 J6d8XiT5FKmd/GJvJUS0Ga4WZNAT1Oo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-EL-xutgbOiO5gLgvg9XeCQ-1; Tue, 07 Jan 2020 17:24:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13E1E100550E;
 Tue,  7 Jan 2020 22:24:55 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9C395C1BB;
 Tue,  7 Jan 2020 22:24:53 +0000 (UTC)
Subject: Re: [PATCH] nbd: fix uninitialized variable warning
To: pannengyuan@huawei.com
References: <20200106015443.38540-1-pannengyuan@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a67b1b6c-addf-da76-b8b3-8af0dd48a1d8@redhat.com>
Date: Tue, 7 Jan 2020 16:24:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106015443.38540-1-pannengyuan@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: EL-xutgbOiO5gLgvg9XeCQ-1
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
Cc: qemu-trivial@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/5/20 7:54 PM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Fixes:
> /mnt/sdb/qemu/nbd/server.c: In function 'nbd_handle_request':
> /mnt/sdb/qemu/nbd/server.c:2313:9: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>       int ret;
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>

False positive in the robot - I cannot see any path where ret is used 
uninitialized.  Closest might be the handling of NBD_CMD_BLOCK_STATUS, 
which looks like:

if (a || b) {
   if (a) {
     ret = ...;
     if (ret < 0) {
       return ret;
     }
   }
   if (b) {
     ret = ...;
     if (ret < 0) {
       return ret;
     }
   }
   return ret;
}

In fact, those 'if (ret < 0)' tests are pointless, since nothing else 
really happens before the final return ret.

If I'm right about this being what trips up the robot, does changing 'if 
(b)' into 'else' solve the problem, rather than adding an initializer? 
And if so, can we clean up the pointless code while at it?

> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>   nbd/server.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 24ebc1a805..7eb3de0842 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2310,7 +2310,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>                                              NBDRequest *request,
>                                              uint8_t *data, Error **errp)
>   {
> -    int ret;
> +    int ret = 0;
>       int flags;
>       NBDExport *exp = client->exp;
>       char *msg;
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


