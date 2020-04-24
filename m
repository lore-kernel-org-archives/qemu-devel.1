Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DE2C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 07:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEAA20704
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 07:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5N8ffEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEAA20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRtAr-0006G1-KJ
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 03:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jRtA2-0005gb-7W
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jRtA1-0002wO-A8
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:54:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57424
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jRtA0-0002lw-R3
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587714847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3jE6usgknXPl6ytGXXGOllr1Fmxd5Yuz0pXoppA+V58=;
 b=E5N8ffEYQYDaeLZ72VV5HPRFIhblclP4agexSB2X49+nFau5fwlZY1/GbnFeLldegnzieQ
 QLv6ateDFdWzVt3/oXgVqA+OVmEsKkGUuycX0MQ+DYFqxYmJSsuYTwujcQLOx7HaEiJhNW
 xh2PXNUnQ4UEZn2cM32CInoO8bQSCQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-8K3atlxmNEqDnBENtAdrTQ-1; Fri, 24 Apr 2020 03:54:05 -0400
X-MC-Unique: 8K3atlxmNEqDnBENtAdrTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 079F41005510;
 Fri, 24 Apr 2020 07:54:04 +0000 (UTC)
Received: from gondolin (ovpn-112-240.ams2.redhat.com [10.36.112.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 132BC60300;
 Fri, 24 Apr 2020 07:53:57 +0000 (UTC)
Date: Fri, 24 Apr 2020 09:53:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v21 QEMU 4/5] virtio-balloon: Implement support for page
 poison tracking feature
Message-ID: <20200424095354.03008d1e.cohuck@redhat.com>
In-Reply-To: <69ff8fd6-8f34-bf8a-2a8c-a1c4947383a6@redhat.com>
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
 <20200422182120.12258.67417.stgit@localhost.localdomain>
 <2d335814-c7eb-970b-5973-13dcdc7e0f12@redhat.com>
 <CAKgT0UeiKxy8AjrfoKRA9tV-8+nRMfEKjp1qCVcRoLhGs-oLew@mail.gmail.com>
 <46fb7362-0ec7-d27d-a8bc-458e9ae0beea@redhat.com>
 <CAKgT0Ucczmk2nG-yP8_Dfh1vFc5W242Q3=cMOQrG8aHG_6KFfw@mail.gmail.com>
 <69ff8fd6-8f34-bf8a-2a8c-a1c4947383a6@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:54:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>, "Michael S.
 Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Apr 2020 09:07:25 +0200
David Hildenbrand <david@redhat.com> wrote:

> >>  GlobalProperty hw_compat_4_2[] = {
> >>      { "virtio-blk-device", "queue-size", "128"},
> >>      { "virtio-scsi-device", "virtqueue_size", "128"},  
> > 
> > Okay, so the bit above is for after 5_0 is released then? Is there a  
> 
> Yes.
> 
> > way to queue up a reminder or something so we get to it when the time
> > comes, or I just need to watch for 5.0 to come out and submit a patch
> > then?  
> 
> I think what happened usually happens is that someone introduces all the
> compat machines, sometimes directly with empty hw_compat.
> 
> E.g., see
> 
> commit 3eb74d2087d3bd6cb51c06a49ba94222248d2de4
> Author: Cornelia Huck <cohuck@redhat.com>
> Date:   Tue Nov 12 11:48:11 2019 +0100
> 
>     hw: add compat machines for 5.0
> 
>     Add 5.0 machine types for arm/i440fx/q35/s390x/spapr.
> 
> and
> 
> commit 9aec2e52ce9d9632a86be2d1d0dd493722d2e7be
> Author: Cornelia Huck <cohuck@redhat.com>
> Date:   Wed Jul 24 12:35:24 2019 +0200
> 
>     hw: add compat machines for 4.2
> 
>     Add 4.2 machine types for arm/i440fx/q35/s390x/spapr.
> 
> 
> The latter already introduced hw_compat_4_1, for examnple.
> 
> @Conny, do you already have a patch for 5.1 compat patch lying around
> somewhere?

Not yet, will do so now. Thanks for the reminder, nearly forgot about
that :)


