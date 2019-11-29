Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A71C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 07:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002A221721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 07:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeKHdXzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002A221721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iab5K-000748-2k
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 02:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iaarB-0001lr-My
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iaar6-0003Bf-4t
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:38:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26134
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iaar5-00037u-S7
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575013099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ugWduPKYqS1aKmAMjDn0U32aHtRHH1B9URx1vzj2ks=;
 b=HeKHdXzZZajgfjtoFIENl2BlJ5EnHLnkCgA1N/f2kN8IMP+SQCV/LS064+A+y5Ul6Jf/2h
 btBz6wvkg9UrDS3HVyjeK95/bRAJk517G5W1+OXIScPErMuUayUU9M+zMEG7OC88rAM1+Z
 0TRxuSoUywg9uO7Rh8sXJPiFjtgx8xw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-xwHUKyogMpa-cfP15TsnQQ-1; Fri, 29 Nov 2019 02:38:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A42ED800D53;
 Fri, 29 Nov 2019 07:38:09 +0000 (UTC)
Received: from gondolin (ovpn-116-140.ams2.redhat.com [10.36.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAB825D6D2;
 Fri, 29 Nov 2019 07:38:01 +0000 (UTC)
Date: Fri, 29 Nov 2019 08:37:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost
 <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] hw: add compat machines for 5.0
Message-ID: <20191129083759.7e23a97e.cohuck@redhat.com>
In-Reply-To: <20191112104811.30323-1-cohuck@redhat.com>
References: <20191112104811.30323-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: xwHUKyogMpa-cfP15TsnQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 Nov 2019 11:48:11 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Add 5.0 machine types for arm/i440fx/q35/s390x/spapr.
> 
> For i440fx and q35, unversioned cpu models are still translated
> to -v1; I'll leave changing this (if desired) to the respective
> maintainers.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> also pushed out to https://github.com/cohuck/qemu machine-5.0
> 
> x86 folks: if you want to change the cpu model versioning, I
> can do it in this patch, or just do it on top yourselves
> 
> ---
>  hw/arm/virt.c              |  7 ++++++-
>  hw/core/machine.c          |  3 +++
>  hw/i386/pc.c               |  3 +++
>  hw/i386/pc_piix.c          | 14 +++++++++++++-
>  hw/i386/pc_q35.c           | 13 ++++++++++++-
>  hw/ppc/spapr.c             | 15 +++++++++++++--
>  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>  include/hw/boards.h        |  3 +++
>  include/hw/i386/pc.h       |  3 +++
>  9 files changed, 69 insertions(+), 6 deletions(-)

Queued to s390-next.


