Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCB7C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 13:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991B22063A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 13:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKeyVLQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991B22063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ij1Lk-0001kU-MT
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 08:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ij1Ki-0001IA-AN
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 08:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ij1Kf-0007Nw-Fo
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 08:31:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ij1Kf-0007MA-2X
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 08:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577021499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l7bW2zbSyGKedSVX91Se88cQpwOh8KUr/wWgTUkYkQ4=;
 b=YKeyVLQu0YZ+DildPVADynXlOQ9Bk/P+9dg9FGBpakEkB2ZEegeGXLmfssk1SiE2XdoX+N
 OMdsT4TqT16M1MtHaw1BjjZ4yrNWJlLJql3INuS3gSM+VqepRqDZolCUSETGaVS6KDknCU
 bJja0mY2/VNCD5AVjp9B2iPBxfqJo3A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-5zdPQ7UdOMuIwQ8VJKLf6A-1; Sun, 22 Dec 2019 08:31:36 -0500
Received: by mail-qt1-f200.google.com with SMTP id m30so9448538qtb.2
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2019 05:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dX36/Vui46kD4oNyBhwNVIJwwytLglCTxvDKZGADWko=;
 b=qqP8vWI5mdcfnocoSbhBbX4krHXTWzHxRiVn5BoKFrsBXXCgDMpzgya4WKL+b0NCjV
 nkAPGzWz8AM6TbPV9VN4MKv+hjDvkyVeaLk1Mo7NMr/ZB+86XoiPxfJpIgou7g4rURXB
 QIE/tRqRyaCCnPZjL7sIbyVxbjOIz6iE+yWbIr8ybsStg6k/AVDSz7EUJ+6rMQS4q8VL
 BNoeSiLRF5P8GaUQrkz9DWPkZaC9vHHKvqlvhYGc3sQ7U6LAoDf7ty8VUnRFSpgCj1Ei
 H/qiJw/EMHTPZv9eDq9Z7WqRcIz+VozO0YVt3X4CXBYnXdrav4nXuqBM10+werg7P3qU
 TQBw==
X-Gm-Message-State: APjAAAV4WXZiSHLIN4ZHwjAbGUyyLlBMD988jCIkhHxezjCdGveEOHXi
 Xij/P6dhH0nuwSnw/ufIPCHh4wBzqVFDXrlspzCUQvRTxG4ZQ7p1XcoNX84zhEZJ9sVZXsAdFM4
 lqHKD+CjqwIfztxU=
X-Received: by 2002:ad4:4f45:: with SMTP id eu5mr20661387qvb.235.1577021496006; 
 Sun, 22 Dec 2019 05:31:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXKy3lTxE0JYoQeyjnX3/vBO1Ac78G8NI9D2aT6f1Yi9tqx0kFrOKXeyGmYUV1O5gl8ToG9w==
X-Received: by 2002:ad4:4f45:: with SMTP id eu5mr20661368qvb.235.1577021495800; 
 Sun, 22 Dec 2019 05:31:35 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id j15sm5091982qtn.37.2019.12.22.05.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2019 05:31:34 -0800 (PST)
Date: Sun, 22 Dec 2019 08:31:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v5 0/2] virtio: make seg_max virtqueue size dependent
Message-ID: <20191222083058-mutt-send-email-mst@kernel.org>
References: <20191220140905.1718-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191220140905.1718-1-dplotnikov@virtuozzo.com>
X-MC-Unique: 5zdPQ7UdOMuIwQ8VJKLf6A-1
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 05:09:03PM +0300, Denis Plotnikov wrote:
> v5:
>   * rebased on the recent master [MST]
>   * NOTE: the test doesn't pass because 5.0 machine type use 4.2 compat
>           instead of it's own or no compat at all. The test will pass
>           once the new 5.0 compat is used.=20


So please fix that up first (in a separate patch).

> v4:
>   * rebased on 4.2 [MST]
>=20
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
>  tests/acceptance/virtio_seg_max_adjust.py | 134 ++++++++++++++++++++++
>  7 files changed, 158 insertions(+), 2 deletions(-)
>  create mode 100755 tests/acceptance/virtio_seg_max_adjust.py
>=20
> --=20
> 2.17.0


