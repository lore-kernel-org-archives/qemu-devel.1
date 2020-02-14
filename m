Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD9FC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1659C222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdGpzGYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1659C222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2aSV-0005Ag-Av
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 07:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j2aRr-0004cD-2o
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j2aRp-0006kY-Ti
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:51:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54591
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j2aRp-0006gN-Nh
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581684716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLrOPqrgFOE393WYrrpxKRySzbl1/Mdelx1szBdfNak=;
 b=RdGpzGYnVSjvCmcZHTHqbCeDyjy9AbM4qsOeX4YNZ/risJQb3hULxNuJzUwbFZ9JXpybX8
 16CakHCNDcRjZAxD7e6ER2FfICzWeEpU/FR9ok6FkBWXpzbBSX9Fiw3BgDvD5hqJgRbBrb
 bCiPj4AnZW1z0qjRizNErwJ1gB0AKrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-Zz6DYJm1Ow6dpBn46TaOrw-1; Fri, 14 Feb 2020 07:51:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF28013E4;
 Fri, 14 Feb 2020 12:51:53 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C05D98ECFA;
 Fri, 14 Feb 2020 12:51:52 +0000 (UTC)
Date: Fri, 14 Feb 2020 13:51:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH] qcow2: Fix alignment checks in encrypted images
Message-ID: <20200214125151.GB5443@linux.fritz.box>
References: <20200213171646.15876-1-berto@igalia.com>
MIME-Version: 1.0
In-Reply-To: <20200213171646.15876-1-berto@igalia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Zz6DYJm1Ow6dpBn46TaOrw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.02.2020 um 18:16 hat Alberto Garcia geschrieben:
> I/O requests to encrypted media should be aligned to the sector size
> used by the underlying encryption method, not to BDRV_SECTOR_SIZE.
> Fortunately this doesn't break anything at the moment because
> both existing QCRYPTO_BLOCK_*_SECTOR_SIZE have the same value as
> BDRV_SECTOR_SIZE.
>=20
> The checks in qcow2_co_preadv_encrypted() are also unnecessary because
> they are repeated immediately afterwards in qcow2_co_encdec().
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin


