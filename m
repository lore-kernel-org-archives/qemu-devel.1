Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819C1C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D656206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCGmjOw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D656206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoBh-0004LE-Cu
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1igoB6-0003we-As
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1igoB3-0000mh-U3
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:04:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28039
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1igoB3-0000ke-Pg
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576494275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QFx9ZMJGGLchrdWTvtIA2lU20wUiFmKf8nvAQedVx3I=;
 b=HCGmjOw55cXAQOJHbBN+Cd8f9q5hpBRz12A/WOvCpPStuRHBNBDLtTkJU5VJp/cpHoT4y1
 1Z3Ybd7jovyi8U6ERIEp45+17m5VvgXhu1tDqR6v7dRZKBC8qin3/2a1UXlS3YWH9P9hLy
 FHB5F18b5ObSPUa8M+Fec8L68TiL0i4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-ri91u2PFN1uyM3smtMBhaQ-1; Mon, 16 Dec 2019 06:04:32 -0500
Received: by mail-qt1-f199.google.com with SMTP id d9so4387453qtq.13
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KmQhJeN0hfIlFlvcoh4JWmsV2x50GreGPIA2iZaYPnk=;
 b=bcGLbDOFOXp59ZbDuyLZ0JKcffdyTypauoC2L6rH0XGXTVfv9m7Us7hfzns6P4N8E+
 s0o/ZidRYBEEa9HCbdE55n+GnqVHBfsC0PLHn4o/T0twgwWaSBNCp89YVcTDdEszJX1p
 Nh8AyzLGDNDsl6C4sP7/vYxEA/i8us2+uvGUE/sM+sBIVyadvtYCPWivHvUtzIo2Mn0D
 Rgwj38kk//v1KODahn2yx/hp+ItvxX1iGbjOmDT8KCFl/ETLJO4o+3K28gUR1iDACu+V
 g0rcKL89wvLgVSYnd2EhPit4PQyXOvsM3MZ0+xwYqXNeb5YCirYtGwNe2BITf0Gieqa0
 lBFQ==
X-Gm-Message-State: APjAAAWFKY9AYr5l9RfTTiLV1t7IIsYKi4nLvi01whsTp279yDYzP+tH
 YhV/FviXmCdH1rSLHKkl/PRmX9a/IETBYYkJtBUHiQ8r6cqdYohIqfwyRvKjf3RVYdYvfsMho+m
 EsvnSPXaw2xp/Z+s=
X-Received: by 2002:ac8:5313:: with SMTP id t19mr14604312qtn.375.1576494271777; 
 Mon, 16 Dec 2019 03:04:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6/r5KxdTeFB59616ssUs4cRSWIa2UIxVnVjWkL4+ba1vztaaDKLO19fN0qneVlc+7vN0GWQ==
X-Received: by 2002:ac8:5313:: with SMTP id t19mr14604289qtn.375.1576494271616; 
 Mon, 16 Dec 2019 03:04:31 -0800 (PST)
Received: from redhat.com (bzq-111-168-31-5.red.bezeqint.net. [31.168.111.5])
 by smtp.gmail.com with ESMTPSA id
 l31sm6697820qte.30.2019.12.16.03.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:04:30 -0800 (PST)
Date: Mon, 16 Dec 2019 06:04:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v4 0/2] virtio: make seg_max virtqueue size dependent
Message-ID: <20191216060349-mutt-send-email-mst@kernel.org>
References: <20191216100451.28060-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191216100451.28060-1-dplotnikov@virtuozzo.com>
X-MC-Unique: ri91u2PFN1uyM3smtMBhaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 16, 2019 at 01:04:49PM +0300, Denis Plotnikov wrote:
> v4:
>   * rebased on 4.2 [MST]


Looks good. Can I get some acks from storage guys pls?

> v3:
>   * add property to set in machine type [MST]
>   * add min queue size check [Stefan]
>   * add avocado based test [Max, Stefan, Eduardo, Cleber]
>=20
> v2:
>   * the standalone patch to make seg_max virtqueue size dependent
>   * other patches are postponed
>=20
> v1:
>   the initial series
>=20
> Denis Plotnikov (2):
>   virtio: make seg_max virtqueue size dependent
>   tests: add virtio-scsi and virtio-blk seg_max_adjust test
>=20
>  hw/block/virtio-blk.c                     |   9 +-
>  hw/core/machine.c                         |   3 +
>  hw/scsi/vhost-scsi.c                      |   2 +
>  hw/scsi/virtio-scsi.c                     |  10 +-
>  include/hw/virtio/virtio-blk.h            |   1 +
>  include/hw/virtio/virtio-scsi.h           |   1 +
>  tests/acceptance/virtio_seg_max_adjust.py | 135 ++++++++++++++++++++++
>  7 files changed, 159 insertions(+), 2 deletions(-)
>  create mode 100755 tests/acceptance/virtio_seg_max_adjust.py
>=20
> --=20
> 2.17.0


