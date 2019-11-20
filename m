Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD30FC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9478A206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyxshcIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9478A206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRM6-0003e6-Rv
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iXRLR-0003Ew-2B
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iXRLP-0002wv-W4
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:52:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48230
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iXRLP-0002wT-SQ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574261555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8J737fju5hwjc78G3GKhCksNncu+cvGtPG+bcCz9U0=;
 b=RyxshcIlz/402DuNCrXjNV3bJBSFbgue6q4nQeR6ZVpGVp+AEQAfIp9o7POHg2POqRpsjt
 ZIAs1f7/Ds64G4mhdSfgTogHn+VuIvnyp8QCGIf2A7IuvRu4GNv+C+tdxKPkBBX2PdxO6D
 ofMXonwAEk+bSMZvqEp7Ct9fFY2y69I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-Ak5ac3ttPjO6KWp1cg2IxA-1; Wed, 20 Nov 2019 09:52:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC907477;
 Wed, 20 Nov 2019 14:52:30 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B85A63DA7;
 Wed, 20 Nov 2019 14:52:27 +0000 (UTC)
Subject: Re: [PATCH 6/6] iotests: Test committing to short backing file
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-7-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fc338397-feba-5a1e-5ef1-9a68af788793@redhat.com>
Date: Wed, 20 Nov 2019 08:52:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120140319.1505-7-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Ak5ac3ttPjO6KWp1cg2IxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 8:03 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/274        | 131 +++++++++++++++++++++++++++++
>   tests/qemu-iotests/274.out    | 150 ++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/group      |   1 +
>   tests/qemu-iotests/iotests.py |   2 +-
>   4 files changed, 283 insertions(+), 1 deletion(-)
>   create mode 100755 tests/qemu-iotests/274
>   create mode 100644 tests/qemu-iotests/274.out
>=20

> +def create_chain():
> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, base,
> +                         str(size_long))
> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, mid=
,
> +                         str(size_short))
> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', mid, top,
> +                         str(size_long))
> +
> +    iotests.qemu_io_log('-c', 'write -P 1 0 %d' % size_long, base)

Matches the setup in the cover letter, and definitely exposes the issues=20
at hand.

Reviewed-by: Eric Blake <eblake@redhat.com>

As leaving this bug open represents a data leak/corruption to guests, I=20
think this series counts as worthy of -rc3.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


