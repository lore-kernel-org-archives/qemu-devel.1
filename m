Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12081C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF96D24671
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjGRPovL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF96D24671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irkEg-0004uY-Sm
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1irkDx-0004LD-3y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:04:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1irkDw-0005Wd-2u
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:04:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48008
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1irkDv-0005WL-Uu
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579100686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCuftxJNdF3kxBj8oa4PT2qaVcewZ4vHhyNd9oC/xTc=;
 b=LjGRPovLsTCwDKQEIyENZr+HHUIBj43+IcvLhA2VsZw11WkKChqItK8LXCrYYsCv/ZMKVj
 rofaqrETj2b+sNVjCtanac+vn0EFbw7ty4kxlXh12nppgBJ4+ABhWod2h0TW17OHSqBmCM
 ehtZ1gXWZA6H5td/w8hetyHx6SMv72Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-hI0XyygZN06RAvvGxkhxpA-1; Wed, 15 Jan 2020 10:04:45 -0500
Received: by mail-qv1-f70.google.com with SMTP id p3so11171060qvt.9
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 07:04:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sd42UO1Bkkp1gbRccpWIkuLUdR8NJv7X4bTm/t0zc8w=;
 b=o7mMEYOhuA5kGAV6CQS7FvCW0c5+bdxMEaOA4/q/XnLtWzUHEuOGREh9ZxeaqWQEAL
 anGNunbZ71r9Fggr4KCvjUD7Vq6hW/bnlNYtyuLoyk+GLqKuwsRa7mxjdjESA57iJF3m
 oSlzNxwOf0L+VTLGKI++PzHDi+0IoqYgQXNNt7yNnD/8DlJYKDuG6dVrDeOzhuvLFLwE
 k6NIvpFTEk6Vhd8IFAWMtmNoGFDEVJKe0XLkUO9jbIiBEwWelqqPN+zfVs3eFWAimqJV
 a5KyYL5EIqion562oJKbfnikagTfOtcbUBvlRoXsDSJHbrWuOCfhWSJ7N2wTrqIzwDNe
 kOpA==
X-Gm-Message-State: APjAAAXrNbqZDhJFZ6IwXss7U7gnRxfnkgOF9k3QQzAhEVw/C6kukBSU
 bI6E3FOEKl3yo03/CoaP8ClSoxlDbTyVYHoyaKCblM/PnJg7Blg2Y2fq+SVud8lOrfbtuwi/FGZ
 PiC+wW+U2jL3OlJM=
X-Received: by 2002:ac8:4257:: with SMTP id r23mr3959510qtm.126.1579100685148; 
 Wed, 15 Jan 2020 07:04:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyP1oiYoMxSJw3mDADXTR51H6XZu0WYDFatNflrcvNwWfIPYfr2mdRrutFy+WF9BT+nT077nA==
X-Received: by 2002:ac8:4257:: with SMTP id r23mr3959488qtm.126.1579100684962; 
 Wed, 15 Jan 2020 07:04:44 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id l35sm9703518qtl.12.2020.01.15.07.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 07:04:44 -0800 (PST)
Date: Wed, 15 Jan 2020 10:04:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v12 09/13] virtio-iommu: Implement fault reporting
Message-ID: <20200115150442.GD233443@xz-x1>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-10-eric.auger@redhat.com>
 <20200114190433.GE225163@xz-x1>
 <2a060fcf-f9d6-c6bf-d444-018df532e475@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2a060fcf-f9d6-c6bf-d444-018df532e475@redhat.com>
X-MC-Unique: hI0XyygZN06RAvvGxkhxpA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 02:12:20PM +0100, Auger Eric wrote:
> >> +static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t re=
ason,
> >> +                                      int flags, uint32_t endpoint,
> >> +                                      uint64_t address)
> >> +{

[...]

> >> +        if (iov_size(elem->in_sg, elem->in_num) < sizeof(fault)) {
> >> +            virtio_error(vdev, "error buffer of wrong size");
> >> +            virtqueue_detach_element(vq, elem, 0);
> >> +            g_free(elem);
> >> +            continue;
> >=20
> > If virtio_error(), should we stop rather than continue?
> My understanding is the buffer just popped had a wrong size so it is not
> usable. We skip it we try to use another one if any. Does it make sense?

I'm not very familiar to virtio, but I see that virtio_error marks
vdev->broken to true.  If with that iiuc the next virtqueue_pop() will
fail directly (see the first call to virtio_device_disabled in
virtqueue_pop).  Then I don't see why retry any more...

Thanks,

--=20
Peter Xu


