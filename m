Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BBAC282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 22:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD8220715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 22:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9W5xR1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD8220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iowvS-0007Hi-1g
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 17:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iowug-0006mX-LM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iowue-0002DV-83
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:01:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29193
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iowud-0002Bn-L0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578434478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ve+5bnsQwqI/tw1TnoJd7CZ7ixvX0rgpGrhys7Uo/iY=;
 b=N9W5xR1SUqWNa7lXzE8bTGURi82bmeT2PAyjKplKTqUZs793wux0FkXkYt5oB1F9BvHmYI
 GPmGnI0L1DuDU/jns86mV/8fa8CH8NY6vUqJN9jbXzgL/2vMY7EVPWjuTBs8bWItcz5N4s
 JpKZhlUnVzhvdOrbWucVWTACXWhSmIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-It70sAanP-myY-RTA3IisQ-1; Tue, 07 Jan 2020 17:01:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0196F801E77;
 Tue,  7 Jan 2020 22:01:14 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 704F8271A5;
 Tue,  7 Jan 2020 22:01:13 +0000 (UTC)
Subject: Re: [PATCH] nbd/server: improve nbd_negotiate_send_rep_list
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191226081521.29652-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <22eee419-ba2e-512a-568d-e8bd348f592a@redhat.com>
Date: Tue, 7 Jan 2020 16:01:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191226081521.29652-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: It70sAanP-myY-RTA3IisQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/26/19 2:15 AM, Vladimir Sementsov-Ogievskiy wrote:
> Don't try to write zero-lenght strings.

length

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 24ebc1a805..28a915f5a2 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -392,14 +392,18 @@ static int nbd_negotiate_send_rep_list(NBDClient *client, NBDExport *exp,
>           return -EINVAL;
>       }
>   
> -    if (nbd_write(ioc, name, name_len, errp) < 0) {
> -        error_prepend(errp, "write failed (name buffer): ");
> -        return -EINVAL;
> +    if (name_len > 0) {
> +        if (nbd_write(ioc, name, name_len, errp) < 0) {

What's the rationale for this change?  nbd_write() should be a no-op for 
a zero length write, at which point this is a micro-optimization (fewer 
CPU cycles, but no semantic change).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


