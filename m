Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F8BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 03:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D132166E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 03:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZr7LCyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D132166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNqBF-00061i-SU
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 23:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iNq9u-0003aj-BH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 23:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iNq9s-00017P-47
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 23:21:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42676
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iNq9r-000170-3G
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 23:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571973657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/4fHj3Gj+iiIMrMlKnsrLJLpVTJtRryuCRukfhnYRE=;
 b=dZr7LCybIKc6LkowaAgIqnxnvH5MgMbdNNvPvw3e93oY1Qv6m+cHkvKVqiLEfC6WggkD0D
 f6Ba6ZK0VAmxDwikHzlbrpDT7mflw5wLhxekLi48DN6EBIUr5uBo3fFmspkLKfzm5pwuVP
 3YG+DY/ijBaZhPLStyeJ7lUHSPhdBgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-ioFzNb4uPq6LErscPKMJ2g-1; Thu, 24 Oct 2019 23:20:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52A4280183D;
 Fri, 25 Oct 2019 03:20:54 +0000 (UTC)
Received: from [10.72.12.249] (ovpn-12-249.pek2.redhat.com [10.72.12.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 017E5600CD;
 Fri, 25 Oct 2019 03:20:36 +0000 (UTC)
Subject: Re: [PATCH v6 0/9] Packed virtqueue for virtio
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20191024171406.12504-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <118b31fe-d1c1-9e96-84ac-c76829dd3ada@redhat.com>
Date: Fri, 25 Oct 2019 11:20:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191024171406.12504-1-eperezma@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ioFzNb4uPq6LErscPKMJ2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/10/25 =E4=B8=8A=E5=8D=881:13, Eugenio P=C3=A9rez wrote:
> Hi:
>
> This is an updated version of packed virtqueue support based on Wei and J=
ason's
> V5, mainly solving the clang leak detector error CI gave.
>
> Please review.
>
> Changes from V5:
> - Fix qemu's CI asan error.
> - Move/copy rcu comments.
> - Merge duplicated vdev->broken check between split and packet version.
>
> Eugenio P=C3=A9rez (3):
>    virtio: Free rng and blk virqueues
>    virtio: add some rcu comments
>    virtio: Move vdev->broken check to dispatch drop_all
>
> Jason Wang (4):
>    virtio: basic packed virtqueue support
>    virtio: event suppression support for packed ring
>    vhost_net: enable packed ring support
>    virtio: add property to enable packed virtqueue
>
> Wei Xu (2):
>    virtio: basic structure for packed ring
>    virtio: device/driverr area size calculation refactor for split ring


Looks good to me.

Just two nits:

I tend to squash patch 8 and patch 9 into the patch that introduces=20
those issues and split patch 3 into two parts.

Btw, if you wish you can add your s-o-b to the series.

Do you want to post a new version or I can tweak them by myself?

Thanks


>
>   hw/block/virtio-blk.c       |    7 +-
>   hw/char/virtio-serial-bus.c |    2 +-
>   hw/net/vhost_net.c          |    2 +
>   hw/scsi/virtio-scsi.c       |    3 +-
>   hw/virtio/virtio-rng.c      |    1 +
>   hw/virtio/virtio.c          | 1154 ++++++++++++++++++++++++++++++++++++=
++-----
>   include/hw/virtio/virtio.h  |   14 +-
>   7 files changed, 1045 insertions(+), 138 deletions(-)
>


