Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3117C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A352080D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dD3C+dOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A352080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWNU5-0005iq-Jt
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 13:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWNTS-0005Ce-EJ
 for qemu-devel@nongnu.org; Wed, 06 May 2020 13:04:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50731
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWNTR-0002zL-1n
 for qemu-devel@nongnu.org; Wed, 06 May 2020 13:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588784683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnTjtNSNb0AbHn8SrQy1JNLz80nxdr3J1Bj3DEEqPtc=;
 b=dD3C+dOnAuDRU41YHiNbSgy4lfY05iohtJNWofTVeK2tnUHIwpj6TAoZNwLMeeCnFx3PI/
 WSYgO/AErz+L3EN/jV8fREMn2ofu2Vo3GhbGR4TryHUBxBz3GF+y7H9AA/Ci9H3DIxgNgx
 S4UhI8q+KXOAObuvrL6KY6g+CU3H07g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-2Ky2At4VP06JcWaPltMKOw-1; Wed, 06 May 2020 13:04:41 -0400
X-MC-Unique: 2Ky2At4VP06JcWaPltMKOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24F2A39346;
 Wed,  6 May 2020 17:04:39 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-140.ams2.redhat.com [10.36.113.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 845F56E71F;
 Wed,  6 May 2020 17:04:27 +0000 (UTC)
Date: Wed, 6 May 2020 19:04:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 26/33] block: Use child_of_bds in remaining places
Message-ID: <20200506170426.GI6333@linux.fritz.box>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-27-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200218124242.584644-27-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
> Replace child_file by child_of_bds in all remaining places (excluding
> tests).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/blkreplay.c b/block/blkreplay.c
> index f97493f45a..71628f4d56 100644
> --- a/block/blkreplay.c
> +++ b/block/blkreplay.c
> @@ -27,8 +27,9 @@ static int blkreplay_open(BlockDriverState *bs, QDict *=
options, int flags,
>      int ret;
> =20
>      /* Open the image file */
> -    bs->file =3D bdrv_open_child(NULL, options, "image",
> -                               bs, &child_file, 0, false, &local_err);
> +    bs->file =3D bdrv_open_child(NULL, options, "image", bs, &child_of_b=
ds,
> +                               BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY,
> +                               false, &local_err);

Why isn't blkreplay a filter?

Kevin


