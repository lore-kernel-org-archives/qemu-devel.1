Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBCFC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA31207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJUeiUJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA31207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1CE-0008Tc-CC
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:00:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iw1BP-0007sO-PF
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iw1BN-0000l4-Bh
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:59:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41464
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iw1BN-0000g1-7V
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580119188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PnK5ZMIUqjSZHLYS4RjOIQaIA5Xa3+EjKPOuCvE7hQ8=;
 b=hJUeiUJfJkwUBPg34wced3N38nOVtPo8adS38euQus50VaSpzqNPIqL6Wp85UdWeq0MB+m
 fb9+4LZKj16SqDjvgBmeZV47XOhdm3bArQbuNrjaVnPvVnHPSIOi8PYT7Qw2ID2P2Vr9cT
 u9WBCCt0Oq1VNJ7RMLSYm8LGBgw+G8c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-xfr_27pAPv256gWtpjBtrw-1; Mon, 27 Jan 2020 04:59:46 -0500
Received: by mail-wm1-f71.google.com with SMTP id o24so1192548wmh.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 01:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iSZYGNyHGGEUf1gVUBJdo/uJV57H/bCFXmOWePwTxBc=;
 b=HHluASLsmaLJ5XpUTjQh5aq4BS9B+5QJoyqMYf53L94FX6zNKIb+/eg14fvrG3QpB+
 IGRRbuEBnbTTvRqUNxhqpHlYRICD0SyFBWp0VC1MojTSJUSr3Z8Ed2UwIRKbd+CMKgiC
 GO9A/VOp0IPzw9uD+7JUWnqcWQLOEPDqQVXqtlSXGOqMfu4dEuctf8nS2kgVEMMDV39x
 C6rYpmJXyWUxgDEc1gzKqGzdPerPA3k25UhAEzaNbVyxLtkvRG+WJ8IbfN6jFxS06jXs
 gJEOVuYsbpwXoALbHVamnkhynbSe7YlFzGuHBW2UFdkWZCEzYX7mNoh6c2xp+HfY/Wfp
 360g==
X-Gm-Message-State: APjAAAVL1jbXC07B6So8MH4WrMBIV3Z5Okh5OwNz5fhxMoEFou6Y2XO4
 yMLkGreRHg+PkmLheUv/a0NqcYFmccI9yB6f86nuTRSYW4FeOKhQDV32xHvzhDsiWRkJL+I/bNk
 J9o3m+sGjavg7FCI=
X-Received: by 2002:a1c:6755:: with SMTP id b82mr11930521wmc.127.1580119185295; 
 Mon, 27 Jan 2020 01:59:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxp8/BIJ/vQrRHwArJ8TQXi6df8K0G8FdmD6cU4ol5B1GA33SWgf1kmPCNPFROPGyqHtpcDlw==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr11930489wmc.127.1580119184996; 
 Mon, 27 Jan 2020 01:59:44 -0800 (PST)
Received: from steredhat (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id x11sm18322736wmg.46.2020.01.27.01.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 01:59:44 -0800 (PST)
Date: Mon, 27 Jan 2020 10:59:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 0/4] virtio-pci: enable blk and scsi multi-queue by
 default
Message-ID: <20200127095942.4n4ikvfptirqhn7c@steredhat>
References: <20200124100159.736209-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200124100159.736209-1-stefanha@redhat.com>
X-MC-Unique: xfr_27pAPv256gWtpjBtrw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 24, 2020 at 10:01:55AM +0000, Stefan Hajnoczi wrote:
> v2:
>  * Let the virtio-DEVICE-pci device select num-queues because the optimal
>    multi-queue configuration may differ between virtio-pci, virtio-mmio, =
and
>    virtio-ccw [Cornelia]
>=20
> Enabling multi-queue on virtio-pci storage devices improves performance o=
n SMP
> guests because the completion interrupt is handled on the vCPU that submi=
tted
> the I/O request.  This avoids IPIs inside the guest.
>=20
> Note that performance is unchanged in these cases:
> 1. Uniprocessor guests.  They don't have IPIs.
> 2. Application threads might be scheduled on the sole vCPU that handles
>    completion interrupts purely by chance.  (This is one reason why bench=
mark
>    results can vary noticably between runs.)
> 3. Users may bind the application to the vCPU that handles completion
>    interrupts.
>=20
> Set the number of queues to the number of vCPUs by default.  Older machin=
e
> types continue to default to 1 queue for live migration compatibility.
>=20
> This patch improves IOPS by 1-4% on an Intel Optane SSD with 4 vCPUs, -dr=
ive
> aio=3Dnative, and fio bs=3D4k direct=3D1 rw=3Drandread.
>=20
> Stefan Hajnoczi (4):
>   virtio-scsi: introduce a constant for fixed virtqueues
>   virtio-scsi: default num_queues to -smp N
>   virtio-blk: default num_queues to -smp N
>   vhost-user-blk: default num_queues to -smp N

The series looks good to me:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


