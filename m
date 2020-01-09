Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EE9C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4192067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmbWwajN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4192067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWnP-0005Dx-6N
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ipWmJ-0004Mh-Ij
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ipWmI-0004AU-2T
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:19:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ipWmH-000484-PC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578572345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5L1s3HRbns+MOo+H5KAYyxSCSZL0qzS6ngBBGVZrqE=;
 b=XmbWwajNixDP4uAN+qt5JIAiYyjP2XbgXQrvUPPkK8hWC1b13qdeapPbY/k+SP0PtoIgsY
 P2sdEXsxyqCS5+IdhJ/NCqATM5GmvZpDJXROCqv3LDgCuG4MQr5xO3dab8y3vPa028Av01
 JL05k4+SLkcRidU7i1JXsNQgIqOMGD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-8k-Y7bgYM42cCi5VsuPHow-1; Thu, 09 Jan 2020 07:19:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD7391883521;
 Thu,  9 Jan 2020 12:19:02 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-193.ams2.redhat.com [10.36.117.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB2861001281;
 Thu,  9 Jan 2020 12:19:01 +0000 (UTC)
Date: Thu, 9 Jan 2020 13:19:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH 3/3] qcow2: Use BDRV_SECTOR_SIZE instead of the hardcoded
 value
Message-ID: <20200109121900.GF9504@linux.fritz.box>
References: <cover.1578505678.git.berto@igalia.com>
 <f6dcb0d7b17cddb475e3a018a5b802490c7bc21d.1578505678.git.berto@igalia.com>
MIME-Version: 1.0
In-Reply-To: <f6dcb0d7b17cddb475e3a018a5b802490c7bc21d.1578505678.git.berto@igalia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 8k-Y7bgYM42cCi5VsuPHow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.01.2020 um 18:49 hat Alberto Garcia geschrieben:
> This replaces all remaining instances in the qcow2 code.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>

> diff --git a/block/qcow2.c b/block/qcow2.c
> index e8ce966f7f..6427c75409 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2175,7 +2175,7 @@ static coroutine_fn int qcow2_co_preadv_task(BlockD=
riverState *bs,
>                                            offset, bytes, qiov, qiov_offs=
et);
> =20
>      case QCOW2_CLUSTER_NORMAL:
> -        if ((file_cluster_offset & 511) !=3D 0) {
> +        if ((file_cluster_offset % BDRV_SECTOR_SIZE) !=3D 0) {
>              return -EIO;
>          }

Hm, unrelated to your change, but why do we test for 512 byte alignment
here? file_cluster_offset should certainly be cluster aligned for normal
clusters. And if the check fails, that's actually an image corruption
and not just an I/O error. Am I missing something?

Kevin


