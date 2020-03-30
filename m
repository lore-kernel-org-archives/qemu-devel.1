Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3B7C2D0EB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 07:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CEF520781
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 07:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoE3F/zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEF520781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIoo0-0005oc-57
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 03:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jIon2-0004zE-9H
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 03:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jIon1-00034e-8g
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 03:24:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39805)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jIon1-000341-4z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 03:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585553093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AXAhUACDM2gZxnq1V3wP9OEXZS/SK+u9IN3fA/0nlG0=;
 b=DoE3F/zbAWZV8Sbp3tQ7t+EDJXGMc9L0EPzjGYnHxKOM5iRdrwOdHQglF0E+BvzXER8WVV
 aTN8YWmI66552dbd7oQ6hAQE3uhVKtCddgr01We8AtME5f6vbsVwqKLwhovAQfVDn/sqIp
 jc7rf9PEpEd2pd2AvlfP5Kvl2Zf2QWk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-eeIO9pJWO3ub-a6GxsUAXQ-1; Mon, 30 Mar 2020 03:24:51 -0400
X-MC-Unique: eeIO9pJWO3ub-a6GxsUAXQ-1
Received: by mail-wr1-f69.google.com with SMTP id i18so10585390wrx.17
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 00:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QN6u9uAOnnJUD5pu7QxV4bk6WRt95TwhOwf2Vb059P0=;
 b=jUlWArB96MiTdIhrU6yTSQixl6CzvqsDTlhXApg0rOJsUQr9rlO47FsAzWZaV5OQ9M
 7Rui3UvW+ejfR5OJRXzJ3gNXyoRyXmkrtS6eA/MiphMaISXLNTVKe1yJPtxMJ+Wu8ytv
 5Jous7cHmKKJTJzkhHDFJgqhVgu4VX9Dvq0CEX9hkVL2jmUGDec1jL3BhJxAPRS8LQ4r
 /L23xlH0+PskNQi6r307sxNE+BrjZ/hGVb1Jgw0b+ZMQVB3U/23sOFlzzantNfzBWSit
 RhW/4lqH2RQZ5xy4CvWzfi2Sq0goBCCPnKFnyHnC/CsLP3n90VEuLCUrh5xsyBhN1TZK
 1pVw==
X-Gm-Message-State: ANhLgQ3vmgtIM724XXlenaZ3DqOis5kHAyqpomxRCPJQmgzsNhMgpu+h
 FwUMO6QkR9AIb/PvGnLBUQ8gL1/ZUkVJfoDe8bi5Bg7g9zsfAbqkRuJRju8Ee/H8DEeqPre87Pn
 zyyeRFwYHB5+EvTg=
X-Received: by 2002:adf:b258:: with SMTP id y24mr10635863wra.318.1585553090438; 
 Mon, 30 Mar 2020 00:24:50 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuuYB5mYl486JhTzPCB/FkrS0wX/SzCtSrxT0O2y3r6xAih+iu06h867bqQwXxn/XrcoZmU9g==
X-Received: by 2002:adf:b258:: with SMTP id y24mr10635846wra.318.1585553090235; 
 Mon, 30 Mar 2020 00:24:50 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id d6sm20548636wrw.10.2020.03.30.00.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 00:24:49 -0700 (PDT)
Date: Mon, 30 Mar 2020 09:24:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v4 2/2] virtio-iommu: avoid memleak in the unrealize
Message-ID: <20200330072447.lcstsuhcswl2sxmu@steredhat>
References: <20200328005705.29898-1-pannengyuan@huawei.com>
 <20200328005705.29898-3-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200328005705.29898-3-pannengyuan@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: zhang.zhanghailiang@huawei.com, mst@redhat.com, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 28, 2020 at 08:57:05AM +0800, Pan Nengyuan wrote:
> req_vq/event_vq forgot to free in unrealize. Fix that.
> And also do clean 's->as_by_busptr' hash table in unrealize to fix anothe=
r leak.
>=20
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Acked-by: Eric Auger <eric.auger@redhat.com>
> ---
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v3->v1/v2:
> - Also clean 's->as_by_busptr' hash table in unrealize.(Suggested by Stef=
ano Garzarella)
> v4->v3:
> - update subject msg and move g_hash_table_destroy to the beginning of un=
realize.
> ---
>  hw/virtio/virtio-iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>=20
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 4cee8083bc..22ba8848c2 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -693,9 +693,12 @@ static void virtio_iommu_device_unrealize(DeviceStat=
e *dev, Error **errp)
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VirtIOIOMMU *s =3D VIRTIO_IOMMU(dev);
> =20
> +    g_hash_table_destroy(s->as_by_busptr);
>      g_tree_destroy(s->domains);
>      g_tree_destroy(s->endpoints);
> =20
> +    virtio_delete_queue(s->req_vq);
> +    virtio_delete_queue(s->event_vq);
>      virtio_cleanup(vdev);
>  }
> =20
> --=20
> 2.18.2
>=20
>=20


