Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91C2C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7304B20715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fO0cmVO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7304B20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iojYg-0001A7-GU
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 02:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iojOI-0002tZ-So
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iojOH-0006uC-AI
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21788
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iojOH-0006tf-6E
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=peBNSQFwuSX+sGeKpxeq90QOSLv89w7D7PKtGk/sYUE=;
 b=fO0cmVO0+3Ifb17A8hFMBkBCju/yst2YslssgPuygIpSuF2AR2Un9wTpFg8omYGnSSiWIG
 37QU/RkD6eNXSRglMeBMqPWwP9n5m5LwyLEcq9o7/SOBYNaCL4u7MCvg9zzH1Sc2Z5aPPE
 VzcgJmhEpbuMmjvKodFDkm8zYp1PfS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-ebpztxXBOLiQb3mN_fwWrQ-1; Tue, 07 Jan 2020 02:34:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA158DBB7;
 Tue,  7 Jan 2020 07:34:55 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA5125D9CA;
 Tue,  7 Jan 2020 07:34:43 +0000 (UTC)
Date: Tue, 7 Jan 2020 08:34:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH v3 1/2] ide: Fix incorrect handling of some PRDTs in
 ide_dma_cb()
Message-ID: <20200107073442.GD4076@linux.fritz.box>
References: <20191223175117.508990-1-alex.popov@linux.com>
 <20191223175117.508990-2-alex.popov@linux.com>
MIME-Version: 1.0
In-Reply-To: <20191223175117.508990-2-alex.popov@linux.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ebpztxXBOLiQb3mN_fwWrQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, sstabellini@kernel.org,
 pmatouse@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.12.2019 um 18:51 hat Alexander Popov geschrieben:
> The commit a718978ed58a from July 2015 introduced the assertion which
> implies that the size of successful DMA transfers handled in ide_dma_cb()
> should be multiple of 512 (the size of a sector). But guest systems can
> initiate DMA transfers that don't fit this requirement.
>=20
> For fixing that let's check the number of bytes prepared for the transfer
> by the prepare_buf() handler. The code in ide_dma_cb() must behave
> according to the Programming Interface for Bus Master IDE Controller
> (Revision 1.0 5/16/94):
> 1. If PRDs specified a smaller size than the IDE transfer
>    size, then the Interrupt and Active bits in the Controller
>    status register are not set (Error Condition).
> 2. If the size of the physical memory regions was equal to
>    the IDE device transfer size, the Interrupt bit in the
>    Controller status register is set to 1, Active bit is set to 0.
> 3. If PRDs specified a larger size than the IDE transfer size,
>    the Interrupt and Active bits in the Controller status register
>    are both set to 1.
>=20
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


