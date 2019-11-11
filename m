Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7305AC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3F8206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4+BWPl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3F8206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUDtS-0003IE-Dj
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 12:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iUDsm-0002rk-Os
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iUDsk-0006Zc-QY
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:53:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34052
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iUDsk-0006ZS-NL
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573494822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ht5K7v8mAM20pi6lGNPmiNkZ+0cgjo2/aOQZQ5UivdM=;
 b=W4+BWPl5uWyleMBIA0EmH1EeecGQ84GCaPmA2RzoxQQUrx55JgWsFA7LCYtrG/cp6NeMEo
 e1aH7Wdj9J3zsIvtfmtb7VB+GQw/jkzXjQc+QD1jsq5cDuhPrd1XWcJ6UyZ9GPPKKGDVbo
 5wImIgChPmsUfrGazUXUerGiALk2aGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-3lb4O7LhPVCU_KrVzL4-2Q-1; Mon, 11 Nov 2019 12:53:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02BD01005500;
 Mon, 11 Nov 2019 17:53:38 +0000 (UTC)
Received: from [10.3.116.242] (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 033859F4C;
 Mon, 11 Nov 2019 17:53:36 +0000 (UTC)
Subject: Re: [PATCH v4] iotests: Test NBD client reconnection
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1573466663-626788-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <68944099-25f1-8aea-c951-ea1802bf9549@redhat.com>
Date: Mon, 11 Nov 2019 11:53:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573466663-626788-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3lb4O7LhPVCU_KrVzL4-2Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 rkagan@virtuozzo.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/11/19 4:04 AM, Andrey Shinkevich wrote:
> The test for an NBD client. The NBD server is disconnected after the
> client write request. The NBD client should reconnect and complete
> the write operation.
>=20
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
> v3 was discussed in the email thread with the message ID
> <1572627272-23359-1-git-send-email-andrey.shinkevich@virtuozzo.com>
>=20

> +import os
> +import subprocess
> +import iotests
> +from iotests import file_path, log
> +
> +
> +nbd_sock, conf_file =3D file_path('nbd-sock', "nbd-fault-injector.conf")

Mixing '' and "" in the same line is odd.  I don't know if we have a=20
strong preference for one style over the other.

> +++ b/tests/qemu-iotests/group
> @@ -284,3 +284,4 @@
>  268 rw auto quick
>  270 rw backing quick
>  272 rw
> +277 rw

The test completes in 3 seconds for me; we could add 'quick'.

Otherwise, looks reasonable to me.

Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>

I'll probably queue this through my NBD tree for rc1, as it adds test=20
coverage of a new feature for the 4.2 release.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


