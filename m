Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87841C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD7620727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tis+I6zl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD7620727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBivV-0004Sj-JW
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 13:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jBiug-0003dD-2M
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jBiue-00086j-9H
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:43:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46722
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jBiue-00080y-1a
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583862207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kOMlogi8EflAUdnayDY2M153epr38tobBeSFdPhj50=;
 b=Tis+I6zlEigHwC0P4Q6dsS4qUcr/UFDUIndKPiIaP9uoqXxO4H2kdrmXV3zWrZpG4U9+Gb
 YN+XSIMdJwr5Xg8JUxL+8rGGpXpJfVG1fHUUFGd0xHvm16WLeFamBYny56rtd/J/szUC5N
 yd0nvRVgRdSFTjRWPx85yLN26BEftN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-7CsCtca-MhKAO1UNjllK6A-1; Tue, 10 Mar 2020 13:43:25 -0400
X-MC-Unique: 7CsCtca-MhKAO1UNjllK6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30FD8107ACCC;
 Tue, 10 Mar 2020 17:43:24 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37B625D9C5;
 Tue, 10 Mar 2020 17:43:22 +0000 (UTC)
Date: Tue, 10 Mar 2020 18:43:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/7] block: Relax restrictions for blockdev-snapshot
Message-ID: <20200310174321.GI6926@linux.fritz.box>
References: <20200310113831.27293-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200310113831.27293-1-kwolf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.03.2020 um 12:38 hat Kevin Wolf geschrieben:
> This series allows libvirt to fix a regression that its switch from
> drive-mirror to blockdev-mirror caused: It currently requires that the
> backing chain of the target image is already available when the mirror
> operation is started.
>=20
> In reality, the backing chain may only be copied while the operation is
> in progress, so the backing file of the target image needs to stay
> disabled until the operation completes and should be attached only at
> that point. Without this series, we don't have a supported API to attach
> the backing file at that later point.
>=20
> v2:
> - Added a fix and test case for iothreads [Peter]
> - Added a blockdev-snapshot feature flag to indicate that it's usable
>   for attaching a backing chain to an overlay that is already in
>   write-only use (e.g. as a mirror target) [Peter]

Thanks for review and testing, applied to the block branch.

Kevin


