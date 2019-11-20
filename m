Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FA7C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238EE224B2
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivxVSrbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238EE224B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXQli-0005VP-3U
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iXQkV-0004yO-5Y
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iXQkS-00069l-QG
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:14:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iXQkS-000695-Lw
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574259263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dcCVo5J6uRYgX0fwfvFWxG4scctCTmgZm4oGiBERxRw=;
 b=ivxVSrbiU7GexmMWZHrtNYzjPj4W2G3rGgSEbzq6sfp9kZX/gWpr9rgffCr5/gjj2Y4pAY
 mczY89qP2vfae380phZZeLn/olB+ECn+NW3Fosf+CvdOP5xMLGLgAB4QUt+V3Yjv3jrOOa
 5iaUAX0OHEy4S2ApbYQNtM6BXhCi2a8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-Gsubw-uJNHGTi3ULAtlPug-1; Wed, 20 Nov 2019 09:14:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39765801E5B;
 Wed, 20 Nov 2019 14:14:20 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1879766D2D;
 Wed, 20 Nov 2019 14:14:16 +0000 (UTC)
Subject: Re: [PATCH 1/6] block: bdrv_co_do_pwrite_zeroes: 64 bit 'bytes'
 parameter
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c1ec6b98-9ff0-1280-cf69-26db6237dd2b@redhat.com>
Date: Wed, 20 Nov 2019 08:14:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120140319.1505-2-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Gsubw-uJNHGTi3ULAtlPug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 8:03 AM, Kevin Wolf wrote:
> bdrv_co_do_pwrite_zeroes() can already cope with maximum request sizes
> by calling the driver in a loop until everything is done. Make the small
> remaining change that is necessary to let it accept a 64 bit byte count.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/io.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


