Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCE8C35671
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 08:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A112205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 08:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAgs1SIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A112205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5mT0-00011R-Ls
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 03:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j5mSK-0000Vf-Ad
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 03:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j5mSJ-0002ur-1s
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 03:17:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57164
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j5mSI-0002rc-UY
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 03:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582445855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4TrWPUuEuLBHImQVGVwprlXYP7/K1lE0tMIMfQeaQs=;
 b=YAgs1SIqTAP/x8HhH0Jfw3gi3lCUx5idwtzhcogIrmYEMuTk7OrUCZItlRPgBbwI/GFB4e
 IKBVhFiSL1XoUNIng8rNk6CHRsEEBUQVtDY3AunI7lQZuXqGXvFYvvo0rAbs4c2ok3pet2
 awIZ/C6ZnEmfSEHqf9ZT26xKZ1WKYzg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-lwZNdu9iO8Kw1yzxPW2afw-1; Sun, 23 Feb 2020 03:17:31 -0500
X-MC-Unique: lwZNdu9iO8Kw1yzxPW2afw-1
Received: by mail-wr1-f70.google.com with SMTP id t3so1871300wrp.2
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2020 00:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fBtgdXi/8M0JSMMM03KZUpZNHh1H7P6raMwXC0r5Y3w=;
 b=VeCahYfFD2MqFq34mFfRfPpj2vV2NokLFiWsiCQHi2VAPgW5ZDgWPDsbp7oAwbCU/d
 63hn7oANIgqIO9AKGxqa0oPPzYcxHZZob5v6Us2t3YRn5uo2PsDt5UZfFmxRXnB76HjZ
 qccoqczIwvCNxbogyT32oQ1CvBQSaYMVJ2elkPFepX6qh41nVUpQXUH5Cn7PiJ5vdu2G
 NfEnQzkyhPr84zmrhM+Y44htD4namAL88iVjtM2UDhypculhdr5PDxHPxj9le6IHotT9
 ZbTIvgjNG/MRP93T9Rl9FgkV1ljUYE+GOBtukMtI+Jf2T+AV6Ag3D/D/i5P91EkSW5T3
 QFLQ==
X-Gm-Message-State: APjAAAXZM3aEJBcd1uU/zoZseTykt8IKCpgbK6cTI+wYGN5mn5cYkBV6
 GOSerOipfdRlCxMr+Uji1HF3si8rFL6mfEW/X0mlphQ5760fEBeHbJApESNJ5z9AKpoBI3C+zlx
 S5RkD88Qrp401fzQ=
X-Received: by 2002:a1c:491:: with SMTP id 139mr15092189wme.117.1582445850374; 
 Sun, 23 Feb 2020 00:17:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJXyXpVXaMrYFEi3b2lJ5MSiruINY9MFvqWKIGWIY5oP8pFQGx+BxeK17qQkHN+RYYcueosg==
X-Received: by 2002:a1c:491:: with SMTP id 139mr15092151wme.117.1582445850077; 
 Sun, 23 Feb 2020 00:17:30 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 z10sm11803414wmk.31.2020.02.23.00.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2020 00:17:29 -0800 (PST)
Date: Sun, 23 Feb 2020 03:17:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v16 00/10] VIRTIO-IOMMU device
Message-ID: <20200223031659-mutt-send-email-mst@kernel.org>
References: <20200214132745.23392-1-eric.auger@redhat.com>
 <CAFEAcA-U9b7GVXOd0QDw526JChoD3gRhVBzLcSy++PQzHbVzFg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-U9b7GVXOd0QDw526JChoD3gRhVBzLcSy++PQzHbVzFg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, tnowicki@marvell.com,
 Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, bharatb.linux@gmail.com,
 qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 02:27:30PM +0000, Peter Maydell wrote:
> On Fri, 14 Feb 2020 at 13:28, Eric Auger <eric.auger@redhat.com> wrote:
> >
> > This series implements the QEMU virtio-iommu device.
> >
> > This matches the v0.12 spec (voted) and the corresponding
> > virtio-iommu driver upstreamed in 5.3. All kernel dependencies
> > are resolved for DT integration. The virtio-iommu can be
> > instantiated in ARM virt using:
> >
> > "-device virtio-iommu-pci".
> >
> > Non DT mode is not yet supported as it has non resolved kernel
> > dependencies [1].
> >
> > This feature targets 5.0.
> >
> > Integration with vhost devices and vfio devices is not part
> > of this series. Please follow Bharat's respins [2].
>=20
> I think everything here has reviewed-by tags now -- does
> anybody still want more time to review it, and what
> is the preference for how it goes into master?
>=20
> thanks
> -- PMM

I guess I'll pick it up, most code seems to be virtio related.

Thanks everyone!

--=20
MST


