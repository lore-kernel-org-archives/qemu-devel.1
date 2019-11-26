Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E232CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3022071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJY5dJwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3022071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZdC4-0002Km-PE
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 10:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iZdAt-0001HZ-IO
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iZdAs-0006bK-GZ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:54:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25241
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iZdAs-0006b8-DE
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574783686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60VUjwtLrwMqI1MqQMIQwAZJTw7gaSuGKA4pVxVQ448=;
 b=HJY5dJwUbzcPlf63VLj+xcC+aUdMddaG1LTw+JtcWFE8xTh5xwjE7RZ8C7VMs99KTaI3bN
 A1l/PNCB+XJcFXouXax0Lq+qRJlrfSARUbN/ZcRGhrMHWwWvLDvV/db4IPnm5vONsi2LAz
 PtytSJ9tHvwPPU2eEO5ahAAtdfWbj7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-PHbKwvbYNjaiJNkJtT4tKA-1; Tue, 26 Nov 2019 10:54:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67F2F107ACE8;
 Tue, 26 Nov 2019 15:54:41 +0000 (UTC)
Received: from [10.3.116.163] (ovpn-116-163.phx2.redhat.com [10.3.116.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FB83600CD;
 Tue, 26 Nov 2019 15:54:41 +0000 (UTC)
Subject: Re: [PATCH] block: Error out on image creation with conflicting size
 options
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191126154835.27915-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cf113754-c582-03ae-9e53-ab0213c0ccf9@redhat.com>
Date: Tue, 26 Nov 2019 09:54:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191126154835.27915-1-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: PHbKwvbYNjaiJNkJtT4tKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On 11/26/19 9:48 AM, Kevin Wolf wrote:
> If both the create options (qemu-img create -o ...) and the size
> parameter were given, the size parameter was silently ignored. Instead,
> make specifying two sizes an error.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block.c                    | 10 ++++++++--
>   tests/qemu-iotests/049     |  5 +++++
>   tests/qemu-iotests/049.out |  5 +++++
>   3 files changed, 18 insertions(+), 2 deletions(-)

Longtime bug, so not essential for 4.2-rc3.  But small enough that you 
could sneak it in if you have other patches to queue and don't want to 
wait for 5.0.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


