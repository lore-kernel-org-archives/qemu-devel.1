Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B011FC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8093124658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQG4tLNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8093124658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irRGn-0002JG-KO
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 13:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1irRG7-0001MS-6t
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1irRG6-0004Im-4u
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:49:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35133
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1irRG6-0004IS-1K
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579027785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pMOB7Bh5GnFFF9E/G7IoCkeTAyGiZNr08xAqv+Zx4r8=;
 b=MQG4tLNUJ08u3u61HWD3ql8A9WuXIxvi3z0e8X/nBIq+rp2NsB16U6tLYE4q7j5UHo1J2i
 CttpYnOK7RjHbMU6Lek68DTymOCF8jrhIdw6bMs0yhx5Gc9XMbS37Yru/k0+NJVB1E7WQd
 3IHRD5ctucdsK8b2nEMFA0pHEZVFhJU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-Z4TS4J5LP0q0ZOry1D87fQ-1; Tue, 14 Jan 2020 13:49:42 -0500
Received: by mail-qk1-f199.google.com with SMTP id a6so8940600qkl.7
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 10:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Cg9CYW91jza8bY+9bfesuhgfknXcUEKut9hzdJKzl10=;
 b=N5tAjpzqFAS1Sje9Wxs0BHYFlOhYiCYEoIsIv1DcJdB51dFWLQrcGnA5HQqRz904yM
 6QW7Q3nf6Q+8afbv+Z1PnX4dda2RdPmEppAk0HDqApvABk3TA1IX7qWdis1lvbH/GKQM
 pNK16qwbua/hmqH7FwN1AYQT305/lArO3j7isUkRQuq499AEDdkOfNMF3E6hsDnFRjn2
 6UHrrg4/TmH932+CFlryaUxfvq++FFaN61A0UfFuWs6d/ASmghbKileV74sSAPIsLRye
 ncUKB1zd46GHERoyNpuc+asYYZh5XY9w1H+Cm1vVuYUziz+XBPduKTpRLGp3uZP0Dnhm
 WliA==
X-Gm-Message-State: APjAAAX1fsz5S3cpbAfGwmJYqicwMV7BS0UFjUwIoKj7lbU2anEPuW+v
 S7yPjXzlsWhWuAn1NerOj1R8wo4InWBZeF7tZ5NN4XQE14v/C6UT5vLjDefYW7HQ9BKE7t5Oghv
 YQeYNauB0yccrjPA=
X-Received: by 2002:a05:620a:1467:: with SMTP id
 j7mr21807655qkl.76.1579027781848; 
 Tue, 14 Jan 2020 10:49:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXnNG0leWiCTB7FeZo2f8xNDBokwPXTEZR8CLmD8s4pAnz5xnESL/jhzqpyIy89N2z6jFbKw==
X-Received: by 2002:a05:620a:1467:: with SMTP id
 j7mr21807625qkl.76.1579027781667; 
 Tue, 14 Jan 2020 10:49:41 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id u15sm7044799qku.67.2020.01.14.10.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 10:49:40 -0800 (PST)
Date: Tue, 14 Jan 2020 13:49:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v12 04/13] virtio-iommu: Add the iommu regions
Message-ID: <20200114184939.GC225163@xz-x1>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-5-eric.auger@redhat.com>
 <20200113195344.GA201624@xz-x1>
 <779fc8b2-93c1-e3c2-9feb-b2552de2c5d3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <779fc8b2-93c1-e3c2-9feb-b2552de2c5d3@redhat.com>
X-MC-Unique: Z4TS4J5LP0q0ZOry1D87fQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 09:37:51AM +0100, Auger Eric wrote:
> > In all cases, I see that virtio_iommu_mr() is introduced but not used.
> > Would be good to put it into the patch where it's firstly used.
> OK fair enough, I will put the helper in the same patch as the user as
> you have requested that since the beginning ;-) The resulting patch may
> be huge. Just hope nobody will request me to split it back ;-)

We can wait for a few more days and see whether someone will have a
different answer before you start to squash things. :)

In all cases, I think we should get rid of the compiler trick at
least.

Thanks,

--=20
Peter Xu


