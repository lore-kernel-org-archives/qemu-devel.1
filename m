Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA4EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C1F2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaUN9Lbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C1F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHrZ-0007PF-KX
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJHqx-0006zR-A2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJHqv-0004Mv-Ek
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:26:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38457
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJHqv-0004Lt-6Y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585664812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDLLs1FAqa7cGKm9O7cJiKWtcO9K2NnEaRF2AX/UQkM=;
 b=PaUN9Lbn8ajxWAzudsIfg6ZSFZUb8Oqv8DcPiRTQvwkgIdv+yEP9Q/LaH6zn4yzykpEtIb
 bHjHll6Tz8RjgVkKxUtY/fgSHYvP4tuugVh1kNJP8dDnvJrTFxNzLOvU2K9dflN8sdnjBQ
 jly1FwEwVUpCPG9yLtW3gi/qXi/0oNU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-Nn0N8u-BOSW-Gg2_RU3csw-1; Tue, 31 Mar 2020 10:26:50 -0400
X-MC-Unique: Nn0N8u-BOSW-Gg2_RU3csw-1
Received: by mail-wr1-f72.google.com with SMTP id k11so68107wrm.19
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9zSpGatOU+1AB/kcox36rwjVoWt88+VVoPODi2Zh1/g=;
 b=rrlenQVSK23iyRxKG3QRLDgZQw/m6OrHikaf1h5zg+hQA85XfPzRqJ56YXBWPyWN6c
 johOyTiM8YHiTD6I9R/PYm51sXVn2MQx3CRW0xtIwpzRNT4jvA6NYyekcOts+0g18boV
 rRl+vtzqn0FvAL0I49TTEDcoDQdXnqknCcUfOUL8r9oXEX1teEno0UcN1U86EhbL2+EZ
 /I9mznS8wIzEflsEScN+B7W0pCzH9k3h0vEWJ62SwiQInZbHtUO6cSFs0gL3LHYcaW1i
 DuSe82NEU2Fr5R7clhceQTuP4otKXzQ3iGtgzGyugmwAZ3IhUH/RORj5BjR5dUIZ9kFJ
 urXQ==
X-Gm-Message-State: ANhLgQ2oeJGpGdrNPstsVo/GVKgP21Zlu6zXqABelGc12QTO4ZB01gwL
 sLdvbIHJJUmSKS/hbH7FXotjIlSb4BBk8qW2KdRqYb6t8Peodfd/ddyVKlS7vXwAv84CmccTodq
 m5iZfjPVzlH6qiIQ=
X-Received: by 2002:adf:f38a:: with SMTP id m10mr20974848wro.168.1585664809332; 
 Tue, 31 Mar 2020 07:26:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvytDrEYCkckrpNGjAAUWgGdZM42YiEvrBkYxRp8wTMEhrekqZZQWsL5fs5uiqi5of/x2EO6g==
X-Received: by 2002:adf:f38a:: with SMTP id m10mr20974830wro.168.1585664809122; 
 Tue, 31 Mar 2020 07:26:49 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id f3sm2287637wmj.24.2020.03.31.07.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:26:48 -0700 (PDT)
Date: Tue, 31 Mar 2020 10:26:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v7 0/7] reference implementation of RSS and hash report
Message-ID: <20200331102004-mutt-send-email-mst@kernel.org>
References: <20200329150953.23812-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200329150953.23812-1-yuri.benditovich@daynix.com>
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
Cc: yan@daynix.com, jasowang@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 29, 2020 at 06:09:46PM +0300, Yuri Benditovich wrote:
> Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
> features in QEMU for reference purpose.
> Implements Toeplitz hash calculation for incoming
> packets according to configuration provided by driver.
> Uses calculated hash for decision on receive virtqueue
> and/or reports the hash in the virtio header


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Probably post 5.0 material.

> Changes from v6:
> Fixed a bug in patch 5 "reference implementation of hash report"
> that caused the ASAN test to fail
> was: n->rss_data.populate_hash =3D true;
> fixed: n->rss_data.populate_hash =3D !!hash_report;
>=20
> Yuri Benditovich (7):
>   virtio-net: introduce RSS and hash report features
>   virtio-net: implement RSS configuration command
>   virtio-net: implement RX RSS processing
>   tap: allow extended virtio header with hash info
>   virtio-net: reference implementation of hash report
>   vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
>   virtio-net: add migration support for RSS and hash report
>=20
>  hw/net/trace-events            |   3 +
>  hw/net/virtio-net.c            | 448 +++++++++++++++++++++++++++++++--
>  include/hw/virtio/virtio-net.h |  16 ++
>  include/migration/vmstate.h    |  10 +
>  net/tap.c                      |  11 +-
>  5 files changed, 460 insertions(+), 28 deletions(-)
>=20
> --=20
> 2.17.1


