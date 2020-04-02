Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6C8C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75252078B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xy+Co343"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75252078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK4Ln-0005t4-35
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 14:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jK4Kz-0005KI-Fw
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jK4Ky-0007wb-9z
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:13:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24529
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jK4Ky-0007tv-6E
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585851187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQGsE1uPIortyjNTAn4z4Me00AHL0HhHoVdOw3crMq4=;
 b=Xy+Co343JFtBAi0AiCLSOMzDJPbt2vT7APADLCTHflJhimqW/x47TNYuM3RasDdkSyelat
 5FQP37LqGoE480LvCasBnPGzJxKyHkJd7HI2mjtmuajZbUG7EDxu7gXNA+WQHkD3Hgtzy2
 Xksaz5BeKriPnKhfbCfNZjuAHxJQ1/Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-pSKykrKcNei1YIRelqTEnA-1; Thu, 02 Apr 2020 14:13:03 -0400
X-MC-Unique: pSKykrKcNei1YIRelqTEnA-1
Received: by mail-wr1-f70.google.com with SMTP id f15so1842027wrt.4
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 11:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/w1XPcFrLz6tQEiDvBsmFImZ8MWG7D8gxR/TGmyIOfc=;
 b=mnekQhXTIYXF5gIbC7mO1NpYfsW9fLa7L2Fltnmt/RB7IcOR8I+srQM0+0twLCS/Js
 psC+SqToWxyVVQCoSjabDzQipCR4H5sgFghrrYZz8Afj5R4e4887wUVRgXQqApQTrmAf
 X+x7eaZQWiMegIKrYOatriy+QiiiVQceV1DDb0SgMfsZbPwM+8BGBH4toHmTvXI80bLR
 Vn15rKaT/mSnfW172Jw7KV5OKwv7xsLzVth6Yj1I9edN7ZCPicVWY1fonTOYIrQY4Vzt
 ZwyM45MmOjwmjP/NuL/NpwzsQ46v4vbXnDCBrlgNoHZTbFvVsRaPKoH4CQ3YfPX7Qjeh
 Wc8w==
X-Gm-Message-State: AGi0PuZ228x7jHxB3U815bJbcVkkJaK9YsBF36Ccrb4F3nGaTOWCKN1R
 5GydSMuFDdad19ezr4InCxH8t0lQd73A7nTbuPWF+2KMw55fQpAfSXVTR8RWpdEHCT3PV+4NkZP
 sIc7mwTXWxCuRuoQ=
X-Received: by 2002:adf:82a6:: with SMTP id 35mr4724826wrc.307.1585851182481; 
 Thu, 02 Apr 2020 11:13:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypIXdqRzArUH2ZsL1EUSB0H8v1U9gywPCW/4wSXhaIAX48AOcIA+658s2GAe64Wr/fSqOsWFWA==
X-Received: by 2002:adf:82a6:: with SMTP id 35mr4724805wrc.307.1585851182296; 
 Thu, 02 Apr 2020 11:13:02 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id h26sm7882608wmb.19.2020.04.02.11.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 11:13:01 -0700 (PDT)
Date: Thu, 2 Apr 2020 14:12:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 00/22] intel_iommu: expose Shared Virtual Addressing
 to VMs
Message-ID: <20200402181255.GE103677@xz-x1>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, kvm@vger.kernel.org,
 mst@redhat.com, jun.j.tian@intel.com, qemu-devel@nongnu.org,
 eric.auger@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com,
 hao.wu@intel.com, yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 29, 2020 at 09:24:39PM -0700, Liu Yi L wrote:
> Tests: basci vSVA functionality test,

Could you elaborate what's the functionality test?  Does that contains
at least some IOs go through the SVA-capable device so the nested page
table is used?  I thought it was a yes, but after I notice that the
BIND message flags seems to be wrong, I really think I should ask this
loud..

> VM reboot/shutdown/crash,

What's the VM crash test?

> kernel build in
> guest, boot VM with vSVA disabled, full comapilation with all archs.

I believe I've said similar things, but...  I'd appreciate if you can
also smoke on 2nd-level only with the series applied.

Thanks,

--=20
Peter Xu


