Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D040C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A55620721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evCVqG8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A55620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iycDY-0008Hw-7i
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iycC0-0006nE-QG
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iycBz-00084y-R7
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:55:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56282
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iycBz-00084p-Nc
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580738111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qg93xFhEGkdmIT3K3LTNem1fl2cYCQhQan2pX+lCxMw=;
 b=evCVqG8cef5s/NGIw+w/jK8JmVdlspqV2NDqIa6uAsOGDlP7BXTRAUboKqJvxb5vLrRdQD
 9s2mwxbqDgXbsHnGvLC986VJDtEWssxlQk4q+01mEoTMo9J+GgOY3j5k4PtbMGGVd+A/1Q
 Ef69NqHYmZCHBl/TncF6u194HnxAjjI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-fkbKMQKENw6e91nKRvae5Q-1; Mon, 03 Feb 2020 08:55:07 -0500
Received: by mail-qv1-f69.google.com with SMTP id p3so9484163qvt.9
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 05:55:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OX9/undf1GE3j16kXlHknGzXZFn72TP46ty60q477W0=;
 b=FVgrDWyQOkPqbcGtJ8yS/miJtAb5QZtHPlm78upXCv4tJ73ynPeerDAWRALikdz25w
 GDovDPo527GdKlInXYsw1+tKhG1lWuvL4j0l6jZFeUdTRtBswe2UwCLyCx9rs5lNk1zI
 TTTxTwUZ5DGxB9r5PQoSpTyAch3L2R6VVEQuZzZuTtqRQ0LC8U/oOJjZgVjKujVhCbwA
 Q4KgXKLXuJ7Y/UgVu2URpdHMIGww0GHi0rlhLmDYscthvtXGpFYZMieCtsBbGN4JdIi9
 JDQBhAj0qP0Tczi3AM3kISG9YKayMmOB4mcPcHF9VYitnHSMv6HG2+34stK3+u2t7AT1
 hVew==
X-Gm-Message-State: APjAAAUdptLj0C4EeFetEKQYag0lWv2XLCkHu82lvqZXLAy5+0jTtL31
 Djctvk97tj98+vfVtBSzNtfpgwzIxBxlNetBPOpN0OB9E8QiwGIVMbpr9IXZqsySpvyTDfyzLzQ
 VKxmccwDnnyqLxj8=
X-Received: by 2002:ae9:e109:: with SMTP id g9mr23410942qkm.141.1580738106627; 
 Mon, 03 Feb 2020 05:55:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoxO16Sp2ljh1ReMYm6DCws3MoRu1G+rXlC9JNw//PMhRJerjXB/71rb8wqA/99ZEJ1c8sxQ==
X-Received: by 2002:ae9:e109:: with SMTP id g9mr23410919qkm.141.1580738106410; 
 Mon, 03 Feb 2020 05:55:06 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id w60sm9760352qte.39.2020.02.03.05.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 05:55:05 -0800 (PST)
Date: Mon, 3 Feb 2020 08:55:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v13 06/10] virtio-iommu: Implement fault reporting
Message-ID: <20200203135503.GC155875@xz-x1>
References: <20200125171955.12825-1-eric.auger@redhat.com>
 <20200125171955.12825-7-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200125171955.12825-7-eric.auger@redhat.com>
X-MC-Unique: fkbKMQKENw6e91nKRvae5Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jan 25, 2020 at 06:19:51PM +0100, Eric Auger wrote:

[...]

> +static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reaso=
n,
> +                                      int flags, uint32_t endpoint,
> +                                      uint64_t address)
> +{
> +    VirtIODevice *vdev =3D &viommu->parent_obj;
> +    VirtQueue *vq =3D viommu->event_vq;
> +    struct virtio_iommu_fault fault;
> +    VirtQueueElement *elem;
> +    size_t sz;
> +
> +    memset(&fault, 0, sizeof(fault));
> +    fault.reason =3D reason;
> +    fault.flags =3D cpu_to_le32(flags);
> +    fault.endpoint =3D cpu_to_le32(endpoint);
> +    fault.address =3D cpu_to_le64(address);
> +
> +    for (;;) {
> +        elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> +
> +        if (!elem) {
> +            error_report_once(
> +                "no buffer available in event queue to report event");
> +            return;
> +        }
> +
> +        if (iov_size(elem->in_sg, elem->in_num) < sizeof(fault)) {
> +            virtio_error(vdev, "error buffer of wrong size");
> +            virtqueue_detach_element(vq, elem, 0);
> +            g_free(elem);
> +            return;
> +        }
> +        break;

This for loop is not needed any more?  Other than that:

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


