Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A645C54FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A5420658
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCsgQPQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A5420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGQQD-0007O0-81
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jGQPX-0006SK-3F
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jGQPW-0005H4-5M
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:58:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47529)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jGQPW-0005Gw-2U
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584982725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zh/3RA5d1WqX2AO38T5+TftwgyCnqytpYntcHMRogU=;
 b=RCsgQPQS1s6rxCpwCTdHzlUqIMP9XHzD7QzRJDGqCiHt6cZYqFnyvtnSFK5F2LG2PE5sMi
 D+8lAsX2rWYCcjUD3ELf13L7VqSqcvuQm39NnwOqXly53z0PI2ltrPRwsRJtYX4ntA4hwg
 90BNUeqJRiK+8sAx4wKrEOGgm/AHGcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-HLIzCtxxNhiVjDXp0y0_2w-1; Mon, 23 Mar 2020 12:58:39 -0400
X-MC-Unique: HLIzCtxxNhiVjDXp0y0_2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BD81107ACCA;
 Mon, 23 Mar 2020 16:58:38 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-85.ams2.redhat.com [10.36.114.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78A839B92F;
 Mon, 23 Mar 2020 16:58:35 +0000 (UTC)
Date: Mon, 23 Mar 2020 17:58:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH v3] block/iscsi:use the flags in iscsi_open() prevent
 Clang warning
Message-ID: <20200323165834.GB8049@linux.fritz.box>
References: <20200311032927.35092-1-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200311032927.35092-1-kuhn.chenqun@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.03.2020 um 04:29 hat Chen Qun geschrieben:
> Clang static code analyzer show warning:
>   block/iscsi.c:1920:9: warning: Value stored to 'flags' is never read
>         flags &=3D ~BDRV_O_RDWR;
>         ^        ~~~~~~~~~~~~
>=20
> In iscsi_allocmap_init() only checks BDRV_O_NOCACHE, which
> is the same in both of flags and bs->open_flags.
> We can use the flags instead bs->open_flags to prevent Clang warning.
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Thanks, applied to the block branch.

Kevin


